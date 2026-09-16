# Generated from serialization_scheme.json; do not edit.

function layout_AlpaqaInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "AlpaqaInterface", 1)
    field(r, record, "AlpaqaInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "AlpaqaInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_AmplInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Assertion_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "Assertion::fail_message", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_BSpline_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "BSplineCommon::serialize_body")
    layout_BSplineCommon_serialize_body(r, record, scope)
    field(r, record, "BSpline::coeffs", "std::vector<double>", () -> read_std_vector_double(r))
    r.depth -= 1
end

function layout_BSpline_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["BSpline::type"] = field(r, record, "BSpline::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_BSplineCommon_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "BSplineCommon::knots", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "BSplineCommon::offset", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "BSplineCommon::degree", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "BSplineCommon::m", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "BSplineCommon::lookup_mode", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "BSplineCommon::strides", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "BSplineCommon::coeffs_dims", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "BSplineCommon::coeffs_size", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "BSplineCommon::jac_cache_", "MX", () -> read_MX(r))
    r.depth -= 1
end

function layout_BSplineInterpolant_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Interpolant::serialize_body")
    layout_Interpolant_serialize_body(r, record, scope)
    version(r, record, "BSplineInterpolant", 1)
    field(r, record, "BSplineInterpolant::s", "Function", () -> read_Function(r))
    r.depth -= 1
end

function layout_BSplineParametric_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "BSplineCommon::serialize_body")
    layout_BSplineCommon_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_BSplineParametric_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["BSpline::type"] = field(r, record, "BSpline::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_BackwardDiff_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "ForwardDiff::serialize_body")
    layout_ForwardDiff_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Bilin_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "BinaryMX::op", "int", () -> number(r, "int"))
    r.depth -= 1
end

function layout_BinaryMX_ScX_ScY_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
    r.depth -= 1
end

function layout_BinarySX_serialize_node(r, record, scope)
    enter_layout(r)
    field(r, record, "UnarySX::dep0", "SXElem", () -> read_SXElem(r))
    field(r, record, "UnarySX::dep1", "SXElem", () -> read_SXElem(r))
    r.depth -= 1
end

function layout_Bisection_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Rootfinder::serialize_body")
    layout_Rootfinder_serialize_body(r, record, scope)
    version(r, record, "Bisection", 1)
    field(r, record, "Bisection::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Bisection::max_search", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Bisection::search_step", "double", () -> number(r, "double"))
    field(r, record, "Bisection::abstol", "double", () -> number(r, "double"))
    field(r, record, "Bisection::abstol_step", "double", () -> number(r, "double"))
    field(r, record, "Bisection::lb", "double", () -> number(r, "double"))
    field(r, record, "Bisection::ub", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_BlazingSplineFunction_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "BlazingSplineFunction", 2)
    field(r, record, "BlazingSplineFunction::diff_order", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "BlazingSplineFunction::precompute_coeff", "bool", () -> boolvalue(r))
    field(r, record, "BlazingSplineFunction::precompute_grid", "bool", () -> boolvalue(r))
    field(r, record, "BlazingSplineFunction::knots", "std::vector<std::vector<double>>", () -> read_std_vector_std_vector_double(r))
    field(r, record, "BlazingSplineFunction::lookup_modes", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    scope["BlazingSplineFunction::parametric_knots"] = field(r, record, "BlazingSplineFunction::parametric_knots", "bool", () -> boolvalue(r))
    if truth(scope["BlazingSplineFunction::parametric_knots"])
        field(r, record, "BlazingSplineFunction::knots_offset", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
        field(r, record, "BlazingSplineFunction::inv_input", "bool", () -> boolvalue(r))
    end
    field(r, record, "BlazingSplineFunction::pedantic_mode_order", "std::string", () -> stringvalue(r))
    field(r, record, "BlazingSplineFunction::pedantic_mode_size", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_Blocksqp_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "Blocksqp", 1)
    field(r, record, "Blocksqp::nblocks", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::blocks", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Blocksqp::dim", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Blocksqp::nnz_H", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::Asp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Blocksqp::Hsp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Blocksqp::exact_hess_lag_sp_", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Blocksqp::linsol_plugin", "std::string", () -> stringvalue(r))
    field(r, record, "Blocksqp::print_header", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::print_iteration", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::eps", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::opttol", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::nlinfeastol", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::schur", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::globalization", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::restore_feas", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::max_line_search", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::max_consec_reduced_steps", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::max_consec_skipped_updates", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::max_it_qp", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::warmstart", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::qp_init", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::block_hess", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::hess_scaling", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::fallback_scaling", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::max_time_qp", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::ini_hess_diag", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::col_eps", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::col_tau1", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::col_tau2", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::hess_damp", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::hess_damp_fac", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::hess_update", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::fallback_update", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::hess_lim_mem", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::hess_memsize", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::which_second_derv", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::skip_first_globalization", "bool", () -> boolvalue(r))
    field(r, record, "Blocksqp::conv_strategy", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::max_conv_qp", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::max_soc_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Blocksqp::gamma_theta", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::gamma_f", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::kappa_soc", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::kappa_f", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::theta_max", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::theta_min", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::delta", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::s_theta", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::s_f", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::kappa_minus", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::kappa_plus", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::kappa_plus_max", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::delta_h0", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::eta", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::obj_lo", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::obj_up", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::rho", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::zeta", "double", () -> number(r, "double"))
    field(r, record, "Blocksqp::rp_solver", "Function", () -> read_Function(r))
    field(r, record, "Blocksqp::print_maxit_reached", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_BonminInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "BonminInterface", 1)
    field(r, record, "BonminInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "BonminInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "BonminInterface::exact_hessian", "bool", () -> boolvalue(r))
    field(r, record, "BonminInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "BonminInterface::sos1_weights", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "BonminInterface::sos1_indices", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "BonminInterface::sos1_priorities", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "BonminInterface::sos1_starts", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "BonminInterface::sos1_types", "std::vector<char>", () -> read_std_vector_char(r))
    field(r, record, "BonminInterface::sos1_types", "std::vector<char>", () -> read_std_vector_char(r))
    field(r, record, "BonminInterface::sos_num", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "BonminInterface::sos_num_nz", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "BonminInterface::pass_nonlinear_variables", "bool", () -> boolvalue(r))
    field(r, record, "BonminInterface::pass_nonlinear_constraints", "bool", () -> boolvalue(r))
    field(r, record, "BonminInterface::nl_ex", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "BonminInterface::nl_g", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "BonminInterface::var_string_md", "Dict", () -> read_Dict(r))
    field(r, record, "BonminInterface::var_integer_md", "Dict", () -> read_Dict(r))
    field(r, record, "BonminInterface::var_numeric_md", "Dict", () -> read_Dict(r))
    field(r, record, "BonminInterface::con_string_md", "Dict", () -> read_Dict(r))
    field(r, record, "BonminInterface::con_integer_md", "Dict", () -> read_Dict(r))
    field(r, record, "BonminInterface::con_numeric_md", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_CSparseCholeskyInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Call_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MultipleOutput::serialize_body")
    layout_MultipleOutput_serialize_body(r, record, scope)
    field(r, record, "Call::fcn", "Function", () -> read_Function(r))
    r.depth -= 1
end

function layout_CallSX_serialize_node(r, record, scope)
    enter_layout(r)
    field(r, record, "CallSX::f", "Function", () -> read_Function(r))
    field(r, record, "CallSX::dep", "std::vector<SXElem>", () -> read_std_vector_SXElem(r))
    r.depth -= 1
end

function layout_CbcInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "CbcInterface", 1)
    field(r, record, "CbcInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "CbcInterface::sos_groups", "std::vector<std::vector<int>>", () -> read_std_vector_std_vector_int(r))
    field(r, record, "CbcInterface::sos_weights", "std::vector<std::vector<double>>", () -> read_std_vector_std_vector_double(r))
    field(r, record, "CbcInterface::sos_types", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "CbcInterface::hot_start", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_CentralDiff_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FiniteDiff::serialize_body")
    layout_FiniteDiff_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_ClarabelInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "ClarabelInterface", 1)
    field(r, record, "ClarabelInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_ClpInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "ClpInterface", 1)
    field(r, record, "ClpInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_Collocation_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "ImplicitFixedStepIntegrator::serialize_body")
    layout_ImplicitFixedStepIntegrator_serialize_body(r, record, scope)
    version(r, record, "Collocation", 2)
    field(r, record, "Collocation::deg", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Collocation::collocation_scheme", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_Concat_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Conic_serialize(r, record, scope)
    enter_layout(r)
    field(r, record, "Conic::SDPToSOCPMem::r", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Conic::SDPToSOCPMem::AT", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Conic::SDPToSOCPMem::A_mapping", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Conic::SDPToSOCPMem::map_Q", "IM", () -> read_IM(r))
    field(r, record, "Conic::SDPToSOCPMem::map_P", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Conic::SDPToSOCPMem::indval_size", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Conic_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "Conic", 4)
    field(r, record, "Conic::discrete", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "Conic::equality", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "Conic::print_problem", "bool", () -> boolvalue(r))
    field(r, record, "Conic::solver_version_check", "bool", () -> boolvalue(r))
    field(r, record, "Conic::H", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Conic::A", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Conic::Q", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Conic::P", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Conic::nx", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Conic::na", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Conic::np", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Conic_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_type")
    layout_FunctionInternal_serialize_type(r, record, scope)
    push!(record["layouts"], "PluginInterface<Conic>::serialize_type")
    layout_PluginInterface_Conic_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_ConoptInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "ConoptInterface", 1)
    field(r, record, "ConoptInterface::exact_hessian", "bool", () -> boolvalue(r))
    field(r, record, "ConoptInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "ConoptInterface::gradf_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "ConoptInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "ConoptInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "ConoptInterface::optfile", "std::string", () -> stringvalue(r))
    field(r, record, "ConoptInterface::warm_start", "bool", () -> boolvalue(r))
    field(r, record, "ConoptInterface::debug", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_Constant_Value_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Constant_Value_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["ConstantMX::type"] = field(r, record, "ConstantMX::type", "char", () -> byte(r))
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_ConstantDM_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "ConstantMX::nonzeros", "std::vector<double>", () -> read_std_vector_double(r))
    r.depth -= 1
end

function layout_ConstantDM_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["ConstantMX::type"] = field(r, record, "ConstantMX::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_ConstantFile_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "ConstantFile::fname", "std::string", () -> stringvalue(r))
    field(r, record, "ConstantFile::x", "std::vector<double>", () -> read_std_vector_double(r))
    r.depth -= 1
end

function layout_ConstantFile_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    field(r, record, "ConstantFile::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_ConstantPool_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "ConstantPool::name", "std::string", () -> stringvalue(r))
    field(r, record, "ConstantPool::x", "std::vector<double>", () -> read_std_vector_double(r))
    r.depth -= 1
end

function layout_ConstantPool_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    field(r, record, "ConstantPool::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_Convexify_serialize(r, record, scope)
    enter_layout(r)
    version(r, record, (string(scope["prefix"]) * string("Convexify")), 1)
    field(r, record, (string(scope["prefix"]) * string("Convexify::type_in")), "int", () -> number(r, "int"))
    field(r, record, (string(scope["prefix"]) * string("Convexify::strategy")), "int", () -> number(r, "int"))
    field(r, record, (string(scope["prefix"]) * string("Convexify::margin")), "double", () -> number(r, "double"))
    field(r, record, (string(scope["prefix"]) * string("Convexify::max_iter_eig")), "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, (string(scope["prefix"]) * string("Convexify::scc_offset")), "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, (string(scope["prefix"]) * string("Convexify::scc_mapping")), "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, (string(scope["prefix"]) * string("Convexify::Hsp_project")), "int", () -> number(r, "int"))
    field(r, record, (string(scope["prefix"]) * string("Convexify::scc_transform")), "int", () -> number(r, "int"))
    field(r, record, (string(scope["prefix"]) * string("Convexify::verbose")), "int", () -> number(r, "int"))
    field(r, record, (string(scope["prefix"]) * string("Convexify::Hsp")), "Sparsity", () -> read_Sparsity(r))
    field(r, record, (string(scope["prefix"]) * string("Convexify::Hrsp")), "Sparsity", () -> read_Sparsity(r))
    r.depth -= 1
end

function layout_Convexify_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    push!(record["layouts"], "Convexify::serialize")
    scope["prefix"] = ""
    layout_Convexify_serialize(r, record, scope)
    r.depth -= 1
end

function layout_CplexInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "CplexInterface", 1)
    field(r, record, "CplexInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "CplexInterface::qp_method", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "CplexInterface::dump_to_file", "bool", () -> boolvalue(r))
    field(r, record, "CplexInterface::tol", "double", () -> number(r, "double"))
    field(r, record, "CplexInterface::dep_check", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "CplexInterface::warm_start", "bool", () -> boolvalue(r))
    field(r, record, "CplexInterface::mip_start", "bool", () -> boolvalue(r))
    field(r, record, "CplexInterface::mip", "bool", () -> boolvalue(r))
    field(r, record, "CplexInterface::ctype", "std::vector<char>", () -> read_std_vector_char(r))
    field(r, record, "CplexInterface::sos_weights", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "CplexInterface::sos_beg", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "CplexInterface::sos_ind", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "CplexInterface::sos_types", "std::vector<char>", () -> read_std_vector_char(r))
    push!(record["layouts"], "Conic::serialize")
    layout_Conic_serialize(r, record, scope)
    r.depth -= 1
end

function layout_CsparseInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_CvodesInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "SundialsInterface::serialize_body")
    layout_SundialsInterface_serialize_body(r, record, scope)
    version(r, record, "CvodesInterface", 3)
    field(r, record, "CvodesInterface::lmm", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "CvodesInterface::iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "CvodesInterface::min_step_size", "double", () -> number(r, "double"))
    field(r, record, "CvodesInterface::always_recalculate_jacobian", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_DaqpInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "DaqpInterface", 1)
    field(r, record, "DaqpInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_DenseKron_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Kron::serialize_body")
    layout_Kron_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_DenseKron_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Kron::kind"] = field(r, record, "Kron::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_DenseKronContract_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "KronContract::serialize_body")
    layout_KronContract_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_DenseKronContract_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["KronContract::kind"] = field(r, record, "KronContract::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_DenseMultiplication_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Multiplication::serialize_body")
    layout_Multiplication_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_DenseMultiplication_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Multiplication::kind"] = field(r, record, "Multiplication::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_DenseSparseKron_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Kron::serialize_body")
    layout_Kron_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_DenseSparseKron_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Kron::kind"] = field(r, record, "Kron::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_DenseSparseKronContract_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "KronContract::serialize_body")
    layout_KronContract_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_DenseSparseKronContract_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["KronContract::kind"] = field(r, record, "KronContract::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_DenseSparseMultiplication_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Multiplication::serialize_body")
    layout_Multiplication_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_DenseSparseMultiplication_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Multiplication::kind"] = field(r, record, "Multiplication::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_DenseTranspose_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Transpose::serialize_body")
    layout_Transpose_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_DenseTranspose_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Transpose::dense"] = field(r, record, "Transpose::dense", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_Densify_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Project::serialize_body")
    layout_Project_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Densify_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Project::type"] = field(r, record, "Project::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_Determinant_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "Determinant::linsol", "Linsol", () -> read_Linsol(r))
    r.depth -= 1
end

function layout_Diagcat_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Concat::serialize_body")
    layout_Concat_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Diagsplit_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Split::serialize_body")
    layout_Split_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_DirResource_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "ResourceInternal::serialize_body")
    layout_ResourceInternal_serialize_body(r, record, scope)
    version(r, record, "DirResource", 1)
    if truth((scope["ResourceInternal::serialize_mode"] == "embed"))
        field(r, record, "ZipMemResource::blob", "std::stringstream", () -> streamvalue(r))
    else
        field(r, record, "DirResource::path", "std::string", () -> stringvalue(r))
    end
    r.depth -= 1
end

function layout_DirResource_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered else branch")
    r.depth -= 1
end

function layout_Dot_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Dump_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    version(r, record, "Dump", 1)
    field(r, record, "Dump::base_filename", "std::string", () -> stringvalue(r))
    field(r, record, "Dump::dir", "std::string", () -> stringvalue(r))
    field(r, record, "Dump::format", "std::string", () -> stringvalue(r))
    field(r, record, "Dump::verbose", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_Einstein_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "Einstein::dim_c", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::dim_a", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::dim_b", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::c", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::a", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::b", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::iter_dims", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::strides_a", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::strides_b", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::strides_c", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Einstein::n_iter", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_External_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "External", 2)
    field(r, record, "External::int_data", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "External::real_data", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "External::string_data", "std::string", () -> stringvalue(r))
    field(r, record, "External::li", "Importer", () -> read_Importer(r))
    field(r, record, "External::config_args", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    r.depth -= 1
end

function layout_FastNewton_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Rootfinder::serialize_body")
    layout_Rootfinder_serialize_body(r, record, scope)
    version(r, record, "Newton", 1)
    field(r, record, "Newton::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Newton::abstol", "double", () -> number(r, "double"))
    field(r, record, "Newton::abstolStep", "double", () -> number(r, "double"))
    field(r, record, "Newton::jac_g_x", "Function", () -> read_Function(r))
    field(r, record, "Newton::sp_v", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Newton::sp_r", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Newton::prinv", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Newton::pc", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_FatropConicInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "FatropConicInterface", 1)
    r.depth -= 1
end

function layout_FatropInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "FatropInterface", 1)
    field(r, record, "FatropInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FatropInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FatropInterface::exact_hessian", "bool", () -> boolvalue(r))
    field(r, record, "FatropInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "FatropInterface::convexify", "bool", () -> boolvalue(r))
    field(r, record, "FatropInterface::Isp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FatropInterface::ABsp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FatropInterface::CDsp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FatropInterface::RSQsp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FatropInterface::AB_blocks", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::CD_blocks", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::RSQ_blocks", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::I_blocks", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::nxs", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::nus", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::ngs", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::N", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FatropInterface::structure_detection", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FatropInterface::AB_offsets", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::CD_offsets", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::RSQ_offsets", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::I_offsets", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FatropInterface::debug", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_Feasiblesqpmethod_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "Feasiblesqpmethod", 3)
    field(r, record, "Feasiblesqpmethod::qpsol", "Function", () -> read_Function(r))
    field(r, record, "Feasiblesqpmethod::exact_hessian", "bool", () -> boolvalue(r))
    field(r, record, "Feasiblesqpmethod::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Feasiblesqpmethod::min_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Feasiblesqpmethod::lbfgs_memory", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Feasiblesqpmethod::tol_pr_", "double", () -> number(r, "double"))
    field(r, record, "Feasiblesqpmethod::tol_du_", "double", () -> number(r, "double"))
    field(r, record, "Feasiblesqpmethod::print_header", "bool", () -> boolvalue(r))
    field(r, record, "Feasiblesqpmethod::print_iteration", "bool", () -> boolvalue(r))
    field(r, record, "Feasiblesqpmethod::print_status", "bool", () -> boolvalue(r))
    field(r, record, "Feasiblesqpmethod::init_feasible", "bool", () -> boolvalue(r))
    field(r, record, "Feasiblesqpmethod::Hsp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Feasiblesqpmethod::Asp", "Sparsity", () -> read_Sparsity(r))
    scope["Feasiblesqpmethod::convexify"] = field(r, record, "Feasiblesqpmethod::convexify", "bool", () -> boolvalue(r))
    if truth(scope["Feasiblesqpmethod::convexify"])
        push!(record["layouts"], "Convexify::serialize")
        scope["prefix"] = "Feasiblesqpmethod::"
        layout_Convexify_serialize(r, record, scope)
    end
    r.depth -= 1
end

function layout_Find_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_FiniteDiff_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "FiniteDiff", 1)
    field(r, record, "FiniteDiff::n", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FiniteDiff::h_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FiniteDiff::h", "double", () -> number(r, "double"))
    field(r, record, "FiniteDiff::n_z", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FiniteDiff::n_y", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FiniteDiff::u_aim", "double", () -> number(r, "double"))
    field(r, record, "FiniteDiff::h_min", "double", () -> number(r, "double"))
    field(r, record, "FiniteDiff::h_max", "double", () -> number(r, "double"))
    field(r, record, "FiniteDiff::reltol", "double", () -> number(r, "double"))
    field(r, record, "FiniteDiff::abstol", "double", () -> number(r, "double"))
    field(r, record, "FiniteDiff::smoothing", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_FixedStepIntegrator_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Integrator::serialize_body")
    layout_Integrator_serialize_body(r, record, scope)
    version(r, record, "FixedStepIntegrator", 3)
    field(r, record, "FixedStepIntegrator::nk_target", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FixedStepIntegrator::disc", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FixedStepIntegrator::nv", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FixedStepIntegrator::nv1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FixedStepIntegrator::nrv", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FixedStepIntegrator::nrv1", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Fmu2_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FmuInternal::serialize_body")
    layout_FmuInternal_serialize_body(r, record, scope)
    version(r, record, "Fmu2", 2)
    field(r, record, "Fmu2::vr_real", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu2::vr_integer", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu2::vr_boolean", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu2::vr_string", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu2::init_real", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "Fmu2::init_integer", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "Fmu2::init_boolean", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "Fmu2::init_string", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu2::vn_aux_real", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu2::vn_aux_integer", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu2::vn_aux_boolean", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu2::vn_aux_string", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu2::vr_aux_real", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu2::vr_aux_integer", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu2::vr_aux_boolean", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu2::vr_aux_string", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    r.depth -= 1
end

function layout_Fmu3_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FmuInternal::serialize_body")
    layout_FmuInternal_serialize_body(r, record, scope)
    version(r, record, "Fmu3", 1)
    field(r, record, "Fmu3::vr_real", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu3::vr_integer", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu3::vr_boolean", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu3::vr_string", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu3::init_real", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "Fmu3::init_integer", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "Fmu3::init_boolean", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "Fmu3::init_string", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu3::vn_aux_real", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu3::vn_aux_integer", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu3::vn_aux_boolean", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu3::vn_aux_string", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Fmu3::vr_aux_real", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu3::vr_aux_integer", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu3::vr_aux_boolean", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "Fmu3::vr_aux_string", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    r.depth -= 1
end

function layout_Fmu_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_FmuFunction_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "FmuFunction", 6)
    field(r, record, "FmuFunction::Fmu", "Fmu", () -> read_Fmu(r))
    for _ in 1:count(r, length(scope["FunctionInternal::sp_in"]))
        field(r, record, "FmuFunction::in::type", "int", () -> number(r, "int"))
        field(r, record, "FmuFunction::in::ind", "size_t", () -> number(r, "size_t"))
    end
    for _ in 1:count(r, length(scope["FunctionInternal::sp_out"]))
        field(r, record, "FmuFunction::out::type", "int", () -> number(r, "int"))
        field(r, record, "FmuFunction::out::ind", "size_t", () -> number(r, "size_t"))
        field(r, record, "FmuFunction::out::wrt", "size_t", () -> number(r, "size_t"))
        field(r, record, "FmuFunction::out::rbegin", "size_t", () -> number(r, "size_t"))
        field(r, record, "FmuFunction::out::rend", "size_t", () -> number(r, "size_t"))
        field(r, record, "FmuFunction::out::cbegin", "size_t", () -> number(r, "size_t"))
        field(r, record, "FmuFunction::out::cend", "size_t", () -> number(r, "size_t"))
    end
    field(r, record, "FmuFunction::jac_in", "std::vector<size_t>", () -> read_std_vector_size_t(r))
    field(r, record, "FmuFunction::jac_out", "std::vector<size_t>", () -> read_std_vector_size_t(r))
    field(r, record, "FmuFunction::jac_nom_in", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "FmuFunction::sp_trans", "std::vector<Sparsity>", () -> read_std_vector_Sparsity(r))
    field(r, record, "FmuFunction::sp_trans_map", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FmuFunction::has_jac", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::has_fwd", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::has_adj", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::has_hess", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::uses_directional_derivatives", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::uses_adjoint_derivatives", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::nfwd", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FmuFunction::nadj", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FmuFunction::validate_forward", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::validate_hessian", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::make_symmetric", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::step", "double", () -> number(r, "double"))
    field(r, record, "FmuFunction::fd_flip", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::abstol", "double", () -> number(r, "double"))
    field(r, record, "FmuFunction::reltol", "double", () -> number(r, "double"))
    field(r, record, "FmuFunction::print_progress", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::new_jacobian", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::new_forward", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::new_hessian", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::hessian_coloring", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::asymmetric_hessian_coloring", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::enable_forward_jacobian", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::enable_adjoint_jacobian", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::enable_adjoint_hessian", "bool", () -> boolvalue(r))
    field(r, record, "FmuFunction::validate_ad_file", "std::string", () -> stringvalue(r))
    field(r, record, "FmuFunction::fd", "int", () -> number(r, "int"))
    field(r, record, "FmuFunction::parallelization", "int", () -> number(r, "int"))
    field(r, record, "FmuFunction::init_stats", "Dict", () -> read_Dict(r))
    field(r, record, "FmuFunction::jac_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuFunction::hess_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuFunction::adj_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuFunction::jac_colors", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuFunction::adj_colors", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuFunction::hess_colors", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuFunction::hess_uni_colors", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuFunction::which_hess_color", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FmuFunction::nonlin", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "FmuFunction::max_jac_tasks", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FmuFunction::max_hess_tasks", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FmuFunction::max_n_tasks", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_FmuInternal_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_FmuInternal_serialize_body(r, record, scope)
    enter_layout(r)
    version(r, record, "FmuInternal", 4)
    field(r, record, "FmuInternal::name", "std::string", () -> stringvalue(r))
    field(r, record, "FmuInternal::scheme_in", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "FmuInternal::scheme_out", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "FmuInternal::scheme", "std::map<std::string,std::vector<size_t>>", () -> read_std_map_std_string_std_vector_size_t(r))
    field(r, record, "FmuInternal::aux", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "FmuInternal::iind", "std::vector<size_t>", () -> read_std_vector_size_t(r))
    field(r, record, "FmuInternal::iind_map", "std::vector<size_t>", () -> read_std_vector_size_t(r))
    field(r, record, "FmuInternal::oind", "std::vector<size_t>", () -> read_std_vector_size_t(r))
    field(r, record, "FmuInternal::oind_map", "std::vector<size_t>", () -> read_std_vector_size_t(r))
    field(r, record, "FmuInternal::has_independent", "bool", () -> boolvalue(r))
    field(r, record, "FmuInternal::nominal_in", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "FmuInternal::nominal_out", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "FmuInternal::min_in", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "FmuInternal::min_out", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "FmuInternal::max_in", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "FmuInternal::max_out", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "FmuInternal::vn_in", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "FmuInternal::vn_out", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "FmuInternal::vr_in", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "FmuInternal::vr_out", "std::vector<unsignedint>", () -> read_std_vector_unsignedint(r))
    field(r, record, "FmuInternal::value_in", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "FmuInternal::ired", "std::vector<std::vector<size_t>>", () -> read_std_vector_std_vector_size_t(r))
    field(r, record, "FmuInternal::ored", "std::vector<std::vector<size_t>>", () -> read_std_vector_std_vector_size_t(r))
    field(r, record, "FmuInternal::jac_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuInternal::hess_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "FmuInternal::resource", "Resource", () -> read_Resource(r))
    field(r, record, "FmuInternal::fmutol", "double", () -> number(r, "double"))
    field(r, record, "FmuInternal::instance_name", "std::string", () -> stringvalue(r))
    field(r, record, "FmuInternal::instantiation_token", "std::string", () -> stringvalue(r))
    field(r, record, "FmuInternal::logging_on", "bool", () -> boolvalue(r))
    field(r, record, "FmuInternal::number_of_event_indicators", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FmuInternal::provides_directional_derivatives", "bool", () -> boolvalue(r))
    field(r, record, "FmuInternal::provides_adjoint_derivatives", "bool", () -> boolvalue(r))
    field(r, record, "FmuInternal::can_be_instantiated_only_once_per_process", "bool", () -> boolvalue(r))
    field(r, record, "FmuInternal::start_time", "double", () -> number(r, "double"))
    field(r, record, "FmuInternal::nx", "size_t", () -> number(r, "size_t"))
    field(r, record, "FmuInternal::do_evaluation_dance", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_FmuInternal_serialize_type(r, record, scope)
    enter_layout(r)
    scope["FmuInternal::type"] = field(r, record, "FmuInternal::type", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_ForwardDiff_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FiniteDiff::serialize_body")
    layout_FiniteDiff_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Function_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "Predicate has no serialized field")
    r.depth -= 1
end

function layout_FunctionInternal_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "ProtoFunction::serialize_body")
    layout_ProtoFunction_serialize_body(r, record, scope)
    version(r, record, "FunctionInternal", 8)
    field(r, record, "FunctionInternal::is_diff_in", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "FunctionInternal::is_diff_out", "std::vector<bool>", () -> read_std_vector_bool(r))
    scope["FunctionInternal::sp_in"] = field(r, record, "FunctionInternal::sp_in", "std::vector<Sparsity>", () -> read_std_vector_Sparsity(r))
    scope["FunctionInternal::sp_out"] = field(r, record, "FunctionInternal::sp_out", "std::vector<Sparsity>", () -> read_std_vector_Sparsity(r))
    field(r, record, "FunctionInternal::name_in", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "FunctionInternal::name_out", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    scope["FunctionInternal::jit"] = field(r, record, "FunctionInternal::jit", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::jit_cleanup", "bool", () -> boolvalue(r))
    scope["FunctionInternal::jit_serialize"] = field(r, record, "FunctionInternal::jit_serialize", "std::string", () -> stringvalue(r))
    if truth((truth((scope["FunctionInternal::jit_serialize"] == "link")) || truth((scope["FunctionInternal::jit_serialize"] == "embed"))))
        field(r, record, "FunctionInternal::jit_library", "std::string", () -> stringvalue(r))
        if truth((scope["FunctionInternal::jit_serialize"] == "embed"))
            field(r, record, "FunctionInternal::jit_binary", "std::stringstream", () -> streamvalue(r))
        end
    end
    field(r, record, "FunctionInternal::jit_temp_suffix", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::jit_base_name", "std::string", () -> stringvalue(r))
    field(r, record, "FunctionInternal::jit_options", "Dict", () -> read_Dict(r))
    field(r, record, "FunctionInternal::compiler_plugin", "std::string", () -> stringvalue(r))
    field(r, record, "FunctionInternal::has_refcount", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::cache_init", "Dict", () -> read_Dict(r))
    field(r, record, "FunctionInternal::derivative_of", "Function", () -> read_Function(r))
    field(r, record, "FunctionInternal::jac_penalty", "double", () -> number(r, "double"))
    field(r, record, "FunctionInternal::enable_forward", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::enable_reverse", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::enable_jacobian", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::enable_fd", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::enable_forward_op", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::enable_reverse_op", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::enable_jacobian_op", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::enable_fd_op", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::ad_weight", "double", () -> number(r, "double"))
    field(r, record, "FunctionInternal::ad_weight_sp", "double", () -> number(r, "double"))
    field(r, record, "FunctionInternal::always_inline", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::never_inline", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::max_num_dir", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FunctionInternal::inputs_check", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::fd_step", "double", () -> number(r, "double"))
    field(r, record, "FunctionInternal::fd_method", "std::string", () -> stringvalue(r))
    field(r, record, "FunctionInternal::print_in", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::print_out", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::print_canonical", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::max_io", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "FunctionInternal::dump_in", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::dump_out", "bool", () -> boolvalue(r))
    field(r, record, "FunctionInternal::dump_dir", "std::string", () -> stringvalue(r))
    field(r, record, "FunctionInternal::dump_format", "std::string", () -> stringvalue(r))
    field(r, record, "FunctionInternal::forward_options", "Dict", () -> read_Dict(r))
    field(r, record, "FunctionInternal::reverse_options", "Dict", () -> read_Dict(r))
    field(r, record, "FunctionInternal::jacobian_options", "Dict", () -> read_Dict(r))
    field(r, record, "FunctionInternal::der_options", "Dict", () -> read_Dict(r))
    field(r, record, "FunctionInternal::custom_jacobian", "Function", () -> read_Function(r))
    field(r, record, "FunctionInternal::registered_functions", "std::vector<Function>", () -> read_std_vector_Function(r))
    field(r, record, "FunctionInternal::sz_arg_per", "size_t", () -> number(r, "size_t"))
    field(r, record, "FunctionInternal::sz_res_per", "size_t", () -> number(r, "size_t"))
    field(r, record, "FunctionInternal::sz_iw_per", "size_t", () -> number(r, "size_t"))
    field(r, record, "FunctionInternal::sz_w_per", "size_t", () -> number(r, "size_t"))
    field(r, record, "FunctionInternal::sz_arg_tmp", "size_t", () -> number(r, "size_t"))
    field(r, record, "FunctionInternal::sz_res_tmp", "size_t", () -> number(r, "size_t"))
    field(r, record, "FunctionInternal::sz_iw_tmp", "size_t", () -> number(r, "size_t"))
    field(r, record, "FunctionInternal::sz_w_tmp", "size_t", () -> number(r, "size_t"))
    r.depth -= 1
end

function layout_FunctionInternal_serialize_type(r, record, scope)
    enter_layout(r)
    scope["FunctionInternal::base_function"] = field(r, record, "FunctionInternal::base_function", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_GenericExternal_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_type")
    layout_FunctionInternal_serialize_type(r, record, scope)
    version(r, record, "GenericExternal", 1)
    scope["GenericExternal::type"] = field(r, record, "GenericExternal::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_GenericType_serialize(r, record, scope)
    enter_layout(r)
    scope["GenericType::type"] = field(r, record, "GenericType::type", "int", () -> number(r, "int"))
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_GetNonzeros_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_GetNonzeros_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_GetNonzerosParam_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_GetNonzerosParam_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_GetNonzerosParamParam_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzerosParam::serialize_body")
    layout_GetNonzerosParam_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_GetNonzerosParamParam_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzerosParam::serialize_type")
    layout_GetNonzerosParam_serialize_type(r, record, scope)
    scope["GetNonzerosParam::type"] = field(r, record, "GetNonzerosParam::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_GetNonzerosParamSlice_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzerosParam::serialize_body")
    layout_GetNonzerosParam_serialize_body(r, record, scope)
    field(r, record, "GetNonzerosParamSlice::outer", "Slice", () -> read_Slice(r))
    r.depth -= 1
end

function layout_GetNonzerosParamSlice_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzerosParam::serialize_type")
    layout_GetNonzerosParam_serialize_type(r, record, scope)
    scope["GetNonzerosParam::type"] = field(r, record, "GetNonzerosParam::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_GetNonzerosParamVector_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzerosParam::serialize_body")
    layout_GetNonzerosParam_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_GetNonzerosParamVector_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzerosParam::serialize_type")
    layout_GetNonzerosParam_serialize_type(r, record, scope)
    scope["GetNonzerosParam::type"] = field(r, record, "GetNonzerosParam::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_GetNonzerosSlice2_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzeros::serialize_body")
    layout_GetNonzeros_serialize_body(r, record, scope)
    field(r, record, "GetNonzerosSlice2::inner", "Slice", () -> read_Slice(r))
    field(r, record, "GetNonzerosSlice2::outer", "Slice", () -> read_Slice(r))
    r.depth -= 1
end

function layout_GetNonzerosSlice2_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzeros::serialize_type")
    layout_GetNonzeros_serialize_type(r, record, scope)
    scope["GetNonzeros::type"] = field(r, record, "GetNonzeros::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_GetNonzerosSlice_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzeros::serialize_body")
    layout_GetNonzeros_serialize_body(r, record, scope)
    field(r, record, "GetNonzerosSlice::slice", "Slice", () -> read_Slice(r))
    r.depth -= 1
end

function layout_GetNonzerosSlice_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzeros::serialize_type")
    layout_GetNonzeros_serialize_type(r, record, scope)
    scope["GetNonzeros::type"] = field(r, record, "GetNonzeros::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_GetNonzerosSliceParam_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzerosParam::serialize_body")
    layout_GetNonzerosParam_serialize_body(r, record, scope)
    field(r, record, "GetNonzerosSliceParam::inner", "Slice", () -> read_Slice(r))
    r.depth -= 1
end

function layout_GetNonzerosSliceParam_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzerosParam::serialize_type")
    layout_GetNonzerosParam_serialize_type(r, record, scope)
    scope["GetNonzerosParam::type"] = field(r, record, "GetNonzerosParam::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_GetNonzerosVector_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzeros::serialize_body")
    layout_GetNonzeros_serialize_body(r, record, scope)
    field(r, record, "GetNonzerosVector::nonzeros", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_GetNonzerosVector_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "GetNonzeros::serialize_type")
    layout_GetNonzeros_serialize_type(r, record, scope)
    scope["GetNonzeros::type"] = field(r, record, "GetNonzeros::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_GurobiInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "GurobiInterface", 2)
    field(r, record, "GurobiInterface::lazy_constraints_callback", "Function", () -> read_Function(r))
    field(r, record, "GurobiInterface::vtype", "std::vector<char>", () -> read_std_vector_char(r))
    field(r, record, "GurobiInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "GurobiInterface::sos_weights", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "GurobiInterface::sos_beg", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "GurobiInterface::sos_ind", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "GurobiInterface::sos_types", "std::vector<int>", () -> read_std_vector_int(r))
    push!(record["layouts"], "Conic::serialize")
    layout_Conic_serialize(r, record, scope)
    r.depth -= 1
end

function layout_HighsInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "HighsInterface", 1)
    field(r, record, "HighsInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_HorzRepmat_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "HorzRepmat::n", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_HorzRepsum_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "HorzRepsum::n", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Horzcat_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Concat::serialize_body")
    layout_Concat_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Horzsplit_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Split::serialize_body")
    layout_Split_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_HpipmInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "HpipmInterface", 1)
    r.depth -= 1
end

function layout_HpmpcInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_IOInstruction_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "IOInstruction::ind", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "IOInstruction::segment", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "IOInstruction::offset", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_IdasInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "SundialsInterface::serialize_body")
    layout_SundialsInterface_serialize_body(r, record, scope)
    version(r, record, "IdasInterface", 2)
    field(r, record, "IdasInterface::cj_scaling", "bool", () -> boolvalue(r))
    field(r, record, "IdasInterface::calc_ic", "bool", () -> boolvalue(r))
    field(r, record, "IdasInterface::calc_icB", "bool", () -> boolvalue(r))
    field(r, record, "IdasInterface::suppress_algebraic", "bool", () -> boolvalue(r))
    field(r, record, "IdasInterface::abstolv", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "IdasInterface::first_time", "double", () -> number(r, "double"))
    field(r, record, "IdasInterface::init_xdot", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "IdasInterface::max_step_size", "double", () -> number(r, "double"))
    field(r, record, "IdasInterface::y_c", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_ImplicitFixedStepIntegrator_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FixedStepIntegrator::serialize_body")
    layout_FixedStepIntegrator_serialize_body(r, record, scope)
    version(r, record, "ImplicitFixedStepIntegrator", 2)
    r.depth -= 1
end

function layout_ImplicitToNlp_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Rootfinder::serialize_body")
    layout_Rootfinder_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Importer_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_ImporterInternal_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_ImporterInternal_serialize_body(r, record, scope)
    enter_layout(r)
    version(r, record, "ImporterInternal", 1)
    field(r, record, "ImporterInternal::name", "std::string", () -> stringvalue(r))
    field(r, record, "ImporterInternal::meta", "std::map<std::string,std::pair<casadi_int,std::string>>", () -> read_std_map_std_string_std_pair_casadi_int_std_string(r))
    field(r, record, "ImporterInternal::external", "std::map<std::string,std::pair<bool,std::string>>", () -> read_std_map_std_string_std_pair_bool_std_string(r))
    r.depth -= 1
end

function layout_ImporterInternal_serialize_type(r, record, scope)
    enter_layout(r)
    scope["ImporterInternal::type"] = field(r, record, "ImporterInternal::type", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_InfSX_serialize_node(r, record, scope)
    enter_layout(r)
    scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_Input_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "IOInstruction::serialize_body")
    layout_IOInstruction_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_IntegerSX_serialize_node(r, record, scope)
    enter_layout(r)
    scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
    field(r, record, "ConstantSX::value", "int", () -> number(r, "int"))
    r.depth -= 1
end

function layout_Integrator_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "OracleFunction::serialize_body")
    layout_OracleFunction_serialize_body(r, record, scope)
    version(r, record, "Integrator", 3)
    field(r, record, "Integrator::sp_jac_dae", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Integrator::sp_jac_rdae", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Integrator::t0", "double", () -> number(r, "double"))
    field(r, record, "Integrator::tout", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "Integrator::nfwd", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nadj", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::rdae", "Function", () -> read_Function(r))
    field(r, record, "Integrator::nx", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nz", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nq", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nx1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nz1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nq1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nrx", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nrz", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nrq", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nuq", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nrx1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nrz1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nrq1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nuq1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::np", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nrp", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::np1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nrp1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nu", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nu1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::ne", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::ntmp", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::nom_x", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "Integrator::nom_z", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "Integrator::augmented_options", "Dict", () -> read_Dict(r))
    field(r, record, "Integrator::opts", "Dict", () -> read_Dict(r))
    field(r, record, "Integrator::print_stats", "bool", () -> boolvalue(r))
    field(r, record, "Integrator::transition", "Function", () -> read_Function(r))
    field(r, record, "Integrator::max_event_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::max_events", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Integrator::event_tol", "double", () -> number(r, "double"))
    field(r, record, "Integrator::event_acceptable_tol", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_Integrator_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "OracleFunction::serialize_type")
    layout_OracleFunction_serialize_type(r, record, scope)
    push!(record["layouts"], "PluginInterface<Integrator>::serialize_type")
    layout_PluginInterface_Integrator_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_Interpolant_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "Interpolant", 2)
    field(r, record, "Interpolant::ndim", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Interpolant::m", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Interpolant::grid", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "Interpolant::offset", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Interpolant::values", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "Interpolant::lookup_modes", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "Interpolant::batch_x", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Interpolant_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_type")
    layout_FunctionInternal_serialize_type(r, record, scope)
    push!(record["layouts"], "PluginInterface<Interpolant>::serialize_type")
    layout_PluginInterface_Interpolant_serialize_type_2(r, record, scope)
    r.depth -= 1
end

function layout_Inverse_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_IpoptInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "IpoptInterface", 3)
    field(r, record, "IpoptInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "IpoptInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "IpoptInterface::exact_hessian", "bool", () -> boolvalue(r))
    field(r, record, "IpoptInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "IpoptInterface::pass_nonlinear_variables", "bool", () -> boolvalue(r))
    field(r, record, "IpoptInterface::nl_ex", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "IpoptInterface::var_string_md", "Dict", () -> read_Dict(r))
    field(r, record, "IpoptInterface::var_integer_md", "Dict", () -> read_Dict(r))
    field(r, record, "IpoptInterface::var_numeric_md", "Dict", () -> read_Dict(r))
    field(r, record, "IpoptInterface::con_string_md", "Dict", () -> read_Dict(r))
    field(r, record, "IpoptInterface::con_integer_md", "Dict", () -> read_Dict(r))
    field(r, record, "IpoptInterface::con_numeric_md", "Dict", () -> read_Dict(r))
    scope["IpoptInterface::convexify"] = field(r, record, "IpoptInterface::convexify", "bool", () -> boolvalue(r))
    if truth(scope["IpoptInterface::convexify"])
        push!(record["layouts"], "Convexify::serialize")
        scope["prefix"] = "IpoptInterface::"
        layout_Convexify_serialize(r, record, scope)
    end
    field(r, record, "IpoptInterface::clip_inactive_lam", "bool", () -> boolvalue(r))
    field(r, record, "IpoptInterface::inactive_lam_strategy", "std::string", () -> stringvalue(r))
    field(r, record, "IpoptInterface::inactive_lam_value", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_Ipqp_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "Ipqp", 1)
    field(r, record, "Ipqp::kkt", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Ipqp::print_iter", "bool", () -> boolvalue(r))
    field(r, record, "Ipqp::print_header", "bool", () -> boolvalue(r))
    field(r, record, "Ipqp::print_info", "bool", () -> boolvalue(r))
    field(r, record, "Ipqp::linear_solver", "std::string", () -> stringvalue(r))
    field(r, record, "Ipqp::linear_solver_options", "Dict", () -> read_Dict(r))
    field(r, record, "Ipqp::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Ipqp::pr_tol", "double", () -> number(r, "double"))
    field(r, record, "Ipqp::du_tol", "double", () -> number(r, "double"))
    field(r, record, "Ipqp::co_tol", "double", () -> number(r, "double"))
    field(r, record, "Ipqp::mu_tol", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_KinsolInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Rootfinder::serialize_body")
    layout_Rootfinder_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_KnitroInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "KnitroInterface", 2)
    field(r, record, "KnitroInterface::contype", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "KnitroInterface::comp_type", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "KnitroInterface::comp_i1", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "KnitroInterface::comp_i2", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "KnitroInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "KnitroInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "KnitroInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "KnitroInterface::options_file", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_Kron_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Kron_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Kron::kind"] = field(r, record, "Kron::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_KronContract_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "KronContract::inner", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_KronContract_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["KronContract::kind"] = field(r, record, "KronContract::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_LapackLu_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    version(r, record, "LapackLu", 1)
    field(r, record, "LapackLu::equilibriate", "bool", () -> boolvalue(r))
    field(r, record, "LapackLu::allow_equilibration_failure", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_LapackQr_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    field(r, record, "LapackQr::max_nrhs", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_LinearInterpolant_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Interpolant::serialize_body")
    layout_Interpolant_serialize_body(r, record, scope)
    field(r, record, "LinearInterpolant::lookup_mode", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_LinearInterpolant_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Interpolant::serialize_type")
    layout_Interpolant_serialize_type(r, record, scope)
    version(r, record, "LinearInterpolant", 1)
    scope["LinearInterpolant::type"] = field(r, record, "LinearInterpolant::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_LinearInterpolantJac_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_LinearInterpolantJac_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_type")
    layout_FunctionInternal_serialize_type(r, record, scope)
    push!(record["layouts"], ">PluginInterface<Interpolant>::serialize_type")
    layout_PluginInterface_Interpolant_serialize_type(r, record, scope)
    version(r, record, "LinearInterpolant", 1)
    scope["LinearInterpolant::type"] = field(r, record, "LinearInterpolant::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_Linsol_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_LinsolCall_Tr_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Solve<Tr>::serialize_body")
    layout_Solve_Tr_serialize_body(r, record, scope)
    field(r, record, "Solve::Linsol", "Linsol", () -> read_Linsol(r))
    r.depth -= 1
end

function layout_LinsolCall_Tr_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Solve<Tr>::serialize_type")
    layout_Solve_Tr_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_LinsolInternal_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "ProtoFunction::serialize_body")
    layout_ProtoFunction_serialize_body(r, record, scope)
    field(r, record, "LinsolInternal::sp", "Sparsity", () -> read_Sparsity(r))
    r.depth -= 1
end

function layout_LinsolInternal_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "ProtoFunction::serialize_type")
    layout_ProtoFunction_serialize_type(r, record, scope)
    push!(record["layouts"], "PluginInterface<LinsolInternal>::serialize_type")
    layout_PluginInterface_LinsolInternal_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_LinsolLdl_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    version(r, record, "LinsolLdl", 1)
    field(r, record, "LinsolLdl::p", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "LinsolLdl::sp_Lt", "Sparsity", () -> read_Sparsity(r))
    r.depth -= 1
end

function layout_LinsolQr_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    version(r, record, "LinsolQr", 2)
    field(r, record, "LinsolQr::prinv", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "LinsolQr::pc", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "LinsolQr::sp_v", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "LinsolQr::sp_r", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "LinsolQr::eps", "double", () -> number(r, "double"))
    field(r, record, "LinsolQr::n_cache", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_LinsolTridiag_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_LogSumExp_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Low_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "Low::lookup_mode", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Lsqr_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_MMax_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_MMin_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_MX_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_MXFunction_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "XFunction<MXFunction,MX,MXNode>::serialize_body")
    layout_XFunction_MXFunction_MX_MXNode_serialize_body(r, record, scope)
    version(r, record, "MXFunction", 3)
    scope["MXFunction::n_instr"] = field(r, record, "MXFunction::n_instr", "size_t", () -> number(r, "size_t"))
    for _ in 1:count(r, scope["MXFunction::n_instr"])
        field(r, record, "MXFunction::alg::data", "MX", () -> read_MX(r))
        field(r, record, "MXFunction::alg::arg", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
        field(r, record, "MXFunction::alg::res", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    end
    field(r, record, "MXFunction::workloc", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "MXFunction::free_vars", "std::vector<MX>", () -> read_std_vector_MX(r))
    field(r, record, "MXFunction::default_in", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "MXFunction::live_variables", "bool", () -> boolvalue(r))
    field(r, record, "MXFunction::print_instructions", "bool", () -> boolvalue(r))
    field(r, record, "MXFunction::dump_trace", "bool", () -> boolvalue(r))
    push!(record["layouts"], "XFunction<MXFunction,MX,MXNode>::delayed_serialize_members")
    layout_XFunction_MXFunction_MX_MXNode_delayed_serialize_members(r, record, scope)
    r.depth -= 1
end

function layout_MXNode_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_MXNode_serialize_body(r, record, scope)
    enter_layout(r)
    field(r, record, "MXNode::deps", "std::vector<MX>", () -> read_std_vector_MX(r))
    field(r, record, "MXNode::sp", "Sparsity", () -> read_Sparsity(r))
    r.depth -= 1
end

function layout_MXNode_serialize_type(r, record, scope)
    enter_layout(r)
    scope["MXNode::op"] = field(r, record, "MXNode::op", "int", () -> number(r, "int"))
    r.depth -= 1
end

function layout_Ma27Interface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_MadmpecInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "MadmpecInterface", 1)
    field(r, record, "MadmpecInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "MadmpecInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "MadmpecInterface::exact_hessian", "bool", () -> boolvalue(r))
    field(r, record, "MadmpecInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "MadmpecInterface::convexify", "bool", () -> boolvalue(r))
    field(r, record, "MadmpecInterface::ind_cc1", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "MadmpecInterface::ind_cc2", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "MadmpecInterface::cctypes", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_MadnlpInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "MadnlpInterface", 2)
    field(r, record, "MadnlpInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "MadnlpInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "MadnlpInterface::exact_hessian", "bool", () -> boolvalue(r))
    field(r, record, "MadnlpInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "MadnlpInterface::convexify", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_Map_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    field(r, record, "Map::f", "Function", () -> read_Function(r))
    field(r, record, "Map::n", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Map_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_type")
    layout_FunctionInternal_serialize_type(r, record, scope)
    scope["Map::class_name"] = field(r, record, "Map::class_name", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_MapSum_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    field(r, record, "MapSum::f", "Function", () -> read_Function(r))
    field(r, record, "MapSum::n", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "MapSum::reduce_in", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "MapSum::reduce_out", "std::vector<bool>", () -> read_std_vector_bool(r))
    r.depth -= 1
end

function layout_MapSum_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_type")
    layout_FunctionInternal_serialize_type(r, record, scope)
    scope["MapSum::class_name"] = field(r, record, "MapSum::class_name", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_Matrix_SXElem_serialize(r, record, scope)
    enter_layout(r)
    field(r, record, "Matrix::sparsity", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Matrix::nonzeros", "std::vector<SXElem>", () -> read_std_vector_SXElem(r))
    r.depth -= 1
end

function layout_Matrix_casadi_int_serialize(r, record, scope)
    enter_layout(r)
    field(r, record, "Matrix::sparsity", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Matrix::nonzeros", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_Matrix_double_serialize(r, record, scope)
    enter_layout(r)
    field(r, record, "Matrix::sparsity", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Matrix::nonzeros", "std::vector<double>", () -> read_std_vector_double(r))
    r.depth -= 1
end

function layout_MinusInfSX_serialize_node(r, record, scope)
    enter_layout(r)
    scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_MinusOneSX_serialize_node(r, record, scope)
    enter_layout(r)
    scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_Monitor_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "Monitor::comment", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_MosekInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "MosekInterface", 1)
    field(r, record, "MosekInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_MultipleOutput_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Multiplication_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "Multiplication::blas", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_Multiplication_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Multiplication::kind"] = field(r, record, "Multiplication::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_MumpsInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    version(r, record, "Mumps", 1)
    field(r, record, "MumpsInterface::symmetric", "bool", () -> boolvalue(r))
    field(r, record, "MumpsInterface::posdef", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_NanSX_serialize_node(r, record, scope)
    enter_layout(r)
    scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_Newton_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Rootfinder::serialize_body")
    layout_Rootfinder_serialize_body(r, record, scope)
    version(r, record, "Newton", 1)
    field(r, record, "Newton::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Newton::abstol", "double", () -> number(r, "double"))
    field(r, record, "Newton::abstolStep", "double", () -> number(r, "double"))
    field(r, record, "Newton::print_iteration", "bool", () -> boolvalue(r))
    field(r, record, "Newton::line_search", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_Nlpsol_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "OracleFunction::serialize_body")
    layout_OracleFunction_serialize_body(r, record, scope)
    version(r, record, "Nlpsol", 5)
    field(r, record, "Nlpsol::nx", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Nlpsol::ng", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Nlpsol::np", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Nlpsol::fcallback", "Function", () -> read_Function(r))
    field(r, record, "Nlpsol::callback_step", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Nlpsol::eval_errors_fatal", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::warn_initial_bounds", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::iteration_callback_ignore_errors", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::calc_multipliers", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::calc_lam_x", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::calc_lam_p", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::calc_f", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::calc_g", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::min_lam", "double", () -> number(r, "double"))
    field(r, record, "Nlpsol::bound_consistency", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::no_nlp_grad", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::discrete", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "Nlpsol::equality", "std::vector<bool>", () -> read_std_vector_bool(r))
    field(r, record, "Nlpsol::mi", "bool", () -> boolvalue(r))
    field(r, record, "Nlpsol::sens_linsol", "std::string", () -> stringvalue(r))
    field(r, record, "Nlpsol::sens_linsol_options", "Dict", () -> read_Dict(r))
    field(r, record, "Nlpsol::detect_simple_bounds_is_simple", "std::vector<char>", () -> read_std_vector_char(r))
    field(r, record, "Nlpsol::detect_simple_bounds_parts", "Function", () -> read_Function(r))
    field(r, record, "Nlpsol::detect_simple_bounds_target_x", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_Nlpsol_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "OracleFunction::serialize_type")
    layout_OracleFunction_serialize_type(r, record, scope)
    push!(record["layouts"], "PluginInterface<Nlpsol>::serialize_type")
    layout_PluginInterface_Nlpsol_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_Norm1_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Norm::serialize_body")
    layout_Norm_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Norm2_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Norm::serialize_body")
    layout_Norm_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Norm_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_NormF_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Norm::serialize_body")
    layout_Norm_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_NormInf_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Norm::serialize_body")
    layout_Norm_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_OmpMap_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Map::serialize_body")
    layout_Map_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_OneSX_serialize_node(r, record, scope)
    enter_layout(r)
    scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_OnnxFunction_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "OnnxFunction", 2)
    field(r, record, "OnnxFunction::model_data", "std::string", () -> stringvalue(r))
    push!(record["layouts"], "pack_tensors")
    scope["d"] = "OnnxFunction::in"
    layout_pack_tensors(r, record, scope)
    push!(record["layouts"], "pack_tensors")
    scope["d"] = "OnnxFunction::out"
    layout_pack_tensors(r, record, scope)
    push!(record["layouts"], "pack_tensors")
    scope["d"] = "OnnxFunction::all_in"
    layout_pack_tensors(r, record, scope)
    field(r, record, "OnnxFunction::in_src", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "OnnxFunction::in_val", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "OnnxFunction::model_inputs", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "OnnxFunction::model_outputs", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "OnnxFunction::fwd_dim", "std::string", () -> stringvalue(r))
    field(r, record, "OnnxFunction::adj_dim", "std::string", () -> stringvalue(r))
    field(r, record, "OnnxFunction::input_values", "std::map<std::string,std::vector<double>>", () -> read_std_map_std_string_std_vector_double(r))
    field(r, record, "OnnxFunction::model_path", "std::string", () -> stringvalue(r))
    field(r, record, "OnnxFunction::dim_bindings", "std::map<std::string,casadi_int>", () -> read_std_map_std_string_casadi_int(r))
    field(r, record, "OnnxFunction::input_shapes", "std::map<std::string,std::vector<casadi_int>>", () -> read_std_map_std_string_std_vector_casadi_int(r))
    field(r, record, "OnnxFunction::derivative_opts", "Dict", () -> read_Dict(r))
    field(r, record, "OnnxFunction::builder_opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_OnnxFunction_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_type")
    layout_FunctionInternal_serialize_type(r, record, scope)
    push!(record["layouts"], "PluginInterface<OnnxFunction>::serialize_type")
    layout_PluginInterface_OnnxFunction_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_OnnxRuntimeInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "OnnxFunction::serialize_body")
    layout_OnnxFunction_serialize_body(r, record, scope)
    version(r, record, "OnnxRuntimeInterface", 1)
    field(r, record, "OnnxRuntimeInterface::provider", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_OoqpInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "OoqpInterface", 1)
    field(r, record, "OoqpInterface::spAT", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "OoqpInterface::nQ", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OoqpInterface::nH", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OoqpInterface::nA", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OoqpInterface::print_level", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OoqpInterface::mutol", "double", () -> number(r, "double"))
    field(r, record, "OoqpInterface::artol", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_OracleFunction_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "OracleFunction", 3)
    field(r, record, "OracleFunction::oracle", "Function", () -> read_Function(r))
    field(r, record, "OracleFunction::common_options", "Dict", () -> read_Dict(r))
    field(r, record, "OracleFunction::specific_options", "Dict", () -> read_Dict(r))
    field(r, record, "OracleFunction::show_eval_warnings", "bool", () -> boolvalue(r))
    field(r, record, "OracleFunction::max_num_threads", "int", () -> number(r, "int"))
    scope["OracleFunction::all_functions::size"] = field(r, record, "OracleFunction::all_functions::size", "size_t", () -> number(r, "size_t"))
    for _ in 1:count(r, scope["OracleFunction::all_functions::size"])
        field(r, record, "OracleFunction::all_functions::key", "std::string", () -> stringvalue(r))
        scope["OracleFunction::all_functions::value::jit"] = field(r, record, "OracleFunction::all_functions::value::jit", "bool", () -> boolvalue(r))
        if truth((truth(scope["FunctionInternal::jit"]) && truth(scope["OracleFunction::all_functions::value::jit"])))
            if truth((scope["FunctionInternal::jit_serialize"] == "source"))
                field(r, record, "OracleFunction::all_functions::value::f", "Function", () -> read_Function(r))
            else
                field(r, record, "OracleFunction::all_functions::value::f_name", "std::string", () -> stringvalue(r))
            end
        else
            field(r, record, "OracleFunction::all_functions::value::f", "Function", () -> read_Function(r))
        end
        field(r, record, "OracleFunction::all_functions::value::monitored", "bool", () -> boolvalue(r))
    end
    field(r, record, "OracleFunction::monitor", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, "OracleFunction::stride_arg", "size_t", () -> number(r, "size_t"))
    field(r, record, "OracleFunction::stride_res", "size_t", () -> number(r, "size_t"))
    field(r, record, "OracleFunction::stride_iw", "size_t", () -> number(r, "size_t"))
    field(r, record, "OracleFunction::stride_w", "size_t", () -> number(r, "size_t"))
    r.depth -= 1
end

function layout_OracleFunction_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_type")
    layout_FunctionInternal_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_OsqpInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "OsqpInterface", 2)
    field(r, record, "OsqpInterface::nnzHupp", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::nnzA", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::warm_start_primal", "bool", () -> boolvalue(r))
    field(r, record, "OsqpInterface::warm_start_dual", "bool", () -> boolvalue(r))
    field(r, record, "OsqpInterface::settings::rho", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::sigma", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::scaling", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::adaptive_rho", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::adaptive_rho_interval", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::adaptive_rho_tolerance", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::eps_abs", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::eps_rel", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::eps_prim_inf", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::eps_dual_inf", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::alpha", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::delta", "double", () -> number(r, "double"))
    field(r, record, "OsqpInterface::settings::polish", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::polish_refine_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::verbose", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::scaled_termination", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::check_termination", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::settings::warm_start", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "OsqpInterface::rho_initial", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_Output_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "IOInstruction::serialize_body")
    layout_IOInstruction_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_OutputNode_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "OutputNode::oind", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_OutputSX_serialize_node(r, record, scope)
    enter_layout(r)
    field(r, record, "OutputSX::dep", "SXElem", () -> read_SXElem(r))
    field(r, record, "OutputSX::oind", "int", () -> number(r, "int"))
    r.depth -= 1
end

function layout_PiqpInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "PiqpInterface", 1)
    field(r, record, "PiqpInterface::nnzH", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "PiqpInterface::nnzA", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "PiqpInterface::settings::rho_init", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::delta_init", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::eps_abs", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::eps_rel", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::check_duality_gap", "bool", () -> boolvalue(r))
    field(r, record, "PiqpInterface::settings::eps_duality_gap_abs", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::eps_duality_gap_rel", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::reg_lower_limit", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::reg_finetune_lower_limit", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::reg_finetune_primal_update_threshold", "size_t", () -> number(r, "size_t"))
    field(r, record, "PiqpInterface::settings::reg_finetune_dual_update_threshold", "size_t", () -> number(r, "size_t"))
    field(r, record, "PiqpInterface::settings::max_iter", "size_t", () -> number(r, "size_t"))
    field(r, record, "PiqpInterface::settings::max_factor_retires", "size_t", () -> number(r, "size_t"))
    field(r, record, "PiqpInterface::settings::preconditioner_scale_cost", "bool", () -> boolvalue(r))
    field(r, record, "PiqpInterface::settings::preconditioner_iter", "size_t", () -> number(r, "size_t"))
    field(r, record, "PiqpInterface::settings::tau", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::iterative_refinement_always_enabled", "bool", () -> boolvalue(r))
    field(r, record, "PiqpInterface::settings::iterative_refinement_eps_abs", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::iterative_refinement_eps_rel", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::iterative_refinement_max_iter", "size_t", () -> number(r, "size_t"))
    field(r, record, "PiqpInterface::settings::iterative_refinement_min_improvement_rate", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::iterative_refinement_static_regularization_eps", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::iterative_refinement_static_regularization_rel", "double", () -> number(r, "double"))
    field(r, record, "PiqpInterface::settings::verbose", "bool", () -> boolvalue(r))
    field(r, record, "PiqpInterface::settings::compute_timings", "bool", () -> boolvalue(r))
    field(r, record, "PiqpInterface::settings::kkt_solver", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_PluginInterface_serialize_type(r, record, scope)
    enter_layout(r)
    scope["PluginInterface::plugin_name"] = field(r, record, "PluginInterface::plugin_name", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_Project_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Project_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Project::type"] = field(r, record, "Project::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_ProtoFunction_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_ProtoFunction_serialize_body(r, record, scope)
    enter_layout(r)
    version(r, record, "ProtoFunction", 2)
    field(r, record, "ProtoFunction::name", "std::string", () -> stringvalue(r))
    field(r, record, "ProtoFunction::verbose", "bool", () -> boolvalue(r))
    field(r, record, "ProtoFunction::print_time", "bool", () -> boolvalue(r))
    field(r, record, "ProtoFunction::record_time", "bool", () -> boolvalue(r))
    field(r, record, "ProtoFunction::regularity_check", "bool", () -> boolvalue(r))
    field(r, record, "ProtoFunction::error_on_fail", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_ProtoFunction_serialize_type(r, record, scope)
    enter_layout(r)
    r.depth -= 1
end

function layout_ProxqpInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "ProxqpInterface", 1)
    field(r, record, "ProxqpInterface::warm_start_primal", "bool", () -> boolvalue(r))
    field(r, record, "ProxqpInterface::warm_start_dual", "bool", () -> boolvalue(r))
    field(r, record, "ProxqpInterface::settings::default_rho", "double", () -> number(r, "double"))
    field(r, record, "ProxqpInterface::settings::default_mu_eq", "double", () -> number(r, "double"))
    field(r, record, "ProxqpInterface::settings::default_mu_in", "double", () -> number(r, "double"))
    field(r, record, "ProxqpInterface::settings::eps_abs", "double", () -> number(r, "double"))
    field(r, record, "ProxqpInterface::settings::eps_rel", "double", () -> number(r, "double"))
    field(r, record, "ProxqpInterface::settings::max_iter", "double", () -> number(r, "double"))
    field(r, record, "ProxqpInterface::settings::verbose", "bool", () -> boolvalue(r))
    field(r, record, "ProxqpInterface::settings::sparse_backend", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_PseudoDenseMultiplication_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Multiplication::serialize_body")
    layout_Multiplication_serialize_body(r, record, scope)
    field(r, record, "PseudoDenseMultiplication::a", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "PseudoDenseMultiplication::b", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "PseudoDenseMultiplication::c", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_PseudoDenseMultiplication_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Multiplication::kind"] = field(r, record, "Multiplication::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_QpToNlp_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "QpToNlp", 1)
    field(r, record, "QpToNlp::solver", "Function", () -> read_Function(r))
    r.depth -= 1
end

function layout_QpoasesInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "QpoasesInterface", 1)
    field(r, record, "QpoasesInterface::max_nWSR", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "QpoasesInterface::max_cputime", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::hess", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "QpoasesInterface::sparse", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::schur", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::max_schur", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "QpoasesInterface::linsol_plugin", "std::string", () -> stringvalue(r))
    field(r, record, "QpoasesInterface::ops::printLevel", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "QpoasesInterface::ops::enableRamping", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::ops::enableFarBounds", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::ops::enableFlippingBounds", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::ops::enableRegularisation", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::ops::enableFullLITests", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::ops::enableNZCTests", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::ops::enableDriftCorrection", "int", () -> number(r, "int"))
    field(r, record, "QpoasesInterface::ops::enableCholeskyRefactorisation", "int", () -> number(r, "int"))
    field(r, record, "QpoasesInterface::ops::enableEqualities", "bool", () -> boolvalue(r))
    field(r, record, "QpoasesInterface::ops::terminationTolerance", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::boundTolerance", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::boundRelaxation", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::epsNum", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::epsDen", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::maxPrimalJump", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::maxDualJump", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::initialRamping", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::finalRamping", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::initialFarBounds", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::growFarBounds", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::initialStatusBounds", "std::string", () -> stringvalue(r))
    field(r, record, "QpoasesInterface::ops::epsFlipping", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::numRegularisationSteps", "int", () -> number(r, "int"))
    field(r, record, "QpoasesInterface::ops::epsRegularisation", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::numRefinementSteps", "int", () -> number(r, "int"))
    field(r, record, "QpoasesInterface::ops::epsIterRef", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::epsLITests", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::epsNZCTests", "double", () -> number(r, "double"))
    field(r, record, "QpoasesInterface::ops::enableInertiaCorrection", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_Qrqp_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "Qrqp", 1)
    field(r, record, "Qrqp::AT", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Qrqp::kkt", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Qrqp::sp_v", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Qrqp::sp_r", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Qrqp::prinv", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Qrqp::pc", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Qrqp::print_iter", "bool", () -> boolvalue(r))
    field(r, record, "Qrqp::print_header", "bool", () -> boolvalue(r))
    field(r, record, "Qrqp::print_info", "bool", () -> boolvalue(r))
    field(r, record, "Qrqp::print_lincomb_", "bool", () -> boolvalue(r))
    field(r, record, "Qrqp::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Qrqp::min_lam", "double", () -> number(r, "double"))
    field(r, record, "Qrqp::constr_viol_tol", "double", () -> number(r, "double"))
    field(r, record, "Qrqp::dual_inf_tol", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_Qrsqp_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Rank1_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_RealtypeSX_serialize_node(r, record, scope)
    enter_layout(r)
    scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
    field(r, record, "ConstantSX::value", "double", () -> number(r, "double"))
    r.depth -= 1
end

function layout_Reshape_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Resource_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_ResourceInternal_serialize(r, record, scope)
    enter_layout(r)
    version(r, record, "ResourceInternal", 1)
    fail(r, "unlowered serialization call")
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_ResourceInternal_serialize_body(r, record, scope)
    enter_layout(r)
    scope["ResourceInternal::serialize_mode"] = field(r, record, "ResourceInternal::serialize_mode", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_ResourceInternal_serialize_type(r, record, scope)
    enter_layout(r)
    scope["ResourceInternal::type"] = field(r, record, "ResourceInternal::type", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_Rootfinder_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "OracleFunction::serialize_body")
    layout_OracleFunction_serialize_body(r, record, scope)
    version(r, record, "Rootfinder", 3)
    field(r, record, "Rootfinder::n", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Rootfinder::linsol", "Linsol", () -> read_Linsol(r))
    field(r, record, "Rootfinder::sp_jac", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Rootfinder::u_c", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Rootfinder::iin", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Rootfinder::iout", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Rootfinder_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "OracleFunction::serialize_type")
    layout_OracleFunction_serialize_type(r, record, scope)
    push!(record["layouts"], "PluginInterface<Rootfinder>::serialize_type")
    layout_PluginInterface_Rootfinder_serialize_type(r, record, scope)
    r.depth -= 1
end

function layout_RungeKutta_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FixedStepIntegrator::serialize_body")
    layout_FixedStepIntegrator_serialize_body(r, record, scope)
    version(r, record, "RungeKutta", 2)
    r.depth -= 1
end

function layout_SLEQPInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "SLEQPInterface", 1)
    field(r, record, "SLEQPInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "SLEQPInterface::max_iter", "int", () -> number(r, "int"))
    field(r, record, "SLEQPInterface::max_wall_time", "double", () -> number(r, "double"))
    field(r, record, "SLEQPInterface::print_level", "int", () -> number(r, "int"))
    field(r, record, "SLEQPInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_SXElem_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_SXFunction_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "XFunction<SXFunction,SX,SXNode>::serialize_body")
    layout_XFunction_SXFunction_SX_SXNode_serialize_body(r, record, scope)
    version(r, record, "SXFunction", 4)
    scope["SXFunction::n_instr"] = field(r, record, "SXFunction::n_instr", "size_t", () -> number(r, "size_t"))
    field(r, record, "SXFunction::worksize", "size_t", () -> number(r, "size_t"))
    field(r, record, "SXFunction::free_vars", "std::vector<SXElem>", () -> read_std_vector_SXElem(r))
    field(r, record, "SXFunction::operations", "std::vector<SXElem>", () -> read_std_vector_SXElem(r))
    field(r, record, "SXFunction::constants", "std::vector<SXElem>", () -> read_std_vector_SXElem(r))
    field(r, record, "SXFunction::default_in", "std::vector<double>", () -> read_std_vector_double(r))
    field(r, record, "SXFunction::call_sz_arg", "size_t", () -> number(r, "size_t"))
    field(r, record, "SXFunction::call_sz_res", "size_t", () -> number(r, "size_t"))
    field(r, record, "SXFunction::call_sz_iw", "size_t", () -> number(r, "size_t"))
    field(r, record, "SXFunction::call_sz_w", "size_t", () -> number(r, "size_t"))
    field(r, record, "SXFunction::call_sz_arg", "size_t", () -> number(r, "size_t"))
    field(r, record, "SXFunction::call_sz_res", "size_t", () -> number(r, "size_t"))
    scope["SXFunction::call_el_size"] = field(r, record, "SXFunction::call_el_size", "size_t", () -> number(r, "size_t"))
    for _ in 1:count(r, scope["SXFunction::call_el_size"])
        field(r, record, "SXFunction::call_el_f", "Function", () -> read_Function(r))
        field(r, record, "SXFunction::call_el_dep", "std::vector<int>", () -> read_std_vector_int(r))
        field(r, record, "SXFunction::call_el_res", "std::vector<int>", () -> read_std_vector_int(r))
        field(r, record, "SXFunction::call_el_copy_elision_arg", "std::vector<int>", () -> read_std_vector_int(r))
        field(r, record, "SXFunction::call_el_copy_elision_offset", "std::vector<int>", () -> read_std_vector_int(r))
    end
    field(r, record, "SXFunction::copy_elision", "std::vector<bool>", () -> read_std_vector_bool(r))
    for _ in 1:count(r, scope["SXFunction::n_instr"])
        field(r, record, "SXFunction::ScalarAtomic::op", "int", () -> number(r, "int"))
        field(r, record, "SXFunction::ScalarAtomic::i0", "int", () -> number(r, "int"))
        field(r, record, "SXFunction::ScalarAtomic::i1", "int", () -> number(r, "int"))
        field(r, record, "SXFunction::ScalarAtomic::i2", "int", () -> number(r, "int"))
    end
    field(r, record, "SXFunction::live_variables", "bool", () -> boolvalue(r))
    field(r, record, "SXFunction::print_instructions", "bool", () -> boolvalue(r))
    field(r, record, "SXFunction::dump_trace", "bool", () -> boolvalue(r))
    push!(record["layouts"], "XFunction<SXFunction,SX,SXNode>::delayed_serialize_members")
    layout_XFunction_SXFunction_SX_SXNode_delayed_serialize_members(r, record, scope)
    r.depth -= 1
end

function layout_SXNode_serialize(r, record, scope)
    enter_layout(r)
    scope["SXNode::op"] = field(r, record, "SXNode::op", "casadi_int", () -> number(r, "casadi_int"))
    fail(r, "unlowered serialization call")
    r.depth -= 1
end

function layout_Scpgen_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_SetNonzerosParam_Add_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "SetNonzerosParam<Add>::serialize_body")
    layout_SetNonzerosParam_Add_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_SetNonzerosParamParam_Add_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["SetNonzerosParam::type"] = field(r, record, "SetNonzerosParam::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "SetNonzerosParamSlice::outer", "Slice", () -> read_Slice(r))
    r.depth -= 1
end

function layout_SetNonzerosParamSlice_Add_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["SetNonzerosParam::type"] = field(r, record, "SetNonzerosParam::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_SetNonzerosParamVector_Add_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["SetNonzerosParam::type"] = field(r, record, "SetNonzerosParam::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "SetNonzerosSlice2::inner", "Slice", () -> read_Slice(r))
    field(r, record, "SetNonzerosSlice2::outer", "Slice", () -> read_Slice(r))
    r.depth -= 1
end

function layout_SetNonzerosSlice2_Add_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["SetNonzeros::type"] = field(r, record, "SetNonzeros::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_SetNonzerosSlice_Add_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "SetNonzerosSlice::slice", "Slice", () -> read_Slice(r))
    r.depth -= 1
end

function layout_SetNonzerosSlice_Add_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["SetNonzeros::type"] = field(r, record, "SetNonzeros::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "SetNonzerosSliceParam::inner", "Slice", () -> read_Slice(r))
    r.depth -= 1
end

function layout_SetNonzerosSliceParam_Add_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["SetNonzerosParam::type"] = field(r, record, "SetNonzerosParam::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_SetNonzerosVector_Add_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "SetNonzerosVector::nonzeros", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_SetNonzerosVector_Add_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["SetNonzeros::type"] = field(r, record, "SetNonzeros::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_Slice_serialize(r, record, scope)
    enter_layout(r)
    field(r, record, "Slice::start", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Slice::stop", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Slice::step", "casadi_int", () -> number(r, "casadi_int"))
    r.depth -= 1
end

function layout_Smoothing_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FiniteDiff::serialize_body")
    layout_FiniteDiff_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_SnoptInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "SnoptInterface", 1)
    field(r, record, "SnoptInterface::jacf_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "SnoptInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "SnoptInterface::nnJac", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SnoptInterface::nnObj", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SnoptInterface::nnCon", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SnoptInterface::A_structure", "IM", () -> read_IM(r))
    field(r, record, "SnoptInterface::m", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SnoptInterface::iObj", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SnoptInterface::jacF_row", "bool", () -> boolvalue(r))
    field(r, record, "SnoptInterface::dummyrow", "bool", () -> boolvalue(r))
    field(r, record, "SnoptInterface::Cold_", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SnoptInterface::inf", "double", () -> number(r, "double"))
    field(r, record, "SnoptInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_Solve_Tr_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Solve_Tr_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    field(r, record, "Solve::Tr", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_SparseDenseKron_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Kron::serialize_body")
    layout_Kron_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_SparseDenseKron_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Kron::kind"] = field(r, record, "Kron::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_SparseDenseKronContract_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "KronContract::serialize_body")
    layout_KronContract_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_SparseDenseKronContract_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["KronContract::kind"] = field(r, record, "KronContract::kind", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_Sparsify_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Project::serialize_body")
    layout_Project_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Sparsify_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Project::type"] = field(r, record, "Project::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_Sparsity_serialize(r, record, scope)
    enter_layout(r)
    fail(r, "Predicate has no serialized field")
    r.depth -= 1
end

function layout_SparsityCast_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Split_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MultipleOutput::serialize_body")
    layout_MultipleOutput_serialize_body(r, record, scope)
    field(r, record, "Split::offset", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "Split::output_sparsity", "std::vector<Sparsity>", () -> read_std_vector_Sparsity(r))
    r.depth -= 1
end

function layout_SqicInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Sqpmethod_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "Sqpmethod", 3)
    field(r, record, "Sqpmethod::qpsol", "Function", () -> read_Function(r))
    field(r, record, "Sqpmethod::qpsol_ela", "Function", () -> read_Function(r))
    field(r, record, "Sqpmethod::exact_hessian", "bool", () -> boolvalue(r))
    field(r, record, "Sqpmethod::max_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Sqpmethod::min_iter", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Sqpmethod::lbfgs_memory", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Sqpmethod::tol_pr_", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::tol_du_", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::min_step_size_", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::c1", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::beta", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::max_iter_ls_", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Sqpmethod::merit_memsize_", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "Sqpmethod::beta", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::print_header", "bool", () -> boolvalue(r))
    field(r, record, "Sqpmethod::print_iteration", "bool", () -> boolvalue(r))
    field(r, record, "Sqpmethod::print_status", "bool", () -> boolvalue(r))
    field(r, record, "Sqpmethod::elastic_mode", "bool", () -> boolvalue(r))
    field(r, record, "Sqpmethod::gamma_0", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::gamma_max", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::gamma_1_min", "double", () -> number(r, "double"))
    field(r, record, "Sqpmethod::init_feasible", "bool", () -> boolvalue(r))
    field(r, record, "Sqpmethod::so_corr", "bool", () -> boolvalue(r))
    field(r, record, "Sqpmethod::Hsp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Sqpmethod::Asp", "Sparsity", () -> read_Sparsity(r))
    scope["Sqpmethod::convexify"] = field(r, record, "Sqpmethod::convexify", "bool", () -> boolvalue(r))
    if truth(scope["Sqpmethod::convexify"])
        push!(record["layouts"], "Convexify::serialize")
        scope["prefix"] = "Sqpmethod::"
        layout_Convexify_serialize(r, record, scope)
    end
    r.depth -= 1
end

function layout_SundialsInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Integrator::serialize_body")
    layout_Integrator_serialize_body(r, record, scope)
    version(r, record, "SundialsInterface", 2)
    field(r, record, "SundialsInterface::abstol", "double", () -> number(r, "double"))
    field(r, record, "SundialsInterface::reltol", "double", () -> number(r, "double"))
    field(r, record, "SundialsInterface::max_num_steps", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SundialsInterface::stop_at_end", "bool", () -> boolvalue(r))
    field(r, record, "SundialsInterface::quad_err_con", "bool", () -> boolvalue(r))
    field(r, record, "SundialsInterface::steps_per_checkpoint", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SundialsInterface::disable_internal_warnings", "bool", () -> boolvalue(r))
    field(r, record, "SundialsInterface::max_multistep_order", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SundialsInterface::linear_solver", "std::string", () -> stringvalue(r))
    field(r, record, "SundialsInterface::linear_solver_options", "Dict", () -> read_Dict(r))
    field(r, record, "SundialsInterface::max_krylov", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SundialsInterface::use_precon", "bool", () -> boolvalue(r))
    field(r, record, "SundialsInterface::second_order_correction", "bool", () -> boolvalue(r))
    field(r, record, "SundialsInterface::step0", "double", () -> number(r, "double"))
    field(r, record, "SundialsInterface::max_step_size", "double", () -> number(r, "double"))
    field(r, record, "SundialsInterface::nonlin_conv_coeff", "double", () -> number(r, "double"))
    field(r, record, "SundialsInterface::max_order", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SundialsInterface::scale_abstol", "bool", () -> boolvalue(r))
    field(r, record, "SundialsInterface::linsolF", "Linsol", () -> read_Linsol(r))
    field(r, record, "SundialsInterface::newton_scheme", "int", () -> number(r, "int"))
    field(r, record, "SundialsInterface::interp", "int", () -> number(r, "int"))
    r.depth -= 1
end

function layout_SuperscsInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "SuperscsInterface", 1)
    field(r, record, "SuperscsInterface::settings::normalize", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::scale", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::rho_x", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::max_time_milliseconds", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::max_iters", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::previous_max_iters", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::eps", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::alpha", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::cg_rate", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::verbose", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::warm_start", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::do_super_scs", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::k0", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::c_bl", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::k1", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::k2", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::c1", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::sse", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::ls", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::beta", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::sigma", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::direction", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::thetabar", "double", () -> number(r, "double"))
    field(r, record, "SuperscsInterface::settings::memory", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::tRule", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::broyden_init_scaling", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::do_record_progress", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::settings::do_override_streams", "casadi_int", () -> number(r, "casadi_int"))
    field(r, record, "SuperscsInterface::Hp", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "SuperscsInterface::HL_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "SuperscsInterface::f", "Function", () -> read_Function(r))
    field(r, record, "SuperscsInterface::At", "IM", () -> read_IM(r))
    field(r, record, "SuperscsInterface::lookup", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "SuperscsInterface::perturb", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, "SuperscsInterface::opts", "Dict", () -> read_Dict(r))
    push!(record["layouts"], "Conic::serialize")
    layout_Conic_serialize(r, record, scope)
    r.depth -= 1
end

function layout_Switch_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "Switch", 1)
    field(r, record, "Switch::f", "std::vector<Function>", () -> read_std_vector_Function(r))
    field(r, record, "Switch::f_def", "Function", () -> read_Function(r))
    field(r, record, "Switch::project_in", "bool", () -> boolvalue(r))
    field(r, record, "Switch::project_out", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_SymbolicMX_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "SymbolicMX::name", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_SymbolicQr_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "LinsolInternal::serialize_body")
    layout_LinsolInternal_serialize_body(r, record, scope)
    version(r, record, "SymbolicQr", 1)
    field(r, record, "SymbolicQr::factorize", "Function", () -> read_Function(r))
    field(r, record, "SymbolicQr::solve", "Function", () -> read_Function(r))
    field(r, record, "SymbolicQr::solveT", "Function", () -> read_Function(r))
    field(r, record, "SymbolicQr::fopts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_SymbolicSX_serialize_node(r, record, scope)
    enter_layout(r)
    field(r, record, "SymbolicSX::name", "std::string", () -> stringvalue(r))
    r.depth -= 1
end

function layout_ThreadMap_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Map::serialize_body")
    layout_Map_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Transpose_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Transpose_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["Transpose::dense"] = field(r, record, "Transpose::dense", "bool", () -> boolvalue(r))
    r.depth -= 1
end

function layout_UnaryMX_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_body")
    layout_MXNode_serialize_body(r, record, scope)
    field(r, record, "UnaryMX::op", "int", () -> number(r, "int"))
    r.depth -= 1
end

function layout_UnarySX_serialize_node(r, record, scope)
    enter_layout(r)
    field(r, record, "UnarySX::dep", "SXElem", () -> read_SXElem(r))
    r.depth -= 1
end

function layout_UnoInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "UnoInterface", 1)
    field(r, record, "UnoInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "UnoInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "UnoInterface::opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_Vertcat_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Concat::serialize_body")
    layout_Concat_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_Vertsplit_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Split::serialize_body")
    layout_Split_serialize_body(r, record, scope)
    r.depth -= 1
end

function layout_WorhpInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Nlpsol::serialize_body")
    layout_Nlpsol_serialize_body(r, record, scope)
    version(r, record, "WorhpInterface", 1)
    field(r, record, "WorhpInterface::jacg_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "WorhpInterface::hesslag_sp", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "WorhpInterface::bool_opts", "std::map<std::string,bool>", () -> read_std_map_std_string_bool(r))
    field(r, record, "WorhpInterface::int_opts", "std::map<std::string,casadi_int>", () -> read_std_map_std_string_casadi_int(r))
    field(r, record, "WorhpInterface::double_opts", "std::map<std::string,double>", () -> read_std_map_std_string_double(r))
    field(r, record, "WorhpInterface::qp_opts", "Dict", () -> read_Dict(r))
    r.depth -= 1
end

function layout_XFunction_MXFunction_MX_MXNode_delayed_serialize_members(r, record, scope)
    enter_layout(r)
    field(r, record, "XFunction::out", "std::vector<MX>", () -> read_std_vector_MX(r))
    r.depth -= 1
end

function layout_XFunction_MXFunction_MX_MXNode_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "XFunction", 1)
    field(r, record, "XFunction::in", "std::vector<MX>", () -> read_std_vector_MX(r))
    r.depth -= 1
end

function layout_XFunction_SXFunction_SX_SXNode_delayed_serialize_members(r, record, scope)
    enter_layout(r)
    field(r, record, "XFunction::out", "std::vector<SX>", () -> read_std_vector_SX(r))
    r.depth -= 1
end

function layout_XFunction_SXFunction_SX_SXNode_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "FunctionInternal::serialize_body")
    layout_FunctionInternal_serialize_body(r, record, scope)
    version(r, record, "XFunction", 1)
    field(r, record, "XFunction::in", "std::vector<SX>", () -> read_std_vector_SX(r))
    r.depth -= 1
end

function layout_XpressInterface_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Conic::serialize_body")
    layout_Conic_serialize_body(r, record, scope)
    version(r, record, "XpressInterface", 2)
    field(r, record, "XpressInterface::opts", "Dict", () -> read_Dict(r))
    field(r, record, "XpressInterface::mip_start", "bool", () -> boolvalue(r))
    field(r, record, "XpressInterface::log_file", "std::string", () -> stringvalue(r))
    field(r, record, "XpressInterface::compute_iis", "bool", () -> boolvalue(r))
    field(r, record, "XpressInterface::sos_settype", "std::vector<char>", () -> read_std_vector_char(r))
    field(r, record, "XpressInterface::sos_setstart", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "XpressInterface::sos_setind", "std::vector<int>", () -> read_std_vector_int(r))
    field(r, record, "XpressInterface::sos_refval", "std::vector<double>", () -> read_std_vector_double(r))
    r.depth -= 1
end

function layout_ZeroByZero_serialize_body(r, record, scope)
    enter_layout(r)
    r.depth -= 1
end

function layout_ZeroByZero_serialize_type(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "MXNode::serialize_type")
    layout_MXNode_serialize_type(r, record, scope)
    scope["ConstantMX::type"] = field(r, record, "ConstantMX::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_ZeroSX_serialize_node(r, record, scope)
    enter_layout(r)
    scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
    r.depth -= 1
end

function layout_ZipMemResource_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "ResourceInternal::serialize_body")
    layout_ResourceInternal_serialize_body(r, record, scope)
    version(r, record, "ZipMemResource", 1)
    field(r, record, "ZipMemResource::blob", "std::stringstream", () -> streamvalue(r))
    r.depth -= 1
end

function layout_ZipResource_serialize_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "ResourceInternal::serialize_body")
    layout_ResourceInternal_serialize_body(r, record, scope)
    version(r, record, "ZipResource", 1)
    if truth((scope["ResourceInternal::serialize_mode"] == "embed"))
        field(r, record, "ZipMemResource::blob", "std::stringstream", () -> streamvalue(r))
    else
        field(r, record, "ZipResource::path", "std::string", () -> stringvalue(r))
    end
    r.depth -= 1
end

function layout_ZipResource_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "unlowered else branch")
    r.depth -= 1
end

function layout_pack_tensors(r, record, scope)
    enter_layout(r)
    field(r, record, (string(scope["d"]) * string("::names")), "std::vector<std::string>", () -> read_std_vector_std_string(r))
    field(r, record, (string(scope["d"]) * string("::shapes")), "std::vector<std::vector<casadi_int>>", () -> read_std_vector_std_vector_casadi_int(r))
    field(r, record, (string(scope["d"]) * string("::elem_types")), "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    field(r, record, (string(scope["d"]) * string("::numels")), "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function layout_PluginInterface_Interpolant_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "Serialization layout absent from scheme: >PluginInterface<Interpolant>::serialize_type")
    r.depth -= 1
end

function layout_PluginInterface_Conic_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "Serialization layout absent from scheme: PluginInterface<Conic>::serialize_type")
    r.depth -= 1
end

function layout_PluginInterface_Integrator_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "Serialization layout absent from scheme: PluginInterface<Integrator>::serialize_type")
    r.depth -= 1
end

function layout_PluginInterface_Interpolant_serialize_type_2(r, record, scope)
    enter_layout(r)
    fail(r, "Serialization layout absent from scheme: PluginInterface<Interpolant>::serialize_type")
    r.depth -= 1
end

function layout_PluginInterface_LinsolInternal_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "Serialization layout absent from scheme: PluginInterface<LinsolInternal>::serialize_type")
    r.depth -= 1
end

function layout_PluginInterface_Nlpsol_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "Serialization layout absent from scheme: PluginInterface<Nlpsol>::serialize_type")
    r.depth -= 1
end

function layout_PluginInterface_OnnxFunction_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "Serialization layout absent from scheme: PluginInterface<OnnxFunction>::serialize_type")
    r.depth -= 1
end

function layout_PluginInterface_Rootfinder_serialize_type(r, record, scope)
    enter_layout(r)
    fail(r, "Serialization layout absent from scheme: PluginInterface<Rootfinder>::serialize_type")
    r.depth -= 1
end

function read_DM_body(r, record, scope)
    enter_layout(r)
    field(r, record, "Matrix::sparsity", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Matrix::nonzeros", "std::vector<double>", () -> read_std_vector_double(r))
    r.depth -= 1
end

function read_DM(r)
    return object(r, "DM", nothing, false, read_DM_body)
end

function read_Fmu_body(r, record, scope)
    enter_layout(r)
    scope["FmuInternal::type"] = field(r, record, "FmuInternal::type", "std::string", () -> stringvalue(r))
    tag_1 = string(scope["FmuInternal::type"])
    if tag_1 == "Fmu2"
        push!(record["layouts"], "Fmu2::serialize_body")
        layout_Fmu2_serialize_body(r, record, scope)
    elseif tag_1 == "Fmu3"
        push!(record["layouts"], "Fmu3::serialize_body")
        layout_Fmu3_serialize_body(r, record, scope)
    else
        fail(r, "Unknown serialization discriminator")
    end
    r.depth -= 1
end

function read_Fmu(r)
    return object(r, "Fmu", "F", true, read_Fmu_body)
end

function read_Function_body(r, record, scope)
    enter_layout(r)
    scope["Function::null"] = field(r, record, "Function::null", "bool", () -> boolvalue(r))
    if truth((!truth(scope["Function::null"])))
        scope["FunctionInternal::base_function"] = field(r, record, "FunctionInternal::base_function", "std::string", () -> stringvalue(r))
        tag_2 = string(scope["FunctionInternal::base_function"])
        if tag_2 == "BackwardDiff"
            push!(record["layouts"], "BackwardDiff::serialize_body")
            layout_BackwardDiff_serialize_body(r, record, scope)
        elseif tag_2 == "BlazingSplineFunction"
            push!(record["layouts"], "BlazingSplineFunction::serialize_body")
            layout_BlazingSplineFunction_serialize_body(r, record, scope)
        elseif tag_2 == "CentralDiff"
            push!(record["layouts"], "CentralDiff::serialize_body")
            layout_CentralDiff_serialize_body(r, record, scope)
        elseif tag_2 == "Conic"
            scope["PluginInterface::plugin_name"] = field(r, record, "PluginInterface::plugin_name", "std::string", () -> stringvalue(r))
            tag_3 = string(scope["PluginInterface::plugin_name"])
            if tag_3 == "cbc"
                push!(record["layouts"], "CbcInterface::serialize_body")
                layout_CbcInterface_serialize_body(r, record, scope)
            elseif tag_3 == "clarabel"
                push!(record["layouts"], "ClarabelInterface::serialize_body")
                layout_ClarabelInterface_serialize_body(r, record, scope)
            elseif tag_3 == "clp"
                push!(record["layouts"], "ClpInterface::serialize_body")
                layout_ClpInterface_serialize_body(r, record, scope)
            elseif tag_3 == "cplex"
                push!(record["layouts"], "CplexInterface::serialize_body")
                layout_CplexInterface_serialize_body(r, record, scope)
            elseif tag_3 == "daqp"
                push!(record["layouts"], "DaqpInterface::serialize_body")
                layout_DaqpInterface_serialize_body(r, record, scope)
            elseif tag_3 == "fatrop"
                push!(record["layouts"], "FatropConicInterface::serialize_body")
                layout_FatropConicInterface_serialize_body(r, record, scope)
            elseif tag_3 == "gurobi"
                push!(record["layouts"], "GurobiInterface::serialize_body")
                layout_GurobiInterface_serialize_body(r, record, scope)
            elseif tag_3 == "highs"
                push!(record["layouts"], "HighsInterface::serialize_body")
                layout_HighsInterface_serialize_body(r, record, scope)
            elseif tag_3 == "hpipm"
                push!(record["layouts"], "HpipmInterface::serialize_body")
                layout_HpipmInterface_serialize_body(r, record, scope)
            elseif tag_3 == "hpmpc"
                push!(record["layouts"], "HpmpcInterface::serialize_body")
                layout_HpmpcInterface_serialize_body(r, record, scope)
            elseif tag_3 == "ipqp"
                push!(record["layouts"], "Ipqp::serialize_body")
                layout_Ipqp_serialize_body(r, record, scope)
            elseif tag_3 == "mosek"
                push!(record["layouts"], "MosekInterface::serialize_body")
                layout_MosekInterface_serialize_body(r, record, scope)
            elseif tag_3 == "nlpsol"
                push!(record["layouts"], "QpToNlp::serialize_body")
                layout_QpToNlp_serialize_body(r, record, scope)
            elseif tag_3 == "ooqp"
                push!(record["layouts"], "OoqpInterface::serialize_body")
                layout_OoqpInterface_serialize_body(r, record, scope)
            elseif tag_3 == "osqp"
                push!(record["layouts"], "OsqpInterface::serialize_body")
                layout_OsqpInterface_serialize_body(r, record, scope)
            elseif tag_3 == "piqp"
                push!(record["layouts"], "PiqpInterface::serialize_body")
                layout_PiqpInterface_serialize_body(r, record, scope)
            elseif tag_3 == "proxqp"
                push!(record["layouts"], "ProxqpInterface::serialize_body")
                layout_ProxqpInterface_serialize_body(r, record, scope)
            elseif tag_3 == "qpoases"
                push!(record["layouts"], "QpoasesInterface::serialize_body")
                layout_QpoasesInterface_serialize_body(r, record, scope)
            elseif tag_3 == "qrqp"
                push!(record["layouts"], "Qrqp::serialize_body")
                layout_Qrqp_serialize_body(r, record, scope)
            elseif tag_3 == "sqic"
                push!(record["layouts"], "SqicInterface::serialize_body")
                layout_SqicInterface_serialize_body(r, record, scope)
            elseif tag_3 == "superscs"
                push!(record["layouts"], "SuperscsInterface::serialize_body")
                layout_SuperscsInterface_serialize_body(r, record, scope)
            elseif tag_3 == "xpress"
                push!(record["layouts"], "XpressInterface::serialize_body")
                layout_XpressInterface_serialize_body(r, record, scope)
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "External"
            version(r, record, "GenericExternal", 1)
            scope["GenericExternal::type"] = field(r, record, "GenericExternal::type", "char", () -> byte(r))
            tag_4 = string(scope["GenericExternal::type"])
            if tag_4 == "103"
                push!(record["layouts"], "External::serialize_body")
                layout_External_serialize_body(r, record, scope)
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "FmuFunction"
            push!(record["layouts"], "FmuFunction::serialize_body")
            layout_FmuFunction_serialize_body(r, record, scope)
        elseif tag_2 == "ForwardDiff"
            push!(record["layouts"], "ForwardDiff::serialize_body")
            layout_ForwardDiff_serialize_body(r, record, scope)
        elseif tag_2 == "Integrator"
            scope["PluginInterface::plugin_name"] = field(r, record, "PluginInterface::plugin_name", "std::string", () -> stringvalue(r))
            tag_5 = string(scope["PluginInterface::plugin_name"])
            if tag_5 == "collocation"
                push!(record["layouts"], "Collocation::serialize_body")
                layout_Collocation_serialize_body(r, record, scope)
            elseif tag_5 == "cvodes"
                push!(record["layouts"], "CvodesInterface::serialize_body")
                layout_CvodesInterface_serialize_body(r, record, scope)
            elseif tag_5 == "idas"
                push!(record["layouts"], "IdasInterface::serialize_body")
                layout_IdasInterface_serialize_body(r, record, scope)
            elseif tag_5 == "rk"
                push!(record["layouts"], "RungeKutta::serialize_body")
                layout_RungeKutta_serialize_body(r, record, scope)
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "Interpolant"
            scope["PluginInterface::plugin_name"] = field(r, record, "PluginInterface::plugin_name", "std::string", () -> stringvalue(r))
            tag_6 = string(scope["PluginInterface::plugin_name"])
            if tag_6 == "bspline"
                push!(record["layouts"], "BSplineInterpolant::serialize_body")
                layout_BSplineInterpolant_serialize_body(r, record, scope)
            elseif tag_6 == "linear"
                version(r, record, "LinearInterpolant", 1)
                scope["LinearInterpolant::type"] = field(r, record, "LinearInterpolant::type", "char", () -> byte(r))
                tag_7 = string(scope["LinearInterpolant::type"])
                if tag_7 == "102"
                    push!(record["layouts"], "LinearInterpolant::serialize_body")
                    layout_LinearInterpolant_serialize_body(r, record, scope)
                elseif tag_7 == "106"
                    push!(record["layouts"], "LinearInterpolantJac::serialize_body")
                    layout_LinearInterpolantJac_serialize_body(r, record, scope)
                else
                    fail(r, "Unknown serialization discriminator")
                end
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "MXFunction"
            push!(record["layouts"], "MXFunction::serialize_body")
            layout_MXFunction_serialize_body(r, record, scope)
        elseif tag_2 == "Map"
            scope["Map::class_name"] = field(r, record, "Map::class_name", "std::string", () -> stringvalue(r))
            tag_8 = string(scope["Map::class_name"])
            if tag_8 == "Map"
                push!(record["layouts"], "Map::serialize_body")
                layout_Map_serialize_body(r, record, scope)
            elseif tag_8 == "OmpMap"
                push!(record["layouts"], "OmpMap::serialize_body")
                layout_OmpMap_serialize_body(r, record, scope)
            elseif tag_8 == "ThreadMap"
                push!(record["layouts"], "ThreadMap::serialize_body")
                layout_ThreadMap_serialize_body(r, record, scope)
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "MapSum"
            scope["MapSum::class_name"] = field(r, record, "MapSum::class_name", "std::string", () -> stringvalue(r))
            tag_9 = string(scope["MapSum::class_name"])
            if tag_9 == "MapSum"
                push!(record["layouts"], "MapSum::serialize_body")
                layout_MapSum_serialize_body(r, record, scope)
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "Nlpsol"
            scope["PluginInterface::plugin_name"] = field(r, record, "PluginInterface::plugin_name", "std::string", () -> stringvalue(r))
            tag_10 = string(scope["PluginInterface::plugin_name"])
            if tag_10 == "alpaqa"
                push!(record["layouts"], "AlpaqaInterface::serialize_body")
                layout_AlpaqaInterface_serialize_body(r, record, scope)
            elseif tag_10 == "ampl"
                push!(record["layouts"], "AmplInterface::serialize_body")
                layout_AmplInterface_serialize_body(r, record, scope)
            elseif tag_10 == "blocksqp"
                push!(record["layouts"], "Blocksqp::serialize_body")
                layout_Blocksqp_serialize_body(r, record, scope)
            elseif tag_10 == "bonmin"
                push!(record["layouts"], "BonminInterface::serialize_body")
                layout_BonminInterface_serialize_body(r, record, scope)
            elseif tag_10 == "ccopt"
                push!(record["layouts"], "MadmpecInterface::serialize_body")
                layout_MadmpecInterface_serialize_body(r, record, scope)
            elseif tag_10 == "conopt"
                push!(record["layouts"], "ConoptInterface::serialize_body")
                layout_ConoptInterface_serialize_body(r, record, scope)
            elseif tag_10 == "fatrop"
                push!(record["layouts"], "FatropInterface::serialize_body")
                layout_FatropInterface_serialize_body(r, record, scope)
            elseif tag_10 == "feasiblesqpmethod"
                push!(record["layouts"], "Feasiblesqpmethod::serialize_body")
                layout_Feasiblesqpmethod_serialize_body(r, record, scope)
            elseif tag_10 == "ipopt"
                push!(record["layouts"], "IpoptInterface::serialize_body")
                layout_IpoptInterface_serialize_body(r, record, scope)
            elseif tag_10 == "knitro"
                push!(record["layouts"], "KnitroInterface::serialize_body")
                layout_KnitroInterface_serialize_body(r, record, scope)
            elseif tag_10 == "madnlp"
                push!(record["layouts"], "MadnlpInterface::serialize_body")
                layout_MadnlpInterface_serialize_body(r, record, scope)
            elseif tag_10 == "qrsqp"
                push!(record["layouts"], "Qrsqp::serialize_body")
                layout_Qrsqp_serialize_body(r, record, scope)
            elseif tag_10 == "scpgen"
                push!(record["layouts"], "Scpgen::serialize_body")
                layout_Scpgen_serialize_body(r, record, scope)
            elseif tag_10 == "sleqp"
                push!(record["layouts"], "SLEQPInterface::serialize_body")
                layout_SLEQPInterface_serialize_body(r, record, scope)
            elseif tag_10 == "snopt"
                push!(record["layouts"], "SnoptInterface::serialize_body")
                layout_SnoptInterface_serialize_body(r, record, scope)
            elseif tag_10 == "sqpmethod"
                push!(record["layouts"], "Sqpmethod::serialize_body")
                layout_Sqpmethod_serialize_body(r, record, scope)
            elseif tag_10 == "uno"
                push!(record["layouts"], "UnoInterface::serialize_body")
                layout_UnoInterface_serialize_body(r, record, scope)
            elseif tag_10 == "worhp"
                push!(record["layouts"], "WorhpInterface::serialize_body")
                layout_WorhpInterface_serialize_body(r, record, scope)
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "Onnx"
            scope["PluginInterface::plugin_name"] = field(r, record, "PluginInterface::plugin_name", "std::string", () -> stringvalue(r))
            tag_11 = string(scope["PluginInterface::plugin_name"])
            if tag_11 == "ort"
                push!(record["layouts"], "OnnxRuntimeInterface::serialize_body")
                layout_OnnxRuntimeInterface_serialize_body(r, record, scope)
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "Rootfinder"
            scope["PluginInterface::plugin_name"] = field(r, record, "PluginInterface::plugin_name", "std::string", () -> stringvalue(r))
            tag_12 = string(scope["PluginInterface::plugin_name"])
            if tag_12 == "bisection"
                push!(record["layouts"], "Bisection::serialize_body")
                layout_Bisection_serialize_body(r, record, scope)
            elseif tag_12 == "fast_newton"
                push!(record["layouts"], "FastNewton::serialize_body")
                layout_FastNewton_serialize_body(r, record, scope)
            elseif tag_12 == "kinsol"
                push!(record["layouts"], "KinsolInterface::serialize_body")
                layout_KinsolInterface_serialize_body(r, record, scope)
            elseif tag_12 == "newton"
                push!(record["layouts"], "Newton::serialize_body")
                layout_Newton_serialize_body(r, record, scope)
            elseif tag_12 == "nlpsol"
                push!(record["layouts"], "ImplicitToNlp::serialize_body")
                layout_ImplicitToNlp_serialize_body(r, record, scope)
            else
                fail(r, "Unknown serialization discriminator")
            end
        elseif tag_2 == "SXFunction"
            push!(record["layouts"], "SXFunction::serialize_body")
            layout_SXFunction_serialize_body(r, record, scope)
        elseif tag_2 == "Smoothing"
            push!(record["layouts"], "Smoothing::serialize_body")
            layout_Smoothing_serialize_body(r, record, scope)
        elseif tag_2 == "Switch"
            push!(record["layouts"], "Switch::serialize_body")
            layout_Switch_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    end
    r.depth -= 1
end

function read_Function(r)
    return object(r, "Function", "F", true, read_Function_body)
end

function read_GenericType_body(r, record, scope)
    enter_layout(r)
    scope["GenericType::type"] = field(r, record, "GenericType::type", "int", () -> number(r, "int"))
    tag_13 = string(scope["GenericType::type"])
    if tag_13 == "1"
        field(r, record, "GenericType::d", "bool", () -> boolvalue(r))
    elseif tag_13 == "10"
        field(r, record, "GenericType::d", "std::vector<std::string>", () -> read_std_vector_std_string(r))
    elseif tag_13 == "11"
        field(r, record, "GenericType::d", "Dict", () -> read_Dict(r))
    elseif tag_13 == "12"
        field(r, record, "GenericType::d", "Function", () -> read_Function(r))
    elseif tag_13 == "13"
        field(r, record, "GenericType::d", "std::vector<Function>", () -> read_std_vector_Function(r))
    elseif tag_13 == "14"
        field(r, record, "GenericType::d", "void*", () -> primitive(r, "void*"))
    elseif tag_13 == "16"
        field(r, record, "GenericType::d", "std::vector<std::vector<std::string>>", () -> read_std_vector_std_vector_std_string(r))
    elseif tag_13 == "17"
        field(r, record, "GenericType::d", "std::vector<Dict>", () -> read_std_vector_Dict(r))
    elseif tag_13 == "18"
        field(r, record, "GenericType::d", "std::vector<std::vector<GenericType>>", () -> read_std_vector_std_vector_GenericType(r))
    elseif tag_13 == "19"
        field(r, record, "GenericType::d", "std::vector<GenericType>", () -> read_std_vector_GenericType(r))
    elseif tag_13 == "2"
        field(r, record, "GenericType::d", "casadi_int", () -> number(r, "casadi_int"))
    elseif tag_13 == "3"
        field(r, record, "GenericType::d", "double", () -> number(r, "double"))
    elseif tag_13 == "4"
        field(r, record, "GenericType::d", "std::string", () -> stringvalue(r))
    elseif tag_13 == "5"
        field(r, record, "GenericType::d", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    elseif tag_13 == "6"
        field(r, record, "GenericType::d", "std::vector<std::vector<casadi_int>>", () -> read_std_vector_std_vector_casadi_int(r))
    elseif tag_13 == "7"
        field(r, record, "GenericType::d", "std::vector<bool>", () -> read_std_vector_bool(r))
    elseif tag_13 == "8"
        field(r, record, "GenericType::d", "std::vector<double>", () -> read_std_vector_double(r))
    elseif tag_13 == "9"
        field(r, record, "GenericType::d", "std::vector<std::vector<double>>", () -> read_std_vector_std_vector_double(r))
    else
        fail(r, "Unknown serialization discriminator")
    end
    r.depth -= 1
end

function read_GenericType(r)
    return object(r, "GenericType", "G", true, read_GenericType_body)
end

function read_IM_body(r, record, scope)
    enter_layout(r)
    field(r, record, "Matrix::sparsity", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Matrix::nonzeros", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function read_IM(r)
    return object(r, "IM", nothing, false, read_IM_body)
end

function read_Importer_body(r, record, scope)
    enter_layout(r)
    scope["ImporterInternal::type"] = field(r, record, "ImporterInternal::type", "std::string", () -> stringvalue(r))
    tag_14 = string(scope["ImporterInternal::type"])
    if tag_14 == "DllLibrary"
        push!(record["layouts"], "ImporterInternal::serialize_body")
        layout_ImporterInternal_serialize_body(r, record, scope)
    else
        fail(r, "Unknown serialization discriminator")
    end
    r.depth -= 1
end

function read_Importer(r)
    return object(r, "Importer", "M", true, read_Importer_body)
end

function read_Linsol_body(r, record, scope)
    enter_layout(r)
    scope["PluginInterface::plugin_name"] = field(r, record, "PluginInterface::plugin_name", "std::string", () -> stringvalue(r))
    tag_15 = string(scope["PluginInterface::plugin_name"])
    if tag_15 == "csparse"
        push!(record["layouts"], "CsparseInterface::serialize_body")
        layout_CsparseInterface_serialize_body(r, record, scope)
    elseif tag_15 == "csparsecholesky"
        push!(record["layouts"], "CSparseCholeskyInterface::serialize_body")
        layout_CSparseCholeskyInterface_serialize_body(r, record, scope)
    elseif tag_15 == "lapacklu"
        push!(record["layouts"], "LapackLu::serialize_body")
        layout_LapackLu_serialize_body(r, record, scope)
    elseif tag_15 == "lapackqr"
        push!(record["layouts"], "LapackQr::serialize_body")
        layout_LapackQr_serialize_body(r, record, scope)
    elseif tag_15 == "ldl"
        push!(record["layouts"], "LinsolLdl::serialize_body")
        layout_LinsolLdl_serialize_body(r, record, scope)
    elseif tag_15 == "lsqr"
        push!(record["layouts"], "Lsqr::serialize_body")
        layout_Lsqr_serialize_body(r, record, scope)
    elseif tag_15 == "ma27"
        push!(record["layouts"], "Ma27Interface::serialize_body")
        layout_Ma27Interface_serialize_body(r, record, scope)
    elseif tag_15 == "mumps"
        push!(record["layouts"], "MumpsInterface::serialize_body")
        layout_MumpsInterface_serialize_body(r, record, scope)
    elseif tag_15 == "qr"
        push!(record["layouts"], "LinsolQr::serialize_body")
        layout_LinsolQr_serialize_body(r, record, scope)
    elseif tag_15 == "symbolicqr"
        push!(record["layouts"], "SymbolicQr::serialize_body")
        layout_SymbolicQr_serialize_body(r, record, scope)
    elseif tag_15 == "tridiag"
        push!(record["layouts"], "LinsolTridiag::serialize_body")
        layout_LinsolTridiag_serialize_body(r, record, scope)
    else
        fail(r, "Unknown serialization discriminator")
    end
    r.depth -= 1
end

function read_Linsol(r)
    return object(r, "Linsol", "L", true, read_Linsol_body)
end

function read_MX_body(r, record, scope)
    enter_layout(r)
    scope["MXNode::op"] = field(r, record, "MXNode::op", "int", () -> number(r, "int"))
    tag_16 = string(scope["MXNode::op"])
    if tag_16 == "-1"
        push!(record["layouts"], "OutputNode::serialize_body")
        layout_OutputNode_serialize_body(r, record, scope)
    elseif tag_16 == "0"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "1"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "10"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "100"
        scope["KronContract::kind"] = field(r, record, "KronContract::kind", "std::string", () -> stringvalue(r))
        tag_17 = string(scope["KronContract::kind"])
        if tag_17 == "base"
            push!(record["layouts"], "KronContract::serialize_body")
            layout_KronContract_serialize_body(r, record, scope)
        elseif tag_17 == "dense"
            push!(record["layouts"], "DenseKronContract::serialize_body")
            layout_DenseKronContract_serialize_body(r, record, scope)
        elseif tag_17 == "dense_sparse"
            push!(record["layouts"], "DenseSparseKronContract::serialize_body")
            layout_DenseSparseKronContract_serialize_body(r, record, scope)
        elseif tag_17 == "sparse_dense"
            push!(record["layouts"], "SparseDenseKronContract::serialize_body")
            layout_SparseDenseKronContract_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "11"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "12"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "13"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "14"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "15"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "16"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "17"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "18"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "19"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "2"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "20"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "21"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "22"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "23"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "24"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "25"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "26"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "27"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "28"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "29"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "3"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "30"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "31"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "32"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "33"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "34"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "35"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "36"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "37"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "38"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "39"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "4"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "40"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "41"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "42"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "43"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "44"
        scope["ConstantMX::type"] = field(r, record, "ConstantMX::type", "char", () -> byte(r))
        tag_18 = string(scope["ConstantMX::type"])
        if tag_18 == "102"
            push!(record["layouts"], "ConstantFile::serialize_body")
            layout_ConstantFile_serialize_body(r, record, scope)
        elseif tag_18 == "109"
            push!(record["layouts"], "MXNode::serialize_body")
            layout_MXNode_serialize_body(r, record, scope)
        elseif tag_18 == "112"
            push!(record["layouts"], "ConstantPool::serialize_body")
            layout_ConstantPool_serialize_body(r, record, scope)
        elseif tag_18 == "122"
        elseif tag_18 == "48"
            push!(record["layouts"], "MXNode::serialize_body")
            layout_MXNode_serialize_body(r, record, scope)
        elseif tag_18 == "49"
            push!(record["layouts"], "MXNode::serialize_body")
            layout_MXNode_serialize_body(r, record, scope)
        elseif tag_18 == "68"
            field(r, record, "Constant::value", "double", () -> number(r, "double"))
            push!(record["layouts"], "MXNode::serialize_body")
            layout_MXNode_serialize_body(r, record, scope)
        elseif tag_18 == "73"
            field(r, record, "Constant::value", "casadi_int", () -> number(r, "casadi_int"))
            push!(record["layouts"], "MXNode::serialize_body")
            layout_MXNode_serialize_body(r, record, scope)
        elseif tag_18 == "97"
            push!(record["layouts"], "ConstantDM::serialize_body")
            layout_ConstantDM_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "45"
        push!(record["layouts"], "Input::serialize_body")
        layout_Input_serialize_body(r, record, scope)
    elseif tag_16 == "46"
        push!(record["layouts"], "Output::serialize_body")
        layout_Output_serialize_body(r, record, scope)
    elseif tag_16 == "47"
        push!(record["layouts"], "SymbolicMX::serialize_body")
        layout_SymbolicMX_serialize_body(r, record, scope)
    elseif tag_16 == "48"
        push!(record["layouts"], "Call::serialize_body")
        layout_Call_serialize_body(r, record, scope)
    elseif tag_16 == "49"
        push!(record["layouts"], "Find::serialize_body")
        layout_Find_serialize_body(r, record, scope)
    elseif tag_16 == "5"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "50"
        push!(record["layouts"], "Low::serialize_body")
        layout_Low_serialize_body(r, record, scope)
    elseif tag_16 == "52"
        scope["Multiplication::kind"] = field(r, record, "Multiplication::kind", "std::string", () -> stringvalue(r))
        tag_19 = string(scope["Multiplication::kind"])
        if tag_19 == "base"
            push!(record["layouts"], "Multiplication::serialize_body")
            layout_Multiplication_serialize_body(r, record, scope)
        elseif tag_19 == "dense"
            push!(record["layouts"], "DenseMultiplication::serialize_body")
            layout_DenseMultiplication_serialize_body(r, record, scope)
        elseif tag_19 == "dense_sparse"
            push!(record["layouts"], "DenseSparseMultiplication::serialize_body")
            layout_DenseSparseMultiplication_serialize_body(r, record, scope)
        elseif tag_19 == "pseudo_dense"
            push!(record["layouts"], "PseudoDenseMultiplication::serialize_body")
            layout_PseudoDenseMultiplication_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "53"
        field(r, record, "Solve::Tr", "bool", () -> boolvalue(r))
        push!(record["layouts"], "LinsolCall<Tr>::serialize_body")
        layout_LinsolCall_Tr_serialize_body(r, record, scope)
    elseif tag_16 == "54"
        scope["Transpose::dense"] = field(r, record, "Transpose::dense", "bool", () -> boolvalue(r))
        tag_20 = string(scope["Transpose::dense"])
        if tag_20 == "false"
            push!(record["layouts"], "Transpose::serialize_body")
            layout_Transpose_serialize_body(r, record, scope)
        elseif tag_20 == "true"
            push!(record["layouts"], "DenseTranspose::serialize_body")
            layout_DenseTranspose_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "55"
        push!(record["layouts"], "Determinant::serialize_body")
        layout_Determinant_serialize_body(r, record, scope)
    elseif tag_16 == "56"
        push!(record["layouts"], "Inverse::serialize_body")
        layout_Inverse_serialize_body(r, record, scope)
    elseif tag_16 == "57"
        push!(record["layouts"], "Dot::serialize_body")
        layout_Dot_serialize_body(r, record, scope)
    elseif tag_16 == "58"
        push!(record["layouts"], "Bilin::serialize_body")
        layout_Bilin_serialize_body(r, record, scope)
    elseif tag_16 == "59"
        push!(record["layouts"], "Rank1::serialize_body")
        layout_Rank1_serialize_body(r, record, scope)
    elseif tag_16 == "6"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "60"
        push!(record["layouts"], "Horzcat::serialize_body")
        layout_Horzcat_serialize_body(r, record, scope)
    elseif tag_16 == "61"
        push!(record["layouts"], "Vertcat::serialize_body")
        layout_Vertcat_serialize_body(r, record, scope)
    elseif tag_16 == "62"
        push!(record["layouts"], "Diagcat::serialize_body")
        layout_Diagcat_serialize_body(r, record, scope)
    elseif tag_16 == "63"
        push!(record["layouts"], "Horzsplit::serialize_body")
        layout_Horzsplit_serialize_body(r, record, scope)
    elseif tag_16 == "64"
        push!(record["layouts"], "Vertsplit::serialize_body")
        layout_Vertsplit_serialize_body(r, record, scope)
    elseif tag_16 == "65"
        push!(record["layouts"], "Diagsplit::serialize_body")
        layout_Diagsplit_serialize_body(r, record, scope)
    elseif tag_16 == "66"
        push!(record["layouts"], "Reshape::serialize_body")
        layout_Reshape_serialize_body(r, record, scope)
    elseif tag_16 == "69"
        scope["GetNonzeros::type"] = field(r, record, "GetNonzeros::type", "char", () -> byte(r))
        tag_21 = string(scope["GetNonzeros::type"])
        if tag_21 == "97"
            push!(record["layouts"], "GetNonzerosVector::serialize_body")
            layout_GetNonzerosVector_serialize_body(r, record, scope)
        elseif tag_21 == "98"
            push!(record["layouts"], "GetNonzerosSlice::serialize_body")
            layout_GetNonzerosSlice_serialize_body(r, record, scope)
        elseif tag_21 == "99"
            push!(record["layouts"], "GetNonzerosSlice2::serialize_body")
            layout_GetNonzerosSlice2_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "7"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "70"
        scope["GetNonzerosParam::type"] = field(r, record, "GetNonzerosParam::type", "char", () -> byte(r))
        tag_22 = string(scope["GetNonzerosParam::type"])
        if tag_22 == "100"
            push!(record["layouts"], "GetNonzerosParamParam::serialize_body")
            layout_GetNonzerosParamParam_serialize_body(r, record, scope)
        elseif tag_22 == "97"
            push!(record["layouts"], "GetNonzerosParamVector::serialize_body")
            layout_GetNonzerosParamVector_serialize_body(r, record, scope)
        elseif tag_22 == "98"
            push!(record["layouts"], "GetNonzerosParamSlice::serialize_body")
            layout_GetNonzerosParamSlice_serialize_body(r, record, scope)
        elseif tag_22 == "99"
            push!(record["layouts"], "GetNonzerosSliceParam::serialize_body")
            layout_GetNonzerosSliceParam_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "71"
        scope["SetNonzeros::type"] = field(r, record, "SetNonzeros::type", "char", () -> byte(r))
        tag_23 = string(scope["SetNonzeros::type"])
        if tag_23 == "97"
            push!(record["layouts"], "SetNonzerosVector<Add>::serialize_body")
            layout_SetNonzerosVector_Add_serialize_body(r, record, scope)
        elseif tag_23 == "98"
            push!(record["layouts"], "SetNonzerosSlice<Add>::serialize_body")
            layout_SetNonzerosSlice_Add_serialize_body(r, record, scope)
        elseif tag_23 == "99"
            push!(record["layouts"], "SetNonzerosSlice2<Add>::serialize_body")
            layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "72"
        scope["SetNonzerosParam::type"] = field(r, record, "SetNonzerosParam::type", "char", () -> byte(r))
        tag_24 = string(scope["SetNonzerosParam::type"])
        if tag_24 == "100"
            push!(record["layouts"], "SetNonzerosParamParam<Add>::serialize_body")
            layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope)
        elseif tag_24 == "97"
            push!(record["layouts"], "SetNonzerosParamVector<Add>::serialize_body")
            layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope)
        elseif tag_24 == "98"
            push!(record["layouts"], "SetNonzerosParamSlice<Add>::serialize_body")
            layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope)
        elseif tag_24 == "99"
            push!(record["layouts"], "SetNonzerosSliceParam<Add>::serialize_body")
            layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "73"
        scope["SetNonzeros::type"] = field(r, record, "SetNonzeros::type", "char", () -> byte(r))
        tag_25 = string(scope["SetNonzeros::type"])
        if tag_25 == "97"
            push!(record["layouts"], "SetNonzerosVector<Add>::serialize_body")
            layout_SetNonzerosVector_Add_serialize_body(r, record, scope)
        elseif tag_25 == "98"
            push!(record["layouts"], "SetNonzerosSlice<Add>::serialize_body")
            layout_SetNonzerosSlice_Add_serialize_body(r, record, scope)
        elseif tag_25 == "99"
            push!(record["layouts"], "SetNonzerosSlice2<Add>::serialize_body")
            layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "74"
        scope["SetNonzerosParam::type"] = field(r, record, "SetNonzerosParam::type", "char", () -> byte(r))
        tag_26 = string(scope["SetNonzerosParam::type"])
        if tag_26 == "100"
            push!(record["layouts"], "SetNonzerosParamParam<Add>::serialize_body")
            layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope)
        elseif tag_26 == "97"
            push!(record["layouts"], "SetNonzerosParamVector<Add>::serialize_body")
            layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope)
        elseif tag_26 == "98"
            push!(record["layouts"], "SetNonzerosParamSlice<Add>::serialize_body")
            layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope)
        elseif tag_26 == "99"
            push!(record["layouts"], "SetNonzerosSliceParam<Add>::serialize_body")
            layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "75"
        scope["Project::type"] = field(r, record, "Project::type", "char", () -> byte(r))
        tag_27 = string(scope["Project::type"])
        if tag_27 == "100"
            push!(record["layouts"], "Densify::serialize_body")
            layout_Densify_serialize_body(r, record, scope)
        elseif tag_27 == "110"
            push!(record["layouts"], "Project::serialize_body")
            layout_Project_serialize_body(r, record, scope)
        elseif tag_27 == "115"
            push!(record["layouts"], "Sparsify::serialize_body")
            layout_Sparsify_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "76"
        push!(record["layouts"], "Assertion::serialize_body")
        layout_Assertion_serialize_body(r, record, scope)
    elseif tag_16 == "77"
        push!(record["layouts"], "Monitor::serialize_body")
        layout_Monitor_serialize_body(r, record, scope)
    elseif tag_16 == "78"
        push!(record["layouts"], "Norm2::serialize_body")
        layout_Norm2_serialize_body(r, record, scope)
    elseif tag_16 == "79"
        push!(record["layouts"], "Norm1::serialize_body")
        layout_Norm1_serialize_body(r, record, scope)
    elseif tag_16 == "8"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "80"
        push!(record["layouts"], "NormInf::serialize_body")
        layout_NormInf_serialize_body(r, record, scope)
    elseif tag_16 == "81"
        push!(record["layouts"], "NormF::serialize_body")
        layout_NormF_serialize_body(r, record, scope)
    elseif tag_16 == "82"
        push!(record["layouts"], "MMin::serialize_body")
        layout_MMin_serialize_body(r, record, scope)
    elseif tag_16 == "83"
        push!(record["layouts"], "MMax::serialize_body")
        layout_MMax_serialize_body(r, record, scope)
    elseif tag_16 == "84"
        push!(record["layouts"], "HorzRepmat::serialize_body")
        layout_HorzRepmat_serialize_body(r, record, scope)
    elseif tag_16 == "85"
        push!(record["layouts"], "HorzRepsum::serialize_body")
        layout_HorzRepsum_serialize_body(r, record, scope)
    elseif tag_16 == "86"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "87"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "88"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "89"
        push!(record["layouts"], "Einstein::serialize_body")
        layout_Einstein_serialize_body(r, record, scope)
    elseif tag_16 == "9"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "90"
        scope["BSpline::type"] = field(r, record, "BSpline::type", "char", () -> byte(r))
        tag_28 = string(scope["BSpline::type"])
        if tag_28 == "110"
            push!(record["layouts"], "BSpline::serialize_body")
            layout_BSpline_serialize_body(r, record, scope)
        elseif tag_28 == "112"
            push!(record["layouts"], "BSplineParametric::serialize_body")
            layout_BSplineParametric_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_16 == "91"
        push!(record["layouts"], "Convexify::serialize_body")
        layout_Convexify_serialize_body(r, record, scope)
    elseif tag_16 == "92"
        push!(record["layouts"], "SparsityCast::serialize_body")
        layout_SparsityCast_serialize_body(r, record, scope)
    elseif tag_16 == "93"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "94"
        push!(record["layouts"], "UnaryMX::serialize_body")
        layout_UnaryMX_serialize_body(r, record, scope)
    elseif tag_16 == "95"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "96"
        push!(record["layouts"], "LogSumExp::serialize_body")
        layout_LogSumExp_serialize_body(r, record, scope)
    elseif tag_16 == "97"
        field(r, record, "BinaryMX::scalar_flags", "char", () -> byte(r))
        push!(record["layouts"], "BinaryMX<ScX,ScY>::serialize_body")
        layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope)
    elseif tag_16 == "98"
        push!(record["layouts"], "Dump::serialize_body")
        layout_Dump_serialize_body(r, record, scope)
    elseif tag_16 == "99"
        scope["Kron::kind"] = field(r, record, "Kron::kind", "std::string", () -> stringvalue(r))
        tag_29 = string(scope["Kron::kind"])
        if tag_29 == "base"
            push!(record["layouts"], "Kron::serialize_body")
            layout_Kron_serialize_body(r, record, scope)
        elseif tag_29 == "dense"
            push!(record["layouts"], "DenseKron::serialize_body")
            layout_DenseKron_serialize_body(r, record, scope)
        elseif tag_29 == "dense_sparse"
            push!(record["layouts"], "DenseSparseKron::serialize_body")
            layout_DenseSparseKron_serialize_body(r, record, scope)
        elseif tag_29 == "sparse_dense"
            push!(record["layouts"], "SparseDenseKron::serialize_body")
            layout_SparseDenseKron_serialize_body(r, record, scope)
        else
            fail(r, "Unknown serialization discriminator")
        end
    else
        fail(r, "Unknown serialization discriminator")
    end
    r.depth -= 1
end

function read_MX(r)
    return object(r, "MX", "X", true, read_MX_body)
end

function read_Resource_body(r, record, scope)
    enter_layout(r)
    version(r, record, "ResourceInternal", 1)
    scope["ResourceInternal::type"] = field(r, record, "ResourceInternal::type", "std::string", () -> stringvalue(r))
    tag_30 = string(scope["ResourceInternal::type"])
    if tag_30 == "DirResource"
        push!(record["layouts"], "DirResource::serialize_body")
        layout_DirResource_serialize_body(r, record, scope)
    elseif tag_30 == "ZipMemResource"
        push!(record["layouts"], "ZipMemResource::serialize_body")
        layout_ZipMemResource_serialize_body(r, record, scope)
    elseif tag_30 == "ZipResource"
        push!(record["layouts"], "ZipResource::serialize_body")
        layout_ZipResource_serialize_body(r, record, scope)
    else
        fail(r, "Unknown serialization discriminator")
    end
    r.depth -= 1
end

function read_Resource(r)
    return object(r, "Resource", "R", true, read_Resource_body)
end

function read_SX_body(r, record, scope)
    enter_layout(r)
    field(r, record, "Matrix::sparsity", "Sparsity", () -> read_Sparsity(r))
    field(r, record, "Matrix::nonzeros", "std::vector<SXElem>", () -> read_std_vector_SXElem(r))
    r.depth -= 1
end

function read_SX(r)
    return object(r, "SX", nothing, false, read_SX_body)
end

function read_SXElem_body(r, record, scope)
    enter_layout(r)
    scope["SXNode::op"] = field(r, record, "SXNode::op", "casadi_int", () -> number(r, "casadi_int"))
    tag_31 = string(scope["SXNode::op"])
    if tag_31 == "-1"
        push!(record["layouts"], "OutputSX::serialize_node")
        layout_OutputSX_serialize_node(r, record, scope)
    elseif tag_31 == "0"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "1"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "10"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "11"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "12"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "13"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "14"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "15"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "16"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "17"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "18"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "19"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "2"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "20"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "21"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "22"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "23"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "24"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "25"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "26"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "27"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "28"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "29"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "3"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "30"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "31"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "32"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "33"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "34"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "35"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "36"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "37"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "38"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "39"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "4"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "40"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "41"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "42"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "43"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "44"
        scope["ConstantSX::type"] = field(r, record, "ConstantSX::type", "char", () -> byte(r))
        tag_32 = string(scope["ConstantSX::type"])
        if tag_32 == "102"
        elseif tag_32 == "105"
            field(r, record, "ConstantSX::value", "int", () -> number(r, "int"))
        elseif tag_32 == "109"
        elseif tag_32 == "110"
        elseif tag_32 == "114"
            field(r, record, "ConstantSX::value", "double", () -> number(r, "double"))
        elseif tag_32 == "48"
        elseif tag_32 == "49"
        elseif tag_32 == "70"
        else
            fail(r, "Unknown serialization discriminator")
        end
    elseif tag_31 == "47"
        push!(record["layouts"], "SymbolicSX::serialize_node")
        layout_SymbolicSX_serialize_node(r, record, scope)
    elseif tag_31 == "48"
        push!(record["layouts"], "CallSX::serialize_node")
        layout_CallSX_serialize_node(r, record, scope)
    elseif tag_31 == "5"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "6"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "7"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "8"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "86"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "87"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "88"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "9"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "93"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "94"
        push!(record["layouts"], "UnarySX::serialize_node")
        layout_UnarySX_serialize_node(r, record, scope)
    elseif tag_31 == "95"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    elseif tag_31 == "97"
        push!(record["layouts"], "BinarySX::serialize_node")
        layout_BinarySX_serialize_node(r, record, scope)
    else
        fail(r, "Unknown serialization discriminator")
    end
    r.depth -= 1
end

function read_SXElem(r)
    return object(r, "SXElem", "E", true, read_SXElem_body)
end

function read_Slice_body(r, record, scope)
    enter_layout(r)
    push!(record["layouts"], "Slice::serialize")
    layout_Slice_serialize(r, record, scope)
    r.depth -= 1
end

function read_Slice(r)
    return object(r, "Slice", "S", false, read_Slice_body)
end

function read_Sparsity_body(r, record, scope)
    enter_layout(r)
    field(r, record, "SparsityInternal::compressed", "std::vector<casadi_int>", () -> read_std_vector_casadi_int(r))
    r.depth -= 1
end

function read_Sparsity(r)
    return object(r, "Sparsity", "S", true, read_Sparsity_body)
end

function read_std_vector_double(r)
    decoration(r, "V")
    return Any[number(r, "double") for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_casadi_int(r)
    decoration(r, "V")
    return Any[number(r, "casadi_int") for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_std_vector_double(r)
    decoration(r, "V")
    return Any[read_std_vector_double(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_std_string(r)
    decoration(r, "V")
    return Any[stringvalue(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_int(r)
    decoration(r, "V")
    return Any[number(r, "int") for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_char(r)
    decoration(r, "V")
    return Any[byte(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_bool(r)
    decoration(r, "V")
    return Any[boolvalue(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_SXElem(r)
    decoration(r, "V")
    return Any[read_SXElem(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_std_vector_int(r)
    decoration(r, "V")
    return Any[read_std_vector_int(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_unsignedint(r)
    decoration(r, "V")
    return Any[number(r, "unsignedint") for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_size_t(r)
    decoration(r, "V")
    return Any[number(r, "size_t") for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_Sparsity(r)
    decoration(r, "V")
    return Any[read_Sparsity(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_map_std_string_std_vector_size_t(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), read_std_vector_size_t(r)] for _ in 1:count(r, number(r, "casadi_int"))])
end

function read_std_vector_std_vector_size_t(r)
    decoration(r, "V")
    return Any[read_std_vector_size_t(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_Function(r)
    decoration(r, "V")
    return Any[read_Function(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_pair_casadi_int_std_string(r)
    decoration(r, "p")
    return Any[number(r, "casadi_int"), stringvalue(r)]
end

function read_std_map_std_string_std_pair_casadi_int_std_string(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), read_std_pair_casadi_int_std_string(r)] for _ in 1:count(r, number(r, "casadi_int"))])
end

function read_std_pair_bool_std_string(r)
    decoration(r, "p")
    return Any[boolvalue(r), stringvalue(r)]
end

function read_std_map_std_string_std_pair_bool_std_string(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), read_std_pair_bool_std_string(r)] for _ in 1:count(r, number(r, "casadi_int"))])
end

function read_std_vector_MX(r)
    decoration(r, "V")
    return Any[read_MX(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_map_std_string_std_vector_double(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), read_std_vector_double(r)] for _ in 1:count(r, number(r, "casadi_int"))])
end

function read_std_map_std_string_casadi_int(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), number(r, "casadi_int")] for _ in 1:count(r, number(r, "casadi_int"))])
end

function read_std_map_std_string_std_vector_casadi_int(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), read_std_vector_casadi_int(r)] for _ in 1:count(r, number(r, "casadi_int"))])
end

function read_std_map_std_string_bool(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), boolvalue(r)] for _ in 1:count(r, number(r, "casadi_int"))])
end

function read_std_map_std_string_double(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), number(r, "double")] for _ in 1:count(r, number(r, "casadi_int"))])
end

function read_std_vector_SX(r)
    decoration(r, "V")
    return Any[read_SX(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_std_vector_casadi_int(r)
    decoration(r, "V")
    return Any[read_std_vector_casadi_int(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_std_vector_std_string(r)
    decoration(r, "V")
    return Any[read_std_vector_std_string(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_Dict(r)
    decoration(r, "V")
    return Any[read_Dict(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_GenericType(r)
    decoration(r, "V")
    return Any[read_GenericType(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_std_vector_GenericType(r)
    decoration(r, "V")
    return Any[read_std_vector_GenericType(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_std_vector_DM(r)
    decoration(r, "V")
    return Any[read_DM(r) for _ in 1:count(r, number(r, "casadi_int"))]
end

function read_Dict(r)
    decoration(r, "D")
    return Dict("\$map" => Any[Any[stringvalue(r), read_GenericType(r)] for _ in 1:count(r, number(r, "casadi_int"))])
end

const READERS = Dict(
    "DM" => read_DM,
    "Fmu" => read_Fmu,
    "Function" => read_Function,
    "GenericType" => read_GenericType,
    "IM" => read_IM,
    "Importer" => read_Importer,
    "Linsol" => read_Linsol,
    "MX" => read_MX,
    "Resource" => read_Resource,
    "SX" => read_SX,
    "SXElem" => read_SXElem,
    "Slice" => read_Slice,
    "Sparsity" => read_Sparsity,
    "std::vector<double>" => read_std_vector_double,
    "std::vector<casadi_int>" => read_std_vector_casadi_int,
    "std::vector<std::vector<double>>" => read_std_vector_std_vector_double,
    "std::vector<std::string>" => read_std_vector_std_string,
    "std::vector<int>" => read_std_vector_int,
    "std::vector<char>" => read_std_vector_char,
    "std::vector<bool>" => read_std_vector_bool,
    "std::vector<SXElem>" => read_std_vector_SXElem,
    "std::vector<std::vector<int>>" => read_std_vector_std_vector_int,
    "std::vector<unsignedint>" => read_std_vector_unsignedint,
    "std::vector<size_t>" => read_std_vector_size_t,
    "std::vector<Sparsity>" => read_std_vector_Sparsity,
    "std::map<std::string,std::vector<size_t>>" => read_std_map_std_string_std_vector_size_t,
    "std::vector<std::vector<size_t>>" => read_std_vector_std_vector_size_t,
    "std::vector<Function>" => read_std_vector_Function,
    "std::pair<casadi_int,std::string>" => read_std_pair_casadi_int_std_string,
    "std::map<std::string,std::pair<casadi_int,std::string>>" => read_std_map_std_string_std_pair_casadi_int_std_string,
    "std::pair<bool,std::string>" => read_std_pair_bool_std_string,
    "std::map<std::string,std::pair<bool,std::string>>" => read_std_map_std_string_std_pair_bool_std_string,
    "std::vector<MX>" => read_std_vector_MX,
    "std::map<std::string,std::vector<double>>" => read_std_map_std_string_std_vector_double,
    "std::map<std::string,casadi_int>" => read_std_map_std_string_casadi_int,
    "std::map<std::string,std::vector<casadi_int>>" => read_std_map_std_string_std_vector_casadi_int,
    "std::map<std::string,bool>" => read_std_map_std_string_bool,
    "std::map<std::string,double>" => read_std_map_std_string_double,
    "std::vector<SX>" => read_std_vector_SX,
    "std::vector<std::vector<casadi_int>>" => read_std_vector_std_vector_casadi_int,
    "std::vector<std::vector<std::string>>" => read_std_vector_std_vector_std_string,
    "std::vector<Dict>" => read_std_vector_Dict,
    "std::vector<GenericType>" => read_std_vector_GenericType,
    "std::vector<std::vector<GenericType>>" => read_std_vector_std_vector_GenericType,
    "std::vector<DM>" => read_std_vector_DM,
    "Dict" => read_Dict,
)
const METADATA = Dict("wire" => Dict("magic" => 123456789012345, "protocol" => 3), "reader" => Dict("file_types" => Dict("0" => "Sparsity", "1" => "MX", "10" => "std::vector<Sparsity>", "11" => "std::vector<MX>", "12" => "std::vector<DM>", "13" => "std::vector<SX>", "15" => "std::vector<Function>", "16" => "std::vector<GenericType>", "17" => "std::vector<casadi_int>", "18" => "std::vector<double>", "19" => "std::vector<std::string>", "2" => "DM", "20" => "MX", "21" => "SX", "22" => "std::vector<MX>", "23" => "std::vector<SX>", "3" => "SX", "4" => "Linsol", "5" => "Function", "6" => "GenericType", "7" => "casadi_int", "8" => "double", "9" => "std::string"), "file_prefixes" => Dict("1" => "Function", "11" => "Function", "13" => "Function", "20" => "std::vector<MX>", "21" => "std::vector<SX>", "22" => "std::vector<MX>", "23" => "std::vector<SX>", "3" => "Function")))
