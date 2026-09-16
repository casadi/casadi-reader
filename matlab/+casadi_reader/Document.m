classdef Document < handle
    % Native MATLAB reader; no MEX, CasADi, or foreign runtime.
    properties (Access = private)
        fid = -1
        start = 0
        length = 0
        pos = 0
        depth = 0
        debug = false
        lazy = false
        scheme
        objects = {}
        shared = []
        blobs = zeros(0, 2)
        result
        cache = uint8([])
        cacheStart = -1
        maxItems = 1000000
    end
    methods

        function self = Document(path, type, lazy)
            if nargin < 2
                type = '';
            end
            if nargin < 3
                lazy = false;
            end
            if islogical(type)
                if type
                    type = 'Resource';
                else
                    type = '';
                end
            end
            self.scheme = casadi_reader.metadata();
            self.lazy = lazy;
            self.fid = fopen(path, 'rb');
            if self.fid < 0
                error('casadi_reader:Input', 'Cannot open file');
            end
            try
                fseek(self.fid, 0, 'eof');
                stop = ftell(self.fid);
                while self.start < stop
                    fseek(self.fid, self.start, 'bof');
                    c = fread(self.fid, 1, '*uint8');
                    if ~ismember(c, [32 9 13 10])
                        break
                    end
                    self.start = self.start + 1;
                end
                while stop > self.start
                    fseek(self.fid, stop - 1, 'bof');
                    c = fread(self.fid, 1, '*uint8');
                    if ~ismember(c, [32 9 13 10])
                        break
                    end
                    stop = stop - 1;
                end
                n = stop - self.start;
                if mod(n, 2) || n / 2 > 1024^3
                    self.fail('Invalid .casadi encoding or file too large');
                end
                self.length = n / 2;
                self.result = self.decode(type);
            catch e
                self.delete();
                rethrow(e);
            end
        end

        function delete(self)
            if self.fid >= 0
                fclose(self.fid);
                self.fid = -1;
            end
            self.cache = uint8([]);
        end

        function value = data(self)
            value = jsondecode(self.json());
        end

        function text = json(self)
            self.check();
            text = self.encode(self.result);
        end

        function count = blobCount(self)
            self.check();
            count = size(self.blobs, 1);
        end

        function size = blobSize(self, index)
            self.check();
            if index < 1 || index > self.blobCount() || fix(index) ~= index
                self.fail('Blob index out of bounds');
            end
            size = self.blobs(index, 2);
        end

        function bytes = readBlob(self, index, offset, size)
            total = self.blobSize(index);
            if nargin < 3
                offset = 0;
            end
            if nargin < 4
                size = total - offset;
            end
            if offset < 0 || size < 0 || offset > total || size > total - offset || fix(offset) ~= offset || fix(size) ~= size
                self.fail('Blob slice out of bounds');
            end
            bytes = self.readBytes(self.blobs(index, 1) + offset, size);
        end

    end
    methods (Access = private)

        function check(self)
            if self.fid < 0
                self.fail('Document is closed');
            end
        end

        function fail(self, message)
            error('casadi_reader:Decode', '.casadi byte %d: %s', self.pos, message);
        end

        function bytes = readBytes(self, offset, n)
            self.check();
            if offset < 0 || n < 0 || offset > self.length || n > self.length - offset
                self.fail('Source range out of bounds');
            end
            p = self.start + 2 * offset;
            count = 2 * n;
            if p < self.cacheStart || p + count > self.cacheStart + numel(self.cache)
                fseek(self.fid, p, 'bof');
                self.cache = fread(self.fid, max(count, 65536), '*uint8')';
                self.cacheStart = p;
            end
            i = p - self.cacheStart + 1;
            encoded = self.cache(i:i + count - 1);
            if any(encoded < 97 | encoded > 112)
                self.fail('Invalid .casadi encoding');
            end
            encoded = encoded - 97;
            bytes = bitor(encoded(1:2:end), bitshift(encoded(2:2:end), 4));
        end

        function start = take(self, n)
            if ~isnumeric(n) || ~isscalar(n) || n < 0 || fix(n) ~= n || n > self.length - self.pos
                self.fail('Truncated or excessive payload');
            end
            start = self.pos;
            self.pos = self.pos + double(n);
        end

        function n = count(self, n)
            if ~isnumeric(n) || ~isscalar(n) || n < 0 || n > self.maxItems || fix(n) ~= n
                self.fail('Invalid or excessive collection size');
            end
            n = double(n);
        end

        function b = byte(self)
            b = double(self.readBytes(self.take(1), 1));
        end

        function decoration(self, tag)
            if self.debug && self.byte() ~= double(tag)
                self.fail(['Expected wire decoration ' tag]);
            end
        end

        function fieldname(self, name)
            if self.debug && ~isequal(self.stringValue(), name)
                self.fail(['Expected serialized field ' name]);
            end
        end

        function v = number(self, kind)
            switch kind
                case 'int'
                    tag = 'i';
                    cls = 'int32';
                    n = 4;
                case 'unsignedint'
                    tag = 'u';
                    cls = 'uint32';
                    n = 4;
                case 'casadi_int'
                    tag = 'J';
                    cls = 'int64';
                    n = 8;
                case 'size_t'
                    tag = 'K';
                    cls = 'uint64';
                    n = 8;
                case 'double'
                    tag = 'd';
                    cls = 'double';
                    n = 8;
            end
            self.decoration(tag);
            bytes = self.readBytes(self.take(n), n);
            v = typecast(bytes, cls);
            [~, ~, endian] = computer;
            if endian == 'B'
                v = swapbytes(v);
            end
            if strcmp(kind, 'double')
                if ~isfinite(v)
                    if isnan(v)
                        text = 'NaN';
                    elseif v > 0
                        text = 'Infinity';
                    else
                        text = '-Infinity';
                    end
                    v = self.object({'$float'}, {text});
                end
            elseif v > 9007199254740991 || (isinteger(v) && ~isa(v, 'uint64') && v < -9007199254740991)
                v = self.object({'$integer'}, {char(string(v))});
            else
                v = double(v);
            end
        end

        function v = blob(self, offset, n)
            self.blobs(end + 1, :) = [offset n];
            v = self.object({'kind', 'offset', 'byteLength', 'encoding'}, {'deferred_bytes', offset, n, 'casadi-nibbles'});
        end

        function v = stringValue(self)
            self.decoration('s');
            n = self.number('int');
            offset = self.take(n);
            if self.lazy && n >= 65536
                v = self.blob(offset, n);
                return
            end
            bytes = self.readBytes(offset, n);
            v = native2unicode(bytes, 'UTF-8');
            if ~isequal(unicode2native(v, 'UTF-8'), bytes)
                if self.lazy
                    v = self.blob(offset, n);
                else
                    v = self.object({'$bytes'}, {num2cell(double(bytes))});
                end
            end
        end

        function enterLayout(self)
            self.depth = self.depth + 1;
            if self.depth > 256
                self.fail('Layout nesting limit exceeded');
            end
        end

        function v = field(self, record, name, kind, read)
            self.fieldname(name);
            v = read();
            fields = record('fields');
            fields{end + 1} = self.object({'name', 'type', 'value'}, {name, kind, v});
            record('fields') = fields;
            self.count(numel(fields));
        end

        function version(self, record, base, expected)
            v = self.field(record, [base '::serialization::version'], 'int', @() self.number('int'));
            if ~isequal(v, expected)
                self.fail(['Unsupported version: ' base]);
            end
        end

        function recordLayout(self, record, name)
            layouts = record('layouts');
            layouts{end + 1} = name;
            record('layouts') = layouts;
        end

        function v = tag(self, v)
            if islogical(v)
                if v, v = 'true'; else, v = 'false'; end
            elseif isnumeric(v)
                v = num2str(v);
            end
        end

        function layout_AlpaqaInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'AlpaqaInterface', 1);
            self.field(record, 'AlpaqaInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'AlpaqaInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_AmplInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Assertion_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'Assertion::fail_message', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_BSpline_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'BSplineCommon::serialize_body');
            self.layout_BSplineCommon_serialize_body(record, scope);
            self.field(record, 'BSpline::coeffs', 'std::vector<double>', @() self.read_std_vector_double());
            self.depth = self.depth - 1;
        end

        function layout_BSpline_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('BSpline::type') = self.field(record, 'BSpline::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_BSplineCommon_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'BSplineCommon::knots', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'BSplineCommon::offset', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'BSplineCommon::degree', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'BSplineCommon::m', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'BSplineCommon::lookup_mode', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'BSplineCommon::strides', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'BSplineCommon::coeffs_dims', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'BSplineCommon::coeffs_size', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'BSplineCommon::jac_cache_', 'MX', @() self.read_MX());
            self.depth = self.depth - 1;
        end

        function layout_BSplineInterpolant_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Interpolant::serialize_body');
            self.layout_Interpolant_serialize_body(record, scope);
            self.version(record, 'BSplineInterpolant', 1);
            self.field(record, 'BSplineInterpolant::s', 'Function', @() self.read_Function());
            self.depth = self.depth - 1;
        end

        function layout_BSplineParametric_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'BSplineCommon::serialize_body');
            self.layout_BSplineCommon_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_BSplineParametric_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('BSpline::type') = self.field(record, 'BSpline::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_BackwardDiff_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'ForwardDiff::serialize_body');
            self.layout_ForwardDiff_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Bilin_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_BinaryMX_ScX_ScY_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'BinaryMX::op', 'int', @() self.number('int'));
            self.depth = self.depth - 1;
        end

        function layout_BinaryMX_ScX_ScY_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_BinarySX_serialize_node(self, record, scope)
            self.enterLayout();
            self.field(record, 'UnarySX::dep0', 'SXElem', @() self.read_SXElem());
            self.field(record, 'UnarySX::dep1', 'SXElem', @() self.read_SXElem());
            self.depth = self.depth - 1;
        end

        function layout_Bisection_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Rootfinder::serialize_body');
            self.layout_Rootfinder_serialize_body(record, scope);
            self.version(record, 'Bisection', 1);
            self.field(record, 'Bisection::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Bisection::max_search', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Bisection::search_step', 'double', @() self.number('double'));
            self.field(record, 'Bisection::abstol', 'double', @() self.number('double'));
            self.field(record, 'Bisection::abstol_step', 'double', @() self.number('double'));
            self.field(record, 'Bisection::lb', 'double', @() self.number('double'));
            self.field(record, 'Bisection::ub', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_BlazingSplineFunction_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'BlazingSplineFunction', 2);
            self.field(record, 'BlazingSplineFunction::diff_order', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'BlazingSplineFunction::precompute_coeff', 'bool', @() self.boolValue());
            self.field(record, 'BlazingSplineFunction::precompute_grid', 'bool', @() self.boolValue());
            self.field(record, 'BlazingSplineFunction::knots', 'std::vector<std::vector<double>>', @() self.read_std_vector_std_vector_double());
            self.field(record, 'BlazingSplineFunction::lookup_modes', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            scope('BlazingSplineFunction::parametric_knots') = self.field(record, 'BlazingSplineFunction::parametric_knots', 'bool', @() self.boolValue());
            if self.truth(scope('BlazingSplineFunction::parametric_knots'))
                self.field(record, 'BlazingSplineFunction::knots_offset', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
                self.field(record, 'BlazingSplineFunction::inv_input', 'bool', @() self.boolValue());
            end
            self.field(record, 'BlazingSplineFunction::pedantic_mode_order', 'std::string', @() self.stringValue());
            self.field(record, 'BlazingSplineFunction::pedantic_mode_size', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_Blocksqp_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'Blocksqp', 1);
            self.field(record, 'Blocksqp::nblocks', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::blocks', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Blocksqp::dim', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Blocksqp::nnz_H', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::Asp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Blocksqp::Hsp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Blocksqp::exact_hess_lag_sp_', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Blocksqp::linsol_plugin', 'std::string', @() self.stringValue());
            self.field(record, 'Blocksqp::print_header', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::print_iteration', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::eps', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::opttol', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::nlinfeastol', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::schur', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::globalization', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::restore_feas', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::max_line_search', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::max_consec_reduced_steps', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::max_consec_skipped_updates', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::max_it_qp', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::warmstart', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::qp_init', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::block_hess', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::hess_scaling', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::fallback_scaling', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::max_time_qp', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::ini_hess_diag', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::col_eps', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::col_tau1', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::col_tau2', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::hess_damp', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::hess_damp_fac', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::hess_update', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::fallback_update', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::hess_lim_mem', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::hess_memsize', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::which_second_derv', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::skip_first_globalization', 'bool', @() self.boolValue());
            self.field(record, 'Blocksqp::conv_strategy', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::max_conv_qp', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::max_soc_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Blocksqp::gamma_theta', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::gamma_f', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::kappa_soc', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::kappa_f', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::theta_max', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::theta_min', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::delta', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::s_theta', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::s_f', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::kappa_minus', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::kappa_plus', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::kappa_plus_max', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::delta_h0', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::eta', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::obj_lo', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::obj_up', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::rho', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::zeta', 'double', @() self.number('double'));
            self.field(record, 'Blocksqp::rp_solver', 'Function', @() self.read_Function());
            self.field(record, 'Blocksqp::print_maxit_reached', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_BonminInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'BonminInterface', 1);
            self.field(record, 'BonminInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'BonminInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'BonminInterface::exact_hessian', 'bool', @() self.boolValue());
            self.field(record, 'BonminInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'BonminInterface::sos1_weights', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'BonminInterface::sos1_indices', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'BonminInterface::sos1_priorities', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'BonminInterface::sos1_starts', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'BonminInterface::sos1_types', 'std::vector<char>', @() self.read_std_vector_char());
            self.field(record, 'BonminInterface::sos1_types', 'std::vector<char>', @() self.read_std_vector_char());
            self.field(record, 'BonminInterface::sos_num', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'BonminInterface::sos_num_nz', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'BonminInterface::pass_nonlinear_variables', 'bool', @() self.boolValue());
            self.field(record, 'BonminInterface::pass_nonlinear_constraints', 'bool', @() self.boolValue());
            self.field(record, 'BonminInterface::nl_ex', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'BonminInterface::nl_g', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'BonminInterface::var_string_md', 'Dict', @() self.read_Dict());
            self.field(record, 'BonminInterface::var_integer_md', 'Dict', @() self.read_Dict());
            self.field(record, 'BonminInterface::var_numeric_md', 'Dict', @() self.read_Dict());
            self.field(record, 'BonminInterface::con_string_md', 'Dict', @() self.read_Dict());
            self.field(record, 'BonminInterface::con_integer_md', 'Dict', @() self.read_Dict());
            self.field(record, 'BonminInterface::con_numeric_md', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_CSparseCholeskyInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Call_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MultipleOutput::serialize_body');
            self.layout_MultipleOutput_serialize_body(record, scope);
            self.field(record, 'Call::fcn', 'Function', @() self.read_Function());
            self.depth = self.depth - 1;
        end

        function layout_CallSX_serialize_node(self, record, scope)
            self.enterLayout();
            self.field(record, 'CallSX::f', 'Function', @() self.read_Function());
            self.field(record, 'CallSX::dep', 'std::vector<SXElem>', @() self.read_std_vector_SXElem());
            self.depth = self.depth - 1;
        end

        function layout_CbcInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'CbcInterface', 1);
            self.field(record, 'CbcInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'CbcInterface::sos_groups', 'std::vector<std::vector<int>>', @() self.read_std_vector_std_vector_int());
            self.field(record, 'CbcInterface::sos_weights', 'std::vector<std::vector<double>>', @() self.read_std_vector_std_vector_double());
            self.field(record, 'CbcInterface::sos_types', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'CbcInterface::hot_start', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_CentralDiff_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FiniteDiff::serialize_body');
            self.layout_FiniteDiff_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_ClarabelInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'ClarabelInterface', 1);
            self.field(record, 'ClarabelInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_ClpInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'ClpInterface', 1);
            self.field(record, 'ClpInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_Collocation_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'ImplicitFixedStepIntegrator::serialize_body');
            self.layout_ImplicitFixedStepIntegrator_serialize_body(record, scope);
            self.version(record, 'Collocation', 2);
            self.field(record, 'Collocation::deg', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Collocation::collocation_scheme', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_Concat_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Conic_serialize(self, record, scope)
            self.enterLayout();
            self.field(record, 'Conic::SDPToSOCPMem::r', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Conic::SDPToSOCPMem::AT', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Conic::SDPToSOCPMem::A_mapping', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Conic::SDPToSOCPMem::map_Q', 'IM', @() self.read_IM());
            self.field(record, 'Conic::SDPToSOCPMem::map_P', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Conic::SDPToSOCPMem::indval_size', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Conic_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'Conic', 4);
            self.field(record, 'Conic::discrete', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'Conic::equality', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'Conic::print_problem', 'bool', @() self.boolValue());
            self.field(record, 'Conic::solver_version_check', 'bool', @() self.boolValue());
            self.field(record, 'Conic::H', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Conic::A', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Conic::Q', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Conic::P', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Conic::nx', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Conic::na', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Conic::np', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Conic_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_type');
            self.layout_FunctionInternal_serialize_type(record, scope);
            self.recordLayout(record, 'PluginInterface<Conic>::serialize_type');
            self.layout_PluginInterface_Conic_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_ConoptInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'ConoptInterface', 1);
            self.field(record, 'ConoptInterface::exact_hessian', 'bool', @() self.boolValue());
            self.field(record, 'ConoptInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'ConoptInterface::gradf_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'ConoptInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'ConoptInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'ConoptInterface::optfile', 'std::string', @() self.stringValue());
            self.field(record, 'ConoptInterface::warm_start', 'bool', @() self.boolValue());
            self.field(record, 'ConoptInterface::debug', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_Constant_Value_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Constant_Value_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('ConstantMX::type') = self.field(record, 'ConstantMX::type', 'char', @() self.byte());
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_ConstantDM_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'ConstantMX::nonzeros', 'std::vector<double>', @() self.read_std_vector_double());
            self.depth = self.depth - 1;
        end

        function layout_ConstantDM_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('ConstantMX::type') = self.field(record, 'ConstantMX::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_ConstantFile_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'ConstantFile::fname', 'std::string', @() self.stringValue());
            self.field(record, 'ConstantFile::x', 'std::vector<double>', @() self.read_std_vector_double());
            self.depth = self.depth - 1;
        end

        function layout_ConstantFile_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            self.field(record, 'ConstantFile::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_ConstantPool_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'ConstantPool::name', 'std::string', @() self.stringValue());
            self.field(record, 'ConstantPool::x', 'std::vector<double>', @() self.read_std_vector_double());
            self.depth = self.depth - 1;
        end

        function layout_ConstantPool_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            self.field(record, 'ConstantPool::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_Convexify_serialize(self, record, scope)
            self.enterLayout();
            self.version(record, [scope('prefix') 'Convexify'], 1);
            self.field(record, [scope('prefix') 'Convexify::type_in'], 'int', @() self.number('int'));
            self.field(record, [scope('prefix') 'Convexify::strategy'], 'int', @() self.number('int'));
            self.field(record, [scope('prefix') 'Convexify::margin'], 'double', @() self.number('double'));
            self.field(record, [scope('prefix') 'Convexify::max_iter_eig'], 'casadi_int', @() self.number('casadi_int'));
            self.field(record, [scope('prefix') 'Convexify::scc_offset'], 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, [scope('prefix') 'Convexify::scc_mapping'], 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, [scope('prefix') 'Convexify::Hsp_project'], 'int', @() self.number('int'));
            self.field(record, [scope('prefix') 'Convexify::scc_transform'], 'int', @() self.number('int'));
            self.field(record, [scope('prefix') 'Convexify::verbose'], 'int', @() self.number('int'));
            self.field(record, [scope('prefix') 'Convexify::Hsp'], 'Sparsity', @() self.read_Sparsity());
            self.field(record, [scope('prefix') 'Convexify::Hrsp'], 'Sparsity', @() self.read_Sparsity());
            self.depth = self.depth - 1;
        end

        function layout_Convexify_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.recordLayout(record, 'Convexify::serialize');
            scope('prefix') = '';
            self.layout_Convexify_serialize(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_CplexInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'CplexInterface', 1);
            self.field(record, 'CplexInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'CplexInterface::qp_method', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'CplexInterface::dump_to_file', 'bool', @() self.boolValue());
            self.field(record, 'CplexInterface::tol', 'double', @() self.number('double'));
            self.field(record, 'CplexInterface::dep_check', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'CplexInterface::warm_start', 'bool', @() self.boolValue());
            self.field(record, 'CplexInterface::mip_start', 'bool', @() self.boolValue());
            self.field(record, 'CplexInterface::mip', 'bool', @() self.boolValue());
            self.field(record, 'CplexInterface::ctype', 'std::vector<char>', @() self.read_std_vector_char());
            self.field(record, 'CplexInterface::sos_weights', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'CplexInterface::sos_beg', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'CplexInterface::sos_ind', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'CplexInterface::sos_types', 'std::vector<char>', @() self.read_std_vector_char());
            self.recordLayout(record, 'Conic::serialize');
            self.layout_Conic_serialize(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_CsparseInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_CvodesInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'SundialsInterface::serialize_body');
            self.layout_SundialsInterface_serialize_body(record, scope);
            self.version(record, 'CvodesInterface', 3);
            self.field(record, 'CvodesInterface::lmm', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'CvodesInterface::iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'CvodesInterface::min_step_size', 'double', @() self.number('double'));
            self.field(record, 'CvodesInterface::always_recalculate_jacobian', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_DaqpInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'DaqpInterface', 1);
            self.field(record, 'DaqpInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_DenseKron_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Kron::serialize_body');
            self.layout_Kron_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_DenseKron_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Kron::kind') = self.field(record, 'Kron::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_DenseKronContract_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'KronContract::serialize_body');
            self.layout_KronContract_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_DenseKronContract_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('KronContract::kind') = self.field(record, 'KronContract::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_DenseMultiplication_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Multiplication::serialize_body');
            self.layout_Multiplication_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_DenseMultiplication_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Multiplication::kind') = self.field(record, 'Multiplication::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_DenseSparseKron_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Kron::serialize_body');
            self.layout_Kron_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_DenseSparseKron_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Kron::kind') = self.field(record, 'Kron::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_DenseSparseKronContract_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'KronContract::serialize_body');
            self.layout_KronContract_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_DenseSparseKronContract_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('KronContract::kind') = self.field(record, 'KronContract::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_DenseSparseMultiplication_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Multiplication::serialize_body');
            self.layout_Multiplication_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_DenseSparseMultiplication_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Multiplication::kind') = self.field(record, 'Multiplication::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_DenseTranspose_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Transpose::serialize_body');
            self.layout_Transpose_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_DenseTranspose_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Transpose::dense') = self.field(record, 'Transpose::dense', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_Densify_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Project::serialize_body');
            self.layout_Project_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Densify_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Project::type') = self.field(record, 'Project::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_Determinant_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'Determinant::linsol', 'Linsol', @() self.read_Linsol());
            self.depth = self.depth - 1;
        end

        function layout_Diagcat_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Concat::serialize_body');
            self.layout_Concat_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Diagsplit_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Split::serialize_body');
            self.layout_Split_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_DirResource_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'ResourceInternal::serialize_body');
            self.layout_ResourceInternal_serialize_body(record, scope);
            self.version(record, 'DirResource', 1);
            if self.truth(isequal(scope('ResourceInternal::serialize_mode'), 'embed'))
                self.field(record, 'ZipMemResource::blob', 'std::stringstream', @() self.streamValue());
            else
                self.field(record, 'DirResource::path', 'std::string', @() self.stringValue());
            end
            self.depth = self.depth - 1;
        end

        function layout_DirResource_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('unlowered else branch');
            self.depth = self.depth - 1;
        end

        function layout_Dot_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Dump_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.version(record, 'Dump', 1);
            self.field(record, 'Dump::base_filename', 'std::string', @() self.stringValue());
            self.field(record, 'Dump::dir', 'std::string', @() self.stringValue());
            self.field(record, 'Dump::format', 'std::string', @() self.stringValue());
            self.field(record, 'Dump::verbose', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_Einstein_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'Einstein::dim_c', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::dim_a', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::dim_b', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::c', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::a', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::b', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::iter_dims', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::strides_a', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::strides_b', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::strides_c', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Einstein::n_iter', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_External_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'External', 2);
            self.field(record, 'External::int_data', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'External::real_data', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'External::string_data', 'std::string', @() self.stringValue());
            self.field(record, 'External::li', 'Importer', @() self.read_Importer());
            self.field(record, 'External::config_args', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.depth = self.depth - 1;
        end

        function layout_FastNewton_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Rootfinder::serialize_body');
            self.layout_Rootfinder_serialize_body(record, scope);
            self.version(record, 'Newton', 1);
            self.field(record, 'Newton::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Newton::abstol', 'double', @() self.number('double'));
            self.field(record, 'Newton::abstolStep', 'double', @() self.number('double'));
            self.field(record, 'Newton::jac_g_x', 'Function', @() self.read_Function());
            self.field(record, 'Newton::sp_v', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Newton::sp_r', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Newton::prinv', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Newton::pc', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_FatropConicInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'FatropConicInterface', 1);
            self.depth = self.depth - 1;
        end

        function layout_FatropInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'FatropInterface', 1);
            self.field(record, 'FatropInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FatropInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FatropInterface::exact_hessian', 'bool', @() self.boolValue());
            self.field(record, 'FatropInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'FatropInterface::convexify', 'bool', @() self.boolValue());
            self.field(record, 'FatropInterface::Isp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FatropInterface::ABsp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FatropInterface::CDsp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FatropInterface::RSQsp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FatropInterface::AB_blocks', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::CD_blocks', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::RSQ_blocks', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::I_blocks', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::nxs', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::nus', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::ngs', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::N', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FatropInterface::structure_detection', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FatropInterface::AB_offsets', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::CD_offsets', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::RSQ_offsets', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::I_offsets', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FatropInterface::debug', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_Feasiblesqpmethod_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'Feasiblesqpmethod', 3);
            self.field(record, 'Feasiblesqpmethod::qpsol', 'Function', @() self.read_Function());
            self.field(record, 'Feasiblesqpmethod::exact_hessian', 'bool', @() self.boolValue());
            self.field(record, 'Feasiblesqpmethod::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Feasiblesqpmethod::min_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Feasiblesqpmethod::lbfgs_memory', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Feasiblesqpmethod::tol_pr_', 'double', @() self.number('double'));
            self.field(record, 'Feasiblesqpmethod::tol_du_', 'double', @() self.number('double'));
            self.field(record, 'Feasiblesqpmethod::print_header', 'bool', @() self.boolValue());
            self.field(record, 'Feasiblesqpmethod::print_iteration', 'bool', @() self.boolValue());
            self.field(record, 'Feasiblesqpmethod::print_status', 'bool', @() self.boolValue());
            self.field(record, 'Feasiblesqpmethod::init_feasible', 'bool', @() self.boolValue());
            self.field(record, 'Feasiblesqpmethod::Hsp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Feasiblesqpmethod::Asp', 'Sparsity', @() self.read_Sparsity());
            scope('Feasiblesqpmethod::convexify') = self.field(record, 'Feasiblesqpmethod::convexify', 'bool', @() self.boolValue());
            if self.truth(scope('Feasiblesqpmethod::convexify'))
                self.recordLayout(record, 'Convexify::serialize');
                scope('prefix') = 'Feasiblesqpmethod::';
                self.layout_Convexify_serialize(record, scope);
            end
            self.depth = self.depth - 1;
        end

        function layout_Find_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_FiniteDiff_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'FiniteDiff', 1);
            self.field(record, 'FiniteDiff::n', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FiniteDiff::h_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FiniteDiff::h', 'double', @() self.number('double'));
            self.field(record, 'FiniteDiff::n_z', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FiniteDiff::n_y', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FiniteDiff::u_aim', 'double', @() self.number('double'));
            self.field(record, 'FiniteDiff::h_min', 'double', @() self.number('double'));
            self.field(record, 'FiniteDiff::h_max', 'double', @() self.number('double'));
            self.field(record, 'FiniteDiff::reltol', 'double', @() self.number('double'));
            self.field(record, 'FiniteDiff::abstol', 'double', @() self.number('double'));
            self.field(record, 'FiniteDiff::smoothing', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_FixedStepIntegrator_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Integrator::serialize_body');
            self.layout_Integrator_serialize_body(record, scope);
            self.version(record, 'FixedStepIntegrator', 3);
            self.field(record, 'FixedStepIntegrator::nk_target', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FixedStepIntegrator::disc', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FixedStepIntegrator::nv', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FixedStepIntegrator::nv1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FixedStepIntegrator::nrv', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FixedStepIntegrator::nrv1', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Fmu2_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FmuInternal::serialize_body');
            self.layout_FmuInternal_serialize_body(record, scope);
            self.version(record, 'Fmu2', 2);
            self.field(record, 'Fmu2::vr_real', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu2::vr_integer', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu2::vr_boolean', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu2::vr_string', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu2::init_real', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'Fmu2::init_integer', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'Fmu2::init_boolean', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'Fmu2::init_string', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu2::vn_aux_real', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu2::vn_aux_integer', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu2::vn_aux_boolean', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu2::vn_aux_string', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu2::vr_aux_real', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu2::vr_aux_integer', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu2::vr_aux_boolean', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu2::vr_aux_string', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.depth = self.depth - 1;
        end

        function layout_Fmu3_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FmuInternal::serialize_body');
            self.layout_FmuInternal_serialize_body(record, scope);
            self.version(record, 'Fmu3', 1);
            self.field(record, 'Fmu3::vr_real', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu3::vr_integer', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu3::vr_boolean', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu3::vr_string', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu3::init_real', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'Fmu3::init_integer', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'Fmu3::init_boolean', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'Fmu3::init_string', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu3::vn_aux_real', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu3::vn_aux_integer', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu3::vn_aux_boolean', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu3::vn_aux_string', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Fmu3::vr_aux_real', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu3::vr_aux_integer', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu3::vr_aux_boolean', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'Fmu3::vr_aux_string', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.depth = self.depth - 1;
        end

        function layout_Fmu_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_FmuFunction_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'FmuFunction', 6);
            self.field(record, 'FmuFunction::Fmu', 'Fmu', @() self.read_Fmu());
            for i_1 = 1:self.count(numel(scope('FunctionInternal::sp_in')))
                self.field(record, 'FmuFunction::in::type', 'int', @() self.number('int'));
                self.field(record, 'FmuFunction::in::ind', 'size_t', @() self.number('size_t'));
            end
            for i_2 = 1:self.count(numel(scope('FunctionInternal::sp_out')))
                self.field(record, 'FmuFunction::out::type', 'int', @() self.number('int'));
                self.field(record, 'FmuFunction::out::ind', 'size_t', @() self.number('size_t'));
                self.field(record, 'FmuFunction::out::wrt', 'size_t', @() self.number('size_t'));
                self.field(record, 'FmuFunction::out::rbegin', 'size_t', @() self.number('size_t'));
                self.field(record, 'FmuFunction::out::rend', 'size_t', @() self.number('size_t'));
                self.field(record, 'FmuFunction::out::cbegin', 'size_t', @() self.number('size_t'));
                self.field(record, 'FmuFunction::out::cend', 'size_t', @() self.number('size_t'));
            end
            self.field(record, 'FmuFunction::jac_in', 'std::vector<size_t>', @() self.read_std_vector_size_t());
            self.field(record, 'FmuFunction::jac_out', 'std::vector<size_t>', @() self.read_std_vector_size_t());
            self.field(record, 'FmuFunction::jac_nom_in', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'FmuFunction::sp_trans', 'std::vector<Sparsity>', @() self.read_std_vector_Sparsity());
            self.field(record, 'FmuFunction::sp_trans_map', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FmuFunction::has_jac', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::has_fwd', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::has_adj', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::has_hess', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::uses_directional_derivatives', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::uses_adjoint_derivatives', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::nfwd', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FmuFunction::nadj', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FmuFunction::validate_forward', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::validate_hessian', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::make_symmetric', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::step', 'double', @() self.number('double'));
            self.field(record, 'FmuFunction::fd_flip', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::abstol', 'double', @() self.number('double'));
            self.field(record, 'FmuFunction::reltol', 'double', @() self.number('double'));
            self.field(record, 'FmuFunction::print_progress', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::new_jacobian', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::new_forward', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::new_hessian', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::hessian_coloring', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::asymmetric_hessian_coloring', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::enable_forward_jacobian', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::enable_adjoint_jacobian', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::enable_adjoint_hessian', 'bool', @() self.boolValue());
            self.field(record, 'FmuFunction::validate_ad_file', 'std::string', @() self.stringValue());
            self.field(record, 'FmuFunction::fd', 'int', @() self.number('int'));
            self.field(record, 'FmuFunction::parallelization', 'int', @() self.number('int'));
            self.field(record, 'FmuFunction::init_stats', 'Dict', @() self.read_Dict());
            self.field(record, 'FmuFunction::jac_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuFunction::hess_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuFunction::adj_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuFunction::jac_colors', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuFunction::adj_colors', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuFunction::hess_colors', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuFunction::hess_uni_colors', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuFunction::which_hess_color', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FmuFunction::nonlin', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'FmuFunction::max_jac_tasks', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FmuFunction::max_hess_tasks', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FmuFunction::max_n_tasks', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_FmuInternal_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_FmuInternal_serialize_body(self, record, scope)
            self.enterLayout();
            self.version(record, 'FmuInternal', 4);
            self.field(record, 'FmuInternal::name', 'std::string', @() self.stringValue());
            self.field(record, 'FmuInternal::scheme_in', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'FmuInternal::scheme_out', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'FmuInternal::scheme', 'std::map<std::string,std::vector<size_t>>', @() self.read_std_map_std_string_std_vector_size_t());
            self.field(record, 'FmuInternal::aux', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'FmuInternal::iind', 'std::vector<size_t>', @() self.read_std_vector_size_t());
            self.field(record, 'FmuInternal::iind_map', 'std::vector<size_t>', @() self.read_std_vector_size_t());
            self.field(record, 'FmuInternal::oind', 'std::vector<size_t>', @() self.read_std_vector_size_t());
            self.field(record, 'FmuInternal::oind_map', 'std::vector<size_t>', @() self.read_std_vector_size_t());
            self.field(record, 'FmuInternal::has_independent', 'bool', @() self.boolValue());
            self.field(record, 'FmuInternal::nominal_in', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'FmuInternal::nominal_out', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'FmuInternal::min_in', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'FmuInternal::min_out', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'FmuInternal::max_in', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'FmuInternal::max_out', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'FmuInternal::vn_in', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'FmuInternal::vn_out', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'FmuInternal::vr_in', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'FmuInternal::vr_out', 'std::vector<unsignedint>', @() self.read_std_vector_unsignedint());
            self.field(record, 'FmuInternal::value_in', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'FmuInternal::ired', 'std::vector<std::vector<size_t>>', @() self.read_std_vector_std_vector_size_t());
            self.field(record, 'FmuInternal::ored', 'std::vector<std::vector<size_t>>', @() self.read_std_vector_std_vector_size_t());
            self.field(record, 'FmuInternal::jac_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuInternal::hess_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'FmuInternal::resource', 'Resource', @() self.read_Resource());
            self.field(record, 'FmuInternal::fmutol', 'double', @() self.number('double'));
            self.field(record, 'FmuInternal::instance_name', 'std::string', @() self.stringValue());
            self.field(record, 'FmuInternal::instantiation_token', 'std::string', @() self.stringValue());
            self.field(record, 'FmuInternal::logging_on', 'bool', @() self.boolValue());
            self.field(record, 'FmuInternal::number_of_event_indicators', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FmuInternal::provides_directional_derivatives', 'bool', @() self.boolValue());
            self.field(record, 'FmuInternal::provides_adjoint_derivatives', 'bool', @() self.boolValue());
            self.field(record, 'FmuInternal::can_be_instantiated_only_once_per_process', 'bool', @() self.boolValue());
            self.field(record, 'FmuInternal::start_time', 'double', @() self.number('double'));
            self.field(record, 'FmuInternal::nx', 'size_t', @() self.number('size_t'));
            self.field(record, 'FmuInternal::do_evaluation_dance', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_FmuInternal_serialize_type(self, record, scope)
            self.enterLayout();
            scope('FmuInternal::type') = self.field(record, 'FmuInternal::type', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_ForwardDiff_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FiniteDiff::serialize_body');
            self.layout_FiniteDiff_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Function_serialize(self, record, scope)
            self.enterLayout();
            self.fail('Predicate has no serialized field');
            self.depth = self.depth - 1;
        end

        function layout_FunctionInternal_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'ProtoFunction::serialize_body');
            self.layout_ProtoFunction_serialize_body(record, scope);
            self.version(record, 'FunctionInternal', 8);
            self.field(record, 'FunctionInternal::is_diff_in', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'FunctionInternal::is_diff_out', 'std::vector<bool>', @() self.read_std_vector_bool());
            scope('FunctionInternal::sp_in') = self.field(record, 'FunctionInternal::sp_in', 'std::vector<Sparsity>', @() self.read_std_vector_Sparsity());
            scope('FunctionInternal::sp_out') = self.field(record, 'FunctionInternal::sp_out', 'std::vector<Sparsity>', @() self.read_std_vector_Sparsity());
            self.field(record, 'FunctionInternal::name_in', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'FunctionInternal::name_out', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            scope('FunctionInternal::jit') = self.field(record, 'FunctionInternal::jit', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::jit_cleanup', 'bool', @() self.boolValue());
            scope('FunctionInternal::jit_serialize') = self.field(record, 'FunctionInternal::jit_serialize', 'std::string', @() self.stringValue());
            if self.truth((self.truth(isequal(scope('FunctionInternal::jit_serialize'), 'link')) || self.truth(isequal(scope('FunctionInternal::jit_serialize'), 'embed'))))
                self.field(record, 'FunctionInternal::jit_library', 'std::string', @() self.stringValue());
                if self.truth(isequal(scope('FunctionInternal::jit_serialize'), 'embed'))
                    self.field(record, 'FunctionInternal::jit_binary', 'std::stringstream', @() self.streamValue());
                end
            end
            self.field(record, 'FunctionInternal::jit_temp_suffix', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::jit_base_name', 'std::string', @() self.stringValue());
            self.field(record, 'FunctionInternal::jit_options', 'Dict', @() self.read_Dict());
            self.field(record, 'FunctionInternal::compiler_plugin', 'std::string', @() self.stringValue());
            self.field(record, 'FunctionInternal::has_refcount', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::cache_init', 'Dict', @() self.read_Dict());
            self.field(record, 'FunctionInternal::derivative_of', 'Function', @() self.read_Function());
            self.field(record, 'FunctionInternal::jac_penalty', 'double', @() self.number('double'));
            self.field(record, 'FunctionInternal::enable_forward', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::enable_reverse', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::enable_jacobian', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::enable_fd', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::enable_forward_op', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::enable_reverse_op', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::enable_jacobian_op', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::enable_fd_op', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::ad_weight', 'double', @() self.number('double'));
            self.field(record, 'FunctionInternal::ad_weight_sp', 'double', @() self.number('double'));
            self.field(record, 'FunctionInternal::always_inline', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::never_inline', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::max_num_dir', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FunctionInternal::inputs_check', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::fd_step', 'double', @() self.number('double'));
            self.field(record, 'FunctionInternal::fd_method', 'std::string', @() self.stringValue());
            self.field(record, 'FunctionInternal::print_in', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::print_out', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::print_canonical', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::max_io', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'FunctionInternal::dump_in', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::dump_out', 'bool', @() self.boolValue());
            self.field(record, 'FunctionInternal::dump_dir', 'std::string', @() self.stringValue());
            self.field(record, 'FunctionInternal::dump_format', 'std::string', @() self.stringValue());
            self.field(record, 'FunctionInternal::forward_options', 'Dict', @() self.read_Dict());
            self.field(record, 'FunctionInternal::reverse_options', 'Dict', @() self.read_Dict());
            self.field(record, 'FunctionInternal::jacobian_options', 'Dict', @() self.read_Dict());
            self.field(record, 'FunctionInternal::der_options', 'Dict', @() self.read_Dict());
            self.field(record, 'FunctionInternal::custom_jacobian', 'Function', @() self.read_Function());
            self.field(record, 'FunctionInternal::registered_functions', 'std::vector<Function>', @() self.read_std_vector_Function());
            self.field(record, 'FunctionInternal::sz_arg_per', 'size_t', @() self.number('size_t'));
            self.field(record, 'FunctionInternal::sz_res_per', 'size_t', @() self.number('size_t'));
            self.field(record, 'FunctionInternal::sz_iw_per', 'size_t', @() self.number('size_t'));
            self.field(record, 'FunctionInternal::sz_w_per', 'size_t', @() self.number('size_t'));
            self.field(record, 'FunctionInternal::sz_arg_tmp', 'size_t', @() self.number('size_t'));
            self.field(record, 'FunctionInternal::sz_res_tmp', 'size_t', @() self.number('size_t'));
            self.field(record, 'FunctionInternal::sz_iw_tmp', 'size_t', @() self.number('size_t'));
            self.field(record, 'FunctionInternal::sz_w_tmp', 'size_t', @() self.number('size_t'));
            self.depth = self.depth - 1;
        end

        function layout_FunctionInternal_serialize_type(self, record, scope)
            self.enterLayout();
            scope('FunctionInternal::base_function') = self.field(record, 'FunctionInternal::base_function', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_GenericExternal_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_type');
            self.layout_FunctionInternal_serialize_type(record, scope);
            self.version(record, 'GenericExternal', 1);
            scope('GenericExternal::type') = self.field(record, 'GenericExternal::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_GenericType_serialize(self, record, scope)
            self.enterLayout();
            scope('GenericType::type') = self.field(record, 'GenericType::type', 'int', @() self.number('int'));
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_GetNonzeros_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_GetNonzeros_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosParam_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosParam_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosParamParam_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzerosParam::serialize_body');
            self.layout_GetNonzerosParam_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosParamParam_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzerosParam::serialize_type');
            self.layout_GetNonzerosParam_serialize_type(record, scope);
            scope('GetNonzerosParam::type') = self.field(record, 'GetNonzerosParam::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosParamSlice_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzerosParam::serialize_body');
            self.layout_GetNonzerosParam_serialize_body(record, scope);
            self.field(record, 'GetNonzerosParamSlice::outer', 'Slice', @() self.read_Slice());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosParamSlice_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzerosParam::serialize_type');
            self.layout_GetNonzerosParam_serialize_type(record, scope);
            scope('GetNonzerosParam::type') = self.field(record, 'GetNonzerosParam::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosParamVector_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzerosParam::serialize_body');
            self.layout_GetNonzerosParam_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosParamVector_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzerosParam::serialize_type');
            self.layout_GetNonzerosParam_serialize_type(record, scope);
            scope('GetNonzerosParam::type') = self.field(record, 'GetNonzerosParam::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosSlice2_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzeros::serialize_body');
            self.layout_GetNonzeros_serialize_body(record, scope);
            self.field(record, 'GetNonzerosSlice2::inner', 'Slice', @() self.read_Slice());
            self.field(record, 'GetNonzerosSlice2::outer', 'Slice', @() self.read_Slice());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosSlice2_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzeros::serialize_type');
            self.layout_GetNonzeros_serialize_type(record, scope);
            scope('GetNonzeros::type') = self.field(record, 'GetNonzeros::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosSlice_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzeros::serialize_body');
            self.layout_GetNonzeros_serialize_body(record, scope);
            self.field(record, 'GetNonzerosSlice::slice', 'Slice', @() self.read_Slice());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosSlice_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzeros::serialize_type');
            self.layout_GetNonzeros_serialize_type(record, scope);
            scope('GetNonzeros::type') = self.field(record, 'GetNonzeros::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosSliceParam_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzerosParam::serialize_body');
            self.layout_GetNonzerosParam_serialize_body(record, scope);
            self.field(record, 'GetNonzerosSliceParam::inner', 'Slice', @() self.read_Slice());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosSliceParam_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzerosParam::serialize_type');
            self.layout_GetNonzerosParam_serialize_type(record, scope);
            scope('GetNonzerosParam::type') = self.field(record, 'GetNonzerosParam::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosVector_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzeros::serialize_body');
            self.layout_GetNonzeros_serialize_body(record, scope);
            self.field(record, 'GetNonzerosVector::nonzeros', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_GetNonzerosVector_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'GetNonzeros::serialize_type');
            self.layout_GetNonzeros_serialize_type(record, scope);
            scope('GetNonzeros::type') = self.field(record, 'GetNonzeros::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_GurobiInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'GurobiInterface', 2);
            self.field(record, 'GurobiInterface::lazy_constraints_callback', 'Function', @() self.read_Function());
            self.field(record, 'GurobiInterface::vtype', 'std::vector<char>', @() self.read_std_vector_char());
            self.field(record, 'GurobiInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'GurobiInterface::sos_weights', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'GurobiInterface::sos_beg', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'GurobiInterface::sos_ind', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'GurobiInterface::sos_types', 'std::vector<int>', @() self.read_std_vector_int());
            self.recordLayout(record, 'Conic::serialize');
            self.layout_Conic_serialize(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_HighsInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'HighsInterface', 1);
            self.field(record, 'HighsInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_HorzRepmat_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'HorzRepmat::n', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_HorzRepsum_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'HorzRepsum::n', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Horzcat_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Concat::serialize_body');
            self.layout_Concat_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Horzsplit_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Split::serialize_body');
            self.layout_Split_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_HpipmInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'HpipmInterface', 1);
            self.depth = self.depth - 1;
        end

        function layout_HpmpcInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_IOInstruction_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'IOInstruction::ind', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'IOInstruction::segment', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'IOInstruction::offset', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_IdasInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'SundialsInterface::serialize_body');
            self.layout_SundialsInterface_serialize_body(record, scope);
            self.version(record, 'IdasInterface', 2);
            self.field(record, 'IdasInterface::cj_scaling', 'bool', @() self.boolValue());
            self.field(record, 'IdasInterface::calc_ic', 'bool', @() self.boolValue());
            self.field(record, 'IdasInterface::calc_icB', 'bool', @() self.boolValue());
            self.field(record, 'IdasInterface::suppress_algebraic', 'bool', @() self.boolValue());
            self.field(record, 'IdasInterface::abstolv', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'IdasInterface::first_time', 'double', @() self.number('double'));
            self.field(record, 'IdasInterface::init_xdot', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'IdasInterface::max_step_size', 'double', @() self.number('double'));
            self.field(record, 'IdasInterface::y_c', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_ImplicitFixedStepIntegrator_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FixedStepIntegrator::serialize_body');
            self.layout_FixedStepIntegrator_serialize_body(record, scope);
            self.version(record, 'ImplicitFixedStepIntegrator', 2);
            self.depth = self.depth - 1;
        end

        function layout_ImplicitToNlp_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Rootfinder::serialize_body');
            self.layout_Rootfinder_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Importer_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_ImporterInternal_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_ImporterInternal_serialize_body(self, record, scope)
            self.enterLayout();
            self.version(record, 'ImporterInternal', 1);
            self.field(record, 'ImporterInternal::name', 'std::string', @() self.stringValue());
            self.field(record, 'ImporterInternal::meta', 'std::map<std::string,std::pair<casadi_int,std::string>>', @() self.read_std_map_std_string_std_pair_casadi_int__327());
            self.field(record, 'ImporterInternal::external', 'std::map<std::string,std::pair<bool,std::string>>', @() self.read_std_map_std_string_std_pair_bool_std_string());
            self.depth = self.depth - 1;
        end

        function layout_ImporterInternal_serialize_type(self, record, scope)
            self.enterLayout();
            scope('ImporterInternal::type') = self.field(record, 'ImporterInternal::type', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_InfSX_serialize_node(self, record, scope)
            self.enterLayout();
            scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_Input_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'IOInstruction::serialize_body');
            self.layout_IOInstruction_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_IntegerSX_serialize_node(self, record, scope)
            self.enterLayout();
            scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
            self.field(record, 'ConstantSX::value', 'int', @() self.number('int'));
            self.depth = self.depth - 1;
        end

        function layout_Integrator_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'OracleFunction::serialize_body');
            self.layout_OracleFunction_serialize_body(record, scope);
            self.version(record, 'Integrator', 3);
            self.field(record, 'Integrator::sp_jac_dae', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Integrator::sp_jac_rdae', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Integrator::t0', 'double', @() self.number('double'));
            self.field(record, 'Integrator::tout', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'Integrator::nfwd', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nadj', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::rdae', 'Function', @() self.read_Function());
            self.field(record, 'Integrator::nx', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nz', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nq', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nx1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nz1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nq1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nrx', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nrz', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nrq', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nuq', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nrx1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nrz1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nrq1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nuq1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::np', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nrp', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::np1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nrp1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nu', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nu1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::ne', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::ntmp', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::nom_x', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'Integrator::nom_z', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'Integrator::augmented_options', 'Dict', @() self.read_Dict());
            self.field(record, 'Integrator::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'Integrator::print_stats', 'bool', @() self.boolValue());
            self.field(record, 'Integrator::transition', 'Function', @() self.read_Function());
            self.field(record, 'Integrator::max_event_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::max_events', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Integrator::event_tol', 'double', @() self.number('double'));
            self.field(record, 'Integrator::event_acceptable_tol', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_Integrator_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'OracleFunction::serialize_type');
            self.layout_OracleFunction_serialize_type(record, scope);
            self.recordLayout(record, 'PluginInterface<Integrator>::serialize_type');
            self.layout_PluginInterface_Integrator_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Interpolant_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'Interpolant', 2);
            self.field(record, 'Interpolant::ndim', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Interpolant::m', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Interpolant::grid', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'Interpolant::offset', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Interpolant::values', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'Interpolant::lookup_modes', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'Interpolant::batch_x', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Interpolant_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_type');
            self.layout_FunctionInternal_serialize_type(record, scope);
            self.recordLayout(record, 'PluginInterface<Interpolant>::serialize_type');
            self.layout_PluginInterface_Interpolant_serialize_type_2(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Inverse_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_IpoptInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'IpoptInterface', 3);
            self.field(record, 'IpoptInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'IpoptInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'IpoptInterface::exact_hessian', 'bool', @() self.boolValue());
            self.field(record, 'IpoptInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'IpoptInterface::pass_nonlinear_variables', 'bool', @() self.boolValue());
            self.field(record, 'IpoptInterface::nl_ex', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'IpoptInterface::var_string_md', 'Dict', @() self.read_Dict());
            self.field(record, 'IpoptInterface::var_integer_md', 'Dict', @() self.read_Dict());
            self.field(record, 'IpoptInterface::var_numeric_md', 'Dict', @() self.read_Dict());
            self.field(record, 'IpoptInterface::con_string_md', 'Dict', @() self.read_Dict());
            self.field(record, 'IpoptInterface::con_integer_md', 'Dict', @() self.read_Dict());
            self.field(record, 'IpoptInterface::con_numeric_md', 'Dict', @() self.read_Dict());
            scope('IpoptInterface::convexify') = self.field(record, 'IpoptInterface::convexify', 'bool', @() self.boolValue());
            if self.truth(scope('IpoptInterface::convexify'))
                self.recordLayout(record, 'Convexify::serialize');
                scope('prefix') = 'IpoptInterface::';
                self.layout_Convexify_serialize(record, scope);
            end
            self.field(record, 'IpoptInterface::clip_inactive_lam', 'bool', @() self.boolValue());
            self.field(record, 'IpoptInterface::inactive_lam_strategy', 'std::string', @() self.stringValue());
            self.field(record, 'IpoptInterface::inactive_lam_value', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_Ipqp_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'Ipqp', 1);
            self.field(record, 'Ipqp::kkt', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Ipqp::print_iter', 'bool', @() self.boolValue());
            self.field(record, 'Ipqp::print_header', 'bool', @() self.boolValue());
            self.field(record, 'Ipqp::print_info', 'bool', @() self.boolValue());
            self.field(record, 'Ipqp::linear_solver', 'std::string', @() self.stringValue());
            self.field(record, 'Ipqp::linear_solver_options', 'Dict', @() self.read_Dict());
            self.field(record, 'Ipqp::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Ipqp::pr_tol', 'double', @() self.number('double'));
            self.field(record, 'Ipqp::du_tol', 'double', @() self.number('double'));
            self.field(record, 'Ipqp::co_tol', 'double', @() self.number('double'));
            self.field(record, 'Ipqp::mu_tol', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_KinsolInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Rootfinder::serialize_body');
            self.layout_Rootfinder_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_KnitroInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'KnitroInterface', 2);
            self.field(record, 'KnitroInterface::contype', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'KnitroInterface::comp_type', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'KnitroInterface::comp_i1', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'KnitroInterface::comp_i2', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'KnitroInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'KnitroInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'KnitroInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'KnitroInterface::options_file', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_Kron_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Kron_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Kron::kind') = self.field(record, 'Kron::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_KronContract_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'KronContract::inner', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_KronContract_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('KronContract::kind') = self.field(record, 'KronContract::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_LapackLu_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.version(record, 'LapackLu', 1);
            self.field(record, 'LapackLu::equilibriate', 'bool', @() self.boolValue());
            self.field(record, 'LapackLu::allow_equilibration_failure', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_LapackQr_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.field(record, 'LapackQr::max_nrhs', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_LinearInterpolant_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Interpolant::serialize_body');
            self.layout_Interpolant_serialize_body(record, scope);
            self.field(record, 'LinearInterpolant::lookup_mode', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_LinearInterpolant_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Interpolant::serialize_type');
            self.layout_Interpolant_serialize_type(record, scope);
            self.version(record, 'LinearInterpolant', 1);
            scope('LinearInterpolant::type') = self.field(record, 'LinearInterpolant::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_LinearInterpolantJac_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_LinearInterpolantJac_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_type');
            self.layout_FunctionInternal_serialize_type(record, scope);
            self.recordLayout(record, '>PluginInterface<Interpolant>::serialize_type');
            self.layout_PluginInterface_Interpolant_serialize_type(record, scope);
            self.version(record, 'LinearInterpolant', 1);
            scope('LinearInterpolant::type') = self.field(record, 'LinearInterpolant::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_Linsol_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_LinsolCall_Tr_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Solve<Tr>::serialize_body');
            self.layout_Solve_Tr_serialize_body(record, scope);
            self.field(record, 'Solve::Linsol', 'Linsol', @() self.read_Linsol());
            self.depth = self.depth - 1;
        end

        function layout_LinsolCall_Tr_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Solve<Tr>::serialize_type');
            self.layout_Solve_Tr_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_LinsolInternal_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'ProtoFunction::serialize_body');
            self.layout_ProtoFunction_serialize_body(record, scope);
            self.field(record, 'LinsolInternal::sp', 'Sparsity', @() self.read_Sparsity());
            self.depth = self.depth - 1;
        end

        function layout_LinsolInternal_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'ProtoFunction::serialize_type');
            self.layout_ProtoFunction_serialize_type(record, scope);
            self.recordLayout(record, 'PluginInterface<LinsolInternal>::serialize_type');
            self.layout_PluginInterface_LinsolInternal_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_LinsolLdl_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.version(record, 'LinsolLdl', 1);
            self.field(record, 'LinsolLdl::p', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'LinsolLdl::sp_Lt', 'Sparsity', @() self.read_Sparsity());
            self.depth = self.depth - 1;
        end

        function layout_LinsolQr_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.version(record, 'LinsolQr', 2);
            self.field(record, 'LinsolQr::prinv', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'LinsolQr::pc', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'LinsolQr::sp_v', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'LinsolQr::sp_r', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'LinsolQr::eps', 'double', @() self.number('double'));
            self.field(record, 'LinsolQr::n_cache', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_LinsolTridiag_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_LogSumExp_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Low_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'Low::lookup_mode', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Lsqr_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_MMax_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_MMin_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_MX_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_MXFunction_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'XFunction<MXFunction,MX,MXNode>::serialize_body');
            self.layout_XFunction_MXFunction_MX_MXNode_serialize_body(record, scope);
            self.version(record, 'MXFunction', 3);
            scope('MXFunction::n_instr') = self.field(record, 'MXFunction::n_instr', 'size_t', @() self.number('size_t'));
            for i_3 = 1:self.count(scope('MXFunction::n_instr'))
                self.field(record, 'MXFunction::alg::data', 'MX', @() self.read_MX());
                self.field(record, 'MXFunction::alg::arg', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
                self.field(record, 'MXFunction::alg::res', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            end
            self.field(record, 'MXFunction::workloc', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'MXFunction::free_vars', 'std::vector<MX>', @() self.read_std_vector_MX());
            self.field(record, 'MXFunction::default_in', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'MXFunction::live_variables', 'bool', @() self.boolValue());
            self.field(record, 'MXFunction::print_instructions', 'bool', @() self.boolValue());
            self.field(record, 'MXFunction::dump_trace', 'bool', @() self.boolValue());
            self.recordLayout(record, 'XFunction<MXFunction,MX,MXNode>::delayed_serialize_members');
            self.layout_XFunction_MXFunction_MX_MXNode_delaye_278(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_MXNode_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_MXNode_serialize_body(self, record, scope)
            self.enterLayout();
            self.field(record, 'MXNode::deps', 'std::vector<MX>', @() self.read_std_vector_MX());
            self.field(record, 'MXNode::sp', 'Sparsity', @() self.read_Sparsity());
            self.depth = self.depth - 1;
        end

        function layout_MXNode_serialize_type(self, record, scope)
            self.enterLayout();
            scope('MXNode::op') = self.field(record, 'MXNode::op', 'int', @() self.number('int'));
            self.depth = self.depth - 1;
        end

        function layout_Ma27Interface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_MadmpecInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'MadmpecInterface', 1);
            self.field(record, 'MadmpecInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'MadmpecInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'MadmpecInterface::exact_hessian', 'bool', @() self.boolValue());
            self.field(record, 'MadmpecInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'MadmpecInterface::convexify', 'bool', @() self.boolValue());
            self.field(record, 'MadmpecInterface::ind_cc1', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'MadmpecInterface::ind_cc2', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'MadmpecInterface::cctypes', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_MadnlpInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'MadnlpInterface', 2);
            self.field(record, 'MadnlpInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'MadnlpInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'MadnlpInterface::exact_hessian', 'bool', @() self.boolValue());
            self.field(record, 'MadnlpInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'MadnlpInterface::convexify', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_Map_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.field(record, 'Map::f', 'Function', @() self.read_Function());
            self.field(record, 'Map::n', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Map_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_type');
            self.layout_FunctionInternal_serialize_type(record, scope);
            scope('Map::class_name') = self.field(record, 'Map::class_name', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_MapSum_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.field(record, 'MapSum::f', 'Function', @() self.read_Function());
            self.field(record, 'MapSum::n', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'MapSum::reduce_in', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'MapSum::reduce_out', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.depth = self.depth - 1;
        end

        function layout_MapSum_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_type');
            self.layout_FunctionInternal_serialize_type(record, scope);
            scope('MapSum::class_name') = self.field(record, 'MapSum::class_name', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_Matrix_SXElem_serialize(self, record, scope)
            self.enterLayout();
            self.field(record, 'Matrix::sparsity', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Matrix::nonzeros', 'std::vector<SXElem>', @() self.read_std_vector_SXElem());
            self.depth = self.depth - 1;
        end

        function layout_Matrix_casadi_int_serialize(self, record, scope)
            self.enterLayout();
            self.field(record, 'Matrix::sparsity', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Matrix::nonzeros', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_Matrix_double_serialize(self, record, scope)
            self.enterLayout();
            self.field(record, 'Matrix::sparsity', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Matrix::nonzeros', 'std::vector<double>', @() self.read_std_vector_double());
            self.depth = self.depth - 1;
        end

        function layout_MinusInfSX_serialize_node(self, record, scope)
            self.enterLayout();
            scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_MinusOneSX_serialize_node(self, record, scope)
            self.enterLayout();
            scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_Monitor_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'Monitor::comment', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_MosekInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'MosekInterface', 1);
            self.field(record, 'MosekInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_MultipleOutput_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Multiplication_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'Multiplication::blas', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_Multiplication_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Multiplication::kind') = self.field(record, 'Multiplication::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_MumpsInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.version(record, 'Mumps', 1);
            self.field(record, 'MumpsInterface::symmetric', 'bool', @() self.boolValue());
            self.field(record, 'MumpsInterface::posdef', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_NanSX_serialize_node(self, record, scope)
            self.enterLayout();
            scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_Newton_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Rootfinder::serialize_body');
            self.layout_Rootfinder_serialize_body(record, scope);
            self.version(record, 'Newton', 1);
            self.field(record, 'Newton::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Newton::abstol', 'double', @() self.number('double'));
            self.field(record, 'Newton::abstolStep', 'double', @() self.number('double'));
            self.field(record, 'Newton::print_iteration', 'bool', @() self.boolValue());
            self.field(record, 'Newton::line_search', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_Nlpsol_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'OracleFunction::serialize_body');
            self.layout_OracleFunction_serialize_body(record, scope);
            self.version(record, 'Nlpsol', 5);
            self.field(record, 'Nlpsol::nx', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Nlpsol::ng', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Nlpsol::np', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Nlpsol::fcallback', 'Function', @() self.read_Function());
            self.field(record, 'Nlpsol::callback_step', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Nlpsol::eval_errors_fatal', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::warn_initial_bounds', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::iteration_callback_ignore_errors', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::calc_multipliers', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::calc_lam_x', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::calc_lam_p', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::calc_f', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::calc_g', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::min_lam', 'double', @() self.number('double'));
            self.field(record, 'Nlpsol::bound_consistency', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::no_nlp_grad', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::discrete', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'Nlpsol::equality', 'std::vector<bool>', @() self.read_std_vector_bool());
            self.field(record, 'Nlpsol::mi', 'bool', @() self.boolValue());
            self.field(record, 'Nlpsol::sens_linsol', 'std::string', @() self.stringValue());
            self.field(record, 'Nlpsol::sens_linsol_options', 'Dict', @() self.read_Dict());
            self.field(record, 'Nlpsol::detect_simple_bounds_is_simple', 'std::vector<char>', @() self.read_std_vector_char());
            self.field(record, 'Nlpsol::detect_simple_bounds_parts', 'Function', @() self.read_Function());
            self.field(record, 'Nlpsol::detect_simple_bounds_target_x', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_Nlpsol_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'OracleFunction::serialize_type');
            self.layout_OracleFunction_serialize_type(record, scope);
            self.recordLayout(record, 'PluginInterface<Nlpsol>::serialize_type');
            self.layout_PluginInterface_Nlpsol_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Norm1_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Norm::serialize_body');
            self.layout_Norm_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Norm2_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Norm::serialize_body');
            self.layout_Norm_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Norm_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_NormF_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Norm::serialize_body');
            self.layout_Norm_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_NormInf_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Norm::serialize_body');
            self.layout_Norm_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_OmpMap_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Map::serialize_body');
            self.layout_Map_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_OneSX_serialize_node(self, record, scope)
            self.enterLayout();
            scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_OnnxFunction_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'OnnxFunction', 2);
            self.field(record, 'OnnxFunction::model_data', 'std::string', @() self.stringValue());
            self.recordLayout(record, 'pack_tensors');
            scope('d') = 'OnnxFunction::in';
            self.layout_pack_tensors(record, scope);
            self.recordLayout(record, 'pack_tensors');
            scope('d') = 'OnnxFunction::out';
            self.layout_pack_tensors(record, scope);
            self.recordLayout(record, 'pack_tensors');
            scope('d') = 'OnnxFunction::all_in';
            self.layout_pack_tensors(record, scope);
            self.field(record, 'OnnxFunction::in_src', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'OnnxFunction::in_val', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'OnnxFunction::model_inputs', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'OnnxFunction::model_outputs', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'OnnxFunction::fwd_dim', 'std::string', @() self.stringValue());
            self.field(record, 'OnnxFunction::adj_dim', 'std::string', @() self.stringValue());
            self.field(record, 'OnnxFunction::input_values', 'std::map<std::string,std::vector<double>>', @() self.read_std_map_std_string_std_vector_double());
            self.field(record, 'OnnxFunction::model_path', 'std::string', @() self.stringValue());
            self.field(record, 'OnnxFunction::dim_bindings', 'std::map<std::string,casadi_int>', @() self.read_std_map_std_string_casadi_int());
            self.field(record, 'OnnxFunction::input_shapes', 'std::map<std::string,std::vector<casadi_int>>', @() self.read_std_map_std_string_std_vector_casadi_int());
            self.field(record, 'OnnxFunction::derivative_opts', 'Dict', @() self.read_Dict());
            self.field(record, 'OnnxFunction::builder_opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_OnnxFunction_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_type');
            self.layout_FunctionInternal_serialize_type(record, scope);
            self.recordLayout(record, 'PluginInterface<OnnxFunction>::serialize_type');
            self.layout_PluginInterface_OnnxFunction_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_OnnxRuntimeInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'OnnxFunction::serialize_body');
            self.layout_OnnxFunction_serialize_body(record, scope);
            self.version(record, 'OnnxRuntimeInterface', 1);
            self.field(record, 'OnnxRuntimeInterface::provider', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_OoqpInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'OoqpInterface', 1);
            self.field(record, 'OoqpInterface::spAT', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'OoqpInterface::nQ', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OoqpInterface::nH', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OoqpInterface::nA', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OoqpInterface::print_level', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OoqpInterface::mutol', 'double', @() self.number('double'));
            self.field(record, 'OoqpInterface::artol', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_OracleFunction_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'OracleFunction', 3);
            self.field(record, 'OracleFunction::oracle', 'Function', @() self.read_Function());
            self.field(record, 'OracleFunction::common_options', 'Dict', @() self.read_Dict());
            self.field(record, 'OracleFunction::specific_options', 'Dict', @() self.read_Dict());
            self.field(record, 'OracleFunction::show_eval_warnings', 'bool', @() self.boolValue());
            self.field(record, 'OracleFunction::max_num_threads', 'int', @() self.number('int'));
            scope('OracleFunction::all_functions::size') = self.field(record, 'OracleFunction::all_functions::size', 'size_t', @() self.number('size_t'));
            for i_4 = 1:self.count(scope('OracleFunction::all_functions::size'))
                self.field(record, 'OracleFunction::all_functions::key', 'std::string', @() self.stringValue());
                scope('OracleFunction::all_functions::value::jit') = self.field(record, 'OracleFunction::all_functions::value::jit', 'bool', @() self.boolValue());
                if self.truth((self.truth(scope('FunctionInternal::jit')) && self.truth(scope('OracleFunction::all_functions::value::jit'))))
                    if self.truth(isequal(scope('FunctionInternal::jit_serialize'), 'source'))
                        self.field(record, 'OracleFunction::all_functions::value::f', 'Function', @() self.read_Function());
                    else
                        self.field(record, 'OracleFunction::all_functions::value::f_name', 'std::string', @() self.stringValue());
                    end
                else
                    self.field(record, 'OracleFunction::all_functions::value::f', 'Function', @() self.read_Function());
                end
                self.field(record, 'OracleFunction::all_functions::value::monitored', 'bool', @() self.boolValue());
            end
            self.field(record, 'OracleFunction::monitor', 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, 'OracleFunction::stride_arg', 'size_t', @() self.number('size_t'));
            self.field(record, 'OracleFunction::stride_res', 'size_t', @() self.number('size_t'));
            self.field(record, 'OracleFunction::stride_iw', 'size_t', @() self.number('size_t'));
            self.field(record, 'OracleFunction::stride_w', 'size_t', @() self.number('size_t'));
            self.depth = self.depth - 1;
        end

        function layout_OracleFunction_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_type');
            self.layout_FunctionInternal_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_OsqpInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'OsqpInterface', 2);
            self.field(record, 'OsqpInterface::nnzHupp', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::nnzA', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::warm_start_primal', 'bool', @() self.boolValue());
            self.field(record, 'OsqpInterface::warm_start_dual', 'bool', @() self.boolValue());
            self.field(record, 'OsqpInterface::settings::rho', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::sigma', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::scaling', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::adaptive_rho', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::adaptive_rho_interval', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::adaptive_rho_tolerance', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::eps_abs', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::eps_rel', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::eps_prim_inf', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::eps_dual_inf', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::alpha', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::delta', 'double', @() self.number('double'));
            self.field(record, 'OsqpInterface::settings::polish', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::polish_refine_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::verbose', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::scaled_termination', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::check_termination', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::settings::warm_start', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'OsqpInterface::rho_initial', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_Output_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'IOInstruction::serialize_body');
            self.layout_IOInstruction_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_OutputNode_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'OutputNode::oind', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_OutputSX_serialize_node(self, record, scope)
            self.enterLayout();
            self.field(record, 'OutputSX::dep', 'SXElem', @() self.read_SXElem());
            self.field(record, 'OutputSX::oind', 'int', @() self.number('int'));
            self.depth = self.depth - 1;
        end

        function layout_PiqpInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'PiqpInterface', 1);
            self.field(record, 'PiqpInterface::nnzH', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'PiqpInterface::nnzA', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'PiqpInterface::settings::rho_init', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::delta_init', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::eps_abs', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::eps_rel', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::check_duality_gap', 'bool', @() self.boolValue());
            self.field(record, 'PiqpInterface::settings::eps_duality_gap_abs', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::eps_duality_gap_rel', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::reg_lower_limit', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::reg_finetune_lower_limit', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::reg_finetune_primal_update_threshold', 'size_t', @() self.number('size_t'));
            self.field(record, 'PiqpInterface::settings::reg_finetune_dual_update_threshold', 'size_t', @() self.number('size_t'));
            self.field(record, 'PiqpInterface::settings::max_iter', 'size_t', @() self.number('size_t'));
            self.field(record, 'PiqpInterface::settings::max_factor_retires', 'size_t', @() self.number('size_t'));
            self.field(record, 'PiqpInterface::settings::preconditioner_scale_cost', 'bool', @() self.boolValue());
            self.field(record, 'PiqpInterface::settings::preconditioner_iter', 'size_t', @() self.number('size_t'));
            self.field(record, 'PiqpInterface::settings::tau', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::iterative_refinement_always_enabled', 'bool', @() self.boolValue());
            self.field(record, 'PiqpInterface::settings::iterative_refinement_eps_abs', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::iterative_refinement_eps_rel', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::iterative_refinement_max_iter', 'size_t', @() self.number('size_t'));
            self.field(record, 'PiqpInterface::settings::iterative_refinement_min_improvement_rate', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::iterative_refinement_static_regularization_eps', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::iterative_refinement_static_regularization_rel', 'double', @() self.number('double'));
            self.field(record, 'PiqpInterface::settings::verbose', 'bool', @() self.boolValue());
            self.field(record, 'PiqpInterface::settings::compute_timings', 'bool', @() self.boolValue());
            self.field(record, 'PiqpInterface::settings::kkt_solver', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_serialize_type(self, record, scope)
            self.enterLayout();
            scope('PluginInterface::plugin_name') = self.field(record, 'PluginInterface::plugin_name', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_Project_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Project_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Project::type') = self.field(record, 'Project::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_ProtoFunction_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_ProtoFunction_serialize_body(self, record, scope)
            self.enterLayout();
            self.version(record, 'ProtoFunction', 2);
            self.field(record, 'ProtoFunction::name', 'std::string', @() self.stringValue());
            self.field(record, 'ProtoFunction::verbose', 'bool', @() self.boolValue());
            self.field(record, 'ProtoFunction::print_time', 'bool', @() self.boolValue());
            self.field(record, 'ProtoFunction::record_time', 'bool', @() self.boolValue());
            self.field(record, 'ProtoFunction::regularity_check', 'bool', @() self.boolValue());
            self.field(record, 'ProtoFunction::error_on_fail', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_ProtoFunction_serialize_type(self, record, scope)
            self.enterLayout();
            self.depth = self.depth - 1;
        end

        function layout_ProxqpInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'ProxqpInterface', 1);
            self.field(record, 'ProxqpInterface::warm_start_primal', 'bool', @() self.boolValue());
            self.field(record, 'ProxqpInterface::warm_start_dual', 'bool', @() self.boolValue());
            self.field(record, 'ProxqpInterface::settings::default_rho', 'double', @() self.number('double'));
            self.field(record, 'ProxqpInterface::settings::default_mu_eq', 'double', @() self.number('double'));
            self.field(record, 'ProxqpInterface::settings::default_mu_in', 'double', @() self.number('double'));
            self.field(record, 'ProxqpInterface::settings::eps_abs', 'double', @() self.number('double'));
            self.field(record, 'ProxqpInterface::settings::eps_rel', 'double', @() self.number('double'));
            self.field(record, 'ProxqpInterface::settings::max_iter', 'double', @() self.number('double'));
            self.field(record, 'ProxqpInterface::settings::verbose', 'bool', @() self.boolValue());
            self.field(record, 'ProxqpInterface::settings::sparse_backend', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_PseudoDenseMultiplication_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Multiplication::serialize_body');
            self.layout_Multiplication_serialize_body(record, scope);
            self.field(record, 'PseudoDenseMultiplication::a', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'PseudoDenseMultiplication::b', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'PseudoDenseMultiplication::c', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_PseudoDenseMultiplication_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Multiplication::kind') = self.field(record, 'Multiplication::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_QpToNlp_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'QpToNlp', 1);
            self.field(record, 'QpToNlp::solver', 'Function', @() self.read_Function());
            self.depth = self.depth - 1;
        end

        function layout_QpoasesInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'QpoasesInterface', 1);
            self.field(record, 'QpoasesInterface::max_nWSR', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'QpoasesInterface::max_cputime', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::hess', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'QpoasesInterface::sparse', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::schur', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::max_schur', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'QpoasesInterface::linsol_plugin', 'std::string', @() self.stringValue());
            self.field(record, 'QpoasesInterface::ops::printLevel', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'QpoasesInterface::ops::enableRamping', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::ops::enableFarBounds', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::ops::enableFlippingBounds', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::ops::enableRegularisation', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::ops::enableFullLITests', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::ops::enableNZCTests', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::ops::enableDriftCorrection', 'int', @() self.number('int'));
            self.field(record, 'QpoasesInterface::ops::enableCholeskyRefactorisation', 'int', @() self.number('int'));
            self.field(record, 'QpoasesInterface::ops::enableEqualities', 'bool', @() self.boolValue());
            self.field(record, 'QpoasesInterface::ops::terminationTolerance', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::boundTolerance', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::boundRelaxation', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::epsNum', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::epsDen', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::maxPrimalJump', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::maxDualJump', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::initialRamping', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::finalRamping', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::initialFarBounds', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::growFarBounds', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::initialStatusBounds', 'std::string', @() self.stringValue());
            self.field(record, 'QpoasesInterface::ops::epsFlipping', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::numRegularisationSteps', 'int', @() self.number('int'));
            self.field(record, 'QpoasesInterface::ops::epsRegularisation', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::numRefinementSteps', 'int', @() self.number('int'));
            self.field(record, 'QpoasesInterface::ops::epsIterRef', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::epsLITests', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::epsNZCTests', 'double', @() self.number('double'));
            self.field(record, 'QpoasesInterface::ops::enableInertiaCorrection', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_Qrqp_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'Qrqp', 1);
            self.field(record, 'Qrqp::AT', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Qrqp::kkt', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Qrqp::sp_v', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Qrqp::sp_r', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Qrqp::prinv', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Qrqp::pc', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Qrqp::print_iter', 'bool', @() self.boolValue());
            self.field(record, 'Qrqp::print_header', 'bool', @() self.boolValue());
            self.field(record, 'Qrqp::print_info', 'bool', @() self.boolValue());
            self.field(record, 'Qrqp::print_lincomb_', 'bool', @() self.boolValue());
            self.field(record, 'Qrqp::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Qrqp::min_lam', 'double', @() self.number('double'));
            self.field(record, 'Qrqp::constr_viol_tol', 'double', @() self.number('double'));
            self.field(record, 'Qrqp::dual_inf_tol', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_Qrsqp_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Rank1_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_RealtypeSX_serialize_node(self, record, scope)
            self.enterLayout();
            scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
            self.field(record, 'ConstantSX::value', 'double', @() self.number('double'));
            self.depth = self.depth - 1;
        end

        function layout_Reshape_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Resource_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_ResourceInternal_serialize(self, record, scope)
            self.enterLayout();
            self.version(record, 'ResourceInternal', 1);
            self.fail('unlowered serialization call');
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_ResourceInternal_serialize_body(self, record, scope)
            self.enterLayout();
            scope('ResourceInternal::serialize_mode') = self.field(record, 'ResourceInternal::serialize_mode', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_ResourceInternal_serialize_type(self, record, scope)
            self.enterLayout();
            scope('ResourceInternal::type') = self.field(record, 'ResourceInternal::type', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_Rootfinder_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'OracleFunction::serialize_body');
            self.layout_OracleFunction_serialize_body(record, scope);
            self.version(record, 'Rootfinder', 3);
            self.field(record, 'Rootfinder::n', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Rootfinder::linsol', 'Linsol', @() self.read_Linsol());
            self.field(record, 'Rootfinder::sp_jac', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Rootfinder::u_c', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Rootfinder::iin', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Rootfinder::iout', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Rootfinder_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'OracleFunction::serialize_type');
            self.layout_OracleFunction_serialize_type(record, scope);
            self.recordLayout(record, 'PluginInterface<Rootfinder>::serialize_type');
            self.layout_PluginInterface_Rootfinder_serialize_type(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_RungeKutta_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FixedStepIntegrator::serialize_body');
            self.layout_FixedStepIntegrator_serialize_body(record, scope);
            self.version(record, 'RungeKutta', 2);
            self.depth = self.depth - 1;
        end

        function layout_SLEQPInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'SLEQPInterface', 1);
            self.field(record, 'SLEQPInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'SLEQPInterface::max_iter', 'int', @() self.number('int'));
            self.field(record, 'SLEQPInterface::max_wall_time', 'double', @() self.number('double'));
            self.field(record, 'SLEQPInterface::print_level', 'int', @() self.number('int'));
            self.field(record, 'SLEQPInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_SXElem_serialize(self, record, scope)
            self.enterLayout();
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_SXFunction_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'XFunction<SXFunction,SX,SXNode>::serialize_body');
            self.layout_XFunction_SXFunction_SX_SXNode_serialize_body(record, scope);
            self.version(record, 'SXFunction', 4);
            scope('SXFunction::n_instr') = self.field(record, 'SXFunction::n_instr', 'size_t', @() self.number('size_t'));
            self.field(record, 'SXFunction::worksize', 'size_t', @() self.number('size_t'));
            self.field(record, 'SXFunction::free_vars', 'std::vector<SXElem>', @() self.read_std_vector_SXElem());
            self.field(record, 'SXFunction::operations', 'std::vector<SXElem>', @() self.read_std_vector_SXElem());
            self.field(record, 'SXFunction::constants', 'std::vector<SXElem>', @() self.read_std_vector_SXElem());
            self.field(record, 'SXFunction::default_in', 'std::vector<double>', @() self.read_std_vector_double());
            self.field(record, 'SXFunction::call_sz_arg', 'size_t', @() self.number('size_t'));
            self.field(record, 'SXFunction::call_sz_res', 'size_t', @() self.number('size_t'));
            self.field(record, 'SXFunction::call_sz_iw', 'size_t', @() self.number('size_t'));
            self.field(record, 'SXFunction::call_sz_w', 'size_t', @() self.number('size_t'));
            self.field(record, 'SXFunction::call_sz_arg', 'size_t', @() self.number('size_t'));
            self.field(record, 'SXFunction::call_sz_res', 'size_t', @() self.number('size_t'));
            scope('SXFunction::call_el_size') = self.field(record, 'SXFunction::call_el_size', 'size_t', @() self.number('size_t'));
            for i_5 = 1:self.count(scope('SXFunction::call_el_size'))
                self.field(record, 'SXFunction::call_el_f', 'Function', @() self.read_Function());
                self.field(record, 'SXFunction::call_el_dep', 'std::vector<int>', @() self.read_std_vector_int());
                self.field(record, 'SXFunction::call_el_res', 'std::vector<int>', @() self.read_std_vector_int());
                self.field(record, 'SXFunction::call_el_copy_elision_arg', 'std::vector<int>', @() self.read_std_vector_int());
                self.field(record, 'SXFunction::call_el_copy_elision_offset', 'std::vector<int>', @() self.read_std_vector_int());
            end
            self.field(record, 'SXFunction::copy_elision', 'std::vector<bool>', @() self.read_std_vector_bool());
            for i_6 = 1:self.count(scope('SXFunction::n_instr'))
                self.field(record, 'SXFunction::ScalarAtomic::op', 'int', @() self.number('int'));
                self.field(record, 'SXFunction::ScalarAtomic::i0', 'int', @() self.number('int'));
                self.field(record, 'SXFunction::ScalarAtomic::i1', 'int', @() self.number('int'));
                self.field(record, 'SXFunction::ScalarAtomic::i2', 'int', @() self.number('int'));
            end
            self.field(record, 'SXFunction::live_variables', 'bool', @() self.boolValue());
            self.field(record, 'SXFunction::print_instructions', 'bool', @() self.boolValue());
            self.field(record, 'SXFunction::dump_trace', 'bool', @() self.boolValue());
            self.recordLayout(record, 'XFunction<SXFunction,SX,SXNode>::delayed_serialize_members');
            self.layout_XFunction_SXFunction_SX_SXNode_delaye_280(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_SXNode_serialize(self, record, scope)
            self.enterLayout();
            scope('SXNode::op') = self.field(record, 'SXNode::op', 'casadi_int', @() self.number('casadi_int'));
            self.fail('unlowered serialization call');
            self.depth = self.depth - 1;
        end

        function layout_Scpgen_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosParam_Add_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosParamParam_Add_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'SetNonzerosParam<Add>::serialize_body');
            self.layout_SetNonzerosParam_Add_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosParamParam_Add_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('SetNonzerosParam::type') = self.field(record, 'SetNonzerosParam::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosParamSlice_Add_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'SetNonzerosParamSlice::outer', 'Slice', @() self.read_Slice());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosParamSlice_Add_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('SetNonzerosParam::type') = self.field(record, 'SetNonzerosParam::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosParamVector_Add_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosParamVector_Add_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('SetNonzerosParam::type') = self.field(record, 'SetNonzerosParam::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosSlice2_Add_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'SetNonzerosSlice2::inner', 'Slice', @() self.read_Slice());
            self.field(record, 'SetNonzerosSlice2::outer', 'Slice', @() self.read_Slice());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosSlice2_Add_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('SetNonzeros::type') = self.field(record, 'SetNonzeros::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosSlice_Add_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'SetNonzerosSlice::slice', 'Slice', @() self.read_Slice());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosSlice_Add_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('SetNonzeros::type') = self.field(record, 'SetNonzeros::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosSliceParam_Add_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'SetNonzerosSliceParam::inner', 'Slice', @() self.read_Slice());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosSliceParam_Add_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('SetNonzerosParam::type') = self.field(record, 'SetNonzerosParam::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosVector_Add_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'SetNonzerosVector::nonzeros', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_SetNonzerosVector_Add_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('SetNonzeros::type') = self.field(record, 'SetNonzeros::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_Slice_serialize(self, record, scope)
            self.enterLayout();
            self.field(record, 'Slice::start', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Slice::stop', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Slice::step', 'casadi_int', @() self.number('casadi_int'));
            self.depth = self.depth - 1;
        end

        function layout_Smoothing_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FiniteDiff::serialize_body');
            self.layout_FiniteDiff_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_SnoptInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'SnoptInterface', 1);
            self.field(record, 'SnoptInterface::jacf_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'SnoptInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'SnoptInterface::nnJac', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SnoptInterface::nnObj', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SnoptInterface::nnCon', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SnoptInterface::A_structure', 'IM', @() self.read_IM());
            self.field(record, 'SnoptInterface::m', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SnoptInterface::iObj', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SnoptInterface::jacF_row', 'bool', @() self.boolValue());
            self.field(record, 'SnoptInterface::dummyrow', 'bool', @() self.boolValue());
            self.field(record, 'SnoptInterface::Cold_', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SnoptInterface::inf', 'double', @() self.number('double'));
            self.field(record, 'SnoptInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_Solve_Tr_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Solve_Tr_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            self.field(record, 'Solve::Tr', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_SparseDenseKron_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Kron::serialize_body');
            self.layout_Kron_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_SparseDenseKron_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Kron::kind') = self.field(record, 'Kron::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_SparseDenseKronContract_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'KronContract::serialize_body');
            self.layout_KronContract_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_SparseDenseKronContract_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('KronContract::kind') = self.field(record, 'KronContract::kind', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_Sparsify_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Project::serialize_body');
            self.layout_Project_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Sparsify_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Project::type') = self.field(record, 'Project::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_Sparsity_serialize(self, record, scope)
            self.enterLayout();
            self.fail('Predicate has no serialized field');
            self.depth = self.depth - 1;
        end

        function layout_SparsityCast_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Split_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MultipleOutput::serialize_body');
            self.layout_MultipleOutput_serialize_body(record, scope);
            self.field(record, 'Split::offset', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'Split::output_sparsity', 'std::vector<Sparsity>', @() self.read_std_vector_Sparsity());
            self.depth = self.depth - 1;
        end

        function layout_SqicInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Sqpmethod_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'Sqpmethod', 3);
            self.field(record, 'Sqpmethod::qpsol', 'Function', @() self.read_Function());
            self.field(record, 'Sqpmethod::qpsol_ela', 'Function', @() self.read_Function());
            self.field(record, 'Sqpmethod::exact_hessian', 'bool', @() self.boolValue());
            self.field(record, 'Sqpmethod::max_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Sqpmethod::min_iter', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Sqpmethod::lbfgs_memory', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Sqpmethod::tol_pr_', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::tol_du_', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::min_step_size_', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::c1', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::beta', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::max_iter_ls_', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Sqpmethod::merit_memsize_', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'Sqpmethod::beta', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::print_header', 'bool', @() self.boolValue());
            self.field(record, 'Sqpmethod::print_iteration', 'bool', @() self.boolValue());
            self.field(record, 'Sqpmethod::print_status', 'bool', @() self.boolValue());
            self.field(record, 'Sqpmethod::elastic_mode', 'bool', @() self.boolValue());
            self.field(record, 'Sqpmethod::gamma_0', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::gamma_max', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::gamma_1_min', 'double', @() self.number('double'));
            self.field(record, 'Sqpmethod::init_feasible', 'bool', @() self.boolValue());
            self.field(record, 'Sqpmethod::so_corr', 'bool', @() self.boolValue());
            self.field(record, 'Sqpmethod::Hsp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Sqpmethod::Asp', 'Sparsity', @() self.read_Sparsity());
            scope('Sqpmethod::convexify') = self.field(record, 'Sqpmethod::convexify', 'bool', @() self.boolValue());
            if self.truth(scope('Sqpmethod::convexify'))
                self.recordLayout(record, 'Convexify::serialize');
                scope('prefix') = 'Sqpmethod::';
                self.layout_Convexify_serialize(record, scope);
            end
            self.depth = self.depth - 1;
        end

        function layout_SundialsInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Integrator::serialize_body');
            self.layout_Integrator_serialize_body(record, scope);
            self.version(record, 'SundialsInterface', 2);
            self.field(record, 'SundialsInterface::abstol', 'double', @() self.number('double'));
            self.field(record, 'SundialsInterface::reltol', 'double', @() self.number('double'));
            self.field(record, 'SundialsInterface::max_num_steps', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SundialsInterface::stop_at_end', 'bool', @() self.boolValue());
            self.field(record, 'SundialsInterface::quad_err_con', 'bool', @() self.boolValue());
            self.field(record, 'SundialsInterface::steps_per_checkpoint', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SundialsInterface::disable_internal_warnings', 'bool', @() self.boolValue());
            self.field(record, 'SundialsInterface::max_multistep_order', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SundialsInterface::linear_solver', 'std::string', @() self.stringValue());
            self.field(record, 'SundialsInterface::linear_solver_options', 'Dict', @() self.read_Dict());
            self.field(record, 'SundialsInterface::max_krylov', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SundialsInterface::use_precon', 'bool', @() self.boolValue());
            self.field(record, 'SundialsInterface::second_order_correction', 'bool', @() self.boolValue());
            self.field(record, 'SundialsInterface::step0', 'double', @() self.number('double'));
            self.field(record, 'SundialsInterface::max_step_size', 'double', @() self.number('double'));
            self.field(record, 'SundialsInterface::nonlin_conv_coeff', 'double', @() self.number('double'));
            self.field(record, 'SundialsInterface::max_order', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SundialsInterface::scale_abstol', 'bool', @() self.boolValue());
            self.field(record, 'SundialsInterface::linsolF', 'Linsol', @() self.read_Linsol());
            self.field(record, 'SundialsInterface::newton_scheme', 'int', @() self.number('int'));
            self.field(record, 'SundialsInterface::interp', 'int', @() self.number('int'));
            self.depth = self.depth - 1;
        end

        function layout_SuperscsInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'SuperscsInterface', 1);
            self.field(record, 'SuperscsInterface::settings::normalize', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::scale', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::rho_x', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::max_time_milliseconds', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::max_iters', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::previous_max_iters', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::eps', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::alpha', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::cg_rate', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::verbose', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::warm_start', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::do_super_scs', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::k0', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::c_bl', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::k1', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::k2', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::c1', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::sse', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::ls', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::beta', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::sigma', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::direction', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::thetabar', 'double', @() self.number('double'));
            self.field(record, 'SuperscsInterface::settings::memory', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::tRule', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::broyden_init_scaling', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::do_record_progress', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::settings::do_override_streams', 'casadi_int', @() self.number('casadi_int'));
            self.field(record, 'SuperscsInterface::Hp', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'SuperscsInterface::HL_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'SuperscsInterface::f', 'Function', @() self.read_Function());
            self.field(record, 'SuperscsInterface::At', 'IM', @() self.read_IM());
            self.field(record, 'SuperscsInterface::lookup', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'SuperscsInterface::perturb', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, 'SuperscsInterface::opts', 'Dict', @() self.read_Dict());
            self.recordLayout(record, 'Conic::serialize');
            self.layout_Conic_serialize(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Switch_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'Switch', 1);
            self.field(record, 'Switch::f', 'std::vector<Function>', @() self.read_std_vector_Function());
            self.field(record, 'Switch::f_def', 'Function', @() self.read_Function());
            self.field(record, 'Switch::project_in', 'bool', @() self.boolValue());
            self.field(record, 'Switch::project_out', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_SymbolicMX_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'SymbolicMX::name', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_SymbolicQr_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'LinsolInternal::serialize_body');
            self.layout_LinsolInternal_serialize_body(record, scope);
            self.version(record, 'SymbolicQr', 1);
            self.field(record, 'SymbolicQr::factorize', 'Function', @() self.read_Function());
            self.field(record, 'SymbolicQr::solve', 'Function', @() self.read_Function());
            self.field(record, 'SymbolicQr::solveT', 'Function', @() self.read_Function());
            self.field(record, 'SymbolicQr::fopts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_SymbolicSX_serialize_node(self, record, scope)
            self.enterLayout();
            self.field(record, 'SymbolicSX::name', 'std::string', @() self.stringValue());
            self.depth = self.depth - 1;
        end

        function layout_ThreadMap_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Map::serialize_body');
            self.layout_Map_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Transpose_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Transpose_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('Transpose::dense') = self.field(record, 'Transpose::dense', 'bool', @() self.boolValue());
            self.depth = self.depth - 1;
        end

        function layout_UnaryMX_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_body');
            self.layout_MXNode_serialize_body(record, scope);
            self.field(record, 'UnaryMX::op', 'int', @() self.number('int'));
            self.depth = self.depth - 1;
        end

        function layout_UnarySX_serialize_node(self, record, scope)
            self.enterLayout();
            self.field(record, 'UnarySX::dep', 'SXElem', @() self.read_SXElem());
            self.depth = self.depth - 1;
        end

        function layout_UnoInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'UnoInterface', 1);
            self.field(record, 'UnoInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'UnoInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'UnoInterface::opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_Vertcat_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Concat::serialize_body');
            self.layout_Concat_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_Vertsplit_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Split::serialize_body');
            self.layout_Split_serialize_body(record, scope);
            self.depth = self.depth - 1;
        end

        function layout_WorhpInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Nlpsol::serialize_body');
            self.layout_Nlpsol_serialize_body(record, scope);
            self.version(record, 'WorhpInterface', 1);
            self.field(record, 'WorhpInterface::jacg_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'WorhpInterface::hesslag_sp', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'WorhpInterface::bool_opts', 'std::map<std::string,bool>', @() self.read_std_map_std_string_bool());
            self.field(record, 'WorhpInterface::int_opts', 'std::map<std::string,casadi_int>', @() self.read_std_map_std_string_casadi_int());
            self.field(record, 'WorhpInterface::double_opts', 'std::map<std::string,double>', @() self.read_std_map_std_string_double());
            self.field(record, 'WorhpInterface::qp_opts', 'Dict', @() self.read_Dict());
            self.depth = self.depth - 1;
        end

        function layout_XFunction_MXFunction_MX_MXNode_delaye_278(self, record, scope)
            self.enterLayout();
            self.field(record, 'XFunction::out', 'std::vector<MX>', @() self.read_std_vector_MX());
            self.depth = self.depth - 1;
        end

        function layout_XFunction_MXFunction_MX_MXNode_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'XFunction', 1);
            self.field(record, 'XFunction::in', 'std::vector<MX>', @() self.read_std_vector_MX());
            self.depth = self.depth - 1;
        end

        function layout_XFunction_SXFunction_SX_SXNode_delaye_280(self, record, scope)
            self.enterLayout();
            self.field(record, 'XFunction::out', 'std::vector<SX>', @() self.read_std_vector_SX());
            self.depth = self.depth - 1;
        end

        function layout_XFunction_SXFunction_SX_SXNode_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'FunctionInternal::serialize_body');
            self.layout_FunctionInternal_serialize_body(record, scope);
            self.version(record, 'XFunction', 1);
            self.field(record, 'XFunction::in', 'std::vector<SX>', @() self.read_std_vector_SX());
            self.depth = self.depth - 1;
        end

        function layout_XpressInterface_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Conic::serialize_body');
            self.layout_Conic_serialize_body(record, scope);
            self.version(record, 'XpressInterface', 2);
            self.field(record, 'XpressInterface::opts', 'Dict', @() self.read_Dict());
            self.field(record, 'XpressInterface::mip_start', 'bool', @() self.boolValue());
            self.field(record, 'XpressInterface::log_file', 'std::string', @() self.stringValue());
            self.field(record, 'XpressInterface::compute_iis', 'bool', @() self.boolValue());
            self.field(record, 'XpressInterface::sos_settype', 'std::vector<char>', @() self.read_std_vector_char());
            self.field(record, 'XpressInterface::sos_setstart', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'XpressInterface::sos_setind', 'std::vector<int>', @() self.read_std_vector_int());
            self.field(record, 'XpressInterface::sos_refval', 'std::vector<double>', @() self.read_std_vector_double());
            self.depth = self.depth - 1;
        end

        function layout_ZeroByZero_serialize_body(self, record, scope)
            self.enterLayout();
            self.depth = self.depth - 1;
        end

        function layout_ZeroByZero_serialize_type(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'MXNode::serialize_type');
            self.layout_MXNode_serialize_type(record, scope);
            scope('ConstantMX::type') = self.field(record, 'ConstantMX::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_ZeroSX_serialize_node(self, record, scope)
            self.enterLayout();
            scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
            self.depth = self.depth - 1;
        end

        function layout_ZipMemResource_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'ResourceInternal::serialize_body');
            self.layout_ResourceInternal_serialize_body(record, scope);
            self.version(record, 'ZipMemResource', 1);
            self.field(record, 'ZipMemResource::blob', 'std::stringstream', @() self.streamValue());
            self.depth = self.depth - 1;
        end

        function layout_ZipResource_serialize_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'ResourceInternal::serialize_body');
            self.layout_ResourceInternal_serialize_body(record, scope);
            self.version(record, 'ZipResource', 1);
            if self.truth(isequal(scope('ResourceInternal::serialize_mode'), 'embed'))
                self.field(record, 'ZipMemResource::blob', 'std::stringstream', @() self.streamValue());
            else
                self.field(record, 'ZipResource::path', 'std::string', @() self.stringValue());
            end
            self.depth = self.depth - 1;
        end

        function layout_ZipResource_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('unlowered else branch');
            self.depth = self.depth - 1;
        end

        function layout_pack_tensors(self, record, scope)
            self.enterLayout();
            self.field(record, [scope('d') '::names'], 'std::vector<std::string>', @() self.read_std_vector_std_string());
            self.field(record, [scope('d') '::shapes'], 'std::vector<std::vector<casadi_int>>', @() self.read_std_vector_std_vector_casadi_int());
            self.field(record, [scope('d') '::elem_types'], 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.field(record, [scope('d') '::numels'], 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_Interpolant_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('Serialization layout absent from scheme: >PluginInterface<Interpolant>::serialize_type');
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_Conic_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('Serialization layout absent from scheme: PluginInterface<Conic>::serialize_type');
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_Integrator_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('Serialization layout absent from scheme: PluginInterface<Integrator>::serialize_type');
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_Interpolant_serialize_type_2(self, record, scope)
            self.enterLayout();
            self.fail('Serialization layout absent from scheme: PluginInterface<Interpolant>::serialize_type');
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_LinsolInternal_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('Serialization layout absent from scheme: PluginInterface<LinsolInternal>::serialize_type');
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_Nlpsol_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('Serialization layout absent from scheme: PluginInterface<Nlpsol>::serialize_type');
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_OnnxFunction_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('Serialization layout absent from scheme: PluginInterface<OnnxFunction>::serialize_type');
            self.depth = self.depth - 1;
        end

        function layout_PluginInterface_Rootfinder_serialize_type(self, record, scope)
            self.enterLayout();
            self.fail('Serialization layout absent from scheme: PluginInterface<Rootfinder>::serialize_type');
            self.depth = self.depth - 1;
        end

        function read_DM_body(self, record, scope)
            self.enterLayout();
            self.field(record, 'Matrix::sparsity', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Matrix::nonzeros', 'std::vector<double>', @() self.read_std_vector_double());
            self.depth = self.depth - 1;
        end

        function v = read_DM(self)
            v = self.readObject('DM', '', false, @(record, scope) self.read_DM_body(record, scope));
        end

        function read_Fmu_body(self, record, scope)
            self.enterLayout();
            scope('FmuInternal::type') = self.field(record, 'FmuInternal::type', 'std::string', @() self.stringValue());
            tag_7 = self.tag(scope('FmuInternal::type'));
            switch tag_7
                case 'Fmu2'
                    self.recordLayout(record, 'Fmu2::serialize_body');
                    self.layout_Fmu2_serialize_body(record, scope);
                case 'Fmu3'
                    self.recordLayout(record, 'Fmu3::serialize_body');
                    self.layout_Fmu3_serialize_body(record, scope);
                otherwise
                    self.fail('Unknown serialization discriminator');
            end
            self.depth = self.depth - 1;
        end

        function v = read_Fmu(self)
            v = self.readObject('Fmu', 'F', true, @(record, scope) self.read_Fmu_body(record, scope));
        end

        function read_Function_body(self, record, scope)
            self.enterLayout();
            scope('Function::null') = self.field(record, 'Function::null', 'bool', @() self.boolValue());
            if self.truth((~self.truth(scope('Function::null'))))
                scope('FunctionInternal::base_function') = self.field(record, 'FunctionInternal::base_function', 'std::string', @() self.stringValue());
                tag_8 = self.tag(scope('FunctionInternal::base_function'));
                switch tag_8
                    case 'BackwardDiff'
                        self.recordLayout(record, 'BackwardDiff::serialize_body');
                        self.layout_BackwardDiff_serialize_body(record, scope);
                    case 'BlazingSplineFunction'
                        self.recordLayout(record, 'BlazingSplineFunction::serialize_body');
                        self.layout_BlazingSplineFunction_serialize_body(record, scope);
                    case 'CentralDiff'
                        self.recordLayout(record, 'CentralDiff::serialize_body');
                        self.layout_CentralDiff_serialize_body(record, scope);
                    case 'Conic'
                        scope('PluginInterface::plugin_name') = self.field(record, 'PluginInterface::plugin_name', 'std::string', @() self.stringValue());
                        tag_9 = self.tag(scope('PluginInterface::plugin_name'));
                        switch tag_9
                            case 'cbc'
                                self.recordLayout(record, 'CbcInterface::serialize_body');
                                self.layout_CbcInterface_serialize_body(record, scope);
                            case 'clarabel'
                                self.recordLayout(record, 'ClarabelInterface::serialize_body');
                                self.layout_ClarabelInterface_serialize_body(record, scope);
                            case 'clp'
                                self.recordLayout(record, 'ClpInterface::serialize_body');
                                self.layout_ClpInterface_serialize_body(record, scope);
                            case 'cplex'
                                self.recordLayout(record, 'CplexInterface::serialize_body');
                                self.layout_CplexInterface_serialize_body(record, scope);
                            case 'daqp'
                                self.recordLayout(record, 'DaqpInterface::serialize_body');
                                self.layout_DaqpInterface_serialize_body(record, scope);
                            case 'fatrop'
                                self.recordLayout(record, 'FatropConicInterface::serialize_body');
                                self.layout_FatropConicInterface_serialize_body(record, scope);
                            case 'gurobi'
                                self.recordLayout(record, 'GurobiInterface::serialize_body');
                                self.layout_GurobiInterface_serialize_body(record, scope);
                            case 'highs'
                                self.recordLayout(record, 'HighsInterface::serialize_body');
                                self.layout_HighsInterface_serialize_body(record, scope);
                            case 'hpipm'
                                self.recordLayout(record, 'HpipmInterface::serialize_body');
                                self.layout_HpipmInterface_serialize_body(record, scope);
                            case 'hpmpc'
                                self.recordLayout(record, 'HpmpcInterface::serialize_body');
                                self.layout_HpmpcInterface_serialize_body(record, scope);
                            case 'ipqp'
                                self.recordLayout(record, 'Ipqp::serialize_body');
                                self.layout_Ipqp_serialize_body(record, scope);
                            case 'mosek'
                                self.recordLayout(record, 'MosekInterface::serialize_body');
                                self.layout_MosekInterface_serialize_body(record, scope);
                            case 'nlpsol'
                                self.recordLayout(record, 'QpToNlp::serialize_body');
                                self.layout_QpToNlp_serialize_body(record, scope);
                            case 'ooqp'
                                self.recordLayout(record, 'OoqpInterface::serialize_body');
                                self.layout_OoqpInterface_serialize_body(record, scope);
                            case 'osqp'
                                self.recordLayout(record, 'OsqpInterface::serialize_body');
                                self.layout_OsqpInterface_serialize_body(record, scope);
                            case 'piqp'
                                self.recordLayout(record, 'PiqpInterface::serialize_body');
                                self.layout_PiqpInterface_serialize_body(record, scope);
                            case 'proxqp'
                                self.recordLayout(record, 'ProxqpInterface::serialize_body');
                                self.layout_ProxqpInterface_serialize_body(record, scope);
                            case 'qpoases'
                                self.recordLayout(record, 'QpoasesInterface::serialize_body');
                                self.layout_QpoasesInterface_serialize_body(record, scope);
                            case 'qrqp'
                                self.recordLayout(record, 'Qrqp::serialize_body');
                                self.layout_Qrqp_serialize_body(record, scope);
                            case 'sqic'
                                self.recordLayout(record, 'SqicInterface::serialize_body');
                                self.layout_SqicInterface_serialize_body(record, scope);
                            case 'superscs'
                                self.recordLayout(record, 'SuperscsInterface::serialize_body');
                                self.layout_SuperscsInterface_serialize_body(record, scope);
                            case 'xpress'
                                self.recordLayout(record, 'XpressInterface::serialize_body');
                                self.layout_XpressInterface_serialize_body(record, scope);
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'External'
                        self.version(record, 'GenericExternal', 1);
                        scope('GenericExternal::type') = self.field(record, 'GenericExternal::type', 'char', @() self.byte());
                        tag_10 = self.tag(scope('GenericExternal::type'));
                        switch tag_10
                            case '103'
                                self.recordLayout(record, 'External::serialize_body');
                                self.layout_External_serialize_body(record, scope);
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'FmuFunction'
                        self.recordLayout(record, 'FmuFunction::serialize_body');
                        self.layout_FmuFunction_serialize_body(record, scope);
                    case 'ForwardDiff'
                        self.recordLayout(record, 'ForwardDiff::serialize_body');
                        self.layout_ForwardDiff_serialize_body(record, scope);
                    case 'Integrator'
                        scope('PluginInterface::plugin_name') = self.field(record, 'PluginInterface::plugin_name', 'std::string', @() self.stringValue());
                        tag_11 = self.tag(scope('PluginInterface::plugin_name'));
                        switch tag_11
                            case 'collocation'
                                self.recordLayout(record, 'Collocation::serialize_body');
                                self.layout_Collocation_serialize_body(record, scope);
                            case 'cvodes'
                                self.recordLayout(record, 'CvodesInterface::serialize_body');
                                self.layout_CvodesInterface_serialize_body(record, scope);
                            case 'idas'
                                self.recordLayout(record, 'IdasInterface::serialize_body');
                                self.layout_IdasInterface_serialize_body(record, scope);
                            case 'rk'
                                self.recordLayout(record, 'RungeKutta::serialize_body');
                                self.layout_RungeKutta_serialize_body(record, scope);
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'Interpolant'
                        scope('PluginInterface::plugin_name') = self.field(record, 'PluginInterface::plugin_name', 'std::string', @() self.stringValue());
                        tag_12 = self.tag(scope('PluginInterface::plugin_name'));
                        switch tag_12
                            case 'bspline'
                                self.recordLayout(record, 'BSplineInterpolant::serialize_body');
                                self.layout_BSplineInterpolant_serialize_body(record, scope);
                            case 'linear'
                                self.version(record, 'LinearInterpolant', 1);
                                scope('LinearInterpolant::type') = self.field(record, 'LinearInterpolant::type', 'char', @() self.byte());
                                tag_13 = self.tag(scope('LinearInterpolant::type'));
                                switch tag_13
                                    case '102'
                                        self.recordLayout(record, 'LinearInterpolant::serialize_body');
                                        self.layout_LinearInterpolant_serialize_body(record, scope);
                                    case '106'
                                        self.recordLayout(record, 'LinearInterpolantJac::serialize_body');
                                        self.layout_LinearInterpolantJac_serialize_body(record, scope);
                                    otherwise
                                        self.fail('Unknown serialization discriminator');
                                end
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'MXFunction'
                        self.recordLayout(record, 'MXFunction::serialize_body');
                        self.layout_MXFunction_serialize_body(record, scope);
                    case 'Map'
                        scope('Map::class_name') = self.field(record, 'Map::class_name', 'std::string', @() self.stringValue());
                        tag_14 = self.tag(scope('Map::class_name'));
                        switch tag_14
                            case 'Map'
                                self.recordLayout(record, 'Map::serialize_body');
                                self.layout_Map_serialize_body(record, scope);
                            case 'OmpMap'
                                self.recordLayout(record, 'OmpMap::serialize_body');
                                self.layout_OmpMap_serialize_body(record, scope);
                            case 'ThreadMap'
                                self.recordLayout(record, 'ThreadMap::serialize_body');
                                self.layout_ThreadMap_serialize_body(record, scope);
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'MapSum'
                        scope('MapSum::class_name') = self.field(record, 'MapSum::class_name', 'std::string', @() self.stringValue());
                        tag_15 = self.tag(scope('MapSum::class_name'));
                        switch tag_15
                            case 'MapSum'
                                self.recordLayout(record, 'MapSum::serialize_body');
                                self.layout_MapSum_serialize_body(record, scope);
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'Nlpsol'
                        scope('PluginInterface::plugin_name') = self.field(record, 'PluginInterface::plugin_name', 'std::string', @() self.stringValue());
                        tag_16 = self.tag(scope('PluginInterface::plugin_name'));
                        switch tag_16
                            case 'alpaqa'
                                self.recordLayout(record, 'AlpaqaInterface::serialize_body');
                                self.layout_AlpaqaInterface_serialize_body(record, scope);
                            case 'ampl'
                                self.recordLayout(record, 'AmplInterface::serialize_body');
                                self.layout_AmplInterface_serialize_body(record, scope);
                            case 'blocksqp'
                                self.recordLayout(record, 'Blocksqp::serialize_body');
                                self.layout_Blocksqp_serialize_body(record, scope);
                            case 'bonmin'
                                self.recordLayout(record, 'BonminInterface::serialize_body');
                                self.layout_BonminInterface_serialize_body(record, scope);
                            case 'ccopt'
                                self.recordLayout(record, 'MadmpecInterface::serialize_body');
                                self.layout_MadmpecInterface_serialize_body(record, scope);
                            case 'conopt'
                                self.recordLayout(record, 'ConoptInterface::serialize_body');
                                self.layout_ConoptInterface_serialize_body(record, scope);
                            case 'fatrop'
                                self.recordLayout(record, 'FatropInterface::serialize_body');
                                self.layout_FatropInterface_serialize_body(record, scope);
                            case 'feasiblesqpmethod'
                                self.recordLayout(record, 'Feasiblesqpmethod::serialize_body');
                                self.layout_Feasiblesqpmethod_serialize_body(record, scope);
                            case 'ipopt'
                                self.recordLayout(record, 'IpoptInterface::serialize_body');
                                self.layout_IpoptInterface_serialize_body(record, scope);
                            case 'knitro'
                                self.recordLayout(record, 'KnitroInterface::serialize_body');
                                self.layout_KnitroInterface_serialize_body(record, scope);
                            case 'madnlp'
                                self.recordLayout(record, 'MadnlpInterface::serialize_body');
                                self.layout_MadnlpInterface_serialize_body(record, scope);
                            case 'qrsqp'
                                self.recordLayout(record, 'Qrsqp::serialize_body');
                                self.layout_Qrsqp_serialize_body(record, scope);
                            case 'scpgen'
                                self.recordLayout(record, 'Scpgen::serialize_body');
                                self.layout_Scpgen_serialize_body(record, scope);
                            case 'sleqp'
                                self.recordLayout(record, 'SLEQPInterface::serialize_body');
                                self.layout_SLEQPInterface_serialize_body(record, scope);
                            case 'snopt'
                                self.recordLayout(record, 'SnoptInterface::serialize_body');
                                self.layout_SnoptInterface_serialize_body(record, scope);
                            case 'sqpmethod'
                                self.recordLayout(record, 'Sqpmethod::serialize_body');
                                self.layout_Sqpmethod_serialize_body(record, scope);
                            case 'uno'
                                self.recordLayout(record, 'UnoInterface::serialize_body');
                                self.layout_UnoInterface_serialize_body(record, scope);
                            case 'worhp'
                                self.recordLayout(record, 'WorhpInterface::serialize_body');
                                self.layout_WorhpInterface_serialize_body(record, scope);
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'Onnx'
                        scope('PluginInterface::plugin_name') = self.field(record, 'PluginInterface::plugin_name', 'std::string', @() self.stringValue());
                        tag_17 = self.tag(scope('PluginInterface::plugin_name'));
                        switch tag_17
                            case 'ort'
                                self.recordLayout(record, 'OnnxRuntimeInterface::serialize_body');
                                self.layout_OnnxRuntimeInterface_serialize_body(record, scope);
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'Rootfinder'
                        scope('PluginInterface::plugin_name') = self.field(record, 'PluginInterface::plugin_name', 'std::string', @() self.stringValue());
                        tag_18 = self.tag(scope('PluginInterface::plugin_name'));
                        switch tag_18
                            case 'bisection'
                                self.recordLayout(record, 'Bisection::serialize_body');
                                self.layout_Bisection_serialize_body(record, scope);
                            case 'fast_newton'
                                self.recordLayout(record, 'FastNewton::serialize_body');
                                self.layout_FastNewton_serialize_body(record, scope);
                            case 'kinsol'
                                self.recordLayout(record, 'KinsolInterface::serialize_body');
                                self.layout_KinsolInterface_serialize_body(record, scope);
                            case 'newton'
                                self.recordLayout(record, 'Newton::serialize_body');
                                self.layout_Newton_serialize_body(record, scope);
                            case 'nlpsol'
                                self.recordLayout(record, 'ImplicitToNlp::serialize_body');
                                self.layout_ImplicitToNlp_serialize_body(record, scope);
                            otherwise
                                self.fail('Unknown serialization discriminator');
                        end
                    case 'SXFunction'
                        self.recordLayout(record, 'SXFunction::serialize_body');
                        self.layout_SXFunction_serialize_body(record, scope);
                    case 'Smoothing'
                        self.recordLayout(record, 'Smoothing::serialize_body');
                        self.layout_Smoothing_serialize_body(record, scope);
                    case 'Switch'
                        self.recordLayout(record, 'Switch::serialize_body');
                        self.layout_Switch_serialize_body(record, scope);
                    otherwise
                        self.fail('Unknown serialization discriminator');
                end
            end
            self.depth = self.depth - 1;
        end

        function v = read_Function(self)
            v = self.readObject('Function', 'F', true, @(record, scope) self.read_Function_body(record, scope));
        end

        function read_GenericType_body(self, record, scope)
            self.enterLayout();
            scope('GenericType::type') = self.field(record, 'GenericType::type', 'int', @() self.number('int'));
            tag_19 = self.tag(scope('GenericType::type'));
            switch tag_19
                case '1'
                    self.field(record, 'GenericType::d', 'bool', @() self.boolValue());
                case '10'
                    self.field(record, 'GenericType::d', 'std::vector<std::string>', @() self.read_std_vector_std_string());
                case '11'
                    self.field(record, 'GenericType::d', 'Dict', @() self.read_Dict());
                case '12'
                    self.field(record, 'GenericType::d', 'Function', @() self.read_Function());
                case '13'
                    self.field(record, 'GenericType::d', 'std::vector<Function>', @() self.read_std_vector_Function());
                case '14'
                    self.field(record, 'GenericType::d', 'void*', @() self.primitive('void*'));
                case '16'
                    self.field(record, 'GenericType::d', 'std::vector<std::vector<std::string>>', @() self.read_std_vector_std_vector_std_string());
                case '17'
                    self.field(record, 'GenericType::d', 'std::vector<Dict>', @() self.read_std_vector_Dict());
                case '18'
                    self.field(record, 'GenericType::d', 'std::vector<std::vector<GenericType>>', @() self.read_std_vector_std_vector_GenericType());
                case '19'
                    self.field(record, 'GenericType::d', 'std::vector<GenericType>', @() self.read_std_vector_GenericType());
                case '2'
                    self.field(record, 'GenericType::d', 'casadi_int', @() self.number('casadi_int'));
                case '3'
                    self.field(record, 'GenericType::d', 'double', @() self.number('double'));
                case '4'
                    self.field(record, 'GenericType::d', 'std::string', @() self.stringValue());
                case '5'
                    self.field(record, 'GenericType::d', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
                case '6'
                    self.field(record, 'GenericType::d', 'std::vector<std::vector<casadi_int>>', @() self.read_std_vector_std_vector_casadi_int());
                case '7'
                    self.field(record, 'GenericType::d', 'std::vector<bool>', @() self.read_std_vector_bool());
                case '8'
                    self.field(record, 'GenericType::d', 'std::vector<double>', @() self.read_std_vector_double());
                case '9'
                    self.field(record, 'GenericType::d', 'std::vector<std::vector<double>>', @() self.read_std_vector_std_vector_double());
                otherwise
                    self.fail('Unknown serialization discriminator');
            end
            self.depth = self.depth - 1;
        end

        function v = read_GenericType(self)
            v = self.readObject('GenericType', 'G', true, @(record, scope) self.read_GenericType_body(record, scope));
        end

        function read_IM_body(self, record, scope)
            self.enterLayout();
            self.field(record, 'Matrix::sparsity', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Matrix::nonzeros', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function v = read_IM(self)
            v = self.readObject('IM', '', false, @(record, scope) self.read_IM_body(record, scope));
        end

        function read_Importer_body(self, record, scope)
            self.enterLayout();
            scope('ImporterInternal::type') = self.field(record, 'ImporterInternal::type', 'std::string', @() self.stringValue());
            tag_20 = self.tag(scope('ImporterInternal::type'));
            switch tag_20
                case 'DllLibrary'
                    self.recordLayout(record, 'ImporterInternal::serialize_body');
                    self.layout_ImporterInternal_serialize_body(record, scope);
                otherwise
                    self.fail('Unknown serialization discriminator');
            end
            self.depth = self.depth - 1;
        end

        function v = read_Importer(self)
            v = self.readObject('Importer', 'M', true, @(record, scope) self.read_Importer_body(record, scope));
        end

        function read_Linsol_body(self, record, scope)
            self.enterLayout();
            scope('PluginInterface::plugin_name') = self.field(record, 'PluginInterface::plugin_name', 'std::string', @() self.stringValue());
            tag_21 = self.tag(scope('PluginInterface::plugin_name'));
            switch tag_21
                case 'csparse'
                    self.recordLayout(record, 'CsparseInterface::serialize_body');
                    self.layout_CsparseInterface_serialize_body(record, scope);
                case 'csparsecholesky'
                    self.recordLayout(record, 'CSparseCholeskyInterface::serialize_body');
                    self.layout_CSparseCholeskyInterface_serialize_body(record, scope);
                case 'lapacklu'
                    self.recordLayout(record, 'LapackLu::serialize_body');
                    self.layout_LapackLu_serialize_body(record, scope);
                case 'lapackqr'
                    self.recordLayout(record, 'LapackQr::serialize_body');
                    self.layout_LapackQr_serialize_body(record, scope);
                case 'ldl'
                    self.recordLayout(record, 'LinsolLdl::serialize_body');
                    self.layout_LinsolLdl_serialize_body(record, scope);
                case 'lsqr'
                    self.recordLayout(record, 'Lsqr::serialize_body');
                    self.layout_Lsqr_serialize_body(record, scope);
                case 'ma27'
                    self.recordLayout(record, 'Ma27Interface::serialize_body');
                    self.layout_Ma27Interface_serialize_body(record, scope);
                case 'mumps'
                    self.recordLayout(record, 'MumpsInterface::serialize_body');
                    self.layout_MumpsInterface_serialize_body(record, scope);
                case 'qr'
                    self.recordLayout(record, 'LinsolQr::serialize_body');
                    self.layout_LinsolQr_serialize_body(record, scope);
                case 'symbolicqr'
                    self.recordLayout(record, 'SymbolicQr::serialize_body');
                    self.layout_SymbolicQr_serialize_body(record, scope);
                case 'tridiag'
                    self.recordLayout(record, 'LinsolTridiag::serialize_body');
                    self.layout_LinsolTridiag_serialize_body(record, scope);
                otherwise
                    self.fail('Unknown serialization discriminator');
            end
            self.depth = self.depth - 1;
        end

        function v = read_Linsol(self)
            v = self.readObject('Linsol', 'L', true, @(record, scope) self.read_Linsol_body(record, scope));
        end

        function read_MX_body(self, record, scope)
            self.enterLayout();
            scope('MXNode::op') = self.field(record, 'MXNode::op', 'int', @() self.number('int'));
            tag_22 = self.tag(scope('MXNode::op'));
            switch tag_22
                case '-1'
                    self.recordLayout(record, 'OutputNode::serialize_body');
                    self.layout_OutputNode_serialize_body(record, scope);
                case '0'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '1'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '10'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '100'
                    scope('KronContract::kind') = self.field(record, 'KronContract::kind', 'std::string', @() self.stringValue());
                    tag_23 = self.tag(scope('KronContract::kind'));
                    switch tag_23
                        case 'base'
                            self.recordLayout(record, 'KronContract::serialize_body');
                            self.layout_KronContract_serialize_body(record, scope);
                        case 'dense'
                            self.recordLayout(record, 'DenseKronContract::serialize_body');
                            self.layout_DenseKronContract_serialize_body(record, scope);
                        case 'dense_sparse'
                            self.recordLayout(record, 'DenseSparseKronContract::serialize_body');
                            self.layout_DenseSparseKronContract_serialize_body(record, scope);
                        case 'sparse_dense'
                            self.recordLayout(record, 'SparseDenseKronContract::serialize_body');
                            self.layout_SparseDenseKronContract_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '11'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '12'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '13'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '14'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '15'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '16'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '17'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '18'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '19'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '2'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '20'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '21'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '22'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '23'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '24'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '25'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '26'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '27'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '28'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '29'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '3'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '30'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '31'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '32'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '33'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '34'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '35'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '36'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '37'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '38'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '39'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '4'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '40'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '41'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '42'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '43'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '44'
                    scope('ConstantMX::type') = self.field(record, 'ConstantMX::type', 'char', @() self.byte());
                    tag_24 = self.tag(scope('ConstantMX::type'));
                    switch tag_24
                        case '102'
                            self.recordLayout(record, 'ConstantFile::serialize_body');
                            self.layout_ConstantFile_serialize_body(record, scope);
                        case '109'
                            self.recordLayout(record, 'MXNode::serialize_body');
                            self.layout_MXNode_serialize_body(record, scope);
                        case '112'
                            self.recordLayout(record, 'ConstantPool::serialize_body');
                            self.layout_ConstantPool_serialize_body(record, scope);
                        case '122'
                        case '48'
                            self.recordLayout(record, 'MXNode::serialize_body');
                            self.layout_MXNode_serialize_body(record, scope);
                        case '49'
                            self.recordLayout(record, 'MXNode::serialize_body');
                            self.layout_MXNode_serialize_body(record, scope);
                        case '68'
                            self.field(record, 'Constant::value', 'double', @() self.number('double'));
                            self.recordLayout(record, 'MXNode::serialize_body');
                            self.layout_MXNode_serialize_body(record, scope);
                        case '73'
                            self.field(record, 'Constant::value', 'casadi_int', @() self.number('casadi_int'));
                            self.recordLayout(record, 'MXNode::serialize_body');
                            self.layout_MXNode_serialize_body(record, scope);
                        case '97'
                            self.recordLayout(record, 'ConstantDM::serialize_body');
                            self.layout_ConstantDM_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '45'
                    self.recordLayout(record, 'Input::serialize_body');
                    self.layout_Input_serialize_body(record, scope);
                case '46'
                    self.recordLayout(record, 'Output::serialize_body');
                    self.layout_Output_serialize_body(record, scope);
                case '47'
                    self.recordLayout(record, 'SymbolicMX::serialize_body');
                    self.layout_SymbolicMX_serialize_body(record, scope);
                case '48'
                    self.recordLayout(record, 'Call::serialize_body');
                    self.layout_Call_serialize_body(record, scope);
                case '49'
                    self.recordLayout(record, 'Find::serialize_body');
                    self.layout_Find_serialize_body(record, scope);
                case '5'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '50'
                    self.recordLayout(record, 'Low::serialize_body');
                    self.layout_Low_serialize_body(record, scope);
                case '52'
                    scope('Multiplication::kind') = self.field(record, 'Multiplication::kind', 'std::string', @() self.stringValue());
                    tag_25 = self.tag(scope('Multiplication::kind'));
                    switch tag_25
                        case 'base'
                            self.recordLayout(record, 'Multiplication::serialize_body');
                            self.layout_Multiplication_serialize_body(record, scope);
                        case 'dense'
                            self.recordLayout(record, 'DenseMultiplication::serialize_body');
                            self.layout_DenseMultiplication_serialize_body(record, scope);
                        case 'dense_sparse'
                            self.recordLayout(record, 'DenseSparseMultiplication::serialize_body');
                            self.layout_DenseSparseMultiplication_serialize_body(record, scope);
                        case 'pseudo_dense'
                            self.recordLayout(record, 'PseudoDenseMultiplication::serialize_body');
                            self.layout_PseudoDenseMultiplication_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '53'
                    self.field(record, 'Solve::Tr', 'bool', @() self.boolValue());
                    self.recordLayout(record, 'LinsolCall<Tr>::serialize_body');
                    self.layout_LinsolCall_Tr_serialize_body(record, scope);
                case '54'
                    scope('Transpose::dense') = self.field(record, 'Transpose::dense', 'bool', @() self.boolValue());
                    tag_26 = self.tag(scope('Transpose::dense'));
                    switch tag_26
                        case 'false'
                            self.recordLayout(record, 'Transpose::serialize_body');
                            self.layout_Transpose_serialize_body(record, scope);
                        case 'true'
                            self.recordLayout(record, 'DenseTranspose::serialize_body');
                            self.layout_DenseTranspose_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '55'
                    self.recordLayout(record, 'Determinant::serialize_body');
                    self.layout_Determinant_serialize_body(record, scope);
                case '56'
                    self.recordLayout(record, 'Inverse::serialize_body');
                    self.layout_Inverse_serialize_body(record, scope);
                case '57'
                    self.recordLayout(record, 'Dot::serialize_body');
                    self.layout_Dot_serialize_body(record, scope);
                case '58'
                    self.recordLayout(record, 'Bilin::serialize_body');
                    self.layout_Bilin_serialize_body(record, scope);
                case '59'
                    self.recordLayout(record, 'Rank1::serialize_body');
                    self.layout_Rank1_serialize_body(record, scope);
                case '6'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '60'
                    self.recordLayout(record, 'Horzcat::serialize_body');
                    self.layout_Horzcat_serialize_body(record, scope);
                case '61'
                    self.recordLayout(record, 'Vertcat::serialize_body');
                    self.layout_Vertcat_serialize_body(record, scope);
                case '62'
                    self.recordLayout(record, 'Diagcat::serialize_body');
                    self.layout_Diagcat_serialize_body(record, scope);
                case '63'
                    self.recordLayout(record, 'Horzsplit::serialize_body');
                    self.layout_Horzsplit_serialize_body(record, scope);
                case '64'
                    self.recordLayout(record, 'Vertsplit::serialize_body');
                    self.layout_Vertsplit_serialize_body(record, scope);
                case '65'
                    self.recordLayout(record, 'Diagsplit::serialize_body');
                    self.layout_Diagsplit_serialize_body(record, scope);
                case '66'
                    self.recordLayout(record, 'Reshape::serialize_body');
                    self.layout_Reshape_serialize_body(record, scope);
                case '69'
                    scope('GetNonzeros::type') = self.field(record, 'GetNonzeros::type', 'char', @() self.byte());
                    tag_27 = self.tag(scope('GetNonzeros::type'));
                    switch tag_27
                        case '97'
                            self.recordLayout(record, 'GetNonzerosVector::serialize_body');
                            self.layout_GetNonzerosVector_serialize_body(record, scope);
                        case '98'
                            self.recordLayout(record, 'GetNonzerosSlice::serialize_body');
                            self.layout_GetNonzerosSlice_serialize_body(record, scope);
                        case '99'
                            self.recordLayout(record, 'GetNonzerosSlice2::serialize_body');
                            self.layout_GetNonzerosSlice2_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '7'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '70'
                    scope('GetNonzerosParam::type') = self.field(record, 'GetNonzerosParam::type', 'char', @() self.byte());
                    tag_28 = self.tag(scope('GetNonzerosParam::type'));
                    switch tag_28
                        case '100'
                            self.recordLayout(record, 'GetNonzerosParamParam::serialize_body');
                            self.layout_GetNonzerosParamParam_serialize_body(record, scope);
                        case '97'
                            self.recordLayout(record, 'GetNonzerosParamVector::serialize_body');
                            self.layout_GetNonzerosParamVector_serialize_body(record, scope);
                        case '98'
                            self.recordLayout(record, 'GetNonzerosParamSlice::serialize_body');
                            self.layout_GetNonzerosParamSlice_serialize_body(record, scope);
                        case '99'
                            self.recordLayout(record, 'GetNonzerosSliceParam::serialize_body');
                            self.layout_GetNonzerosSliceParam_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '71'
                    scope('SetNonzeros::type') = self.field(record, 'SetNonzeros::type', 'char', @() self.byte());
                    tag_29 = self.tag(scope('SetNonzeros::type'));
                    switch tag_29
                        case '97'
                            self.recordLayout(record, 'SetNonzerosVector<Add>::serialize_body');
                            self.layout_SetNonzerosVector_Add_serialize_body(record, scope);
                        case '98'
                            self.recordLayout(record, 'SetNonzerosSlice<Add>::serialize_body');
                            self.layout_SetNonzerosSlice_Add_serialize_body(record, scope);
                        case '99'
                            self.recordLayout(record, 'SetNonzerosSlice2<Add>::serialize_body');
                            self.layout_SetNonzerosSlice2_Add_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '72'
                    scope('SetNonzerosParam::type') = self.field(record, 'SetNonzerosParam::type', 'char', @() self.byte());
                    tag_30 = self.tag(scope('SetNonzerosParam::type'));
                    switch tag_30
                        case '100'
                            self.recordLayout(record, 'SetNonzerosParamParam<Add>::serialize_body');
                            self.layout_SetNonzerosParamParam_Add_serialize_body(record, scope);
                        case '97'
                            self.recordLayout(record, 'SetNonzerosParamVector<Add>::serialize_body');
                            self.layout_SetNonzerosParamVector_Add_serialize_body(record, scope);
                        case '98'
                            self.recordLayout(record, 'SetNonzerosParamSlice<Add>::serialize_body');
                            self.layout_SetNonzerosParamSlice_Add_serialize_body(record, scope);
                        case '99'
                            self.recordLayout(record, 'SetNonzerosSliceParam<Add>::serialize_body');
                            self.layout_SetNonzerosSliceParam_Add_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '73'
                    scope('SetNonzeros::type') = self.field(record, 'SetNonzeros::type', 'char', @() self.byte());
                    tag_31 = self.tag(scope('SetNonzeros::type'));
                    switch tag_31
                        case '97'
                            self.recordLayout(record, 'SetNonzerosVector<Add>::serialize_body');
                            self.layout_SetNonzerosVector_Add_serialize_body(record, scope);
                        case '98'
                            self.recordLayout(record, 'SetNonzerosSlice<Add>::serialize_body');
                            self.layout_SetNonzerosSlice_Add_serialize_body(record, scope);
                        case '99'
                            self.recordLayout(record, 'SetNonzerosSlice2<Add>::serialize_body');
                            self.layout_SetNonzerosSlice2_Add_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '74'
                    scope('SetNonzerosParam::type') = self.field(record, 'SetNonzerosParam::type', 'char', @() self.byte());
                    tag_32 = self.tag(scope('SetNonzerosParam::type'));
                    switch tag_32
                        case '100'
                            self.recordLayout(record, 'SetNonzerosParamParam<Add>::serialize_body');
                            self.layout_SetNonzerosParamParam_Add_serialize_body(record, scope);
                        case '97'
                            self.recordLayout(record, 'SetNonzerosParamVector<Add>::serialize_body');
                            self.layout_SetNonzerosParamVector_Add_serialize_body(record, scope);
                        case '98'
                            self.recordLayout(record, 'SetNonzerosParamSlice<Add>::serialize_body');
                            self.layout_SetNonzerosParamSlice_Add_serialize_body(record, scope);
                        case '99'
                            self.recordLayout(record, 'SetNonzerosSliceParam<Add>::serialize_body');
                            self.layout_SetNonzerosSliceParam_Add_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '75'
                    scope('Project::type') = self.field(record, 'Project::type', 'char', @() self.byte());
                    tag_33 = self.tag(scope('Project::type'));
                    switch tag_33
                        case '100'
                            self.recordLayout(record, 'Densify::serialize_body');
                            self.layout_Densify_serialize_body(record, scope);
                        case '110'
                            self.recordLayout(record, 'Project::serialize_body');
                            self.layout_Project_serialize_body(record, scope);
                        case '115'
                            self.recordLayout(record, 'Sparsify::serialize_body');
                            self.layout_Sparsify_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '76'
                    self.recordLayout(record, 'Assertion::serialize_body');
                    self.layout_Assertion_serialize_body(record, scope);
                case '77'
                    self.recordLayout(record, 'Monitor::serialize_body');
                    self.layout_Monitor_serialize_body(record, scope);
                case '78'
                    self.recordLayout(record, 'Norm2::serialize_body');
                    self.layout_Norm2_serialize_body(record, scope);
                case '79'
                    self.recordLayout(record, 'Norm1::serialize_body');
                    self.layout_Norm1_serialize_body(record, scope);
                case '8'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '80'
                    self.recordLayout(record, 'NormInf::serialize_body');
                    self.layout_NormInf_serialize_body(record, scope);
                case '81'
                    self.recordLayout(record, 'NormF::serialize_body');
                    self.layout_NormF_serialize_body(record, scope);
                case '82'
                    self.recordLayout(record, 'MMin::serialize_body');
                    self.layout_MMin_serialize_body(record, scope);
                case '83'
                    self.recordLayout(record, 'MMax::serialize_body');
                    self.layout_MMax_serialize_body(record, scope);
                case '84'
                    self.recordLayout(record, 'HorzRepmat::serialize_body');
                    self.layout_HorzRepmat_serialize_body(record, scope);
                case '85'
                    self.recordLayout(record, 'HorzRepsum::serialize_body');
                    self.layout_HorzRepsum_serialize_body(record, scope);
                case '86'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '87'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '88'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '89'
                    self.recordLayout(record, 'Einstein::serialize_body');
                    self.layout_Einstein_serialize_body(record, scope);
                case '9'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '90'
                    scope('BSpline::type') = self.field(record, 'BSpline::type', 'char', @() self.byte());
                    tag_34 = self.tag(scope('BSpline::type'));
                    switch tag_34
                        case '110'
                            self.recordLayout(record, 'BSpline::serialize_body');
                            self.layout_BSpline_serialize_body(record, scope);
                        case '112'
                            self.recordLayout(record, 'BSplineParametric::serialize_body');
                            self.layout_BSplineParametric_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '91'
                    self.recordLayout(record, 'Convexify::serialize_body');
                    self.layout_Convexify_serialize_body(record, scope);
                case '92'
                    self.recordLayout(record, 'SparsityCast::serialize_body');
                    self.layout_SparsityCast_serialize_body(record, scope);
                case '93'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '94'
                    self.recordLayout(record, 'UnaryMX::serialize_body');
                    self.layout_UnaryMX_serialize_body(record, scope);
                case '95'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '96'
                    self.recordLayout(record, 'LogSumExp::serialize_body');
                    self.layout_LogSumExp_serialize_body(record, scope);
                case '97'
                    self.field(record, 'BinaryMX::scalar_flags', 'char', @() self.byte());
                    self.recordLayout(record, 'BinaryMX<ScX,ScY>::serialize_body');
                    self.layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
                case '98'
                    self.recordLayout(record, 'Dump::serialize_body');
                    self.layout_Dump_serialize_body(record, scope);
                case '99'
                    scope('Kron::kind') = self.field(record, 'Kron::kind', 'std::string', @() self.stringValue());
                    tag_35 = self.tag(scope('Kron::kind'));
                    switch tag_35
                        case 'base'
                            self.recordLayout(record, 'Kron::serialize_body');
                            self.layout_Kron_serialize_body(record, scope);
                        case 'dense'
                            self.recordLayout(record, 'DenseKron::serialize_body');
                            self.layout_DenseKron_serialize_body(record, scope);
                        case 'dense_sparse'
                            self.recordLayout(record, 'DenseSparseKron::serialize_body');
                            self.layout_DenseSparseKron_serialize_body(record, scope);
                        case 'sparse_dense'
                            self.recordLayout(record, 'SparseDenseKron::serialize_body');
                            self.layout_SparseDenseKron_serialize_body(record, scope);
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                otherwise
                    self.fail('Unknown serialization discriminator');
            end
            self.depth = self.depth - 1;
        end

        function v = read_MX(self)
            v = self.readObject('MX', 'X', true, @(record, scope) self.read_MX_body(record, scope));
        end

        function read_Resource_body(self, record, scope)
            self.enterLayout();
            self.version(record, 'ResourceInternal', 1);
            scope('ResourceInternal::type') = self.field(record, 'ResourceInternal::type', 'std::string', @() self.stringValue());
            tag_36 = self.tag(scope('ResourceInternal::type'));
            switch tag_36
                case 'DirResource'
                    self.recordLayout(record, 'DirResource::serialize_body');
                    self.layout_DirResource_serialize_body(record, scope);
                case 'ZipMemResource'
                    self.recordLayout(record, 'ZipMemResource::serialize_body');
                    self.layout_ZipMemResource_serialize_body(record, scope);
                case 'ZipResource'
                    self.recordLayout(record, 'ZipResource::serialize_body');
                    self.layout_ZipResource_serialize_body(record, scope);
                otherwise
                    self.fail('Unknown serialization discriminator');
            end
            self.depth = self.depth - 1;
        end

        function v = read_Resource(self)
            v = self.readObject('Resource', 'R', true, @(record, scope) self.read_Resource_body(record, scope));
        end

        function read_SX_body(self, record, scope)
            self.enterLayout();
            self.field(record, 'Matrix::sparsity', 'Sparsity', @() self.read_Sparsity());
            self.field(record, 'Matrix::nonzeros', 'std::vector<SXElem>', @() self.read_std_vector_SXElem());
            self.depth = self.depth - 1;
        end

        function v = read_SX(self)
            v = self.readObject('SX', '', false, @(record, scope) self.read_SX_body(record, scope));
        end

        function read_SXElem_body(self, record, scope)
            self.enterLayout();
            scope('SXNode::op') = self.field(record, 'SXNode::op', 'casadi_int', @() self.number('casadi_int'));
            tag_37 = self.tag(scope('SXNode::op'));
            switch tag_37
                case '-1'
                    self.recordLayout(record, 'OutputSX::serialize_node');
                    self.layout_OutputSX_serialize_node(record, scope);
                case '0'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '1'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '10'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '11'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '12'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '13'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '14'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '15'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '16'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '17'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '18'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '19'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '2'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '20'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '21'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '22'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '23'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '24'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '25'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '26'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '27'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '28'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '29'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '3'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '30'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '31'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '32'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '33'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '34'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '35'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '36'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '37'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '38'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '39'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '4'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '40'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '41'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '42'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '43'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '44'
                    scope('ConstantSX::type') = self.field(record, 'ConstantSX::type', 'char', @() self.byte());
                    tag_38 = self.tag(scope('ConstantSX::type'));
                    switch tag_38
                        case '102'
                        case '105'
                            self.field(record, 'ConstantSX::value', 'int', @() self.number('int'));
                        case '109'
                        case '110'
                        case '114'
                            self.field(record, 'ConstantSX::value', 'double', @() self.number('double'));
                        case '48'
                        case '49'
                        case '70'
                        otherwise
                            self.fail('Unknown serialization discriminator');
                    end
                case '47'
                    self.recordLayout(record, 'SymbolicSX::serialize_node');
                    self.layout_SymbolicSX_serialize_node(record, scope);
                case '48'
                    self.recordLayout(record, 'CallSX::serialize_node');
                    self.layout_CallSX_serialize_node(record, scope);
                case '5'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '6'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '7'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '8'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '86'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '87'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '88'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '9'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '93'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '94'
                    self.recordLayout(record, 'UnarySX::serialize_node');
                    self.layout_UnarySX_serialize_node(record, scope);
                case '95'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                case '97'
                    self.recordLayout(record, 'BinarySX::serialize_node');
                    self.layout_BinarySX_serialize_node(record, scope);
                otherwise
                    self.fail('Unknown serialization discriminator');
            end
            self.depth = self.depth - 1;
        end

        function v = read_SXElem(self)
            v = self.readObject('SXElem', 'E', true, @(record, scope) self.read_SXElem_body(record, scope));
        end

        function read_Slice_body(self, record, scope)
            self.enterLayout();
            self.recordLayout(record, 'Slice::serialize');
            self.layout_Slice_serialize(record, scope);
            self.depth = self.depth - 1;
        end

        function v = read_Slice(self)
            v = self.readObject('Slice', 'S', false, @(record, scope) self.read_Slice_body(record, scope));
        end

        function read_Sparsity_body(self, record, scope)
            self.enterLayout();
            self.field(record, 'SparsityInternal::compressed', 'std::vector<casadi_int>', @() self.read_std_vector_casadi_int());
            self.depth = self.depth - 1;
        end

        function v = read_Sparsity(self)
            v = self.readObject('Sparsity', 'S', true, @(record, scope) self.read_Sparsity_body(record, scope));
        end

        function v = read_std_vector_double(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.number('double');
            end
        end

        function v = read_std_vector_casadi_int(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.number('casadi_int');
            end
        end

        function v = read_std_vector_std_vector_double(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_std_vector_double();
            end
        end

        function v = read_std_vector_std_string(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.stringValue();
            end
        end

        function v = read_std_vector_int(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.number('int');
            end
        end

        function v = read_std_vector_char(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.byte();
            end
        end

        function v = read_std_vector_bool(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.boolValue();
            end
        end

        function v = read_std_vector_SXElem(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_SXElem();
            end
        end

        function v = read_std_vector_std_vector_int(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_std_vector_int();
            end
        end

        function v = read_std_vector_unsignedint(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.number('unsignedint');
            end
        end

        function v = read_std_vector_size_t(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.number('size_t');
            end
        end

        function v = read_std_vector_Sparsity(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_Sparsity();
            end
        end

        function v = read_std_map_std_string_std_vector_size_t(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.read_std_vector_size_t()};
            end
            v = self.object({'$map'}, {v});
        end

        function v = read_std_vector_std_vector_size_t(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_std_vector_size_t();
            end
        end

        function v = read_std_vector_Function(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_Function();
            end
        end

        function v = read_std_pair_casadi_int_std_string(self)
            self.decoration('p');
            v = {self.number('casadi_int'), self.stringValue()};
        end

        function v = read_std_map_std_string_std_pair_casadi_int__327(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.read_std_pair_casadi_int_std_string()};
            end
            v = self.object({'$map'}, {v});
        end

        function v = read_std_pair_bool_std_string(self)
            self.decoration('p');
            v = {self.boolValue(), self.stringValue()};
        end

        function v = read_std_map_std_string_std_pair_bool_std_string(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.read_std_pair_bool_std_string()};
            end
            v = self.object({'$map'}, {v});
        end

        function v = read_std_vector_MX(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_MX();
            end
        end

        function v = read_std_map_std_string_std_vector_double(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.read_std_vector_double()};
            end
            v = self.object({'$map'}, {v});
        end

        function v = read_std_map_std_string_casadi_int(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.number('casadi_int')};
            end
            v = self.object({'$map'}, {v});
        end

        function v = read_std_map_std_string_std_vector_casadi_int(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.read_std_vector_casadi_int()};
            end
            v = self.object({'$map'}, {v});
        end

        function v = read_std_map_std_string_bool(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.boolValue()};
            end
            v = self.object({'$map'}, {v});
        end

        function v = read_std_map_std_string_double(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.number('double')};
            end
            v = self.object({'$map'}, {v});
        end

        function v = read_std_vector_SX(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_SX();
            end
        end

        function v = read_std_vector_std_vector_casadi_int(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_std_vector_casadi_int();
            end
        end

        function v = read_std_vector_std_vector_std_string(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_std_vector_std_string();
            end
        end

        function v = read_std_vector_Dict(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_Dict();
            end
        end

        function v = read_std_vector_GenericType(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_GenericType();
            end
        end

        function v = read_std_vector_std_vector_GenericType(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_std_vector_GenericType();
            end
        end

        function v = read_std_vector_DM(self)
            self.decoration('V');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = self.read_DM();
            end
        end

        function v = read_Dict(self)
            self.decoration('D');
            n = self.count(self.number('casadi_int'));
            v = cell(1, n);
            for i = 1:n
                v{i} = {self.stringValue(), self.read_GenericType()};
            end
            v = self.object({'$map'}, {v});
        end

        function v = value(self, kind)
            switch kind
                case 'DM'
                    v = self.read_DM();
                case 'Fmu'
                    v = self.read_Fmu();
                case 'Function'
                    v = self.read_Function();
                case 'GenericType'
                    v = self.read_GenericType();
                case 'IM'
                    v = self.read_IM();
                case 'Importer'
                    v = self.read_Importer();
                case 'Linsol'
                    v = self.read_Linsol();
                case 'MX'
                    v = self.read_MX();
                case 'Resource'
                    v = self.read_Resource();
                case 'SX'
                    v = self.read_SX();
                case 'SXElem'
                    v = self.read_SXElem();
                case 'Slice'
                    v = self.read_Slice();
                case 'Sparsity'
                    v = self.read_Sparsity();
                case 'std::vector<double>'
                    v = self.read_std_vector_double();
                case 'std::vector<casadi_int>'
                    v = self.read_std_vector_casadi_int();
                case 'std::vector<std::vector<double>>'
                    v = self.read_std_vector_std_vector_double();
                case 'std::vector<std::string>'
                    v = self.read_std_vector_std_string();
                case 'std::vector<int>'
                    v = self.read_std_vector_int();
                case 'std::vector<char>'
                    v = self.read_std_vector_char();
                case 'std::vector<bool>'
                    v = self.read_std_vector_bool();
                case 'std::vector<SXElem>'
                    v = self.read_std_vector_SXElem();
                case 'std::vector<std::vector<int>>'
                    v = self.read_std_vector_std_vector_int();
                case 'std::vector<unsignedint>'
                    v = self.read_std_vector_unsignedint();
                case 'std::vector<size_t>'
                    v = self.read_std_vector_size_t();
                case 'std::vector<Sparsity>'
                    v = self.read_std_vector_Sparsity();
                case 'std::map<std::string,std::vector<size_t>>'
                    v = self.read_std_map_std_string_std_vector_size_t();
                case 'std::vector<std::vector<size_t>>'
                    v = self.read_std_vector_std_vector_size_t();
                case 'std::vector<Function>'
                    v = self.read_std_vector_Function();
                case 'std::pair<casadi_int,std::string>'
                    v = self.read_std_pair_casadi_int_std_string();
                case 'std::map<std::string,std::pair<casadi_int,std::string>>'
                    v = self.read_std_map_std_string_std_pair_casadi_int__327();
                case 'std::pair<bool,std::string>'
                    v = self.read_std_pair_bool_std_string();
                case 'std::map<std::string,std::pair<bool,std::string>>'
                    v = self.read_std_map_std_string_std_pair_bool_std_string();
                case 'std::vector<MX>'
                    v = self.read_std_vector_MX();
                case 'std::map<std::string,std::vector<double>>'
                    v = self.read_std_map_std_string_std_vector_double();
                case 'std::map<std::string,casadi_int>'
                    v = self.read_std_map_std_string_casadi_int();
                case 'std::map<std::string,std::vector<casadi_int>>'
                    v = self.read_std_map_std_string_std_vector_casadi_int();
                case 'std::map<std::string,bool>'
                    v = self.read_std_map_std_string_bool();
                case 'std::map<std::string,double>'
                    v = self.read_std_map_std_string_double();
                case 'std::vector<SX>'
                    v = self.read_std_vector_SX();
                case 'std::vector<std::vector<casadi_int>>'
                    v = self.read_std_vector_std_vector_casadi_int();
                case 'std::vector<std::vector<std::string>>'
                    v = self.read_std_vector_std_vector_std_string();
                case 'std::vector<Dict>'
                    v = self.read_std_vector_Dict();
                case 'std::vector<GenericType>'
                    v = self.read_std_vector_GenericType();
                case 'std::vector<std::vector<GenericType>>'
                    v = self.read_std_vector_std_vector_GenericType();
                case 'std::vector<DM>'
                    v = self.read_std_vector_DM();
                case 'Dict'
                    v = self.read_Dict();
                otherwise
                    v = self.primitive(kind);
            end
        end

        function v = primitive(self, kind)

            if strcmp(kind, 'std::size_t')
                kind = 'size_t';
            end
            if ismember(kind, {'int', 'unsignedint', 'casadi_int', 'size_t', 'double'})
                v = self.number(kind);
                return
            end
            switch kind
                case 'char'
                    v = self.byte();
                    return
                case 'bool'
                    v = self.boolValue();
                    return
                case 'std::string'
                    v = self.stringValue();
                    return
                case {'std::istream', 'std::stringstream'}
                    v = self.streamValue();
                    return
            end
            self.fail(['Unknown serialization type: ' kind]);
        end

        function v = boolValue(self)
            self.decoration('b');
            v = self.byte();
            if v > 1, self.fail('Invalid boolean'); end
            v = logical(v);
        end

        function v = streamValue(self)
            self.decoration('B');
            n = self.number('size_t');
            offset = self.take(n);
            if self.lazy
                v = self.blob(offset, n);
            else
                v = self.object({'$bytes'}, {num2cell(double(self.readBytes(offset, n)))});
            end
        end

        function v = readObject(self, kind, tag, shared, read)
            if ~isempty(tag)
                self.decoration(tag);
            end
            if shared
                self.fieldname('Shared::flag');
                flag = self.byte();
                if flag == double('r')
                    self.fieldname('Shared::reference');
                    index = self.number('casadi_int');
                    if ~isnumeric(index) || ~isscalar(index) || index < 0 || index >= numel(self.shared)
                        self.fail('Invalid shared reference');
                    end
                    v = self.object({'$ref'}, {self.shared(index + 1)});
                    return
                end
                if flag ~= double('d')
                    self.fail('Invalid shared definition');
                end
            end
            record = self.object({'type', 'fields', 'layouts'}, {kind, {}, {}});
            read(record, self.object({}, {}));
            if ~shared
                v = record;
                return
            end
            self.count(numel(self.objects) + 1);
            index = numel(self.objects);
            self.objects{end + 1} = record;
            self.shared(end + 1) = index;
            v = self.object({'$ref'}, {index});
        end

        function v = decode(self, type)
            wire = self.scheme('wire');
            reader = self.scheme('reader');
            if ~isequal(self.number('casadi_int'), wire('magic'))
                self.fail('Invalid serialization magic');
            end
            if ~isequal(self.number('casadi_int'), wire('protocol'))
                self.fail('Unsupported serialization protocol');
            end
            debug = self.byte();
            if debug > 1
                self.fail('Invalid debug flag');
            end
            self.debug = logical(debug);
            roots = {};
            if ~isempty(type)
                roots = {self.value(type)};
            else
                kinds = reader('file_types');
                prefixes = self.get(reader, 'file_prefixes', self.object({}, {}));
                while self.pos < self.length
                    tag = num2str(self.byte());
                    if ~isKey(kinds, tag)
                        self.fail(['Unsupported serialized file type ' tag]);
                    end
                    if isKey(prefixes, tag)
                        self.value(prefixes(tag));
                    end
                    roots{end + 1} = self.value(kinds(tag));
                end
            end
            if self.pos ~= self.length
                self.fail('Trailing serialization data');
            end
            root = [];
            if numel(roots) == 1 && isa(roots{1}, 'containers.Map')
                root = self.get(roots{1}, '$ref', []);
            end
            v = self.object({'format', 'version', 'serializationProtocol', 'root', 'roots', 'objects'}, ...
                          {'casadi_serialization', 1, wire('protocol'), root, roots, self.objects});
        end

    end
    methods (Static, Access = private)

        function v = object(keys, values)
            v = containers.Map('KeyType', 'char', 'ValueType', 'any');
            for i = 1:numel(keys)
                v(keys{i}) = values{i};
            end
        end

        function v = get(map, key, default)
            if isKey(map, key)
                v = map(key);
            else
                v = default;
            end
        end

        function v = truth(x)
            if isnumeric(x) || islogical(x)
                v = ~isempty(x) && any(x ~= 0);
            else
                v = ~isempty(x);
            end
        end

        function text = encode(v)
            if isa(v, 'containers.Map')
                keys = v.keys;
                parts = cell(size(keys));
                for i = 1:numel(keys)
                    parts{i} = [jsonencode(keys{i}) ':' casadi_reader.Document.encode(v(keys{i}))];
                end
                text = ['{' strjoin(parts, ',') '}'];
            elseif iscell(v)
                parts = cell(size(v));
                for i = 1:numel(v)
                    parts{i} = casadi_reader.Document.encode(v{i});
                end
                text = ['[' strjoin(parts, ',') ']'];
            elseif isnumeric(v) && isempty(v)
                text = 'null';
            else
                text = jsonencode(v);
            end
        end

    end
end
