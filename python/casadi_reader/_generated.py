# Generated from serialization_scheme.json; do not edit.

def layout_AlpaqaInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'AlpaqaInterface', 1)
    r.field(record, 'AlpaqaInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'AlpaqaInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_AmplInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Assertion_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'Assertion::fail_message', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_BSpline_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('BSplineCommon::serialize_body')
    layout_BSplineCommon_serialize_body(r, record, scope)
    r.field(record, 'BSpline::coeffs', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.depth -= 1

def layout_BSpline_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['BSpline::type'] = r.field(record, 'BSpline::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_BSplineCommon_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'BSplineCommon::knots', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'BSplineCommon::offset', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'BSplineCommon::degree', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'BSplineCommon::m', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'BSplineCommon::lookup_mode', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'BSplineCommon::strides', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'BSplineCommon::coeffs_dims', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'BSplineCommon::coeffs_size', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'BSplineCommon::jac_cache_', 'MX', lambda: read_MX(r))
    r.depth -= 1

def layout_BSplineInterpolant_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Interpolant::serialize_body')
    layout_Interpolant_serialize_body(r, record, scope)
    r.version(record, 'BSplineInterpolant', 1)
    r.field(record, 'BSplineInterpolant::s', 'Function', lambda: read_Function(r))
    r.depth -= 1

def layout_BSplineParametric_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('BSplineCommon::serialize_body')
    layout_BSplineCommon_serialize_body(r, record, scope)
    r.depth -= 1

def layout_BSplineParametric_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['BSpline::type'] = r.field(record, 'BSpline::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_BackwardDiff_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('ForwardDiff::serialize_body')
    layout_ForwardDiff_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Bilin_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'BinaryMX::op', 'int', lambda: r.number('int'))
    r.depth -= 1

def layout_BinaryMX_ScX_ScY_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
    r.depth -= 1

def layout_BinarySX_serialize_node(r, record, scope):
    r.enter_layout()
    r.field(record, 'UnarySX::dep0', 'SXElem', lambda: read_SXElem(r))
    r.field(record, 'UnarySX::dep1', 'SXElem', lambda: read_SXElem(r))
    r.depth -= 1

def layout_Bisection_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Rootfinder::serialize_body')
    layout_Rootfinder_serialize_body(r, record, scope)
    r.version(record, 'Bisection', 1)
    r.field(record, 'Bisection::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Bisection::max_search', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Bisection::search_step', 'double', lambda: r.number('double'))
    r.field(record, 'Bisection::abstol', 'double', lambda: r.number('double'))
    r.field(record, 'Bisection::abstol_step', 'double', lambda: r.number('double'))
    r.field(record, 'Bisection::lb', 'double', lambda: r.number('double'))
    r.field(record, 'Bisection::ub', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_BlazingSplineFunction_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'BlazingSplineFunction', 2)
    r.field(record, 'BlazingSplineFunction::diff_order', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'BlazingSplineFunction::precompute_coeff', 'bool', lambda: r.boolean())
    r.field(record, 'BlazingSplineFunction::precompute_grid', 'bool', lambda: r.boolean())
    r.field(record, 'BlazingSplineFunction::knots', 'std::vector<std::vector<double>>', lambda: read_std_vector_std_vector_double(r))
    r.field(record, 'BlazingSplineFunction::lookup_modes', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    scope['BlazingSplineFunction::parametric_knots'] = r.field(record, 'BlazingSplineFunction::parametric_knots', 'bool', lambda: r.boolean())
    if scope['BlazingSplineFunction::parametric_knots']:
        r.field(record, 'BlazingSplineFunction::knots_offset', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
        r.field(record, 'BlazingSplineFunction::inv_input', 'bool', lambda: r.boolean())
    r.field(record, 'BlazingSplineFunction::pedantic_mode_order', 'std::string', lambda: r.string())
    r.field(record, 'BlazingSplineFunction::pedantic_mode_size', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_Blocksqp_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'Blocksqp', 1)
    r.field(record, 'Blocksqp::nblocks', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::blocks', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Blocksqp::dim', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Blocksqp::nnz_H', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::Asp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Blocksqp::Hsp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Blocksqp::exact_hess_lag_sp_', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Blocksqp::linsol_plugin', 'std::string', lambda: r.string())
    r.field(record, 'Blocksqp::print_header', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::print_iteration', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::eps', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::opttol', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::nlinfeastol', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::schur', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::globalization', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::restore_feas', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::max_line_search', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::max_consec_reduced_steps', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::max_consec_skipped_updates', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::max_it_qp', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::warmstart', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::qp_init', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::block_hess', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::hess_scaling', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::fallback_scaling', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::max_time_qp', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::ini_hess_diag', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::col_eps', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::col_tau1', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::col_tau2', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::hess_damp', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::hess_damp_fac', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::hess_update', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::fallback_update', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::hess_lim_mem', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::hess_memsize', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::which_second_derv', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::skip_first_globalization', 'bool', lambda: r.boolean())
    r.field(record, 'Blocksqp::conv_strategy', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::max_conv_qp', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::max_soc_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Blocksqp::gamma_theta', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::gamma_f', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::kappa_soc', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::kappa_f', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::theta_max', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::theta_min', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::delta', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::s_theta', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::s_f', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::kappa_minus', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::kappa_plus', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::kappa_plus_max', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::delta_h0', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::eta', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::obj_lo', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::obj_up', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::rho', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::zeta', 'double', lambda: r.number('double'))
    r.field(record, 'Blocksqp::rp_solver', 'Function', lambda: read_Function(r))
    r.field(record, 'Blocksqp::print_maxit_reached', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_BonminInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'BonminInterface', 1)
    r.field(record, 'BonminInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'BonminInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'BonminInterface::exact_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'BonminInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'BonminInterface::sos1_weights', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'BonminInterface::sos1_indices', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'BonminInterface::sos1_priorities', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'BonminInterface::sos1_starts', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'BonminInterface::sos1_types', 'std::vector<char>', lambda: read_std_vector_char(r))
    r.field(record, 'BonminInterface::sos1_types', 'std::vector<char>', lambda: read_std_vector_char(r))
    r.field(record, 'BonminInterface::sos_num', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'BonminInterface::sos_num_nz', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'BonminInterface::pass_nonlinear_variables', 'bool', lambda: r.boolean())
    r.field(record, 'BonminInterface::pass_nonlinear_constraints', 'bool', lambda: r.boolean())
    r.field(record, 'BonminInterface::nl_ex', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'BonminInterface::nl_g', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'BonminInterface::var_string_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'BonminInterface::var_integer_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'BonminInterface::var_numeric_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'BonminInterface::con_string_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'BonminInterface::con_integer_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'BonminInterface::con_numeric_md', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_CSparseCholeskyInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Call_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MultipleOutput::serialize_body')
    layout_MultipleOutput_serialize_body(r, record, scope)
    r.field(record, 'Call::fcn', 'Function', lambda: read_Function(r))
    r.depth -= 1

def layout_CallSX_serialize_node(r, record, scope):
    r.enter_layout()
    r.field(record, 'CallSX::f', 'Function', lambda: read_Function(r))
    r.field(record, 'CallSX::dep', 'std::vector<SXElem>', lambda: read_std_vector_SXElem(r))
    r.depth -= 1

def layout_CbcInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'CbcInterface', 1)
    r.field(record, 'CbcInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'CbcInterface::sos_groups', 'std::vector<std::vector<int>>', lambda: read_std_vector_std_vector_int(r))
    r.field(record, 'CbcInterface::sos_weights', 'std::vector<std::vector<double>>', lambda: read_std_vector_std_vector_double(r))
    r.field(record, 'CbcInterface::sos_types', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'CbcInterface::hot_start', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_CentralDiff_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FiniteDiff::serialize_body')
    layout_FiniteDiff_serialize_body(r, record, scope)
    r.depth -= 1

def layout_ClarabelInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'ClarabelInterface', 1)
    r.field(record, 'ClarabelInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_ClpInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'ClpInterface', 1)
    r.field(record, 'ClpInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_Collocation_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('ImplicitFixedStepIntegrator::serialize_body')
    layout_ImplicitFixedStepIntegrator_serialize_body(r, record, scope)
    r.version(record, 'Collocation', 2)
    r.field(record, 'Collocation::deg', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Collocation::collocation_scheme', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_Concat_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Conic_serialize(r, record, scope):
    r.enter_layout()
    r.field(record, 'Conic::SDPToSOCPMem::r', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Conic::SDPToSOCPMem::AT', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Conic::SDPToSOCPMem::A_mapping', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Conic::SDPToSOCPMem::map_Q', 'IM', lambda: read_IM(r))
    r.field(record, 'Conic::SDPToSOCPMem::map_P', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Conic::SDPToSOCPMem::indval_size', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Conic_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'Conic', 4)
    r.field(record, 'Conic::discrete', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'Conic::equality', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'Conic::print_problem', 'bool', lambda: r.boolean())
    r.field(record, 'Conic::solver_version_check', 'bool', lambda: r.boolean())
    r.field(record, 'Conic::H', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Conic::A', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Conic::Q', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Conic::P', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Conic::nx', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Conic::na', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Conic::np', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Conic_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_type')
    layout_FunctionInternal_serialize_type(r, record, scope)
    record["layouts"].append('PluginInterface<Conic>::serialize_type')
    layout_PluginInterface_Conic_serialize_type(r, record, scope)
    r.depth -= 1

def layout_ConoptInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'ConoptInterface', 1)
    r.field(record, 'ConoptInterface::exact_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'ConoptInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'ConoptInterface::gradf_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'ConoptInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'ConoptInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'ConoptInterface::optfile', 'std::string', lambda: r.string())
    r.field(record, 'ConoptInterface::warm_start', 'bool', lambda: r.boolean())
    r.field(record, 'ConoptInterface::debug', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_Constant_Value_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Constant_Value_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['ConstantMX::type'] = r.field(record, 'ConstantMX::type', 'char', lambda: r.byte())
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_ConstantDM_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'ConstantMX::nonzeros', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.depth -= 1

def layout_ConstantDM_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['ConstantMX::type'] = r.field(record, 'ConstantMX::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_ConstantFile_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'ConstantFile::fname', 'std::string', lambda: r.string())
    r.field(record, 'ConstantFile::x', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.depth -= 1

def layout_ConstantFile_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    r.field(record, 'ConstantFile::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_ConstantPool_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'ConstantPool::name', 'std::string', lambda: r.string())
    r.field(record, 'ConstantPool::x', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.depth -= 1

def layout_ConstantPool_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    r.field(record, 'ConstantPool::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_Convexify_serialize(r, record, scope):
    r.enter_layout()
    r.version(record, (str(scope['prefix']) + str('Convexify')), 1)
    r.field(record, (str(scope['prefix']) + str('Convexify::type_in')), 'int', lambda: r.number('int'))
    r.field(record, (str(scope['prefix']) + str('Convexify::strategy')), 'int', lambda: r.number('int'))
    r.field(record, (str(scope['prefix']) + str('Convexify::margin')), 'double', lambda: r.number('double'))
    r.field(record, (str(scope['prefix']) + str('Convexify::max_iter_eig')), 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, (str(scope['prefix']) + str('Convexify::scc_offset')), 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, (str(scope['prefix']) + str('Convexify::scc_mapping')), 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, (str(scope['prefix']) + str('Convexify::Hsp_project')), 'int', lambda: r.number('int'))
    r.field(record, (str(scope['prefix']) + str('Convexify::scc_transform')), 'int', lambda: r.number('int'))
    r.field(record, (str(scope['prefix']) + str('Convexify::verbose')), 'int', lambda: r.number('int'))
    r.field(record, (str(scope['prefix']) + str('Convexify::Hsp')), 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, (str(scope['prefix']) + str('Convexify::Hrsp')), 'Sparsity', lambda: read_Sparsity(r))
    r.depth -= 1

def layout_Convexify_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    record["layouts"].append('Convexify::serialize')
    scope['prefix'] = ''
    layout_Convexify_serialize(r, record, scope)
    r.depth -= 1

def layout_CplexInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'CplexInterface', 1)
    r.field(record, 'CplexInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'CplexInterface::qp_method', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'CplexInterface::dump_to_file', 'bool', lambda: r.boolean())
    r.field(record, 'CplexInterface::tol', 'double', lambda: r.number('double'))
    r.field(record, 'CplexInterface::dep_check', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'CplexInterface::warm_start', 'bool', lambda: r.boolean())
    r.field(record, 'CplexInterface::mip_start', 'bool', lambda: r.boolean())
    r.field(record, 'CplexInterface::mip', 'bool', lambda: r.boolean())
    r.field(record, 'CplexInterface::ctype', 'std::vector<char>', lambda: read_std_vector_char(r))
    r.field(record, 'CplexInterface::sos_weights', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'CplexInterface::sos_beg', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'CplexInterface::sos_ind', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'CplexInterface::sos_types', 'std::vector<char>', lambda: read_std_vector_char(r))
    record["layouts"].append('Conic::serialize')
    layout_Conic_serialize(r, record, scope)
    r.depth -= 1

def layout_CsparseInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1

def layout_CvodesInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('SundialsInterface::serialize_body')
    layout_SundialsInterface_serialize_body(r, record, scope)
    r.version(record, 'CvodesInterface', 3)
    r.field(record, 'CvodesInterface::lmm', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'CvodesInterface::iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'CvodesInterface::min_step_size', 'double', lambda: r.number('double'))
    r.field(record, 'CvodesInterface::always_recalculate_jacobian', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_DaqpInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'DaqpInterface', 1)
    r.field(record, 'DaqpInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_DenseKron_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Kron::serialize_body')
    layout_Kron_serialize_body(r, record, scope)
    r.depth -= 1

def layout_DenseKron_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Kron::kind'] = r.field(record, 'Kron::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_DenseKronContract_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('KronContract::serialize_body')
    layout_KronContract_serialize_body(r, record, scope)
    r.depth -= 1

def layout_DenseKronContract_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['KronContract::kind'] = r.field(record, 'KronContract::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_DenseMultiplication_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Multiplication::serialize_body')
    layout_Multiplication_serialize_body(r, record, scope)
    r.depth -= 1

def layout_DenseMultiplication_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Multiplication::kind'] = r.field(record, 'Multiplication::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_DenseSparseKron_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Kron::serialize_body')
    layout_Kron_serialize_body(r, record, scope)
    r.depth -= 1

def layout_DenseSparseKron_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Kron::kind'] = r.field(record, 'Kron::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_DenseSparseKronContract_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('KronContract::serialize_body')
    layout_KronContract_serialize_body(r, record, scope)
    r.depth -= 1

def layout_DenseSparseKronContract_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['KronContract::kind'] = r.field(record, 'KronContract::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_DenseSparseMultiplication_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Multiplication::serialize_body')
    layout_Multiplication_serialize_body(r, record, scope)
    r.depth -= 1

def layout_DenseSparseMultiplication_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Multiplication::kind'] = r.field(record, 'Multiplication::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_DenseTranspose_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Transpose::serialize_body')
    layout_Transpose_serialize_body(r, record, scope)
    r.depth -= 1

def layout_DenseTranspose_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Transpose::dense'] = r.field(record, 'Transpose::dense', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_Densify_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Project::serialize_body')
    layout_Project_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Densify_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Project::type'] = r.field(record, 'Project::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_Determinant_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'Determinant::linsol', 'Linsol', lambda: read_Linsol(r))
    r.depth -= 1

def layout_Diagcat_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Concat::serialize_body')
    layout_Concat_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Diagsplit_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Split::serialize_body')
    layout_Split_serialize_body(r, record, scope)
    r.depth -= 1

def layout_DirResource_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('ResourceInternal::serialize_body')
    layout_ResourceInternal_serialize_body(r, record, scope)
    r.version(record, 'DirResource', 1)
    if (scope['ResourceInternal::serialize_mode'] == 'embed'):
        r.field(record, 'ZipMemResource::blob', 'std::stringstream', lambda: r.stream())
    else:
        r.field(record, 'DirResource::path', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_DirResource_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('unlowered else branch')
    r.depth -= 1

def layout_Dot_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Dump_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.version(record, 'Dump', 1)
    r.field(record, 'Dump::base_filename', 'std::string', lambda: r.string())
    r.field(record, 'Dump::dir', 'std::string', lambda: r.string())
    r.field(record, 'Dump::format', 'std::string', lambda: r.string())
    r.field(record, 'Dump::verbose', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_Einstein_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'Einstein::dim_c', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::dim_a', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::dim_b', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::c', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::a', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::b', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::iter_dims', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::strides_a', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::strides_b', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::strides_c', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Einstein::n_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_External_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'External', 2)
    r.field(record, 'External::int_data', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'External::real_data', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'External::string_data', 'std::string', lambda: r.string())
    r.field(record, 'External::li', 'Importer', lambda: read_Importer(r))
    r.field(record, 'External::config_args', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.depth -= 1

def layout_FastNewton_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Rootfinder::serialize_body')
    layout_Rootfinder_serialize_body(r, record, scope)
    r.version(record, 'Newton', 1)
    r.field(record, 'Newton::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Newton::abstol', 'double', lambda: r.number('double'))
    r.field(record, 'Newton::abstolStep', 'double', lambda: r.number('double'))
    r.field(record, 'Newton::jac_g_x', 'Function', lambda: read_Function(r))
    r.field(record, 'Newton::sp_v', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Newton::sp_r', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Newton::prinv', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Newton::pc', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_FatropConicInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'FatropConicInterface', 1)
    r.depth -= 1

def layout_FatropInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'FatropInterface', 1)
    r.field(record, 'FatropInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FatropInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FatropInterface::exact_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'FatropInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'FatropInterface::convexify', 'bool', lambda: r.boolean())
    r.field(record, 'FatropInterface::Isp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FatropInterface::ABsp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FatropInterface::CDsp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FatropInterface::RSQsp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FatropInterface::AB_blocks', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::CD_blocks', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::RSQ_blocks', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::I_blocks', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::nxs', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::nus', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::ngs', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::N', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FatropInterface::structure_detection', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FatropInterface::AB_offsets', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::CD_offsets', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::RSQ_offsets', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::I_offsets', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FatropInterface::debug', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_Feasiblesqpmethod_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'Feasiblesqpmethod', 3)
    r.field(record, 'Feasiblesqpmethod::qpsol', 'Function', lambda: read_Function(r))
    r.field(record, 'Feasiblesqpmethod::exact_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'Feasiblesqpmethod::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Feasiblesqpmethod::min_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Feasiblesqpmethod::lbfgs_memory', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Feasiblesqpmethod::tol_pr_', 'double', lambda: r.number('double'))
    r.field(record, 'Feasiblesqpmethod::tol_du_', 'double', lambda: r.number('double'))
    r.field(record, 'Feasiblesqpmethod::print_header', 'bool', lambda: r.boolean())
    r.field(record, 'Feasiblesqpmethod::print_iteration', 'bool', lambda: r.boolean())
    r.field(record, 'Feasiblesqpmethod::print_status', 'bool', lambda: r.boolean())
    r.field(record, 'Feasiblesqpmethod::init_feasible', 'bool', lambda: r.boolean())
    r.field(record, 'Feasiblesqpmethod::Hsp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Feasiblesqpmethod::Asp', 'Sparsity', lambda: read_Sparsity(r))
    scope['Feasiblesqpmethod::convexify'] = r.field(record, 'Feasiblesqpmethod::convexify', 'bool', lambda: r.boolean())
    if scope['Feasiblesqpmethod::convexify']:
        record["layouts"].append('Convexify::serialize')
        scope['prefix'] = 'Feasiblesqpmethod::'
        layout_Convexify_serialize(r, record, scope)
    r.depth -= 1

def layout_Find_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_FiniteDiff_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'FiniteDiff', 1)
    r.field(record, 'FiniteDiff::n', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FiniteDiff::h_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FiniteDiff::h', 'double', lambda: r.number('double'))
    r.field(record, 'FiniteDiff::n_z', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FiniteDiff::n_y', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FiniteDiff::u_aim', 'double', lambda: r.number('double'))
    r.field(record, 'FiniteDiff::h_min', 'double', lambda: r.number('double'))
    r.field(record, 'FiniteDiff::h_max', 'double', lambda: r.number('double'))
    r.field(record, 'FiniteDiff::reltol', 'double', lambda: r.number('double'))
    r.field(record, 'FiniteDiff::abstol', 'double', lambda: r.number('double'))
    r.field(record, 'FiniteDiff::smoothing', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_FixedStepIntegrator_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Integrator::serialize_body')
    layout_Integrator_serialize_body(r, record, scope)
    r.version(record, 'FixedStepIntegrator', 3)
    r.field(record, 'FixedStepIntegrator::nk_target', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FixedStepIntegrator::disc', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FixedStepIntegrator::nv', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FixedStepIntegrator::nv1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FixedStepIntegrator::nrv', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FixedStepIntegrator::nrv1', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Fmu2_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FmuInternal::serialize_body')
    layout_FmuInternal_serialize_body(r, record, scope)
    r.version(record, 'Fmu2', 2)
    r.field(record, 'Fmu2::vr_real', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu2::vr_integer', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu2::vr_boolean', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu2::vr_string', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu2::init_real', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'Fmu2::init_integer', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'Fmu2::init_boolean', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'Fmu2::init_string', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu2::vn_aux_real', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu2::vn_aux_integer', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu2::vn_aux_boolean', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu2::vn_aux_string', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu2::vr_aux_real', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu2::vr_aux_integer', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu2::vr_aux_boolean', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu2::vr_aux_string', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.depth -= 1

def layout_Fmu3_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FmuInternal::serialize_body')
    layout_FmuInternal_serialize_body(r, record, scope)
    r.version(record, 'Fmu3', 1)
    r.field(record, 'Fmu3::vr_real', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu3::vr_integer', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu3::vr_boolean', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu3::vr_string', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu3::init_real', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'Fmu3::init_integer', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'Fmu3::init_boolean', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'Fmu3::init_string', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu3::vn_aux_real', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu3::vn_aux_integer', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu3::vn_aux_boolean', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu3::vn_aux_string', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Fmu3::vr_aux_real', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu3::vr_aux_integer', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu3::vr_aux_boolean', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'Fmu3::vr_aux_string', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.depth -= 1

def layout_Fmu_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_FmuFunction_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'FmuFunction', 6)
    r.field(record, 'FmuFunction::Fmu', 'Fmu', lambda: read_Fmu(r))
    for _ in range(r.count(len(scope['FunctionInternal::sp_in']))):
        r.field(record, 'FmuFunction::in::type', 'int', lambda: r.number('int'))
        r.field(record, 'FmuFunction::in::ind', 'size_t', lambda: r.number('size_t'))
    for _ in range(r.count(len(scope['FunctionInternal::sp_out']))):
        r.field(record, 'FmuFunction::out::type', 'int', lambda: r.number('int'))
        r.field(record, 'FmuFunction::out::ind', 'size_t', lambda: r.number('size_t'))
        r.field(record, 'FmuFunction::out::wrt', 'size_t', lambda: r.number('size_t'))
        r.field(record, 'FmuFunction::out::rbegin', 'size_t', lambda: r.number('size_t'))
        r.field(record, 'FmuFunction::out::rend', 'size_t', lambda: r.number('size_t'))
        r.field(record, 'FmuFunction::out::cbegin', 'size_t', lambda: r.number('size_t'))
        r.field(record, 'FmuFunction::out::cend', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FmuFunction::jac_in', 'std::vector<size_t>', lambda: read_std_vector_size_t(r))
    r.field(record, 'FmuFunction::jac_out', 'std::vector<size_t>', lambda: read_std_vector_size_t(r))
    r.field(record, 'FmuFunction::jac_nom_in', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'FmuFunction::sp_trans', 'std::vector<Sparsity>', lambda: read_std_vector_Sparsity(r))
    r.field(record, 'FmuFunction::sp_trans_map', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FmuFunction::has_jac', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::has_fwd', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::has_adj', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::has_hess', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::uses_directional_derivatives', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::uses_adjoint_derivatives', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::nfwd', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FmuFunction::nadj', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FmuFunction::validate_forward', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::validate_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::make_symmetric', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::step', 'double', lambda: r.number('double'))
    r.field(record, 'FmuFunction::fd_flip', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::abstol', 'double', lambda: r.number('double'))
    r.field(record, 'FmuFunction::reltol', 'double', lambda: r.number('double'))
    r.field(record, 'FmuFunction::print_progress', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::new_jacobian', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::new_forward', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::new_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::hessian_coloring', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::asymmetric_hessian_coloring', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::enable_forward_jacobian', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::enable_adjoint_jacobian', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::enable_adjoint_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'FmuFunction::validate_ad_file', 'std::string', lambda: r.string())
    r.field(record, 'FmuFunction::fd', 'int', lambda: r.number('int'))
    r.field(record, 'FmuFunction::parallelization', 'int', lambda: r.number('int'))
    r.field(record, 'FmuFunction::init_stats', 'Dict', lambda: read_Dict(r))
    r.field(record, 'FmuFunction::jac_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuFunction::hess_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuFunction::adj_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuFunction::jac_colors', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuFunction::adj_colors', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuFunction::hess_colors', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuFunction::hess_uni_colors', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuFunction::which_hess_color', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FmuFunction::nonlin', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'FmuFunction::max_jac_tasks', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FmuFunction::max_hess_tasks', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FmuFunction::max_n_tasks', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_FmuInternal_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_FmuInternal_serialize_body(r, record, scope):
    r.enter_layout()
    r.version(record, 'FmuInternal', 4)
    r.field(record, 'FmuInternal::name', 'std::string', lambda: r.string())
    r.field(record, 'FmuInternal::scheme_in', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'FmuInternal::scheme_out', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'FmuInternal::scheme', 'std::map<std::string,std::vector<size_t>>', lambda: read_std_map_std_string_std_vector_size_t(r))
    r.field(record, 'FmuInternal::aux', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'FmuInternal::iind', 'std::vector<size_t>', lambda: read_std_vector_size_t(r))
    r.field(record, 'FmuInternal::iind_map', 'std::vector<size_t>', lambda: read_std_vector_size_t(r))
    r.field(record, 'FmuInternal::oind', 'std::vector<size_t>', lambda: read_std_vector_size_t(r))
    r.field(record, 'FmuInternal::oind_map', 'std::vector<size_t>', lambda: read_std_vector_size_t(r))
    r.field(record, 'FmuInternal::has_independent', 'bool', lambda: r.boolean())
    r.field(record, 'FmuInternal::nominal_in', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'FmuInternal::nominal_out', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'FmuInternal::min_in', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'FmuInternal::min_out', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'FmuInternal::max_in', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'FmuInternal::max_out', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'FmuInternal::vn_in', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'FmuInternal::vn_out', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'FmuInternal::vr_in', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'FmuInternal::vr_out', 'std::vector<unsignedint>', lambda: read_std_vector_unsignedint(r))
    r.field(record, 'FmuInternal::value_in', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'FmuInternal::ired', 'std::vector<std::vector<size_t>>', lambda: read_std_vector_std_vector_size_t(r))
    r.field(record, 'FmuInternal::ored', 'std::vector<std::vector<size_t>>', lambda: read_std_vector_std_vector_size_t(r))
    r.field(record, 'FmuInternal::jac_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuInternal::hess_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'FmuInternal::resource', 'Resource', lambda: read_Resource(r))
    r.field(record, 'FmuInternal::fmutol', 'double', lambda: r.number('double'))
    r.field(record, 'FmuInternal::instance_name', 'std::string', lambda: r.string())
    r.field(record, 'FmuInternal::instantiation_token', 'std::string', lambda: r.string())
    r.field(record, 'FmuInternal::logging_on', 'bool', lambda: r.boolean())
    r.field(record, 'FmuInternal::number_of_event_indicators', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FmuInternal::provides_directional_derivatives', 'bool', lambda: r.boolean())
    r.field(record, 'FmuInternal::provides_adjoint_derivatives', 'bool', lambda: r.boolean())
    r.field(record, 'FmuInternal::can_be_instantiated_only_once_per_process', 'bool', lambda: r.boolean())
    r.field(record, 'FmuInternal::start_time', 'double', lambda: r.number('double'))
    r.field(record, 'FmuInternal::nx', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FmuInternal::do_evaluation_dance', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_FmuInternal_serialize_type(r, record, scope):
    r.enter_layout()
    scope['FmuInternal::type'] = r.field(record, 'FmuInternal::type', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_ForwardDiff_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FiniteDiff::serialize_body')
    layout_FiniteDiff_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Function_serialize(r, record, scope):
    r.enter_layout()
    r.fail('Predicate has no serialized field')
    r.depth -= 1

def layout_FunctionInternal_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('ProtoFunction::serialize_body')
    layout_ProtoFunction_serialize_body(r, record, scope)
    r.version(record, 'FunctionInternal', 8)
    r.field(record, 'FunctionInternal::is_diff_in', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'FunctionInternal::is_diff_out', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    scope['FunctionInternal::sp_in'] = r.field(record, 'FunctionInternal::sp_in', 'std::vector<Sparsity>', lambda: read_std_vector_Sparsity(r))
    scope['FunctionInternal::sp_out'] = r.field(record, 'FunctionInternal::sp_out', 'std::vector<Sparsity>', lambda: read_std_vector_Sparsity(r))
    r.field(record, 'FunctionInternal::name_in', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'FunctionInternal::name_out', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    scope['FunctionInternal::jit'] = r.field(record, 'FunctionInternal::jit', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::jit_cleanup', 'bool', lambda: r.boolean())
    scope['FunctionInternal::jit_serialize'] = r.field(record, 'FunctionInternal::jit_serialize', 'std::string', lambda: r.string())
    if ((scope['FunctionInternal::jit_serialize'] == 'link') or (scope['FunctionInternal::jit_serialize'] == 'embed')):
        r.field(record, 'FunctionInternal::jit_library', 'std::string', lambda: r.string())
        if (scope['FunctionInternal::jit_serialize'] == 'embed'):
            r.field(record, 'FunctionInternal::jit_binary', 'std::stringstream', lambda: r.stream())
    r.field(record, 'FunctionInternal::jit_temp_suffix', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::jit_base_name', 'std::string', lambda: r.string())
    r.field(record, 'FunctionInternal::jit_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'FunctionInternal::compiler_plugin', 'std::string', lambda: r.string())
    r.field(record, 'FunctionInternal::has_refcount', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::cache_init', 'Dict', lambda: read_Dict(r))
    r.field(record, 'FunctionInternal::derivative_of', 'Function', lambda: read_Function(r))
    r.field(record, 'FunctionInternal::jac_penalty', 'double', lambda: r.number('double'))
    r.field(record, 'FunctionInternal::enable_forward', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::enable_reverse', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::enable_jacobian', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::enable_fd', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::enable_forward_op', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::enable_reverse_op', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::enable_jacobian_op', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::enable_fd_op', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::ad_weight', 'double', lambda: r.number('double'))
    r.field(record, 'FunctionInternal::ad_weight_sp', 'double', lambda: r.number('double'))
    r.field(record, 'FunctionInternal::always_inline', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::never_inline', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::max_num_dir', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FunctionInternal::inputs_check', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::fd_step', 'double', lambda: r.number('double'))
    r.field(record, 'FunctionInternal::fd_method', 'std::string', lambda: r.string())
    r.field(record, 'FunctionInternal::print_in', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::print_out', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::print_canonical', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::max_io', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'FunctionInternal::dump_in', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::dump_out', 'bool', lambda: r.boolean())
    r.field(record, 'FunctionInternal::dump_dir', 'std::string', lambda: r.string())
    r.field(record, 'FunctionInternal::dump_format', 'std::string', lambda: r.string())
    r.field(record, 'FunctionInternal::forward_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'FunctionInternal::reverse_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'FunctionInternal::jacobian_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'FunctionInternal::der_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'FunctionInternal::custom_jacobian', 'Function', lambda: read_Function(r))
    r.field(record, 'FunctionInternal::registered_functions', 'std::vector<Function>', lambda: read_std_vector_Function(r))
    r.field(record, 'FunctionInternal::sz_arg_per', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FunctionInternal::sz_res_per', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FunctionInternal::sz_iw_per', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FunctionInternal::sz_w_per', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FunctionInternal::sz_arg_tmp', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FunctionInternal::sz_res_tmp', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FunctionInternal::sz_iw_tmp', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'FunctionInternal::sz_w_tmp', 'size_t', lambda: r.number('size_t'))
    r.depth -= 1

def layout_FunctionInternal_serialize_type(r, record, scope):
    r.enter_layout()
    scope['FunctionInternal::base_function'] = r.field(record, 'FunctionInternal::base_function', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_GenericExternal_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_type')
    layout_FunctionInternal_serialize_type(r, record, scope)
    r.version(record, 'GenericExternal', 1)
    scope['GenericExternal::type'] = r.field(record, 'GenericExternal::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_GenericType_serialize(r, record, scope):
    r.enter_layout()
    scope['GenericType::type'] = r.field(record, 'GenericType::type', 'int', lambda: r.number('int'))
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_GetNonzeros_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_GetNonzeros_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    r.depth -= 1

def layout_GetNonzerosParam_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_GetNonzerosParam_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    r.depth -= 1

def layout_GetNonzerosParamParam_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzerosParam::serialize_body')
    layout_GetNonzerosParam_serialize_body(r, record, scope)
    r.depth -= 1

def layout_GetNonzerosParamParam_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzerosParam::serialize_type')
    layout_GetNonzerosParam_serialize_type(r, record, scope)
    scope['GetNonzerosParam::type'] = r.field(record, 'GetNonzerosParam::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_GetNonzerosParamSlice_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzerosParam::serialize_body')
    layout_GetNonzerosParam_serialize_body(r, record, scope)
    r.field(record, 'GetNonzerosParamSlice::outer', 'Slice', lambda: read_Slice(r))
    r.depth -= 1

def layout_GetNonzerosParamSlice_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzerosParam::serialize_type')
    layout_GetNonzerosParam_serialize_type(r, record, scope)
    scope['GetNonzerosParam::type'] = r.field(record, 'GetNonzerosParam::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_GetNonzerosParamVector_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzerosParam::serialize_body')
    layout_GetNonzerosParam_serialize_body(r, record, scope)
    r.depth -= 1

def layout_GetNonzerosParamVector_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzerosParam::serialize_type')
    layout_GetNonzerosParam_serialize_type(r, record, scope)
    scope['GetNonzerosParam::type'] = r.field(record, 'GetNonzerosParam::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_GetNonzerosSlice2_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzeros::serialize_body')
    layout_GetNonzeros_serialize_body(r, record, scope)
    r.field(record, 'GetNonzerosSlice2::inner', 'Slice', lambda: read_Slice(r))
    r.field(record, 'GetNonzerosSlice2::outer', 'Slice', lambda: read_Slice(r))
    r.depth -= 1

def layout_GetNonzerosSlice2_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzeros::serialize_type')
    layout_GetNonzeros_serialize_type(r, record, scope)
    scope['GetNonzeros::type'] = r.field(record, 'GetNonzeros::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_GetNonzerosSlice_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzeros::serialize_body')
    layout_GetNonzeros_serialize_body(r, record, scope)
    r.field(record, 'GetNonzerosSlice::slice', 'Slice', lambda: read_Slice(r))
    r.depth -= 1

def layout_GetNonzerosSlice_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzeros::serialize_type')
    layout_GetNonzeros_serialize_type(r, record, scope)
    scope['GetNonzeros::type'] = r.field(record, 'GetNonzeros::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_GetNonzerosSliceParam_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzerosParam::serialize_body')
    layout_GetNonzerosParam_serialize_body(r, record, scope)
    r.field(record, 'GetNonzerosSliceParam::inner', 'Slice', lambda: read_Slice(r))
    r.depth -= 1

def layout_GetNonzerosSliceParam_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzerosParam::serialize_type')
    layout_GetNonzerosParam_serialize_type(r, record, scope)
    scope['GetNonzerosParam::type'] = r.field(record, 'GetNonzerosParam::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_GetNonzerosVector_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzeros::serialize_body')
    layout_GetNonzeros_serialize_body(r, record, scope)
    r.field(record, 'GetNonzerosVector::nonzeros', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_GetNonzerosVector_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('GetNonzeros::serialize_type')
    layout_GetNonzeros_serialize_type(r, record, scope)
    scope['GetNonzeros::type'] = r.field(record, 'GetNonzeros::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_GurobiInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'GurobiInterface', 2)
    r.field(record, 'GurobiInterface::lazy_constraints_callback', 'Function', lambda: read_Function(r))
    r.field(record, 'GurobiInterface::vtype', 'std::vector<char>', lambda: read_std_vector_char(r))
    r.field(record, 'GurobiInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'GurobiInterface::sos_weights', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'GurobiInterface::sos_beg', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'GurobiInterface::sos_ind', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'GurobiInterface::sos_types', 'std::vector<int>', lambda: read_std_vector_int(r))
    record["layouts"].append('Conic::serialize')
    layout_Conic_serialize(r, record, scope)
    r.depth -= 1

def layout_HighsInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'HighsInterface', 1)
    r.field(record, 'HighsInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_HorzRepmat_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'HorzRepmat::n', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_HorzRepsum_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'HorzRepsum::n', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Horzcat_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Concat::serialize_body')
    layout_Concat_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Horzsplit_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Split::serialize_body')
    layout_Split_serialize_body(r, record, scope)
    r.depth -= 1

def layout_HpipmInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'HpipmInterface', 1)
    r.depth -= 1

def layout_HpmpcInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.depth -= 1

def layout_IOInstruction_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'IOInstruction::ind', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'IOInstruction::segment', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'IOInstruction::offset', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_IdasInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('SundialsInterface::serialize_body')
    layout_SundialsInterface_serialize_body(r, record, scope)
    r.version(record, 'IdasInterface', 2)
    r.field(record, 'IdasInterface::cj_scaling', 'bool', lambda: r.boolean())
    r.field(record, 'IdasInterface::calc_ic', 'bool', lambda: r.boolean())
    r.field(record, 'IdasInterface::calc_icB', 'bool', lambda: r.boolean())
    r.field(record, 'IdasInterface::suppress_algebraic', 'bool', lambda: r.boolean())
    r.field(record, 'IdasInterface::abstolv', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'IdasInterface::first_time', 'double', lambda: r.number('double'))
    r.field(record, 'IdasInterface::init_xdot', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'IdasInterface::max_step_size', 'double', lambda: r.number('double'))
    r.field(record, 'IdasInterface::y_c', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_ImplicitFixedStepIntegrator_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FixedStepIntegrator::serialize_body')
    layout_FixedStepIntegrator_serialize_body(r, record, scope)
    r.version(record, 'ImplicitFixedStepIntegrator', 2)
    r.depth -= 1

def layout_ImplicitToNlp_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Rootfinder::serialize_body')
    layout_Rootfinder_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Importer_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_ImporterInternal_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_ImporterInternal_serialize_body(r, record, scope):
    r.enter_layout()
    r.version(record, 'ImporterInternal', 1)
    r.field(record, 'ImporterInternal::name', 'std::string', lambda: r.string())
    r.field(record, 'ImporterInternal::meta', 'std::map<std::string,std::pair<casadi_int,std::string>>', lambda: read_std_map_std_string_std_pair_casadi_int_std_string(r))
    r.field(record, 'ImporterInternal::external', 'std::map<std::string,std::pair<bool,std::string>>', lambda: read_std_map_std_string_std_pair_bool_std_string(r))
    r.depth -= 1

def layout_ImporterInternal_serialize_type(r, record, scope):
    r.enter_layout()
    scope['ImporterInternal::type'] = r.field(record, 'ImporterInternal::type', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_InfSX_serialize_node(r, record, scope):
    r.enter_layout()
    scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_Input_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('IOInstruction::serialize_body')
    layout_IOInstruction_serialize_body(r, record, scope)
    r.depth -= 1

def layout_IntegerSX_serialize_node(r, record, scope):
    r.enter_layout()
    scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
    r.field(record, 'ConstantSX::value', 'int', lambda: r.number('int'))
    r.depth -= 1

def layout_Integrator_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('OracleFunction::serialize_body')
    layout_OracleFunction_serialize_body(r, record, scope)
    r.version(record, 'Integrator', 3)
    r.field(record, 'Integrator::sp_jac_dae', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Integrator::sp_jac_rdae', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Integrator::t0', 'double', lambda: r.number('double'))
    r.field(record, 'Integrator::tout', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'Integrator::nfwd', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nadj', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::rdae', 'Function', lambda: read_Function(r))
    r.field(record, 'Integrator::nx', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nz', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nq', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nx1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nz1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nq1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nrx', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nrz', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nrq', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nuq', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nrx1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nrz1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nrq1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nuq1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::np', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nrp', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::np1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nrp1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nu', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nu1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::ne', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::ntmp', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::nom_x', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'Integrator::nom_z', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'Integrator::augmented_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'Integrator::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'Integrator::print_stats', 'bool', lambda: r.boolean())
    r.field(record, 'Integrator::transition', 'Function', lambda: read_Function(r))
    r.field(record, 'Integrator::max_event_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::max_events', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Integrator::event_tol', 'double', lambda: r.number('double'))
    r.field(record, 'Integrator::event_acceptable_tol', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_Integrator_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('OracleFunction::serialize_type')
    layout_OracleFunction_serialize_type(r, record, scope)
    record["layouts"].append('PluginInterface<Integrator>::serialize_type')
    layout_PluginInterface_Integrator_serialize_type(r, record, scope)
    r.depth -= 1

def layout_Interpolant_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'Interpolant', 2)
    r.field(record, 'Interpolant::ndim', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Interpolant::m', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Interpolant::grid', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'Interpolant::offset', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Interpolant::values', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'Interpolant::lookup_modes', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'Interpolant::batch_x', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Interpolant_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_type')
    layout_FunctionInternal_serialize_type(r, record, scope)
    record["layouts"].append('PluginInterface<Interpolant>::serialize_type')
    layout_PluginInterface_Interpolant_serialize_type_2(r, record, scope)
    r.depth -= 1

def layout_Inverse_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_IpoptInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'IpoptInterface', 3)
    r.field(record, 'IpoptInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'IpoptInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'IpoptInterface::exact_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'IpoptInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'IpoptInterface::pass_nonlinear_variables', 'bool', lambda: r.boolean())
    r.field(record, 'IpoptInterface::nl_ex', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'IpoptInterface::var_string_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'IpoptInterface::var_integer_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'IpoptInterface::var_numeric_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'IpoptInterface::con_string_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'IpoptInterface::con_integer_md', 'Dict', lambda: read_Dict(r))
    r.field(record, 'IpoptInterface::con_numeric_md', 'Dict', lambda: read_Dict(r))
    scope['IpoptInterface::convexify'] = r.field(record, 'IpoptInterface::convexify', 'bool', lambda: r.boolean())
    if scope['IpoptInterface::convexify']:
        record["layouts"].append('Convexify::serialize')
        scope['prefix'] = 'IpoptInterface::'
        layout_Convexify_serialize(r, record, scope)
    r.field(record, 'IpoptInterface::clip_inactive_lam', 'bool', lambda: r.boolean())
    r.field(record, 'IpoptInterface::inactive_lam_strategy', 'std::string', lambda: r.string())
    r.field(record, 'IpoptInterface::inactive_lam_value', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_Ipqp_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'Ipqp', 1)
    r.field(record, 'Ipqp::kkt', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Ipqp::print_iter', 'bool', lambda: r.boolean())
    r.field(record, 'Ipqp::print_header', 'bool', lambda: r.boolean())
    r.field(record, 'Ipqp::print_info', 'bool', lambda: r.boolean())
    r.field(record, 'Ipqp::linear_solver', 'std::string', lambda: r.string())
    r.field(record, 'Ipqp::linear_solver_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'Ipqp::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Ipqp::pr_tol', 'double', lambda: r.number('double'))
    r.field(record, 'Ipqp::du_tol', 'double', lambda: r.number('double'))
    r.field(record, 'Ipqp::co_tol', 'double', lambda: r.number('double'))
    r.field(record, 'Ipqp::mu_tol', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_KinsolInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Rootfinder::serialize_body')
    layout_Rootfinder_serialize_body(r, record, scope)
    r.depth -= 1

def layout_KnitroInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'KnitroInterface', 2)
    r.field(record, 'KnitroInterface::contype', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'KnitroInterface::comp_type', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'KnitroInterface::comp_i1', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'KnitroInterface::comp_i2', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'KnitroInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'KnitroInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'KnitroInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'KnitroInterface::options_file', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_Kron_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Kron_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Kron::kind'] = r.field(record, 'Kron::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_KronContract_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'KronContract::inner', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_KronContract_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['KronContract::kind'] = r.field(record, 'KronContract::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_LapackLu_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.version(record, 'LapackLu', 1)
    r.field(record, 'LapackLu::equilibriate', 'bool', lambda: r.boolean())
    r.field(record, 'LapackLu::allow_equilibration_failure', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_LapackQr_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.field(record, 'LapackQr::max_nrhs', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_LinearInterpolant_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Interpolant::serialize_body')
    layout_Interpolant_serialize_body(r, record, scope)
    r.field(record, 'LinearInterpolant::lookup_mode', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_LinearInterpolant_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Interpolant::serialize_type')
    layout_Interpolant_serialize_type(r, record, scope)
    r.version(record, 'LinearInterpolant', 1)
    scope['LinearInterpolant::type'] = r.field(record, 'LinearInterpolant::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_LinearInterpolantJac_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.depth -= 1

def layout_LinearInterpolantJac_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_type')
    layout_FunctionInternal_serialize_type(r, record, scope)
    record["layouts"].append('>PluginInterface<Interpolant>::serialize_type')
    layout_PluginInterface_Interpolant_serialize_type(r, record, scope)
    r.version(record, 'LinearInterpolant', 1)
    scope['LinearInterpolant::type'] = r.field(record, 'LinearInterpolant::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_Linsol_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_LinsolCall_Tr_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Solve<Tr>::serialize_body')
    layout_Solve_Tr_serialize_body(r, record, scope)
    r.field(record, 'Solve::Linsol', 'Linsol', lambda: read_Linsol(r))
    r.depth -= 1

def layout_LinsolCall_Tr_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Solve<Tr>::serialize_type')
    layout_Solve_Tr_serialize_type(r, record, scope)
    r.depth -= 1

def layout_LinsolInternal_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('ProtoFunction::serialize_body')
    layout_ProtoFunction_serialize_body(r, record, scope)
    r.field(record, 'LinsolInternal::sp', 'Sparsity', lambda: read_Sparsity(r))
    r.depth -= 1

def layout_LinsolInternal_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('ProtoFunction::serialize_type')
    layout_ProtoFunction_serialize_type(r, record, scope)
    record["layouts"].append('PluginInterface<LinsolInternal>::serialize_type')
    layout_PluginInterface_LinsolInternal_serialize_type(r, record, scope)
    r.depth -= 1

def layout_LinsolLdl_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.version(record, 'LinsolLdl', 1)
    r.field(record, 'LinsolLdl::p', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'LinsolLdl::sp_Lt', 'Sparsity', lambda: read_Sparsity(r))
    r.depth -= 1

def layout_LinsolQr_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.version(record, 'LinsolQr', 2)
    r.field(record, 'LinsolQr::prinv', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'LinsolQr::pc', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'LinsolQr::sp_v', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'LinsolQr::sp_r', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'LinsolQr::eps', 'double', lambda: r.number('double'))
    r.field(record, 'LinsolQr::n_cache', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_LinsolTridiag_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1

def layout_LogSumExp_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Low_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'Low::lookup_mode', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Lsqr_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1

def layout_MMax_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_MMin_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_MX_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_MXFunction_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('XFunction<MXFunction,MX,MXNode>::serialize_body')
    layout_XFunction_MXFunction_MX_MXNode_serialize_body(r, record, scope)
    r.version(record, 'MXFunction', 3)
    scope['MXFunction::n_instr'] = r.field(record, 'MXFunction::n_instr', 'size_t', lambda: r.number('size_t'))
    for _ in range(r.count(scope['MXFunction::n_instr'])):
        r.field(record, 'MXFunction::alg::data', 'MX', lambda: read_MX(r))
        r.field(record, 'MXFunction::alg::arg', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
        r.field(record, 'MXFunction::alg::res', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'MXFunction::workloc', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'MXFunction::free_vars', 'std::vector<MX>', lambda: read_std_vector_MX(r))
    r.field(record, 'MXFunction::default_in', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'MXFunction::live_variables', 'bool', lambda: r.boolean())
    r.field(record, 'MXFunction::print_instructions', 'bool', lambda: r.boolean())
    r.field(record, 'MXFunction::dump_trace', 'bool', lambda: r.boolean())
    record["layouts"].append('XFunction<MXFunction,MX,MXNode>::delayed_serialize_members')
    layout_XFunction_MXFunction_MX_MXNode_delayed_serialize_members(r, record, scope)
    r.depth -= 1

def layout_MXNode_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_MXNode_serialize_body(r, record, scope):
    r.enter_layout()
    r.field(record, 'MXNode::deps', 'std::vector<MX>', lambda: read_std_vector_MX(r))
    r.field(record, 'MXNode::sp', 'Sparsity', lambda: read_Sparsity(r))
    r.depth -= 1

def layout_MXNode_serialize_type(r, record, scope):
    r.enter_layout()
    scope['MXNode::op'] = r.field(record, 'MXNode::op', 'int', lambda: r.number('int'))
    r.depth -= 1

def layout_Ma27Interface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1

def layout_MadmpecInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'MadmpecInterface', 1)
    r.field(record, 'MadmpecInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'MadmpecInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'MadmpecInterface::exact_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'MadmpecInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'MadmpecInterface::convexify', 'bool', lambda: r.boolean())
    r.field(record, 'MadmpecInterface::ind_cc1', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'MadmpecInterface::ind_cc2', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'MadmpecInterface::cctypes', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_MadnlpInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'MadnlpInterface', 2)
    r.field(record, 'MadnlpInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'MadnlpInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'MadnlpInterface::exact_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'MadnlpInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'MadnlpInterface::convexify', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_Map_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.field(record, 'Map::f', 'Function', lambda: read_Function(r))
    r.field(record, 'Map::n', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Map_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_type')
    layout_FunctionInternal_serialize_type(r, record, scope)
    scope['Map::class_name'] = r.field(record, 'Map::class_name', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_MapSum_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.field(record, 'MapSum::f', 'Function', lambda: read_Function(r))
    r.field(record, 'MapSum::n', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'MapSum::reduce_in', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'MapSum::reduce_out', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.depth -= 1

def layout_MapSum_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_type')
    layout_FunctionInternal_serialize_type(r, record, scope)
    scope['MapSum::class_name'] = r.field(record, 'MapSum::class_name', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_Matrix_SXElem_serialize(r, record, scope):
    r.enter_layout()
    r.field(record, 'Matrix::sparsity', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Matrix::nonzeros', 'std::vector<SXElem>', lambda: read_std_vector_SXElem(r))
    r.depth -= 1

def layout_Matrix_casadi_int_serialize(r, record, scope):
    r.enter_layout()
    r.field(record, 'Matrix::sparsity', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Matrix::nonzeros', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_Matrix_double_serialize(r, record, scope):
    r.enter_layout()
    r.field(record, 'Matrix::sparsity', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Matrix::nonzeros', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.depth -= 1

def layout_MinusInfSX_serialize_node(r, record, scope):
    r.enter_layout()
    scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_MinusOneSX_serialize_node(r, record, scope):
    r.enter_layout()
    scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_Monitor_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'Monitor::comment', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_MosekInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'MosekInterface', 1)
    r.field(record, 'MosekInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_MultipleOutput_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Multiplication_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'Multiplication::blas', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_Multiplication_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Multiplication::kind'] = r.field(record, 'Multiplication::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_MumpsInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.version(record, 'Mumps', 1)
    r.field(record, 'MumpsInterface::symmetric', 'bool', lambda: r.boolean())
    r.field(record, 'MumpsInterface::posdef', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_NanSX_serialize_node(r, record, scope):
    r.enter_layout()
    scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_Newton_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Rootfinder::serialize_body')
    layout_Rootfinder_serialize_body(r, record, scope)
    r.version(record, 'Newton', 1)
    r.field(record, 'Newton::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Newton::abstol', 'double', lambda: r.number('double'))
    r.field(record, 'Newton::abstolStep', 'double', lambda: r.number('double'))
    r.field(record, 'Newton::print_iteration', 'bool', lambda: r.boolean())
    r.field(record, 'Newton::line_search', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_Nlpsol_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('OracleFunction::serialize_body')
    layout_OracleFunction_serialize_body(r, record, scope)
    r.version(record, 'Nlpsol', 5)
    r.field(record, 'Nlpsol::nx', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Nlpsol::ng', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Nlpsol::np', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Nlpsol::fcallback', 'Function', lambda: read_Function(r))
    r.field(record, 'Nlpsol::callback_step', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Nlpsol::eval_errors_fatal', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::warn_initial_bounds', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::iteration_callback_ignore_errors', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::calc_multipliers', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::calc_lam_x', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::calc_lam_p', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::calc_f', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::calc_g', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::min_lam', 'double', lambda: r.number('double'))
    r.field(record, 'Nlpsol::bound_consistency', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::no_nlp_grad', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::discrete', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'Nlpsol::equality', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    r.field(record, 'Nlpsol::mi', 'bool', lambda: r.boolean())
    r.field(record, 'Nlpsol::sens_linsol', 'std::string', lambda: r.string())
    r.field(record, 'Nlpsol::sens_linsol_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'Nlpsol::detect_simple_bounds_is_simple', 'std::vector<char>', lambda: read_std_vector_char(r))
    r.field(record, 'Nlpsol::detect_simple_bounds_parts', 'Function', lambda: read_Function(r))
    r.field(record, 'Nlpsol::detect_simple_bounds_target_x', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_Nlpsol_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('OracleFunction::serialize_type')
    layout_OracleFunction_serialize_type(r, record, scope)
    record["layouts"].append('PluginInterface<Nlpsol>::serialize_type')
    layout_PluginInterface_Nlpsol_serialize_type(r, record, scope)
    r.depth -= 1

def layout_Norm1_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Norm::serialize_body')
    layout_Norm_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Norm2_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Norm::serialize_body')
    layout_Norm_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Norm_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_NormF_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Norm::serialize_body')
    layout_Norm_serialize_body(r, record, scope)
    r.depth -= 1

def layout_NormInf_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Norm::serialize_body')
    layout_Norm_serialize_body(r, record, scope)
    r.depth -= 1

def layout_OmpMap_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Map::serialize_body')
    layout_Map_serialize_body(r, record, scope)
    r.depth -= 1

def layout_OneSX_serialize_node(r, record, scope):
    r.enter_layout()
    scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_OnnxFunction_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'OnnxFunction', 2)
    r.field(record, 'OnnxFunction::model_data', 'std::string', lambda: r.string())
    record["layouts"].append('pack_tensors')
    scope['d'] = 'OnnxFunction::in'
    layout_pack_tensors(r, record, scope)
    record["layouts"].append('pack_tensors')
    scope['d'] = 'OnnxFunction::out'
    layout_pack_tensors(r, record, scope)
    record["layouts"].append('pack_tensors')
    scope['d'] = 'OnnxFunction::all_in'
    layout_pack_tensors(r, record, scope)
    r.field(record, 'OnnxFunction::in_src', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'OnnxFunction::in_val', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'OnnxFunction::model_inputs', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'OnnxFunction::model_outputs', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'OnnxFunction::fwd_dim', 'std::string', lambda: r.string())
    r.field(record, 'OnnxFunction::adj_dim', 'std::string', lambda: r.string())
    r.field(record, 'OnnxFunction::input_values', 'std::map<std::string,std::vector<double>>', lambda: read_std_map_std_string_std_vector_double(r))
    r.field(record, 'OnnxFunction::model_path', 'std::string', lambda: r.string())
    r.field(record, 'OnnxFunction::dim_bindings', 'std::map<std::string,casadi_int>', lambda: read_std_map_std_string_casadi_int(r))
    r.field(record, 'OnnxFunction::input_shapes', 'std::map<std::string,std::vector<casadi_int>>', lambda: read_std_map_std_string_std_vector_casadi_int(r))
    r.field(record, 'OnnxFunction::derivative_opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'OnnxFunction::builder_opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_OnnxFunction_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_type')
    layout_FunctionInternal_serialize_type(r, record, scope)
    record["layouts"].append('PluginInterface<OnnxFunction>::serialize_type')
    layout_PluginInterface_OnnxFunction_serialize_type(r, record, scope)
    r.depth -= 1

def layout_OnnxRuntimeInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('OnnxFunction::serialize_body')
    layout_OnnxFunction_serialize_body(r, record, scope)
    r.version(record, 'OnnxRuntimeInterface', 1)
    r.field(record, 'OnnxRuntimeInterface::provider', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_OoqpInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'OoqpInterface', 1)
    r.field(record, 'OoqpInterface::spAT', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'OoqpInterface::nQ', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OoqpInterface::nH', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OoqpInterface::nA', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OoqpInterface::print_level', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OoqpInterface::mutol', 'double', lambda: r.number('double'))
    r.field(record, 'OoqpInterface::artol', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_OracleFunction_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'OracleFunction', 3)
    r.field(record, 'OracleFunction::oracle', 'Function', lambda: read_Function(r))
    r.field(record, 'OracleFunction::common_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'OracleFunction::specific_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'OracleFunction::show_eval_warnings', 'bool', lambda: r.boolean())
    r.field(record, 'OracleFunction::max_num_threads', 'int', lambda: r.number('int'))
    scope['OracleFunction::all_functions::size'] = r.field(record, 'OracleFunction::all_functions::size', 'size_t', lambda: r.number('size_t'))
    for _ in range(r.count(scope['OracleFunction::all_functions::size'])):
        r.field(record, 'OracleFunction::all_functions::key', 'std::string', lambda: r.string())
        scope['OracleFunction::all_functions::value::jit'] = r.field(record, 'OracleFunction::all_functions::value::jit', 'bool', lambda: r.boolean())
        if (scope['FunctionInternal::jit'] and scope['OracleFunction::all_functions::value::jit']):
            if (scope['FunctionInternal::jit_serialize'] == 'source'):
                r.field(record, 'OracleFunction::all_functions::value::f', 'Function', lambda: read_Function(r))
            else:
                r.field(record, 'OracleFunction::all_functions::value::f_name', 'std::string', lambda: r.string())
        else:
            r.field(record, 'OracleFunction::all_functions::value::f', 'Function', lambda: read_Function(r))
        r.field(record, 'OracleFunction::all_functions::value::monitored', 'bool', lambda: r.boolean())
    r.field(record, 'OracleFunction::monitor', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, 'OracleFunction::stride_arg', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'OracleFunction::stride_res', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'OracleFunction::stride_iw', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'OracleFunction::stride_w', 'size_t', lambda: r.number('size_t'))
    r.depth -= 1

def layout_OracleFunction_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_type')
    layout_FunctionInternal_serialize_type(r, record, scope)
    r.depth -= 1

def layout_OsqpInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'OsqpInterface', 2)
    r.field(record, 'OsqpInterface::nnzHupp', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::nnzA', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::warm_start_primal', 'bool', lambda: r.boolean())
    r.field(record, 'OsqpInterface::warm_start_dual', 'bool', lambda: r.boolean())
    r.field(record, 'OsqpInterface::settings::rho', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::sigma', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::scaling', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::adaptive_rho', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::adaptive_rho_interval', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::adaptive_rho_tolerance', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::eps_abs', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::eps_rel', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::eps_prim_inf', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::eps_dual_inf', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::alpha', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::delta', 'double', lambda: r.number('double'))
    r.field(record, 'OsqpInterface::settings::polish', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::polish_refine_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::verbose', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::scaled_termination', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::check_termination', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::settings::warm_start', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'OsqpInterface::rho_initial', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_Output_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('IOInstruction::serialize_body')
    layout_IOInstruction_serialize_body(r, record, scope)
    r.depth -= 1

def layout_OutputNode_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'OutputNode::oind', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_OutputSX_serialize_node(r, record, scope):
    r.enter_layout()
    r.field(record, 'OutputSX::dep', 'SXElem', lambda: read_SXElem(r))
    r.field(record, 'OutputSX::oind', 'int', lambda: r.number('int'))
    r.depth -= 1

def layout_PiqpInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'PiqpInterface', 1)
    r.field(record, 'PiqpInterface::nnzH', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'PiqpInterface::nnzA', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'PiqpInterface::settings::rho_init', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::delta_init', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::eps_abs', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::eps_rel', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::check_duality_gap', 'bool', lambda: r.boolean())
    r.field(record, 'PiqpInterface::settings::eps_duality_gap_abs', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::eps_duality_gap_rel', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::reg_lower_limit', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::reg_finetune_lower_limit', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::reg_finetune_primal_update_threshold', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'PiqpInterface::settings::reg_finetune_dual_update_threshold', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'PiqpInterface::settings::max_iter', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'PiqpInterface::settings::max_factor_retires', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'PiqpInterface::settings::preconditioner_scale_cost', 'bool', lambda: r.boolean())
    r.field(record, 'PiqpInterface::settings::preconditioner_iter', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'PiqpInterface::settings::tau', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::iterative_refinement_always_enabled', 'bool', lambda: r.boolean())
    r.field(record, 'PiqpInterface::settings::iterative_refinement_eps_abs', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::iterative_refinement_eps_rel', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::iterative_refinement_max_iter', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'PiqpInterface::settings::iterative_refinement_min_improvement_rate', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::iterative_refinement_static_regularization_eps', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::iterative_refinement_static_regularization_rel', 'double', lambda: r.number('double'))
    r.field(record, 'PiqpInterface::settings::verbose', 'bool', lambda: r.boolean())
    r.field(record, 'PiqpInterface::settings::compute_timings', 'bool', lambda: r.boolean())
    r.field(record, 'PiqpInterface::settings::kkt_solver', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_PluginInterface_serialize_type(r, record, scope):
    r.enter_layout()
    scope['PluginInterface::plugin_name'] = r.field(record, 'PluginInterface::plugin_name', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_Project_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Project_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Project::type'] = r.field(record, 'Project::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_ProtoFunction_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_ProtoFunction_serialize_body(r, record, scope):
    r.enter_layout()
    r.version(record, 'ProtoFunction', 2)
    r.field(record, 'ProtoFunction::name', 'std::string', lambda: r.string())
    r.field(record, 'ProtoFunction::verbose', 'bool', lambda: r.boolean())
    r.field(record, 'ProtoFunction::print_time', 'bool', lambda: r.boolean())
    r.field(record, 'ProtoFunction::record_time', 'bool', lambda: r.boolean())
    r.field(record, 'ProtoFunction::regularity_check', 'bool', lambda: r.boolean())
    r.field(record, 'ProtoFunction::error_on_fail', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_ProtoFunction_serialize_type(r, record, scope):
    r.enter_layout()
    r.depth -= 1

def layout_ProxqpInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'ProxqpInterface', 1)
    r.field(record, 'ProxqpInterface::warm_start_primal', 'bool', lambda: r.boolean())
    r.field(record, 'ProxqpInterface::warm_start_dual', 'bool', lambda: r.boolean())
    r.field(record, 'ProxqpInterface::settings::default_rho', 'double', lambda: r.number('double'))
    r.field(record, 'ProxqpInterface::settings::default_mu_eq', 'double', lambda: r.number('double'))
    r.field(record, 'ProxqpInterface::settings::default_mu_in', 'double', lambda: r.number('double'))
    r.field(record, 'ProxqpInterface::settings::eps_abs', 'double', lambda: r.number('double'))
    r.field(record, 'ProxqpInterface::settings::eps_rel', 'double', lambda: r.number('double'))
    r.field(record, 'ProxqpInterface::settings::max_iter', 'double', lambda: r.number('double'))
    r.field(record, 'ProxqpInterface::settings::verbose', 'bool', lambda: r.boolean())
    r.field(record, 'ProxqpInterface::settings::sparse_backend', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_PseudoDenseMultiplication_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Multiplication::serialize_body')
    layout_Multiplication_serialize_body(r, record, scope)
    r.field(record, 'PseudoDenseMultiplication::a', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'PseudoDenseMultiplication::b', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'PseudoDenseMultiplication::c', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_PseudoDenseMultiplication_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Multiplication::kind'] = r.field(record, 'Multiplication::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_QpToNlp_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'QpToNlp', 1)
    r.field(record, 'QpToNlp::solver', 'Function', lambda: read_Function(r))
    r.depth -= 1

def layout_QpoasesInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'QpoasesInterface', 1)
    r.field(record, 'QpoasesInterface::max_nWSR', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'QpoasesInterface::max_cputime', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::hess', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'QpoasesInterface::sparse', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::schur', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::max_schur', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'QpoasesInterface::linsol_plugin', 'std::string', lambda: r.string())
    r.field(record, 'QpoasesInterface::ops::printLevel', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'QpoasesInterface::ops::enableRamping', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::ops::enableFarBounds', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::ops::enableFlippingBounds', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::ops::enableRegularisation', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::ops::enableFullLITests', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::ops::enableNZCTests', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::ops::enableDriftCorrection', 'int', lambda: r.number('int'))
    r.field(record, 'QpoasesInterface::ops::enableCholeskyRefactorisation', 'int', lambda: r.number('int'))
    r.field(record, 'QpoasesInterface::ops::enableEqualities', 'bool', lambda: r.boolean())
    r.field(record, 'QpoasesInterface::ops::terminationTolerance', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::boundTolerance', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::boundRelaxation', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::epsNum', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::epsDen', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::maxPrimalJump', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::maxDualJump', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::initialRamping', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::finalRamping', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::initialFarBounds', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::growFarBounds', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::initialStatusBounds', 'std::string', lambda: r.string())
    r.field(record, 'QpoasesInterface::ops::epsFlipping', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::numRegularisationSteps', 'int', lambda: r.number('int'))
    r.field(record, 'QpoasesInterface::ops::epsRegularisation', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::numRefinementSteps', 'int', lambda: r.number('int'))
    r.field(record, 'QpoasesInterface::ops::epsIterRef', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::epsLITests', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::epsNZCTests', 'double', lambda: r.number('double'))
    r.field(record, 'QpoasesInterface::ops::enableInertiaCorrection', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_Qrqp_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'Qrqp', 1)
    r.field(record, 'Qrqp::AT', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Qrqp::kkt', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Qrqp::sp_v', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Qrqp::sp_r', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Qrqp::prinv', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Qrqp::pc', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Qrqp::print_iter', 'bool', lambda: r.boolean())
    r.field(record, 'Qrqp::print_header', 'bool', lambda: r.boolean())
    r.field(record, 'Qrqp::print_info', 'bool', lambda: r.boolean())
    r.field(record, 'Qrqp::print_lincomb_', 'bool', lambda: r.boolean())
    r.field(record, 'Qrqp::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Qrqp::min_lam', 'double', lambda: r.number('double'))
    r.field(record, 'Qrqp::constr_viol_tol', 'double', lambda: r.number('double'))
    r.field(record, 'Qrqp::dual_inf_tol', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_Qrsqp_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Rank1_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_RealtypeSX_serialize_node(r, record, scope):
    r.enter_layout()
    scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
    r.field(record, 'ConstantSX::value', 'double', lambda: r.number('double'))
    r.depth -= 1

def layout_Reshape_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Resource_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_ResourceInternal_serialize(r, record, scope):
    r.enter_layout()
    r.version(record, 'ResourceInternal', 1)
    r.fail('unlowered serialization call')
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_ResourceInternal_serialize_body(r, record, scope):
    r.enter_layout()
    scope['ResourceInternal::serialize_mode'] = r.field(record, 'ResourceInternal::serialize_mode', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_ResourceInternal_serialize_type(r, record, scope):
    r.enter_layout()
    scope['ResourceInternal::type'] = r.field(record, 'ResourceInternal::type', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_Rootfinder_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('OracleFunction::serialize_body')
    layout_OracleFunction_serialize_body(r, record, scope)
    r.version(record, 'Rootfinder', 3)
    r.field(record, 'Rootfinder::n', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Rootfinder::linsol', 'Linsol', lambda: read_Linsol(r))
    r.field(record, 'Rootfinder::sp_jac', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Rootfinder::u_c', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Rootfinder::iin', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Rootfinder::iout', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Rootfinder_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('OracleFunction::serialize_type')
    layout_OracleFunction_serialize_type(r, record, scope)
    record["layouts"].append('PluginInterface<Rootfinder>::serialize_type')
    layout_PluginInterface_Rootfinder_serialize_type(r, record, scope)
    r.depth -= 1

def layout_RungeKutta_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FixedStepIntegrator::serialize_body')
    layout_FixedStepIntegrator_serialize_body(r, record, scope)
    r.version(record, 'RungeKutta', 2)
    r.depth -= 1

def layout_SLEQPInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'SLEQPInterface', 1)
    r.field(record, 'SLEQPInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'SLEQPInterface::max_iter', 'int', lambda: r.number('int'))
    r.field(record, 'SLEQPInterface::max_wall_time', 'double', lambda: r.number('double'))
    r.field(record, 'SLEQPInterface::print_level', 'int', lambda: r.number('int'))
    r.field(record, 'SLEQPInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_SXElem_serialize(r, record, scope):
    r.enter_layout()
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_SXFunction_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('XFunction<SXFunction,SX,SXNode>::serialize_body')
    layout_XFunction_SXFunction_SX_SXNode_serialize_body(r, record, scope)
    r.version(record, 'SXFunction', 4)
    scope['SXFunction::n_instr'] = r.field(record, 'SXFunction::n_instr', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'SXFunction::worksize', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'SXFunction::free_vars', 'std::vector<SXElem>', lambda: read_std_vector_SXElem(r))
    r.field(record, 'SXFunction::operations', 'std::vector<SXElem>', lambda: read_std_vector_SXElem(r))
    r.field(record, 'SXFunction::constants', 'std::vector<SXElem>', lambda: read_std_vector_SXElem(r))
    r.field(record, 'SXFunction::default_in', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.field(record, 'SXFunction::call_sz_arg', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'SXFunction::call_sz_res', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'SXFunction::call_sz_iw', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'SXFunction::call_sz_w', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'SXFunction::call_sz_arg', 'size_t', lambda: r.number('size_t'))
    r.field(record, 'SXFunction::call_sz_res', 'size_t', lambda: r.number('size_t'))
    scope['SXFunction::call_el_size'] = r.field(record, 'SXFunction::call_el_size', 'size_t', lambda: r.number('size_t'))
    for _ in range(r.count(scope['SXFunction::call_el_size'])):
        r.field(record, 'SXFunction::call_el_f', 'Function', lambda: read_Function(r))
        r.field(record, 'SXFunction::call_el_dep', 'std::vector<int>', lambda: read_std_vector_int(r))
        r.field(record, 'SXFunction::call_el_res', 'std::vector<int>', lambda: read_std_vector_int(r))
        r.field(record, 'SXFunction::call_el_copy_elision_arg', 'std::vector<int>', lambda: read_std_vector_int(r))
        r.field(record, 'SXFunction::call_el_copy_elision_offset', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'SXFunction::copy_elision', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    for _ in range(r.count(scope['SXFunction::n_instr'])):
        r.field(record, 'SXFunction::ScalarAtomic::op', 'int', lambda: r.number('int'))
        r.field(record, 'SXFunction::ScalarAtomic::i0', 'int', lambda: r.number('int'))
        r.field(record, 'SXFunction::ScalarAtomic::i1', 'int', lambda: r.number('int'))
        r.field(record, 'SXFunction::ScalarAtomic::i2', 'int', lambda: r.number('int'))
    r.field(record, 'SXFunction::live_variables', 'bool', lambda: r.boolean())
    r.field(record, 'SXFunction::print_instructions', 'bool', lambda: r.boolean())
    r.field(record, 'SXFunction::dump_trace', 'bool', lambda: r.boolean())
    record["layouts"].append('XFunction<SXFunction,SX,SXNode>::delayed_serialize_members')
    layout_XFunction_SXFunction_SX_SXNode_delayed_serialize_members(r, record, scope)
    r.depth -= 1

def layout_SXNode_serialize(r, record, scope):
    r.enter_layout()
    scope['SXNode::op'] = r.field(record, 'SXNode::op', 'casadi_int', lambda: r.number('casadi_int'))
    r.fail('unlowered serialization call')
    r.depth -= 1

def layout_Scpgen_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.depth -= 1

def layout_SetNonzerosParam_Add_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('SetNonzerosParam<Add>::serialize_body')
    layout_SetNonzerosParam_Add_serialize_body(r, record, scope)
    r.depth -= 1

def layout_SetNonzerosParamParam_Add_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['SetNonzerosParam::type'] = r.field(record, 'SetNonzerosParam::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'SetNonzerosParamSlice::outer', 'Slice', lambda: read_Slice(r))
    r.depth -= 1

def layout_SetNonzerosParamSlice_Add_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['SetNonzerosParam::type'] = r.field(record, 'SetNonzerosParam::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_SetNonzerosParamVector_Add_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['SetNonzerosParam::type'] = r.field(record, 'SetNonzerosParam::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'SetNonzerosSlice2::inner', 'Slice', lambda: read_Slice(r))
    r.field(record, 'SetNonzerosSlice2::outer', 'Slice', lambda: read_Slice(r))
    r.depth -= 1

def layout_SetNonzerosSlice2_Add_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['SetNonzeros::type'] = r.field(record, 'SetNonzeros::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_SetNonzerosSlice_Add_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'SetNonzerosSlice::slice', 'Slice', lambda: read_Slice(r))
    r.depth -= 1

def layout_SetNonzerosSlice_Add_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['SetNonzeros::type'] = r.field(record, 'SetNonzeros::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'SetNonzerosSliceParam::inner', 'Slice', lambda: read_Slice(r))
    r.depth -= 1

def layout_SetNonzerosSliceParam_Add_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['SetNonzerosParam::type'] = r.field(record, 'SetNonzerosParam::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_SetNonzerosVector_Add_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'SetNonzerosVector::nonzeros', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_SetNonzerosVector_Add_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['SetNonzeros::type'] = r.field(record, 'SetNonzeros::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_Slice_serialize(r, record, scope):
    r.enter_layout()
    r.field(record, 'Slice::start', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Slice::stop', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Slice::step', 'casadi_int', lambda: r.number('casadi_int'))
    r.depth -= 1

def layout_Smoothing_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FiniteDiff::serialize_body')
    layout_FiniteDiff_serialize_body(r, record, scope)
    r.depth -= 1

def layout_SnoptInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'SnoptInterface', 1)
    r.field(record, 'SnoptInterface::jacf_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'SnoptInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'SnoptInterface::nnJac', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SnoptInterface::nnObj', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SnoptInterface::nnCon', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SnoptInterface::A_structure', 'IM', lambda: read_IM(r))
    r.field(record, 'SnoptInterface::m', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SnoptInterface::iObj', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SnoptInterface::jacF_row', 'bool', lambda: r.boolean())
    r.field(record, 'SnoptInterface::dummyrow', 'bool', lambda: r.boolean())
    r.field(record, 'SnoptInterface::Cold_', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SnoptInterface::inf', 'double', lambda: r.number('double'))
    r.field(record, 'SnoptInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_Solve_Tr_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Solve_Tr_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    r.field(record, 'Solve::Tr', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_SparseDenseKron_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Kron::serialize_body')
    layout_Kron_serialize_body(r, record, scope)
    r.depth -= 1

def layout_SparseDenseKron_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Kron::kind'] = r.field(record, 'Kron::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_SparseDenseKronContract_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('KronContract::serialize_body')
    layout_KronContract_serialize_body(r, record, scope)
    r.depth -= 1

def layout_SparseDenseKronContract_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['KronContract::kind'] = r.field(record, 'KronContract::kind', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_Sparsify_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Project::serialize_body')
    layout_Project_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Sparsify_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Project::type'] = r.field(record, 'Project::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_Sparsity_serialize(r, record, scope):
    r.enter_layout()
    r.fail('Predicate has no serialized field')
    r.depth -= 1

def layout_SparsityCast_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Split_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MultipleOutput::serialize_body')
    layout_MultipleOutput_serialize_body(r, record, scope)
    r.field(record, 'Split::offset', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'Split::output_sparsity', 'std::vector<Sparsity>', lambda: read_std_vector_Sparsity(r))
    r.depth -= 1

def layout_SqicInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Sqpmethod_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'Sqpmethod', 3)
    r.field(record, 'Sqpmethod::qpsol', 'Function', lambda: read_Function(r))
    r.field(record, 'Sqpmethod::qpsol_ela', 'Function', lambda: read_Function(r))
    r.field(record, 'Sqpmethod::exact_hessian', 'bool', lambda: r.boolean())
    r.field(record, 'Sqpmethod::max_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Sqpmethod::min_iter', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Sqpmethod::lbfgs_memory', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Sqpmethod::tol_pr_', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::tol_du_', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::min_step_size_', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::c1', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::beta', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::max_iter_ls_', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Sqpmethod::merit_memsize_', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'Sqpmethod::beta', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::print_header', 'bool', lambda: r.boolean())
    r.field(record, 'Sqpmethod::print_iteration', 'bool', lambda: r.boolean())
    r.field(record, 'Sqpmethod::print_status', 'bool', lambda: r.boolean())
    r.field(record, 'Sqpmethod::elastic_mode', 'bool', lambda: r.boolean())
    r.field(record, 'Sqpmethod::gamma_0', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::gamma_max', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::gamma_1_min', 'double', lambda: r.number('double'))
    r.field(record, 'Sqpmethod::init_feasible', 'bool', lambda: r.boolean())
    r.field(record, 'Sqpmethod::so_corr', 'bool', lambda: r.boolean())
    r.field(record, 'Sqpmethod::Hsp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Sqpmethod::Asp', 'Sparsity', lambda: read_Sparsity(r))
    scope['Sqpmethod::convexify'] = r.field(record, 'Sqpmethod::convexify', 'bool', lambda: r.boolean())
    if scope['Sqpmethod::convexify']:
        record["layouts"].append('Convexify::serialize')
        scope['prefix'] = 'Sqpmethod::'
        layout_Convexify_serialize(r, record, scope)
    r.depth -= 1

def layout_SundialsInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Integrator::serialize_body')
    layout_Integrator_serialize_body(r, record, scope)
    r.version(record, 'SundialsInterface', 2)
    r.field(record, 'SundialsInterface::abstol', 'double', lambda: r.number('double'))
    r.field(record, 'SundialsInterface::reltol', 'double', lambda: r.number('double'))
    r.field(record, 'SundialsInterface::max_num_steps', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SundialsInterface::stop_at_end', 'bool', lambda: r.boolean())
    r.field(record, 'SundialsInterface::quad_err_con', 'bool', lambda: r.boolean())
    r.field(record, 'SundialsInterface::steps_per_checkpoint', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SundialsInterface::disable_internal_warnings', 'bool', lambda: r.boolean())
    r.field(record, 'SundialsInterface::max_multistep_order', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SundialsInterface::linear_solver', 'std::string', lambda: r.string())
    r.field(record, 'SundialsInterface::linear_solver_options', 'Dict', lambda: read_Dict(r))
    r.field(record, 'SundialsInterface::max_krylov', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SundialsInterface::use_precon', 'bool', lambda: r.boolean())
    r.field(record, 'SundialsInterface::second_order_correction', 'bool', lambda: r.boolean())
    r.field(record, 'SundialsInterface::step0', 'double', lambda: r.number('double'))
    r.field(record, 'SundialsInterface::max_step_size', 'double', lambda: r.number('double'))
    r.field(record, 'SundialsInterface::nonlin_conv_coeff', 'double', lambda: r.number('double'))
    r.field(record, 'SundialsInterface::max_order', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SundialsInterface::scale_abstol', 'bool', lambda: r.boolean())
    r.field(record, 'SundialsInterface::linsolF', 'Linsol', lambda: read_Linsol(r))
    r.field(record, 'SundialsInterface::newton_scheme', 'int', lambda: r.number('int'))
    r.field(record, 'SundialsInterface::interp', 'int', lambda: r.number('int'))
    r.depth -= 1

def layout_SuperscsInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'SuperscsInterface', 1)
    r.field(record, 'SuperscsInterface::settings::normalize', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::scale', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::rho_x', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::max_time_milliseconds', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::max_iters', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::previous_max_iters', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::eps', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::alpha', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::cg_rate', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::verbose', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::warm_start', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::do_super_scs', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::k0', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::c_bl', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::k1', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::k2', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::c1', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::sse', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::ls', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::beta', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::sigma', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::direction', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::thetabar', 'double', lambda: r.number('double'))
    r.field(record, 'SuperscsInterface::settings::memory', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::tRule', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::broyden_init_scaling', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::do_record_progress', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::settings::do_override_streams', 'casadi_int', lambda: r.number('casadi_int'))
    r.field(record, 'SuperscsInterface::Hp', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'SuperscsInterface::HL_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'SuperscsInterface::f', 'Function', lambda: read_Function(r))
    r.field(record, 'SuperscsInterface::At', 'IM', lambda: read_IM(r))
    r.field(record, 'SuperscsInterface::lookup', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'SuperscsInterface::perturb', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, 'SuperscsInterface::opts', 'Dict', lambda: read_Dict(r))
    record["layouts"].append('Conic::serialize')
    layout_Conic_serialize(r, record, scope)
    r.depth -= 1

def layout_Switch_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'Switch', 1)
    r.field(record, 'Switch::f', 'std::vector<Function>', lambda: read_std_vector_Function(r))
    r.field(record, 'Switch::f_def', 'Function', lambda: read_Function(r))
    r.field(record, 'Switch::project_in', 'bool', lambda: r.boolean())
    r.field(record, 'Switch::project_out', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_SymbolicMX_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'SymbolicMX::name', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_SymbolicQr_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('LinsolInternal::serialize_body')
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.version(record, 'SymbolicQr', 1)
    r.field(record, 'SymbolicQr::factorize', 'Function', lambda: read_Function(r))
    r.field(record, 'SymbolicQr::solve', 'Function', lambda: read_Function(r))
    r.field(record, 'SymbolicQr::solveT', 'Function', lambda: read_Function(r))
    r.field(record, 'SymbolicQr::fopts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_SymbolicSX_serialize_node(r, record, scope):
    r.enter_layout()
    r.field(record, 'SymbolicSX::name', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_ThreadMap_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Map::serialize_body')
    layout_Map_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Transpose_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Transpose_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['Transpose::dense'] = r.field(record, 'Transpose::dense', 'bool', lambda: r.boolean())
    r.depth -= 1

def layout_UnaryMX_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_body')
    layout_MXNode_serialize_body(r, record, scope)
    r.field(record, 'UnaryMX::op', 'int', lambda: r.number('int'))
    r.depth -= 1

def layout_UnarySX_serialize_node(r, record, scope):
    r.enter_layout()
    r.field(record, 'UnarySX::dep', 'SXElem', lambda: read_SXElem(r))
    r.depth -= 1

def layout_UnoInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'UnoInterface', 1)
    r.field(record, 'UnoInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'UnoInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'UnoInterface::opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_Vertcat_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Concat::serialize_body')
    layout_Concat_serialize_body(r, record, scope)
    r.depth -= 1

def layout_Vertsplit_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Split::serialize_body')
    layout_Split_serialize_body(r, record, scope)
    r.depth -= 1

def layout_WorhpInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Nlpsol::serialize_body')
    layout_Nlpsol_serialize_body(r, record, scope)
    r.version(record, 'WorhpInterface', 1)
    r.field(record, 'WorhpInterface::jacg_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'WorhpInterface::hesslag_sp', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'WorhpInterface::bool_opts', 'std::map<std::string,bool>', lambda: read_std_map_std_string_bool(r))
    r.field(record, 'WorhpInterface::int_opts', 'std::map<std::string,casadi_int>', lambda: read_std_map_std_string_casadi_int(r))
    r.field(record, 'WorhpInterface::double_opts', 'std::map<std::string,double>', lambda: read_std_map_std_string_double(r))
    r.field(record, 'WorhpInterface::qp_opts', 'Dict', lambda: read_Dict(r))
    r.depth -= 1

def layout_XFunction_MXFunction_MX_MXNode_delayed_serialize_members(r, record, scope):
    r.enter_layout()
    r.field(record, 'XFunction::out', 'std::vector<MX>', lambda: read_std_vector_MX(r))
    r.depth -= 1

def layout_XFunction_MXFunction_MX_MXNode_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'XFunction', 1)
    r.field(record, 'XFunction::in', 'std::vector<MX>', lambda: read_std_vector_MX(r))
    r.depth -= 1

def layout_XFunction_SXFunction_SX_SXNode_delayed_serialize_members(r, record, scope):
    r.enter_layout()
    r.field(record, 'XFunction::out', 'std::vector<SX>', lambda: read_std_vector_SX(r))
    r.depth -= 1

def layout_XFunction_SXFunction_SX_SXNode_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('FunctionInternal::serialize_body')
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.version(record, 'XFunction', 1)
    r.field(record, 'XFunction::in', 'std::vector<SX>', lambda: read_std_vector_SX(r))
    r.depth -= 1

def layout_XpressInterface_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Conic::serialize_body')
    layout_Conic_serialize_body(r, record, scope)
    r.version(record, 'XpressInterface', 2)
    r.field(record, 'XpressInterface::opts', 'Dict', lambda: read_Dict(r))
    r.field(record, 'XpressInterface::mip_start', 'bool', lambda: r.boolean())
    r.field(record, 'XpressInterface::log_file', 'std::string', lambda: r.string())
    r.field(record, 'XpressInterface::compute_iis', 'bool', lambda: r.boolean())
    r.field(record, 'XpressInterface::sos_settype', 'std::vector<char>', lambda: read_std_vector_char(r))
    r.field(record, 'XpressInterface::sos_setstart', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'XpressInterface::sos_setind', 'std::vector<int>', lambda: read_std_vector_int(r))
    r.field(record, 'XpressInterface::sos_refval', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.depth -= 1

def layout_ZeroByZero_serialize_body(r, record, scope):
    r.enter_layout()
    r.depth -= 1

def layout_ZeroByZero_serialize_type(r, record, scope):
    r.enter_layout()
    record["layouts"].append('MXNode::serialize_type')
    layout_MXNode_serialize_type(r, record, scope)
    scope['ConstantMX::type'] = r.field(record, 'ConstantMX::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_ZeroSX_serialize_node(r, record, scope):
    r.enter_layout()
    scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
    r.depth -= 1

def layout_ZipMemResource_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('ResourceInternal::serialize_body')
    layout_ResourceInternal_serialize_body(r, record, scope)
    r.version(record, 'ZipMemResource', 1)
    r.field(record, 'ZipMemResource::blob', 'std::stringstream', lambda: r.stream())
    r.depth -= 1

def layout_ZipResource_serialize_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('ResourceInternal::serialize_body')
    layout_ResourceInternal_serialize_body(r, record, scope)
    r.version(record, 'ZipResource', 1)
    if (scope['ResourceInternal::serialize_mode'] == 'embed'):
        r.field(record, 'ZipMemResource::blob', 'std::stringstream', lambda: r.stream())
    else:
        r.field(record, 'ZipResource::path', 'std::string', lambda: r.string())
    r.depth -= 1

def layout_ZipResource_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('unlowered else branch')
    r.depth -= 1

def layout_pack_tensors(r, record, scope):
    r.enter_layout()
    r.field(record, (str(scope['d']) + str('::names')), 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    r.field(record, (str(scope['d']) + str('::shapes')), 'std::vector<std::vector<casadi_int>>', lambda: read_std_vector_std_vector_casadi_int(r))
    r.field(record, (str(scope['d']) + str('::elem_types')), 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.field(record, (str(scope['d']) + str('::numels')), 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def layout_PluginInterface_Interpolant_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('Serialization layout absent from scheme: >PluginInterface<Interpolant>::serialize_type')
    r.depth -= 1

def layout_PluginInterface_Conic_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('Serialization layout absent from scheme: PluginInterface<Conic>::serialize_type')
    r.depth -= 1

def layout_PluginInterface_Integrator_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('Serialization layout absent from scheme: PluginInterface<Integrator>::serialize_type')
    r.depth -= 1

def layout_PluginInterface_Interpolant_serialize_type_2(r, record, scope):
    r.enter_layout()
    r.fail('Serialization layout absent from scheme: PluginInterface<Interpolant>::serialize_type')
    r.depth -= 1

def layout_PluginInterface_LinsolInternal_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('Serialization layout absent from scheme: PluginInterface<LinsolInternal>::serialize_type')
    r.depth -= 1

def layout_PluginInterface_Nlpsol_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('Serialization layout absent from scheme: PluginInterface<Nlpsol>::serialize_type')
    r.depth -= 1

def layout_PluginInterface_OnnxFunction_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('Serialization layout absent from scheme: PluginInterface<OnnxFunction>::serialize_type')
    r.depth -= 1

def layout_PluginInterface_Rootfinder_serialize_type(r, record, scope):
    r.enter_layout()
    r.fail('Serialization layout absent from scheme: PluginInterface<Rootfinder>::serialize_type')
    r.depth -= 1

def read_DM_body(r, record, scope):
    r.enter_layout()
    r.field(record, 'Matrix::sparsity', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Matrix::nonzeros', 'std::vector<double>', lambda: read_std_vector_double(r))
    r.depth -= 1

def read_DM(r):
    return r.object('DM', None, False, read_DM_body)

def read_Fmu_body(r, record, scope):
    r.enter_layout()
    scope['FmuInternal::type'] = r.field(record, 'FmuInternal::type', 'std::string', lambda: r.string())
    tag_1 = r.tag(scope['FmuInternal::type'])
    if tag_1 == 'Fmu2':
        record["layouts"].append('Fmu2::serialize_body')
        layout_Fmu2_serialize_body(r, record, scope)
    elif tag_1 == 'Fmu3':
        record["layouts"].append('Fmu3::serialize_body')
        layout_Fmu3_serialize_body(r, record, scope)
    else:
        r.fail('Unknown serialization discriminator')
    r.depth -= 1

def read_Fmu(r):
    return r.object('Fmu', 'F', True, read_Fmu_body)

def read_Function_body(r, record, scope):
    r.enter_layout()
    scope['Function::null'] = r.field(record, 'Function::null', 'bool', lambda: r.boolean())
    if (not scope['Function::null']):
        scope['FunctionInternal::base_function'] = r.field(record, 'FunctionInternal::base_function', 'std::string', lambda: r.string())
        tag_2 = r.tag(scope['FunctionInternal::base_function'])
        if tag_2 == 'BackwardDiff':
            record["layouts"].append('BackwardDiff::serialize_body')
            layout_BackwardDiff_serialize_body(r, record, scope)
        elif tag_2 == 'BlazingSplineFunction':
            record["layouts"].append('BlazingSplineFunction::serialize_body')
            layout_BlazingSplineFunction_serialize_body(r, record, scope)
        elif tag_2 == 'CentralDiff':
            record["layouts"].append('CentralDiff::serialize_body')
            layout_CentralDiff_serialize_body(r, record, scope)
        elif tag_2 == 'Conic':
            scope['PluginInterface::plugin_name'] = r.field(record, 'PluginInterface::plugin_name', 'std::string', lambda: r.string())
            tag_3 = r.tag(scope['PluginInterface::plugin_name'])
            if tag_3 == 'cbc':
                record["layouts"].append('CbcInterface::serialize_body')
                layout_CbcInterface_serialize_body(r, record, scope)
            elif tag_3 == 'clarabel':
                record["layouts"].append('ClarabelInterface::serialize_body')
                layout_ClarabelInterface_serialize_body(r, record, scope)
            elif tag_3 == 'clp':
                record["layouts"].append('ClpInterface::serialize_body')
                layout_ClpInterface_serialize_body(r, record, scope)
            elif tag_3 == 'cplex':
                record["layouts"].append('CplexInterface::serialize_body')
                layout_CplexInterface_serialize_body(r, record, scope)
            elif tag_3 == 'daqp':
                record["layouts"].append('DaqpInterface::serialize_body')
                layout_DaqpInterface_serialize_body(r, record, scope)
            elif tag_3 == 'fatrop':
                record["layouts"].append('FatropConicInterface::serialize_body')
                layout_FatropConicInterface_serialize_body(r, record, scope)
            elif tag_3 == 'gurobi':
                record["layouts"].append('GurobiInterface::serialize_body')
                layout_GurobiInterface_serialize_body(r, record, scope)
            elif tag_3 == 'highs':
                record["layouts"].append('HighsInterface::serialize_body')
                layout_HighsInterface_serialize_body(r, record, scope)
            elif tag_3 == 'hpipm':
                record["layouts"].append('HpipmInterface::serialize_body')
                layout_HpipmInterface_serialize_body(r, record, scope)
            elif tag_3 == 'hpmpc':
                record["layouts"].append('HpmpcInterface::serialize_body')
                layout_HpmpcInterface_serialize_body(r, record, scope)
            elif tag_3 == 'ipqp':
                record["layouts"].append('Ipqp::serialize_body')
                layout_Ipqp_serialize_body(r, record, scope)
            elif tag_3 == 'mosek':
                record["layouts"].append('MosekInterface::serialize_body')
                layout_MosekInterface_serialize_body(r, record, scope)
            elif tag_3 == 'nlpsol':
                record["layouts"].append('QpToNlp::serialize_body')
                layout_QpToNlp_serialize_body(r, record, scope)
            elif tag_3 == 'ooqp':
                record["layouts"].append('OoqpInterface::serialize_body')
                layout_OoqpInterface_serialize_body(r, record, scope)
            elif tag_3 == 'osqp':
                record["layouts"].append('OsqpInterface::serialize_body')
                layout_OsqpInterface_serialize_body(r, record, scope)
            elif tag_3 == 'piqp':
                record["layouts"].append('PiqpInterface::serialize_body')
                layout_PiqpInterface_serialize_body(r, record, scope)
            elif tag_3 == 'proxqp':
                record["layouts"].append('ProxqpInterface::serialize_body')
                layout_ProxqpInterface_serialize_body(r, record, scope)
            elif tag_3 == 'qpoases':
                record["layouts"].append('QpoasesInterface::serialize_body')
                layout_QpoasesInterface_serialize_body(r, record, scope)
            elif tag_3 == 'qrqp':
                record["layouts"].append('Qrqp::serialize_body')
                layout_Qrqp_serialize_body(r, record, scope)
            elif tag_3 == 'sqic':
                record["layouts"].append('SqicInterface::serialize_body')
                layout_SqicInterface_serialize_body(r, record, scope)
            elif tag_3 == 'superscs':
                record["layouts"].append('SuperscsInterface::serialize_body')
                layout_SuperscsInterface_serialize_body(r, record, scope)
            elif tag_3 == 'xpress':
                record["layouts"].append('XpressInterface::serialize_body')
                layout_XpressInterface_serialize_body(r, record, scope)
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'External':
            r.version(record, 'GenericExternal', 1)
            scope['GenericExternal::type'] = r.field(record, 'GenericExternal::type', 'char', lambda: r.byte())
            tag_4 = r.tag(scope['GenericExternal::type'])
            if tag_4 == '103':
                record["layouts"].append('External::serialize_body')
                layout_External_serialize_body(r, record, scope)
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'FmuFunction':
            record["layouts"].append('FmuFunction::serialize_body')
            layout_FmuFunction_serialize_body(r, record, scope)
        elif tag_2 == 'ForwardDiff':
            record["layouts"].append('ForwardDiff::serialize_body')
            layout_ForwardDiff_serialize_body(r, record, scope)
        elif tag_2 == 'Integrator':
            scope['PluginInterface::plugin_name'] = r.field(record, 'PluginInterface::plugin_name', 'std::string', lambda: r.string())
            tag_5 = r.tag(scope['PluginInterface::plugin_name'])
            if tag_5 == 'collocation':
                record["layouts"].append('Collocation::serialize_body')
                layout_Collocation_serialize_body(r, record, scope)
            elif tag_5 == 'cvodes':
                record["layouts"].append('CvodesInterface::serialize_body')
                layout_CvodesInterface_serialize_body(r, record, scope)
            elif tag_5 == 'idas':
                record["layouts"].append('IdasInterface::serialize_body')
                layout_IdasInterface_serialize_body(r, record, scope)
            elif tag_5 == 'rk':
                record["layouts"].append('RungeKutta::serialize_body')
                layout_RungeKutta_serialize_body(r, record, scope)
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'Interpolant':
            scope['PluginInterface::plugin_name'] = r.field(record, 'PluginInterface::plugin_name', 'std::string', lambda: r.string())
            tag_6 = r.tag(scope['PluginInterface::plugin_name'])
            if tag_6 == 'bspline':
                record["layouts"].append('BSplineInterpolant::serialize_body')
                layout_BSplineInterpolant_serialize_body(r, record, scope)
            elif tag_6 == 'linear':
                r.version(record, 'LinearInterpolant', 1)
                scope['LinearInterpolant::type'] = r.field(record, 'LinearInterpolant::type', 'char', lambda: r.byte())
                tag_7 = r.tag(scope['LinearInterpolant::type'])
                if tag_7 == '102':
                    record["layouts"].append('LinearInterpolant::serialize_body')
                    layout_LinearInterpolant_serialize_body(r, record, scope)
                elif tag_7 == '106':
                    record["layouts"].append('LinearInterpolantJac::serialize_body')
                    layout_LinearInterpolantJac_serialize_body(r, record, scope)
                else:
                    r.fail('Unknown serialization discriminator')
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'MXFunction':
            record["layouts"].append('MXFunction::serialize_body')
            layout_MXFunction_serialize_body(r, record, scope)
        elif tag_2 == 'Map':
            scope['Map::class_name'] = r.field(record, 'Map::class_name', 'std::string', lambda: r.string())
            tag_8 = r.tag(scope['Map::class_name'])
            if tag_8 == 'Map':
                record["layouts"].append('Map::serialize_body')
                layout_Map_serialize_body(r, record, scope)
            elif tag_8 == 'OmpMap':
                record["layouts"].append('OmpMap::serialize_body')
                layout_OmpMap_serialize_body(r, record, scope)
            elif tag_8 == 'ThreadMap':
                record["layouts"].append('ThreadMap::serialize_body')
                layout_ThreadMap_serialize_body(r, record, scope)
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'MapSum':
            scope['MapSum::class_name'] = r.field(record, 'MapSum::class_name', 'std::string', lambda: r.string())
            tag_9 = r.tag(scope['MapSum::class_name'])
            if tag_9 == 'MapSum':
                record["layouts"].append('MapSum::serialize_body')
                layout_MapSum_serialize_body(r, record, scope)
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'Nlpsol':
            scope['PluginInterface::plugin_name'] = r.field(record, 'PluginInterface::plugin_name', 'std::string', lambda: r.string())
            tag_10 = r.tag(scope['PluginInterface::plugin_name'])
            if tag_10 == 'alpaqa':
                record["layouts"].append('AlpaqaInterface::serialize_body')
                layout_AlpaqaInterface_serialize_body(r, record, scope)
            elif tag_10 == 'ampl':
                record["layouts"].append('AmplInterface::serialize_body')
                layout_AmplInterface_serialize_body(r, record, scope)
            elif tag_10 == 'blocksqp':
                record["layouts"].append('Blocksqp::serialize_body')
                layout_Blocksqp_serialize_body(r, record, scope)
            elif tag_10 == 'bonmin':
                record["layouts"].append('BonminInterface::serialize_body')
                layout_BonminInterface_serialize_body(r, record, scope)
            elif tag_10 == 'ccopt':
                record["layouts"].append('MadmpecInterface::serialize_body')
                layout_MadmpecInterface_serialize_body(r, record, scope)
            elif tag_10 == 'conopt':
                record["layouts"].append('ConoptInterface::serialize_body')
                layout_ConoptInterface_serialize_body(r, record, scope)
            elif tag_10 == 'fatrop':
                record["layouts"].append('FatropInterface::serialize_body')
                layout_FatropInterface_serialize_body(r, record, scope)
            elif tag_10 == 'feasiblesqpmethod':
                record["layouts"].append('Feasiblesqpmethod::serialize_body')
                layout_Feasiblesqpmethod_serialize_body(r, record, scope)
            elif tag_10 == 'ipopt':
                record["layouts"].append('IpoptInterface::serialize_body')
                layout_IpoptInterface_serialize_body(r, record, scope)
            elif tag_10 == 'knitro':
                record["layouts"].append('KnitroInterface::serialize_body')
                layout_KnitroInterface_serialize_body(r, record, scope)
            elif tag_10 == 'madnlp':
                record["layouts"].append('MadnlpInterface::serialize_body')
                layout_MadnlpInterface_serialize_body(r, record, scope)
            elif tag_10 == 'qrsqp':
                record["layouts"].append('Qrsqp::serialize_body')
                layout_Qrsqp_serialize_body(r, record, scope)
            elif tag_10 == 'scpgen':
                record["layouts"].append('Scpgen::serialize_body')
                layout_Scpgen_serialize_body(r, record, scope)
            elif tag_10 == 'sleqp':
                record["layouts"].append('SLEQPInterface::serialize_body')
                layout_SLEQPInterface_serialize_body(r, record, scope)
            elif tag_10 == 'snopt':
                record["layouts"].append('SnoptInterface::serialize_body')
                layout_SnoptInterface_serialize_body(r, record, scope)
            elif tag_10 == 'sqpmethod':
                record["layouts"].append('Sqpmethod::serialize_body')
                layout_Sqpmethod_serialize_body(r, record, scope)
            elif tag_10 == 'uno':
                record["layouts"].append('UnoInterface::serialize_body')
                layout_UnoInterface_serialize_body(r, record, scope)
            elif tag_10 == 'worhp':
                record["layouts"].append('WorhpInterface::serialize_body')
                layout_WorhpInterface_serialize_body(r, record, scope)
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'Onnx':
            scope['PluginInterface::plugin_name'] = r.field(record, 'PluginInterface::plugin_name', 'std::string', lambda: r.string())
            tag_11 = r.tag(scope['PluginInterface::plugin_name'])
            if tag_11 == 'ort':
                record["layouts"].append('OnnxRuntimeInterface::serialize_body')
                layout_OnnxRuntimeInterface_serialize_body(r, record, scope)
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'Rootfinder':
            scope['PluginInterface::plugin_name'] = r.field(record, 'PluginInterface::plugin_name', 'std::string', lambda: r.string())
            tag_12 = r.tag(scope['PluginInterface::plugin_name'])
            if tag_12 == 'bisection':
                record["layouts"].append('Bisection::serialize_body')
                layout_Bisection_serialize_body(r, record, scope)
            elif tag_12 == 'fast_newton':
                record["layouts"].append('FastNewton::serialize_body')
                layout_FastNewton_serialize_body(r, record, scope)
            elif tag_12 == 'kinsol':
                record["layouts"].append('KinsolInterface::serialize_body')
                layout_KinsolInterface_serialize_body(r, record, scope)
            elif tag_12 == 'newton':
                record["layouts"].append('Newton::serialize_body')
                layout_Newton_serialize_body(r, record, scope)
            elif tag_12 == 'nlpsol':
                record["layouts"].append('ImplicitToNlp::serialize_body')
                layout_ImplicitToNlp_serialize_body(r, record, scope)
            else:
                r.fail('Unknown serialization discriminator')
        elif tag_2 == 'SXFunction':
            record["layouts"].append('SXFunction::serialize_body')
            layout_SXFunction_serialize_body(r, record, scope)
        elif tag_2 == 'Smoothing':
            record["layouts"].append('Smoothing::serialize_body')
            layout_Smoothing_serialize_body(r, record, scope)
        elif tag_2 == 'Switch':
            record["layouts"].append('Switch::serialize_body')
            layout_Switch_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    r.depth -= 1

def read_Function(r):
    return r.object('Function', 'F', True, read_Function_body)

def read_GenericType_body(r, record, scope):
    r.enter_layout()
    scope['GenericType::type'] = r.field(record, 'GenericType::type', 'int', lambda: r.number('int'))
    tag_13 = r.tag(scope['GenericType::type'])
    if tag_13 == '1':
        r.field(record, 'GenericType::d', 'bool', lambda: r.boolean())
    elif tag_13 == '10':
        r.field(record, 'GenericType::d', 'std::vector<std::string>', lambda: read_std_vector_std_string(r))
    elif tag_13 == '11':
        r.field(record, 'GenericType::d', 'Dict', lambda: read_Dict(r))
    elif tag_13 == '12':
        r.field(record, 'GenericType::d', 'Function', lambda: read_Function(r))
    elif tag_13 == '13':
        r.field(record, 'GenericType::d', 'std::vector<Function>', lambda: read_std_vector_Function(r))
    elif tag_13 == '14':
        r.field(record, 'GenericType::d', 'void*', lambda: r.primitive('void*'))
    elif tag_13 == '16':
        r.field(record, 'GenericType::d', 'std::vector<std::vector<std::string>>', lambda: read_std_vector_std_vector_std_string(r))
    elif tag_13 == '17':
        r.field(record, 'GenericType::d', 'std::vector<Dict>', lambda: read_std_vector_Dict(r))
    elif tag_13 == '18':
        r.field(record, 'GenericType::d', 'std::vector<std::vector<GenericType>>', lambda: read_std_vector_std_vector_GenericType(r))
    elif tag_13 == '19':
        r.field(record, 'GenericType::d', 'std::vector<GenericType>', lambda: read_std_vector_GenericType(r))
    elif tag_13 == '2':
        r.field(record, 'GenericType::d', 'casadi_int', lambda: r.number('casadi_int'))
    elif tag_13 == '3':
        r.field(record, 'GenericType::d', 'double', lambda: r.number('double'))
    elif tag_13 == '4':
        r.field(record, 'GenericType::d', 'std::string', lambda: r.string())
    elif tag_13 == '5':
        r.field(record, 'GenericType::d', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    elif tag_13 == '6':
        r.field(record, 'GenericType::d', 'std::vector<std::vector<casadi_int>>', lambda: read_std_vector_std_vector_casadi_int(r))
    elif tag_13 == '7':
        r.field(record, 'GenericType::d', 'std::vector<bool>', lambda: read_std_vector_bool(r))
    elif tag_13 == '8':
        r.field(record, 'GenericType::d', 'std::vector<double>', lambda: read_std_vector_double(r))
    elif tag_13 == '9':
        r.field(record, 'GenericType::d', 'std::vector<std::vector<double>>', lambda: read_std_vector_std_vector_double(r))
    else:
        r.fail('Unknown serialization discriminator')
    r.depth -= 1

def read_GenericType(r):
    return r.object('GenericType', 'G', True, read_GenericType_body)

def read_IM_body(r, record, scope):
    r.enter_layout()
    r.field(record, 'Matrix::sparsity', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Matrix::nonzeros', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def read_IM(r):
    return r.object('IM', None, False, read_IM_body)

def read_Importer_body(r, record, scope):
    r.enter_layout()
    scope['ImporterInternal::type'] = r.field(record, 'ImporterInternal::type', 'std::string', lambda: r.string())
    tag_14 = r.tag(scope['ImporterInternal::type'])
    if tag_14 == 'DllLibrary':
        record["layouts"].append('ImporterInternal::serialize_body')
        layout_ImporterInternal_serialize_body(r, record, scope)
    else:
        r.fail('Unknown serialization discriminator')
    r.depth -= 1

def read_Importer(r):
    return r.object('Importer', 'M', True, read_Importer_body)

def read_Linsol_body(r, record, scope):
    r.enter_layout()
    scope['PluginInterface::plugin_name'] = r.field(record, 'PluginInterface::plugin_name', 'std::string', lambda: r.string())
    tag_15 = r.tag(scope['PluginInterface::plugin_name'])
    if tag_15 == 'csparse':
        record["layouts"].append('CsparseInterface::serialize_body')
        layout_CsparseInterface_serialize_body(r, record, scope)
    elif tag_15 == 'csparsecholesky':
        record["layouts"].append('CSparseCholeskyInterface::serialize_body')
        layout_CSparseCholeskyInterface_serialize_body(r, record, scope)
    elif tag_15 == 'lapacklu':
        record["layouts"].append('LapackLu::serialize_body')
        layout_LapackLu_serialize_body(r, record, scope)
    elif tag_15 == 'lapackqr':
        record["layouts"].append('LapackQr::serialize_body')
        layout_LapackQr_serialize_body(r, record, scope)
    elif tag_15 == 'ldl':
        record["layouts"].append('LinsolLdl::serialize_body')
        layout_LinsolLdl_serialize_body(r, record, scope)
    elif tag_15 == 'lsqr':
        record["layouts"].append('Lsqr::serialize_body')
        layout_Lsqr_serialize_body(r, record, scope)
    elif tag_15 == 'ma27':
        record["layouts"].append('Ma27Interface::serialize_body')
        layout_Ma27Interface_serialize_body(r, record, scope)
    elif tag_15 == 'mumps':
        record["layouts"].append('MumpsInterface::serialize_body')
        layout_MumpsInterface_serialize_body(r, record, scope)
    elif tag_15 == 'qr':
        record["layouts"].append('LinsolQr::serialize_body')
        layout_LinsolQr_serialize_body(r, record, scope)
    elif tag_15 == 'symbolicqr':
        record["layouts"].append('SymbolicQr::serialize_body')
        layout_SymbolicQr_serialize_body(r, record, scope)
    elif tag_15 == 'tridiag':
        record["layouts"].append('LinsolTridiag::serialize_body')
        layout_LinsolTridiag_serialize_body(r, record, scope)
    else:
        r.fail('Unknown serialization discriminator')
    r.depth -= 1

def read_Linsol(r):
    return r.object('Linsol', 'L', True, read_Linsol_body)

def read_MX_body(r, record, scope):
    r.enter_layout()
    scope['MXNode::op'] = r.field(record, 'MXNode::op', 'int', lambda: r.number('int'))
    tag_16 = r.tag(scope['MXNode::op'])
    if tag_16 == '-1':
        record["layouts"].append('OutputNode::serialize_body')
        layout_OutputNode_serialize_body(r, record, scope)
    elif tag_16 == '0':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '1':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '10':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '100':
        scope['KronContract::kind'] = r.field(record, 'KronContract::kind', 'std::string', lambda: r.string())
        tag_17 = r.tag(scope['KronContract::kind'])
        if tag_17 == 'base':
            record["layouts"].append('KronContract::serialize_body')
            layout_KronContract_serialize_body(r, record, scope)
        elif tag_17 == 'dense':
            record["layouts"].append('DenseKronContract::serialize_body')
            layout_DenseKronContract_serialize_body(r, record, scope)
        elif tag_17 == 'dense_sparse':
            record["layouts"].append('DenseSparseKronContract::serialize_body')
            layout_DenseSparseKronContract_serialize_body(r, record, scope)
        elif tag_17 == 'sparse_dense':
            record["layouts"].append('SparseDenseKronContract::serialize_body')
            layout_SparseDenseKronContract_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '11':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '12':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '13':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '14':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '15':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '16':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '17':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '18':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '19':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '2':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '20':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '21':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '22':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '23':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '24':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '25':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '26':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '27':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '28':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '29':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '3':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '30':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '31':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '32':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '33':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '34':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '35':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '36':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '37':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '38':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '39':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '4':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '40':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '41':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '42':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '43':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '44':
        scope['ConstantMX::type'] = r.field(record, 'ConstantMX::type', 'char', lambda: r.byte())
        tag_18 = r.tag(scope['ConstantMX::type'])
        if tag_18 == '102':
            record["layouts"].append('ConstantFile::serialize_body')
            layout_ConstantFile_serialize_body(r, record, scope)
        elif tag_18 == '109':
            record["layouts"].append('MXNode::serialize_body')
            layout_MXNode_serialize_body(r, record, scope)
        elif tag_18 == '112':
            record["layouts"].append('ConstantPool::serialize_body')
            layout_ConstantPool_serialize_body(r, record, scope)
        elif tag_18 == '122':
            pass
        elif tag_18 == '48':
            record["layouts"].append('MXNode::serialize_body')
            layout_MXNode_serialize_body(r, record, scope)
        elif tag_18 == '49':
            record["layouts"].append('MXNode::serialize_body')
            layout_MXNode_serialize_body(r, record, scope)
        elif tag_18 == '68':
            r.field(record, 'Constant::value', 'double', lambda: r.number('double'))
            record["layouts"].append('MXNode::serialize_body')
            layout_MXNode_serialize_body(r, record, scope)
        elif tag_18 == '73':
            r.field(record, 'Constant::value', 'casadi_int', lambda: r.number('casadi_int'))
            record["layouts"].append('MXNode::serialize_body')
            layout_MXNode_serialize_body(r, record, scope)
        elif tag_18 == '97':
            record["layouts"].append('ConstantDM::serialize_body')
            layout_ConstantDM_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '45':
        record["layouts"].append('Input::serialize_body')
        layout_Input_serialize_body(r, record, scope)
    elif tag_16 == '46':
        record["layouts"].append('Output::serialize_body')
        layout_Output_serialize_body(r, record, scope)
    elif tag_16 == '47':
        record["layouts"].append('SymbolicMX::serialize_body')
        layout_SymbolicMX_serialize_body(r, record, scope)
    elif tag_16 == '48':
        record["layouts"].append('Call::serialize_body')
        layout_Call_serialize_body(r, record, scope)
    elif tag_16 == '49':
        record["layouts"].append('Find::serialize_body')
        layout_Find_serialize_body(r, record, scope)
    elif tag_16 == '5':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '50':
        record["layouts"].append('Low::serialize_body')
        layout_Low_serialize_body(r, record, scope)
    elif tag_16 == '52':
        scope['Multiplication::kind'] = r.field(record, 'Multiplication::kind', 'std::string', lambda: r.string())
        tag_19 = r.tag(scope['Multiplication::kind'])
        if tag_19 == 'base':
            record["layouts"].append('Multiplication::serialize_body')
            layout_Multiplication_serialize_body(r, record, scope)
        elif tag_19 == 'dense':
            record["layouts"].append('DenseMultiplication::serialize_body')
            layout_DenseMultiplication_serialize_body(r, record, scope)
        elif tag_19 == 'dense_sparse':
            record["layouts"].append('DenseSparseMultiplication::serialize_body')
            layout_DenseSparseMultiplication_serialize_body(r, record, scope)
        elif tag_19 == 'pseudo_dense':
            record["layouts"].append('PseudoDenseMultiplication::serialize_body')
            layout_PseudoDenseMultiplication_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '53':
        r.field(record, 'Solve::Tr', 'bool', lambda: r.boolean())
        record["layouts"].append('LinsolCall<Tr>::serialize_body')
        layout_LinsolCall_Tr_serialize_body(r, record, scope)
    elif tag_16 == '54':
        scope['Transpose::dense'] = r.field(record, 'Transpose::dense', 'bool', lambda: r.boolean())
        tag_20 = r.tag(scope['Transpose::dense'])
        if tag_20 == 'false':
            record["layouts"].append('Transpose::serialize_body')
            layout_Transpose_serialize_body(r, record, scope)
        elif tag_20 == 'true':
            record["layouts"].append('DenseTranspose::serialize_body')
            layout_DenseTranspose_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '55':
        record["layouts"].append('Determinant::serialize_body')
        layout_Determinant_serialize_body(r, record, scope)
    elif tag_16 == '56':
        record["layouts"].append('Inverse::serialize_body')
        layout_Inverse_serialize_body(r, record, scope)
    elif tag_16 == '57':
        record["layouts"].append('Dot::serialize_body')
        layout_Dot_serialize_body(r, record, scope)
    elif tag_16 == '58':
        record["layouts"].append('Bilin::serialize_body')
        layout_Bilin_serialize_body(r, record, scope)
    elif tag_16 == '59':
        record["layouts"].append('Rank1::serialize_body')
        layout_Rank1_serialize_body(r, record, scope)
    elif tag_16 == '6':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '60':
        record["layouts"].append('Horzcat::serialize_body')
        layout_Horzcat_serialize_body(r, record, scope)
    elif tag_16 == '61':
        record["layouts"].append('Vertcat::serialize_body')
        layout_Vertcat_serialize_body(r, record, scope)
    elif tag_16 == '62':
        record["layouts"].append('Diagcat::serialize_body')
        layout_Diagcat_serialize_body(r, record, scope)
    elif tag_16 == '63':
        record["layouts"].append('Horzsplit::serialize_body')
        layout_Horzsplit_serialize_body(r, record, scope)
    elif tag_16 == '64':
        record["layouts"].append('Vertsplit::serialize_body')
        layout_Vertsplit_serialize_body(r, record, scope)
    elif tag_16 == '65':
        record["layouts"].append('Diagsplit::serialize_body')
        layout_Diagsplit_serialize_body(r, record, scope)
    elif tag_16 == '66':
        record["layouts"].append('Reshape::serialize_body')
        layout_Reshape_serialize_body(r, record, scope)
    elif tag_16 == '69':
        scope['GetNonzeros::type'] = r.field(record, 'GetNonzeros::type', 'char', lambda: r.byte())
        tag_21 = r.tag(scope['GetNonzeros::type'])
        if tag_21 == '97':
            record["layouts"].append('GetNonzerosVector::serialize_body')
            layout_GetNonzerosVector_serialize_body(r, record, scope)
        elif tag_21 == '98':
            record["layouts"].append('GetNonzerosSlice::serialize_body')
            layout_GetNonzerosSlice_serialize_body(r, record, scope)
        elif tag_21 == '99':
            record["layouts"].append('GetNonzerosSlice2::serialize_body')
            layout_GetNonzerosSlice2_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '7':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '70':
        scope['GetNonzerosParam::type'] = r.field(record, 'GetNonzerosParam::type', 'char', lambda: r.byte())
        tag_22 = r.tag(scope['GetNonzerosParam::type'])
        if tag_22 == '100':
            record["layouts"].append('GetNonzerosParamParam::serialize_body')
            layout_GetNonzerosParamParam_serialize_body(r, record, scope)
        elif tag_22 == '97':
            record["layouts"].append('GetNonzerosParamVector::serialize_body')
            layout_GetNonzerosParamVector_serialize_body(r, record, scope)
        elif tag_22 == '98':
            record["layouts"].append('GetNonzerosParamSlice::serialize_body')
            layout_GetNonzerosParamSlice_serialize_body(r, record, scope)
        elif tag_22 == '99':
            record["layouts"].append('GetNonzerosSliceParam::serialize_body')
            layout_GetNonzerosSliceParam_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '71':
        scope['SetNonzeros::type'] = r.field(record, 'SetNonzeros::type', 'char', lambda: r.byte())
        tag_23 = r.tag(scope['SetNonzeros::type'])
        if tag_23 == '97':
            record["layouts"].append('SetNonzerosVector<Add>::serialize_body')
            layout_SetNonzerosVector_Add_serialize_body(r, record, scope)
        elif tag_23 == '98':
            record["layouts"].append('SetNonzerosSlice<Add>::serialize_body')
            layout_SetNonzerosSlice_Add_serialize_body(r, record, scope)
        elif tag_23 == '99':
            record["layouts"].append('SetNonzerosSlice2<Add>::serialize_body')
            layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '72':
        scope['SetNonzerosParam::type'] = r.field(record, 'SetNonzerosParam::type', 'char', lambda: r.byte())
        tag_24 = r.tag(scope['SetNonzerosParam::type'])
        if tag_24 == '100':
            record["layouts"].append('SetNonzerosParamParam<Add>::serialize_body')
            layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope)
        elif tag_24 == '97':
            record["layouts"].append('SetNonzerosParamVector<Add>::serialize_body')
            layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope)
        elif tag_24 == '98':
            record["layouts"].append('SetNonzerosParamSlice<Add>::serialize_body')
            layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope)
        elif tag_24 == '99':
            record["layouts"].append('SetNonzerosSliceParam<Add>::serialize_body')
            layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '73':
        scope['SetNonzeros::type'] = r.field(record, 'SetNonzeros::type', 'char', lambda: r.byte())
        tag_25 = r.tag(scope['SetNonzeros::type'])
        if tag_25 == '97':
            record["layouts"].append('SetNonzerosVector<Add>::serialize_body')
            layout_SetNonzerosVector_Add_serialize_body(r, record, scope)
        elif tag_25 == '98':
            record["layouts"].append('SetNonzerosSlice<Add>::serialize_body')
            layout_SetNonzerosSlice_Add_serialize_body(r, record, scope)
        elif tag_25 == '99':
            record["layouts"].append('SetNonzerosSlice2<Add>::serialize_body')
            layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '74':
        scope['SetNonzerosParam::type'] = r.field(record, 'SetNonzerosParam::type', 'char', lambda: r.byte())
        tag_26 = r.tag(scope['SetNonzerosParam::type'])
        if tag_26 == '100':
            record["layouts"].append('SetNonzerosParamParam<Add>::serialize_body')
            layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope)
        elif tag_26 == '97':
            record["layouts"].append('SetNonzerosParamVector<Add>::serialize_body')
            layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope)
        elif tag_26 == '98':
            record["layouts"].append('SetNonzerosParamSlice<Add>::serialize_body')
            layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope)
        elif tag_26 == '99':
            record["layouts"].append('SetNonzerosSliceParam<Add>::serialize_body')
            layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '75':
        scope['Project::type'] = r.field(record, 'Project::type', 'char', lambda: r.byte())
        tag_27 = r.tag(scope['Project::type'])
        if tag_27 == '100':
            record["layouts"].append('Densify::serialize_body')
            layout_Densify_serialize_body(r, record, scope)
        elif tag_27 == '110':
            record["layouts"].append('Project::serialize_body')
            layout_Project_serialize_body(r, record, scope)
        elif tag_27 == '115':
            record["layouts"].append('Sparsify::serialize_body')
            layout_Sparsify_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '76':
        record["layouts"].append('Assertion::serialize_body')
        layout_Assertion_serialize_body(r, record, scope)
    elif tag_16 == '77':
        record["layouts"].append('Monitor::serialize_body')
        layout_Monitor_serialize_body(r, record, scope)
    elif tag_16 == '78':
        record["layouts"].append('Norm2::serialize_body')
        layout_Norm2_serialize_body(r, record, scope)
    elif tag_16 == '79':
        record["layouts"].append('Norm1::serialize_body')
        layout_Norm1_serialize_body(r, record, scope)
    elif tag_16 == '8':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '80':
        record["layouts"].append('NormInf::serialize_body')
        layout_NormInf_serialize_body(r, record, scope)
    elif tag_16 == '81':
        record["layouts"].append('NormF::serialize_body')
        layout_NormF_serialize_body(r, record, scope)
    elif tag_16 == '82':
        record["layouts"].append('MMin::serialize_body')
        layout_MMin_serialize_body(r, record, scope)
    elif tag_16 == '83':
        record["layouts"].append('MMax::serialize_body')
        layout_MMax_serialize_body(r, record, scope)
    elif tag_16 == '84':
        record["layouts"].append('HorzRepmat::serialize_body')
        layout_HorzRepmat_serialize_body(r, record, scope)
    elif tag_16 == '85':
        record["layouts"].append('HorzRepsum::serialize_body')
        layout_HorzRepsum_serialize_body(r, record, scope)
    elif tag_16 == '86':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '87':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '88':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '89':
        record["layouts"].append('Einstein::serialize_body')
        layout_Einstein_serialize_body(r, record, scope)
    elif tag_16 == '9':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '90':
        scope['BSpline::type'] = r.field(record, 'BSpline::type', 'char', lambda: r.byte())
        tag_28 = r.tag(scope['BSpline::type'])
        if tag_28 == '110':
            record["layouts"].append('BSpline::serialize_body')
            layout_BSpline_serialize_body(r, record, scope)
        elif tag_28 == '112':
            record["layouts"].append('BSplineParametric::serialize_body')
            layout_BSplineParametric_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_16 == '91':
        record["layouts"].append('Convexify::serialize_body')
        layout_Convexify_serialize_body(r, record, scope)
    elif tag_16 == '92':
        record["layouts"].append('SparsityCast::serialize_body')
        layout_SparsityCast_serialize_body(r, record, scope)
    elif tag_16 == '93':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '94':
        record["layouts"].append('UnaryMX::serialize_body')
        layout_UnaryMX_serialize_body(r, record, scope)
    elif tag_16 == '95':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '96':
        record["layouts"].append('LogSumExp::serialize_body')
        layout_LogSumExp_serialize_body(r, record, scope)
    elif tag_16 == '97':
        r.field(record, 'BinaryMX::scalar_flags', 'char', lambda: r.byte())
        record["layouts"].append('BinaryMX<ScX,ScY>::serialize_body')
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elif tag_16 == '98':
        record["layouts"].append('Dump::serialize_body')
        layout_Dump_serialize_body(r, record, scope)
    elif tag_16 == '99':
        scope['Kron::kind'] = r.field(record, 'Kron::kind', 'std::string', lambda: r.string())
        tag_29 = r.tag(scope['Kron::kind'])
        if tag_29 == 'base':
            record["layouts"].append('Kron::serialize_body')
            layout_Kron_serialize_body(r, record, scope)
        elif tag_29 == 'dense':
            record["layouts"].append('DenseKron::serialize_body')
            layout_DenseKron_serialize_body(r, record, scope)
        elif tag_29 == 'dense_sparse':
            record["layouts"].append('DenseSparseKron::serialize_body')
            layout_DenseSparseKron_serialize_body(r, record, scope)
        elif tag_29 == 'sparse_dense':
            record["layouts"].append('SparseDenseKron::serialize_body')
            layout_SparseDenseKron_serialize_body(r, record, scope)
        else:
            r.fail('Unknown serialization discriminator')
    else:
        r.fail('Unknown serialization discriminator')
    r.depth -= 1

def read_MX(r):
    return r.object('MX', 'X', True, read_MX_body)

def read_Resource_body(r, record, scope):
    r.enter_layout()
    r.version(record, 'ResourceInternal', 1)
    scope['ResourceInternal::type'] = r.field(record, 'ResourceInternal::type', 'std::string', lambda: r.string())
    tag_30 = r.tag(scope['ResourceInternal::type'])
    if tag_30 == 'DirResource':
        record["layouts"].append('DirResource::serialize_body')
        layout_DirResource_serialize_body(r, record, scope)
    elif tag_30 == 'ZipMemResource':
        record["layouts"].append('ZipMemResource::serialize_body')
        layout_ZipMemResource_serialize_body(r, record, scope)
    elif tag_30 == 'ZipResource':
        record["layouts"].append('ZipResource::serialize_body')
        layout_ZipResource_serialize_body(r, record, scope)
    else:
        r.fail('Unknown serialization discriminator')
    r.depth -= 1

def read_Resource(r):
    return r.object('Resource', 'R', True, read_Resource_body)

def read_SX_body(r, record, scope):
    r.enter_layout()
    r.field(record, 'Matrix::sparsity', 'Sparsity', lambda: read_Sparsity(r))
    r.field(record, 'Matrix::nonzeros', 'std::vector<SXElem>', lambda: read_std_vector_SXElem(r))
    r.depth -= 1

def read_SX(r):
    return r.object('SX', None, False, read_SX_body)

def read_SXElem_body(r, record, scope):
    r.enter_layout()
    scope['SXNode::op'] = r.field(record, 'SXNode::op', 'casadi_int', lambda: r.number('casadi_int'))
    tag_31 = r.tag(scope['SXNode::op'])
    if tag_31 == '-1':
        record["layouts"].append('OutputSX::serialize_node')
        layout_OutputSX_serialize_node(r, record, scope)
    elif tag_31 == '0':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '1':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '10':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '11':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '12':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '13':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '14':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '15':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '16':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '17':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '18':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '19':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '2':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '20':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '21':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '22':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '23':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '24':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '25':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '26':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '27':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '28':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '29':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '3':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '30':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '31':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '32':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '33':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '34':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '35':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '36':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '37':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '38':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '39':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '4':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '40':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '41':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '42':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '43':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '44':
        scope['ConstantSX::type'] = r.field(record, 'ConstantSX::type', 'char', lambda: r.byte())
        tag_32 = r.tag(scope['ConstantSX::type'])
        if tag_32 == '102':
            pass
        elif tag_32 == '105':
            r.field(record, 'ConstantSX::value', 'int', lambda: r.number('int'))
        elif tag_32 == '109':
            pass
        elif tag_32 == '110':
            pass
        elif tag_32 == '114':
            r.field(record, 'ConstantSX::value', 'double', lambda: r.number('double'))
        elif tag_32 == '48':
            pass
        elif tag_32 == '49':
            pass
        elif tag_32 == '70':
            pass
        else:
            r.fail('Unknown serialization discriminator')
    elif tag_31 == '47':
        record["layouts"].append('SymbolicSX::serialize_node')
        layout_SymbolicSX_serialize_node(r, record, scope)
    elif tag_31 == '48':
        record["layouts"].append('CallSX::serialize_node')
        layout_CallSX_serialize_node(r, record, scope)
    elif tag_31 == '5':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '6':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '7':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '8':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '86':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '87':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '88':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '9':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '93':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '94':
        record["layouts"].append('UnarySX::serialize_node')
        layout_UnarySX_serialize_node(r, record, scope)
    elif tag_31 == '95':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    elif tag_31 == '97':
        record["layouts"].append('BinarySX::serialize_node')
        layout_BinarySX_serialize_node(r, record, scope)
    else:
        r.fail('Unknown serialization discriminator')
    r.depth -= 1

def read_SXElem(r):
    return r.object('SXElem', 'E', True, read_SXElem_body)

def read_Slice_body(r, record, scope):
    r.enter_layout()
    record["layouts"].append('Slice::serialize')
    layout_Slice_serialize(r, record, scope)
    r.depth -= 1

def read_Slice(r):
    return r.object('Slice', 'S', False, read_Slice_body)

def read_Sparsity_body(r, record, scope):
    r.enter_layout()
    r.field(record, 'SparsityInternal::compressed', 'std::vector<casadi_int>', lambda: read_std_vector_casadi_int(r))
    r.depth -= 1

def read_Sparsity(r):
    return r.object('Sparsity', 'S', True, read_Sparsity_body)

def read_std_vector_double(r):
    r.decoration('V')
    return [r.number('double') for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_casadi_int(r):
    r.decoration('V')
    return [r.number('casadi_int') for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_std_vector_double(r):
    r.decoration('V')
    return [read_std_vector_double(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_std_string(r):
    r.decoration('V')
    return [r.string() for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_int(r):
    r.decoration('V')
    return [r.number('int') for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_char(r):
    r.decoration('V')
    return [r.byte() for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_bool(r):
    r.decoration('V')
    return [r.boolean() for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_SXElem(r):
    r.decoration('V')
    return [read_SXElem(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_std_vector_int(r):
    r.decoration('V')
    return [read_std_vector_int(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_unsignedint(r):
    r.decoration('V')
    return [r.number('unsignedint') for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_size_t(r):
    r.decoration('V')
    return [r.number('size_t') for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_Sparsity(r):
    r.decoration('V')
    return [read_Sparsity(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_map_std_string_std_vector_size_t(r):
    r.decoration('D')
    return {"$map": [[r.string(), read_std_vector_size_t(r)] for _ in range(r.count(r.number("casadi_int")))]}

def read_std_vector_std_vector_size_t(r):
    r.decoration('V')
    return [read_std_vector_size_t(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_Function(r):
    r.decoration('V')
    return [read_Function(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_pair_casadi_int_std_string(r):
    r.decoration('p')
    return [r.number('casadi_int'), r.string()]

def read_std_map_std_string_std_pair_casadi_int_std_string(r):
    r.decoration('D')
    return {"$map": [[r.string(), read_std_pair_casadi_int_std_string(r)] for _ in range(r.count(r.number("casadi_int")))]}

def read_std_pair_bool_std_string(r):
    r.decoration('p')
    return [r.boolean(), r.string()]

def read_std_map_std_string_std_pair_bool_std_string(r):
    r.decoration('D')
    return {"$map": [[r.string(), read_std_pair_bool_std_string(r)] for _ in range(r.count(r.number("casadi_int")))]}

def read_std_vector_MX(r):
    r.decoration('V')
    return [read_MX(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_map_std_string_std_vector_double(r):
    r.decoration('D')
    return {"$map": [[r.string(), read_std_vector_double(r)] for _ in range(r.count(r.number("casadi_int")))]}

def read_std_map_std_string_casadi_int(r):
    r.decoration('D')
    return {"$map": [[r.string(), r.number('casadi_int')] for _ in range(r.count(r.number("casadi_int")))]}

def read_std_map_std_string_std_vector_casadi_int(r):
    r.decoration('D')
    return {"$map": [[r.string(), read_std_vector_casadi_int(r)] for _ in range(r.count(r.number("casadi_int")))]}

def read_std_map_std_string_bool(r):
    r.decoration('D')
    return {"$map": [[r.string(), r.boolean()] for _ in range(r.count(r.number("casadi_int")))]}

def read_std_map_std_string_double(r):
    r.decoration('D')
    return {"$map": [[r.string(), r.number('double')] for _ in range(r.count(r.number("casadi_int")))]}

def read_std_vector_SX(r):
    r.decoration('V')
    return [read_SX(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_std_vector_casadi_int(r):
    r.decoration('V')
    return [read_std_vector_casadi_int(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_std_vector_std_string(r):
    r.decoration('V')
    return [read_std_vector_std_string(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_Dict(r):
    r.decoration('V')
    return [read_Dict(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_GenericType(r):
    r.decoration('V')
    return [read_GenericType(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_std_vector_GenericType(r):
    r.decoration('V')
    return [read_std_vector_GenericType(r) for _ in range(r.count(r.number("casadi_int")))]

def read_std_vector_DM(r):
    r.decoration('V')
    return [read_DM(r) for _ in range(r.count(r.number("casadi_int")))]

def read_Dict(r):
    r.decoration('D')
    return {"$map": [[r.string(), read_GenericType(r)] for _ in range(r.count(r.number("casadi_int")))]}

READERS = {
    'DM': read_DM,
    'Fmu': read_Fmu,
    'Function': read_Function,
    'GenericType': read_GenericType,
    'IM': read_IM,
    'Importer': read_Importer,
    'Linsol': read_Linsol,
    'MX': read_MX,
    'Resource': read_Resource,
    'SX': read_SX,
    'SXElem': read_SXElem,
    'Slice': read_Slice,
    'Sparsity': read_Sparsity,
    'std::vector<double>': read_std_vector_double,
    'std::vector<casadi_int>': read_std_vector_casadi_int,
    'std::vector<std::vector<double>>': read_std_vector_std_vector_double,
    'std::vector<std::string>': read_std_vector_std_string,
    'std::vector<int>': read_std_vector_int,
    'std::vector<char>': read_std_vector_char,
    'std::vector<bool>': read_std_vector_bool,
    'std::vector<SXElem>': read_std_vector_SXElem,
    'std::vector<std::vector<int>>': read_std_vector_std_vector_int,
    'std::vector<unsignedint>': read_std_vector_unsignedint,
    'std::vector<size_t>': read_std_vector_size_t,
    'std::vector<Sparsity>': read_std_vector_Sparsity,
    'std::map<std::string,std::vector<size_t>>': read_std_map_std_string_std_vector_size_t,
    'std::vector<std::vector<size_t>>': read_std_vector_std_vector_size_t,
    'std::vector<Function>': read_std_vector_Function,
    'std::pair<casadi_int,std::string>': read_std_pair_casadi_int_std_string,
    'std::map<std::string,std::pair<casadi_int,std::string>>': read_std_map_std_string_std_pair_casadi_int_std_string,
    'std::pair<bool,std::string>': read_std_pair_bool_std_string,
    'std::map<std::string,std::pair<bool,std::string>>': read_std_map_std_string_std_pair_bool_std_string,
    'std::vector<MX>': read_std_vector_MX,
    'std::map<std::string,std::vector<double>>': read_std_map_std_string_std_vector_double,
    'std::map<std::string,casadi_int>': read_std_map_std_string_casadi_int,
    'std::map<std::string,std::vector<casadi_int>>': read_std_map_std_string_std_vector_casadi_int,
    'std::map<std::string,bool>': read_std_map_std_string_bool,
    'std::map<std::string,double>': read_std_map_std_string_double,
    'std::vector<SX>': read_std_vector_SX,
    'std::vector<std::vector<casadi_int>>': read_std_vector_std_vector_casadi_int,
    'std::vector<std::vector<std::string>>': read_std_vector_std_vector_std_string,
    'std::vector<Dict>': read_std_vector_Dict,
    'std::vector<GenericType>': read_std_vector_GenericType,
    'std::vector<std::vector<GenericType>>': read_std_vector_std_vector_GenericType,
    'std::vector<DM>': read_std_vector_DM,
    'Dict': read_Dict,
}
METADATA = {'reader': {'file_prefixes': {'1': 'Function',
                              '11': 'Function',
                              '13': 'Function',
                              '20': 'std::vector<MX>',
                              '21': 'std::vector<SX>',
                              '22': 'std::vector<MX>',
                              '23': 'std::vector<SX>',
                              '3': 'Function'},
            'file_types': {'0': 'Sparsity',
                           '1': 'MX',
                           '10': 'std::vector<Sparsity>',
                           '11': 'std::vector<MX>',
                           '12': 'std::vector<DM>',
                           '13': 'std::vector<SX>',
                           '15': 'std::vector<Function>',
                           '16': 'std::vector<GenericType>',
                           '17': 'std::vector<casadi_int>',
                           '18': 'std::vector<double>',
                           '19': 'std::vector<std::string>',
                           '2': 'DM',
                           '20': 'MX',
                           '21': 'SX',
                           '22': 'std::vector<MX>',
                           '23': 'std::vector<SX>',
                           '3': 'SX',
                           '4': 'Linsol',
                           '5': 'Function',
                           '6': 'GenericType',
                           '7': 'casadi_int',
                           '8': 'double',
                           '9': 'std::string'}},
 'wire': {'magic': 123456789012345, 'protocol': 3}}
