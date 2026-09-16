// Generated from serialization_scheme.json; do not edit.
void layout_AlpaqaInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "AlpaqaInterface", 1);
    field(record, "AlpaqaInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "AlpaqaInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_AmplInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    --depth;
}

void layout_Assertion_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "Assertion::fail_message", "std::string", [&]() { return string(); });
    --depth;
}

void layout_BSpline_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("BSplineCommon::serialize_body"));
    layout_BSplineCommon_serialize_body(record, scope);
    field(record, "BSpline::coeffs", "std::vector<double>", [&]() { return read_std_vector_double(); });
    --depth;
}

void layout_BSpline_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["BSpline::type"] = field(record, "BSpline::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_BSplineCommon_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "BSplineCommon::knots", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "BSplineCommon::offset", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "BSplineCommon::degree", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "BSplineCommon::m", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "BSplineCommon::lookup_mode", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "BSplineCommon::strides", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "BSplineCommon::coeffs_dims", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "BSplineCommon::coeffs_size", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "BSplineCommon::jac_cache_", "MX", [&]() { return read_MX(); });
    --depth;
}

void layout_BSplineInterpolant_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Interpolant::serialize_body"));
    layout_Interpolant_serialize_body(record, scope);
    version(record, "BSplineInterpolant", 1);
    field(record, "BSplineInterpolant::s", "Function", [&]() { return read_Function(); });
    --depth;
}

void layout_BSplineParametric_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("BSplineCommon::serialize_body"));
    layout_BSplineCommon_serialize_body(record, scope);
    --depth;
}

void layout_BSplineParametric_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["BSpline::type"] = field(record, "BSpline::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_BackwardDiff_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("ForwardDiff::serialize_body"));
    layout_ForwardDiff_serialize_body(record, scope);
    --depth;
}

void layout_Bilin_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_BinaryMX_ScX_ScY_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "BinaryMX::op", "int", [&]() { return number("int"); });
    --depth;
}

void layout_BinaryMX_ScX_ScY_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_BinarySX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "UnarySX::dep0", "SXElem", [&]() { return read_SXElem(); });
    field(record, "UnarySX::dep1", "SXElem", [&]() { return read_SXElem(); });
    --depth;
}

void layout_Bisection_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Rootfinder::serialize_body"));
    layout_Rootfinder_serialize_body(record, scope);
    version(record, "Bisection", 1);
    field(record, "Bisection::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Bisection::max_search", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Bisection::search_step", "double", [&]() { return number("double"); });
    field(record, "Bisection::abstol", "double", [&]() { return number("double"); });
    field(record, "Bisection::abstol_step", "double", [&]() { return number("double"); });
    field(record, "Bisection::lb", "double", [&]() { return number("double"); });
    field(record, "Bisection::ub", "double", [&]() { return number("double"); });
    --depth;
}

void layout_BlazingSplineFunction_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "BlazingSplineFunction", 2);
    field(record, "BlazingSplineFunction::diff_order", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "BlazingSplineFunction::precompute_coeff", "bool", [&]() { return boolvalue(); });
    field(record, "BlazingSplineFunction::precompute_grid", "bool", [&]() { return boolvalue(); });
    field(record, "BlazingSplineFunction::knots", "std::vector<std::vector<double>>", [&]() { return read_std_vector_std_vector_double(); });
    field(record, "BlazingSplineFunction::lookup_modes", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    scope["BlazingSplineFunction::parametric_knots"] = field(record, "BlazingSplineFunction::parametric_knots", "bool", [&]() { return boolvalue(); });
    if (truth(scope.at("BlazingSplineFunction::parametric_knots"))) {
        field(record, "BlazingSplineFunction::knots_offset", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
        field(record, "BlazingSplineFunction::inv_input", "bool", [&]() { return boolvalue(); });
    }
    field(record, "BlazingSplineFunction::pedantic_mode_order", "std::string", [&]() { return string(); });
    field(record, "BlazingSplineFunction::pedantic_mode_size", "std::string", [&]() { return string(); });
    --depth;
}

void layout_Blocksqp_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "Blocksqp", 1);
    field(record, "Blocksqp::nblocks", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::blocks", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Blocksqp::dim", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Blocksqp::nnz_H", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::Asp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Blocksqp::Hsp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Blocksqp::exact_hess_lag_sp_", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Blocksqp::linsol_plugin", "std::string", [&]() { return string(); });
    field(record, "Blocksqp::print_header", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::print_iteration", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::eps", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::opttol", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::nlinfeastol", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::schur", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::globalization", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::restore_feas", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::max_line_search", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::max_consec_reduced_steps", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::max_consec_skipped_updates", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::max_it_qp", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::warmstart", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::qp_init", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::block_hess", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::hess_scaling", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::fallback_scaling", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::max_time_qp", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::ini_hess_diag", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::col_eps", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::col_tau1", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::col_tau2", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::hess_damp", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::hess_damp_fac", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::hess_update", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::fallback_update", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::hess_lim_mem", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::hess_memsize", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::which_second_derv", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::skip_first_globalization", "bool", [&]() { return boolvalue(); });
    field(record, "Blocksqp::conv_strategy", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::max_conv_qp", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::max_soc_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Blocksqp::gamma_theta", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::gamma_f", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::kappa_soc", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::kappa_f", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::theta_max", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::theta_min", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::delta", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::s_theta", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::s_f", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::kappa_minus", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::kappa_plus", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::kappa_plus_max", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::delta_h0", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::eta", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::obj_lo", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::obj_up", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::rho", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::zeta", "double", [&]() { return number("double"); });
    field(record, "Blocksqp::rp_solver", "Function", [&]() { return read_Function(); });
    field(record, "Blocksqp::print_maxit_reached", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_BonminInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "BonminInterface", 1);
    field(record, "BonminInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "BonminInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "BonminInterface::exact_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "BonminInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "BonminInterface::sos1_weights", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "BonminInterface::sos1_indices", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "BonminInterface::sos1_priorities", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "BonminInterface::sos1_starts", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "BonminInterface::sos1_types", "std::vector<char>", [&]() { return read_std_vector_char(); });
    field(record, "BonminInterface::sos1_types", "std::vector<char>", [&]() { return read_std_vector_char(); });
    field(record, "BonminInterface::sos_num", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "BonminInterface::sos_num_nz", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "BonminInterface::pass_nonlinear_variables", "bool", [&]() { return boolvalue(); });
    field(record, "BonminInterface::pass_nonlinear_constraints", "bool", [&]() { return boolvalue(); });
    field(record, "BonminInterface::nl_ex", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "BonminInterface::nl_g", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "BonminInterface::var_string_md", "Dict", [&]() { return read_Dict(); });
    field(record, "BonminInterface::var_integer_md", "Dict", [&]() { return read_Dict(); });
    field(record, "BonminInterface::var_numeric_md", "Dict", [&]() { return read_Dict(); });
    field(record, "BonminInterface::con_string_md", "Dict", [&]() { return read_Dict(); });
    field(record, "BonminInterface::con_integer_md", "Dict", [&]() { return read_Dict(); });
    field(record, "BonminInterface::con_numeric_md", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_CSparseCholeskyInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    --depth;
}

void layout_Call_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MultipleOutput::serialize_body"));
    layout_MultipleOutput_serialize_body(record, scope);
    field(record, "Call::fcn", "Function", [&]() { return read_Function(); });
    --depth;
}

void layout_CallSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "CallSX::f", "Function", [&]() { return read_Function(); });
    field(record, "CallSX::dep", "std::vector<SXElem>", [&]() { return read_std_vector_SXElem(); });
    --depth;
}

void layout_CbcInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "CbcInterface", 1);
    field(record, "CbcInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "CbcInterface::sos_groups", "std::vector<std::vector<int>>", [&]() { return read_std_vector_std_vector_int(); });
    field(record, "CbcInterface::sos_weights", "std::vector<std::vector<double>>", [&]() { return read_std_vector_std_vector_double(); });
    field(record, "CbcInterface::sos_types", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "CbcInterface::hot_start", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_CentralDiff_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FiniteDiff::serialize_body"));
    layout_FiniteDiff_serialize_body(record, scope);
    --depth;
}

void layout_ClarabelInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "ClarabelInterface", 1);
    field(record, "ClarabelInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_ClpInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "ClpInterface", 1);
    field(record, "ClpInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_Collocation_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("ImplicitFixedStepIntegrator::serialize_body"));
    layout_ImplicitFixedStepIntegrator_serialize_body(record, scope);
    version(record, "Collocation", 2);
    field(record, "Collocation::deg", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Collocation::collocation_scheme", "std::string", [&]() { return string(); });
    --depth;
}

void layout_Concat_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Conic_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "Conic::SDPToSOCPMem::r", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Conic::SDPToSOCPMem::AT", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Conic::SDPToSOCPMem::A_mapping", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Conic::SDPToSOCPMem::map_Q", "IM", [&]() { return read_IM(); });
    field(record, "Conic::SDPToSOCPMem::map_P", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Conic::SDPToSOCPMem::indval_size", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Conic_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "Conic", 4);
    field(record, "Conic::discrete", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "Conic::equality", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "Conic::print_problem", "bool", [&]() { return boolvalue(); });
    field(record, "Conic::solver_version_check", "bool", [&]() { return boolvalue(); });
    field(record, "Conic::H", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Conic::A", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Conic::Q", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Conic::P", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Conic::nx", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Conic::na", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Conic::np", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Conic_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_type"));
    layout_FunctionInternal_serialize_type(record, scope);
    record["layouts"].a.push_back(JsonValue("PluginInterface<Conic>::serialize_type"));
    layout_PluginInterface_Conic_serialize_type(record, scope);
    --depth;
}

void layout_ConoptInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "ConoptInterface", 1);
    field(record, "ConoptInterface::exact_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "ConoptInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "ConoptInterface::gradf_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "ConoptInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "ConoptInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "ConoptInterface::optfile", "std::string", [&]() { return string(); });
    field(record, "ConoptInterface::warm_start", "bool", [&]() { return boolvalue(); });
    field(record, "ConoptInterface::debug", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_Constant_Value_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Constant_Value_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["ConstantMX::type"] = field(record, "ConstantMX::type", "char", [&]() { return JsonValue(byte()); });
    fail("unlowered serialization call");
    --depth;
}

void layout_ConstantDM_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "ConstantMX::nonzeros", "std::vector<double>", [&]() { return read_std_vector_double(); });
    --depth;
}

void layout_ConstantDM_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["ConstantMX::type"] = field(record, "ConstantMX::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_ConstantFile_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "ConstantFile::fname", "std::string", [&]() { return string(); });
    field(record, "ConstantFile::x", "std::vector<double>", [&]() { return read_std_vector_double(); });
    --depth;
}

void layout_ConstantFile_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    field(record, "ConstantFile::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_ConstantPool_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "ConstantPool::name", "std::string", [&]() { return string(); });
    field(record, "ConstantPool::x", "std::vector<double>", [&]() { return read_std_vector_double(); });
    --depth;
}

void layout_ConstantPool_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    field(record, "ConstantPool::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_Convexify_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    version(record, (std::string((scope.at("prefix")).scalar) + "Convexify"), 1);
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::type_in"), "int", [&]() { return number("int"); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::strategy"), "int", [&]() { return number("int"); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::margin"), "double", [&]() { return number("double"); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::max_iter_eig"), "casadi_int", [&]() { return number("casadi_int"); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::scc_offset"), "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::scc_mapping"), "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::Hsp_project"), "int", [&]() { return number("int"); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::scc_transform"), "int", [&]() { return number("int"); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::verbose"), "int", [&]() { return number("int"); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::Hsp"), "Sparsity", [&]() { return read_Sparsity(); });
    field(record, (std::string((scope.at("prefix")).scalar) + "Convexify::Hrsp"), "Sparsity", [&]() { return read_Sparsity(); });
    --depth;
}

void layout_Convexify_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    record["layouts"].a.push_back(JsonValue("Convexify::serialize"));
    scope["prefix"] = JsonValue("");
    layout_Convexify_serialize(record, scope);
    --depth;
}

void layout_CplexInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "CplexInterface", 1);
    field(record, "CplexInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "CplexInterface::qp_method", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "CplexInterface::dump_to_file", "bool", [&]() { return boolvalue(); });
    field(record, "CplexInterface::tol", "double", [&]() { return number("double"); });
    field(record, "CplexInterface::dep_check", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "CplexInterface::warm_start", "bool", [&]() { return boolvalue(); });
    field(record, "CplexInterface::mip_start", "bool", [&]() { return boolvalue(); });
    field(record, "CplexInterface::mip", "bool", [&]() { return boolvalue(); });
    field(record, "CplexInterface::ctype", "std::vector<char>", [&]() { return read_std_vector_char(); });
    field(record, "CplexInterface::sos_weights", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "CplexInterface::sos_beg", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "CplexInterface::sos_ind", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "CplexInterface::sos_types", "std::vector<char>", [&]() { return read_std_vector_char(); });
    record["layouts"].a.push_back(JsonValue("Conic::serialize"));
    layout_Conic_serialize(record, scope);
    --depth;
}

void layout_CsparseInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    --depth;
}

void layout_CvodesInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("SundialsInterface::serialize_body"));
    layout_SundialsInterface_serialize_body(record, scope);
    version(record, "CvodesInterface", 3);
    field(record, "CvodesInterface::lmm", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "CvodesInterface::iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "CvodesInterface::min_step_size", "double", [&]() { return number("double"); });
    field(record, "CvodesInterface::always_recalculate_jacobian", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_DaqpInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "DaqpInterface", 1);
    field(record, "DaqpInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_DenseKron_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Kron::serialize_body"));
    layout_Kron_serialize_body(record, scope);
    --depth;
}

void layout_DenseKron_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Kron::kind"] = field(record, "Kron::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_DenseKronContract_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("KronContract::serialize_body"));
    layout_KronContract_serialize_body(record, scope);
    --depth;
}

void layout_DenseKronContract_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["KronContract::kind"] = field(record, "KronContract::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_DenseMultiplication_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Multiplication::serialize_body"));
    layout_Multiplication_serialize_body(record, scope);
    --depth;
}

void layout_DenseMultiplication_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Multiplication::kind"] = field(record, "Multiplication::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_DenseSparseKron_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Kron::serialize_body"));
    layout_Kron_serialize_body(record, scope);
    --depth;
}

void layout_DenseSparseKron_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Kron::kind"] = field(record, "Kron::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_DenseSparseKronContract_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("KronContract::serialize_body"));
    layout_KronContract_serialize_body(record, scope);
    --depth;
}

void layout_DenseSparseKronContract_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["KronContract::kind"] = field(record, "KronContract::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_DenseSparseMultiplication_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Multiplication::serialize_body"));
    layout_Multiplication_serialize_body(record, scope);
    --depth;
}

void layout_DenseSparseMultiplication_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Multiplication::kind"] = field(record, "Multiplication::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_DenseTranspose_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Transpose::serialize_body"));
    layout_Transpose_serialize_body(record, scope);
    --depth;
}

void layout_DenseTranspose_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Transpose::dense"] = field(record, "Transpose::dense", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_Densify_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Project::serialize_body"));
    layout_Project_serialize_body(record, scope);
    --depth;
}

void layout_Densify_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Project::type"] = field(record, "Project::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_Determinant_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "Determinant::linsol", "Linsol", [&]() { return read_Linsol(); });
    --depth;
}

void layout_Diagcat_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Concat::serialize_body"));
    layout_Concat_serialize_body(record, scope);
    --depth;
}

void layout_Diagsplit_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Split::serialize_body"));
    layout_Split_serialize_body(record, scope);
    --depth;
}

void layout_DirResource_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("ResourceInternal::serialize_body"));
    layout_ResourceInternal_serialize_body(record, scope);
    version(record, "DirResource", 1);
    if ((scope.at("ResourceInternal::serialize_mode")).scalar == "embed") {
        field(record, "ZipMemResource::blob", "std::stringstream", [&]() { return streamvalue(); });
    } else {
        field(record, "DirResource::path", "std::string", [&]() { return string(); });
    }
    --depth;
}

void layout_DirResource_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered else branch");
    --depth;
}

void layout_Dot_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Dump_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    version(record, "Dump", 1);
    field(record, "Dump::base_filename", "std::string", [&]() { return string(); });
    field(record, "Dump::dir", "std::string", [&]() { return string(); });
    field(record, "Dump::format", "std::string", [&]() { return string(); });
    field(record, "Dump::verbose", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_Einstein_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "Einstein::dim_c", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::dim_a", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::dim_b", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::c", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::a", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::b", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::iter_dims", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::strides_a", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::strides_b", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::strides_c", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Einstein::n_iter", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_External_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "External", 2);
    field(record, "External::int_data", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "External::real_data", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "External::string_data", "std::string", [&]() { return string(); });
    field(record, "External::li", "Importer", [&]() { return read_Importer(); });
    field(record, "External::config_args", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    --depth;
}

void layout_FastNewton_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Rootfinder::serialize_body"));
    layout_Rootfinder_serialize_body(record, scope);
    version(record, "Newton", 1);
    field(record, "Newton::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Newton::abstol", "double", [&]() { return number("double"); });
    field(record, "Newton::abstolStep", "double", [&]() { return number("double"); });
    field(record, "Newton::jac_g_x", "Function", [&]() { return read_Function(); });
    field(record, "Newton::sp_v", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Newton::sp_r", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Newton::prinv", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Newton::pc", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_FatropConicInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "FatropConicInterface", 1);
    --depth;
}

void layout_FatropInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "FatropInterface", 1);
    field(record, "FatropInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FatropInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FatropInterface::exact_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "FatropInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "FatropInterface::convexify", "bool", [&]() { return boolvalue(); });
    field(record, "FatropInterface::Isp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FatropInterface::ABsp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FatropInterface::CDsp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FatropInterface::RSQsp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FatropInterface::AB_blocks", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::CD_blocks", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::RSQ_blocks", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::I_blocks", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::nxs", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::nus", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::ngs", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::N", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FatropInterface::structure_detection", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FatropInterface::AB_offsets", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::CD_offsets", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::RSQ_offsets", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::I_offsets", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FatropInterface::debug", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_Feasiblesqpmethod_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "Feasiblesqpmethod", 3);
    field(record, "Feasiblesqpmethod::qpsol", "Function", [&]() { return read_Function(); });
    field(record, "Feasiblesqpmethod::exact_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "Feasiblesqpmethod::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Feasiblesqpmethod::min_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Feasiblesqpmethod::lbfgs_memory", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Feasiblesqpmethod::tol_pr_", "double", [&]() { return number("double"); });
    field(record, "Feasiblesqpmethod::tol_du_", "double", [&]() { return number("double"); });
    field(record, "Feasiblesqpmethod::print_header", "bool", [&]() { return boolvalue(); });
    field(record, "Feasiblesqpmethod::print_iteration", "bool", [&]() { return boolvalue(); });
    field(record, "Feasiblesqpmethod::print_status", "bool", [&]() { return boolvalue(); });
    field(record, "Feasiblesqpmethod::init_feasible", "bool", [&]() { return boolvalue(); });
    field(record, "Feasiblesqpmethod::Hsp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Feasiblesqpmethod::Asp", "Sparsity", [&]() { return read_Sparsity(); });
    scope["Feasiblesqpmethod::convexify"] = field(record, "Feasiblesqpmethod::convexify", "bool", [&]() { return boolvalue(); });
    if (truth(scope.at("Feasiblesqpmethod::convexify"))) {
        record["layouts"].a.push_back(JsonValue("Convexify::serialize"));
        scope["prefix"] = JsonValue("Feasiblesqpmethod::");
        layout_Convexify_serialize(record, scope);
    }
    --depth;
}

void layout_Find_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_FiniteDiff_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "FiniteDiff", 1);
    field(record, "FiniteDiff::n", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FiniteDiff::h_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FiniteDiff::h", "double", [&]() { return number("double"); });
    field(record, "FiniteDiff::n_z", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FiniteDiff::n_y", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FiniteDiff::u_aim", "double", [&]() { return number("double"); });
    field(record, "FiniteDiff::h_min", "double", [&]() { return number("double"); });
    field(record, "FiniteDiff::h_max", "double", [&]() { return number("double"); });
    field(record, "FiniteDiff::reltol", "double", [&]() { return number("double"); });
    field(record, "FiniteDiff::abstol", "double", [&]() { return number("double"); });
    field(record, "FiniteDiff::smoothing", "double", [&]() { return number("double"); });
    --depth;
}

void layout_FixedStepIntegrator_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Integrator::serialize_body"));
    layout_Integrator_serialize_body(record, scope);
    version(record, "FixedStepIntegrator", 3);
    field(record, "FixedStepIntegrator::nk_target", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FixedStepIntegrator::disc", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FixedStepIntegrator::nv", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FixedStepIntegrator::nv1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FixedStepIntegrator::nrv", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FixedStepIntegrator::nrv1", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Fmu2_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FmuInternal::serialize_body"));
    layout_FmuInternal_serialize_body(record, scope);
    version(record, "Fmu2", 2);
    field(record, "Fmu2::vr_real", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu2::vr_integer", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu2::vr_boolean", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu2::vr_string", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu2::init_real", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "Fmu2::init_integer", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "Fmu2::init_boolean", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "Fmu2::init_string", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu2::vn_aux_real", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu2::vn_aux_integer", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu2::vn_aux_boolean", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu2::vn_aux_string", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu2::vr_aux_real", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu2::vr_aux_integer", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu2::vr_aux_boolean", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu2::vr_aux_string", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    --depth;
}

void layout_Fmu3_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FmuInternal::serialize_body"));
    layout_FmuInternal_serialize_body(record, scope);
    version(record, "Fmu3", 1);
    field(record, "Fmu3::vr_real", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu3::vr_integer", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu3::vr_boolean", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu3::vr_string", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu3::init_real", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "Fmu3::init_integer", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "Fmu3::init_boolean", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "Fmu3::init_string", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu3::vn_aux_real", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu3::vn_aux_integer", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu3::vn_aux_boolean", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu3::vn_aux_string", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Fmu3::vr_aux_real", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu3::vr_aux_integer", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu3::vr_aux_boolean", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "Fmu3::vr_aux_string", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    --depth;
}

void layout_Fmu_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    --depth;
}

void layout_FmuFunction_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "FmuFunction", 6);
    field(record, "FmuFunction::Fmu", "Fmu", [&]() { return read_Fmu(); });
    const auto count_1 = this->count(JsonValue(int64_t((scope.at("FunctionInternal::sp_in")).a.size())));
    for (uint64_t i_2 = 0; i_2 < count_1; ++i_2) {
        field(record, "FmuFunction::in::type", "int", [&]() { return number("int"); });
        field(record, "FmuFunction::in::ind", "size_t", [&]() { return number("size_t"); });
    }
    const auto count_3 = this->count(JsonValue(int64_t((scope.at("FunctionInternal::sp_out")).a.size())));
    for (uint64_t i_4 = 0; i_4 < count_3; ++i_4) {
        field(record, "FmuFunction::out::type", "int", [&]() { return number("int"); });
        field(record, "FmuFunction::out::ind", "size_t", [&]() { return number("size_t"); });
        field(record, "FmuFunction::out::wrt", "size_t", [&]() { return number("size_t"); });
        field(record, "FmuFunction::out::rbegin", "size_t", [&]() { return number("size_t"); });
        field(record, "FmuFunction::out::rend", "size_t", [&]() { return number("size_t"); });
        field(record, "FmuFunction::out::cbegin", "size_t", [&]() { return number("size_t"); });
        field(record, "FmuFunction::out::cend", "size_t", [&]() { return number("size_t"); });
    }
    field(record, "FmuFunction::jac_in", "std::vector<size_t>", [&]() { return read_std_vector_size_t(); });
    field(record, "FmuFunction::jac_out", "std::vector<size_t>", [&]() { return read_std_vector_size_t(); });
    field(record, "FmuFunction::jac_nom_in", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "FmuFunction::sp_trans", "std::vector<Sparsity>", [&]() { return read_std_vector_Sparsity(); });
    field(record, "FmuFunction::sp_trans_map", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FmuFunction::has_jac", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::has_fwd", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::has_adj", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::has_hess", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::uses_directional_derivatives", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::uses_adjoint_derivatives", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::nfwd", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FmuFunction::nadj", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FmuFunction::validate_forward", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::validate_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::make_symmetric", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::step", "double", [&]() { return number("double"); });
    field(record, "FmuFunction::fd_flip", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::abstol", "double", [&]() { return number("double"); });
    field(record, "FmuFunction::reltol", "double", [&]() { return number("double"); });
    field(record, "FmuFunction::print_progress", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::new_jacobian", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::new_forward", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::new_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::hessian_coloring", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::asymmetric_hessian_coloring", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::enable_forward_jacobian", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::enable_adjoint_jacobian", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::enable_adjoint_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "FmuFunction::validate_ad_file", "std::string", [&]() { return string(); });
    field(record, "FmuFunction::fd", "int", [&]() { return number("int"); });
    field(record, "FmuFunction::parallelization", "int", [&]() { return number("int"); });
    field(record, "FmuFunction::init_stats", "Dict", [&]() { return read_Dict(); });
    field(record, "FmuFunction::jac_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuFunction::hess_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuFunction::adj_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuFunction::jac_colors", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuFunction::adj_colors", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuFunction::hess_colors", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuFunction::hess_uni_colors", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuFunction::which_hess_color", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FmuFunction::nonlin", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "FmuFunction::max_jac_tasks", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FmuFunction::max_hess_tasks", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FmuFunction::max_n_tasks", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_FmuInternal_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    fail("unlowered serialization call");
    --depth;
}

void layout_FmuInternal_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    version(record, "FmuInternal", 4);
    field(record, "FmuInternal::name", "std::string", [&]() { return string(); });
    field(record, "FmuInternal::scheme_in", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "FmuInternal::scheme_out", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "FmuInternal::scheme", "std::map<std::string,std::vector<size_t>>", [&]() { return read_std_map_std_string_std_vector_size_t(); });
    field(record, "FmuInternal::aux", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "FmuInternal::iind", "std::vector<size_t>", [&]() { return read_std_vector_size_t(); });
    field(record, "FmuInternal::iind_map", "std::vector<size_t>", [&]() { return read_std_vector_size_t(); });
    field(record, "FmuInternal::oind", "std::vector<size_t>", [&]() { return read_std_vector_size_t(); });
    field(record, "FmuInternal::oind_map", "std::vector<size_t>", [&]() { return read_std_vector_size_t(); });
    field(record, "FmuInternal::has_independent", "bool", [&]() { return boolvalue(); });
    field(record, "FmuInternal::nominal_in", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "FmuInternal::nominal_out", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "FmuInternal::min_in", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "FmuInternal::min_out", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "FmuInternal::max_in", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "FmuInternal::max_out", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "FmuInternal::vn_in", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "FmuInternal::vn_out", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "FmuInternal::vr_in", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "FmuInternal::vr_out", "std::vector<unsignedint>", [&]() { return read_std_vector_unsignedint(); });
    field(record, "FmuInternal::value_in", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "FmuInternal::ired", "std::vector<std::vector<size_t>>", [&]() { return read_std_vector_std_vector_size_t(); });
    field(record, "FmuInternal::ored", "std::vector<std::vector<size_t>>", [&]() { return read_std_vector_std_vector_size_t(); });
    field(record, "FmuInternal::jac_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuInternal::hess_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "FmuInternal::resource", "Resource", [&]() { return read_Resource(); });
    field(record, "FmuInternal::fmutol", "double", [&]() { return number("double"); });
    field(record, "FmuInternal::instance_name", "std::string", [&]() { return string(); });
    field(record, "FmuInternal::instantiation_token", "std::string", [&]() { return string(); });
    field(record, "FmuInternal::logging_on", "bool", [&]() { return boolvalue(); });
    field(record, "FmuInternal::number_of_event_indicators", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FmuInternal::provides_directional_derivatives", "bool", [&]() { return boolvalue(); });
    field(record, "FmuInternal::provides_adjoint_derivatives", "bool", [&]() { return boolvalue(); });
    field(record, "FmuInternal::can_be_instantiated_only_once_per_process", "bool", [&]() { return boolvalue(); });
    field(record, "FmuInternal::start_time", "double", [&]() { return number("double"); });
    field(record, "FmuInternal::nx", "size_t", [&]() { return number("size_t"); });
    field(record, "FmuInternal::do_evaluation_dance", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_FmuInternal_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["FmuInternal::type"] = field(record, "FmuInternal::type", "std::string", [&]() { return string(); });
    --depth;
}

void layout_ForwardDiff_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FiniteDiff::serialize_body"));
    layout_FiniteDiff_serialize_body(record, scope);
    --depth;
}

void layout_Function_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Predicate has no serialized field");
    --depth;
}

void layout_FunctionInternal_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("ProtoFunction::serialize_body"));
    layout_ProtoFunction_serialize_body(record, scope);
    version(record, "FunctionInternal", 8);
    field(record, "FunctionInternal::is_diff_in", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "FunctionInternal::is_diff_out", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    scope["FunctionInternal::sp_in"] = field(record, "FunctionInternal::sp_in", "std::vector<Sparsity>", [&]() { return read_std_vector_Sparsity(); });
    scope["FunctionInternal::sp_out"] = field(record, "FunctionInternal::sp_out", "std::vector<Sparsity>", [&]() { return read_std_vector_Sparsity(); });
    field(record, "FunctionInternal::name_in", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "FunctionInternal::name_out", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    scope["FunctionInternal::jit"] = field(record, "FunctionInternal::jit", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::jit_cleanup", "bool", [&]() { return boolvalue(); });
    scope["FunctionInternal::jit_serialize"] = field(record, "FunctionInternal::jit_serialize", "std::string", [&]() { return string(); });
    if (((scope.at("FunctionInternal::jit_serialize")).scalar == "link" || (scope.at("FunctionInternal::jit_serialize")).scalar == "embed")) {
        field(record, "FunctionInternal::jit_library", "std::string", [&]() { return string(); });
        if ((scope.at("FunctionInternal::jit_serialize")).scalar == "embed") {
            field(record, "FunctionInternal::jit_binary", "std::stringstream", [&]() { return streamvalue(); });
        }
    }
    field(record, "FunctionInternal::jit_temp_suffix", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::jit_base_name", "std::string", [&]() { return string(); });
    field(record, "FunctionInternal::jit_options", "Dict", [&]() { return read_Dict(); });
    field(record, "FunctionInternal::compiler_plugin", "std::string", [&]() { return string(); });
    field(record, "FunctionInternal::has_refcount", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::cache_init", "Dict", [&]() { return read_Dict(); });
    field(record, "FunctionInternal::derivative_of", "Function", [&]() { return read_Function(); });
    field(record, "FunctionInternal::jac_penalty", "double", [&]() { return number("double"); });
    field(record, "FunctionInternal::enable_forward", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::enable_reverse", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::enable_jacobian", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::enable_fd", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::enable_forward_op", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::enable_reverse_op", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::enable_jacobian_op", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::enable_fd_op", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::ad_weight", "double", [&]() { return number("double"); });
    field(record, "FunctionInternal::ad_weight_sp", "double", [&]() { return number("double"); });
    field(record, "FunctionInternal::always_inline", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::never_inline", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::max_num_dir", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FunctionInternal::inputs_check", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::fd_step", "double", [&]() { return number("double"); });
    field(record, "FunctionInternal::fd_method", "std::string", [&]() { return string(); });
    field(record, "FunctionInternal::print_in", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::print_out", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::print_canonical", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::max_io", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "FunctionInternal::dump_in", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::dump_out", "bool", [&]() { return boolvalue(); });
    field(record, "FunctionInternal::dump_dir", "std::string", [&]() { return string(); });
    field(record, "FunctionInternal::dump_format", "std::string", [&]() { return string(); });
    field(record, "FunctionInternal::forward_options", "Dict", [&]() { return read_Dict(); });
    field(record, "FunctionInternal::reverse_options", "Dict", [&]() { return read_Dict(); });
    field(record, "FunctionInternal::jacobian_options", "Dict", [&]() { return read_Dict(); });
    field(record, "FunctionInternal::der_options", "Dict", [&]() { return read_Dict(); });
    field(record, "FunctionInternal::custom_jacobian", "Function", [&]() { return read_Function(); });
    field(record, "FunctionInternal::registered_functions", "std::vector<Function>", [&]() { return read_std_vector_Function(); });
    field(record, "FunctionInternal::sz_arg_per", "size_t", [&]() { return number("size_t"); });
    field(record, "FunctionInternal::sz_res_per", "size_t", [&]() { return number("size_t"); });
    field(record, "FunctionInternal::sz_iw_per", "size_t", [&]() { return number("size_t"); });
    field(record, "FunctionInternal::sz_w_per", "size_t", [&]() { return number("size_t"); });
    field(record, "FunctionInternal::sz_arg_tmp", "size_t", [&]() { return number("size_t"); });
    field(record, "FunctionInternal::sz_res_tmp", "size_t", [&]() { return number("size_t"); });
    field(record, "FunctionInternal::sz_iw_tmp", "size_t", [&]() { return number("size_t"); });
    field(record, "FunctionInternal::sz_w_tmp", "size_t", [&]() { return number("size_t"); });
    --depth;
}

void layout_FunctionInternal_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["FunctionInternal::base_function"] = field(record, "FunctionInternal::base_function", "std::string", [&]() { return string(); });
    --depth;
}

void layout_GenericExternal_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_type"));
    layout_FunctionInternal_serialize_type(record, scope);
    version(record, "GenericExternal", 1);
    scope["GenericExternal::type"] = field(record, "GenericExternal::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_GenericType_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["GenericType::type"] = field(record, "GenericType::type", "int", [&]() { return number("int"); });
    fail("unlowered serialization call");
    --depth;
}

void layout_GetNonzeros_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_GetNonzeros_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    --depth;
}

void layout_GetNonzerosParam_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_GetNonzerosParam_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    --depth;
}

void layout_GetNonzerosParamParam_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzerosParam::serialize_body"));
    layout_GetNonzerosParam_serialize_body(record, scope);
    --depth;
}

void layout_GetNonzerosParamParam_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzerosParam::serialize_type"));
    layout_GetNonzerosParam_serialize_type(record, scope);
    scope["GetNonzerosParam::type"] = field(record, "GetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_GetNonzerosParamSlice_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzerosParam::serialize_body"));
    layout_GetNonzerosParam_serialize_body(record, scope);
    field(record, "GetNonzerosParamSlice::outer", "Slice", [&]() { return read_Slice(); });
    --depth;
}

void layout_GetNonzerosParamSlice_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzerosParam::serialize_type"));
    layout_GetNonzerosParam_serialize_type(record, scope);
    scope["GetNonzerosParam::type"] = field(record, "GetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_GetNonzerosParamVector_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzerosParam::serialize_body"));
    layout_GetNonzerosParam_serialize_body(record, scope);
    --depth;
}

void layout_GetNonzerosParamVector_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzerosParam::serialize_type"));
    layout_GetNonzerosParam_serialize_type(record, scope);
    scope["GetNonzerosParam::type"] = field(record, "GetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_GetNonzerosSlice2_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzeros::serialize_body"));
    layout_GetNonzeros_serialize_body(record, scope);
    field(record, "GetNonzerosSlice2::inner", "Slice", [&]() { return read_Slice(); });
    field(record, "GetNonzerosSlice2::outer", "Slice", [&]() { return read_Slice(); });
    --depth;
}

void layout_GetNonzerosSlice2_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzeros::serialize_type"));
    layout_GetNonzeros_serialize_type(record, scope);
    scope["GetNonzeros::type"] = field(record, "GetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_GetNonzerosSlice_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzeros::serialize_body"));
    layout_GetNonzeros_serialize_body(record, scope);
    field(record, "GetNonzerosSlice::slice", "Slice", [&]() { return read_Slice(); });
    --depth;
}

void layout_GetNonzerosSlice_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzeros::serialize_type"));
    layout_GetNonzeros_serialize_type(record, scope);
    scope["GetNonzeros::type"] = field(record, "GetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_GetNonzerosSliceParam_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzerosParam::serialize_body"));
    layout_GetNonzerosParam_serialize_body(record, scope);
    field(record, "GetNonzerosSliceParam::inner", "Slice", [&]() { return read_Slice(); });
    --depth;
}

void layout_GetNonzerosSliceParam_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzerosParam::serialize_type"));
    layout_GetNonzerosParam_serialize_type(record, scope);
    scope["GetNonzerosParam::type"] = field(record, "GetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_GetNonzerosVector_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzeros::serialize_body"));
    layout_GetNonzeros_serialize_body(record, scope);
    field(record, "GetNonzerosVector::nonzeros", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_GetNonzerosVector_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("GetNonzeros::serialize_type"));
    layout_GetNonzeros_serialize_type(record, scope);
    scope["GetNonzeros::type"] = field(record, "GetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_GurobiInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "GurobiInterface", 2);
    field(record, "GurobiInterface::lazy_constraints_callback", "Function", [&]() { return read_Function(); });
    field(record, "GurobiInterface::vtype", "std::vector<char>", [&]() { return read_std_vector_char(); });
    field(record, "GurobiInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "GurobiInterface::sos_weights", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "GurobiInterface::sos_beg", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "GurobiInterface::sos_ind", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "GurobiInterface::sos_types", "std::vector<int>", [&]() { return read_std_vector_int(); });
    record["layouts"].a.push_back(JsonValue("Conic::serialize"));
    layout_Conic_serialize(record, scope);
    --depth;
}

void layout_HighsInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "HighsInterface", 1);
    field(record, "HighsInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_HorzRepmat_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "HorzRepmat::n", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_HorzRepsum_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "HorzRepsum::n", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Horzcat_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Concat::serialize_body"));
    layout_Concat_serialize_body(record, scope);
    --depth;
}

void layout_Horzsplit_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Split::serialize_body"));
    layout_Split_serialize_body(record, scope);
    --depth;
}

void layout_HpipmInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "HpipmInterface", 1);
    --depth;
}

void layout_HpmpcInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    --depth;
}

void layout_IOInstruction_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "IOInstruction::ind", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "IOInstruction::segment", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "IOInstruction::offset", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_IdasInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("SundialsInterface::serialize_body"));
    layout_SundialsInterface_serialize_body(record, scope);
    version(record, "IdasInterface", 2);
    field(record, "IdasInterface::cj_scaling", "bool", [&]() { return boolvalue(); });
    field(record, "IdasInterface::calc_ic", "bool", [&]() { return boolvalue(); });
    field(record, "IdasInterface::calc_icB", "bool", [&]() { return boolvalue(); });
    field(record, "IdasInterface::suppress_algebraic", "bool", [&]() { return boolvalue(); });
    field(record, "IdasInterface::abstolv", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "IdasInterface::first_time", "double", [&]() { return number("double"); });
    field(record, "IdasInterface::init_xdot", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "IdasInterface::max_step_size", "double", [&]() { return number("double"); });
    field(record, "IdasInterface::y_c", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_ImplicitFixedStepIntegrator_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FixedStepIntegrator::serialize_body"));
    layout_FixedStepIntegrator_serialize_body(record, scope);
    version(record, "ImplicitFixedStepIntegrator", 2);
    --depth;
}

void layout_ImplicitToNlp_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Rootfinder::serialize_body"));
    layout_Rootfinder_serialize_body(record, scope);
    --depth;
}

void layout_Importer_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    --depth;
}

void layout_ImporterInternal_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    fail("unlowered serialization call");
    --depth;
}

void layout_ImporterInternal_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    version(record, "ImporterInternal", 1);
    field(record, "ImporterInternal::name", "std::string", [&]() { return string(); });
    field(record, "ImporterInternal::meta", "std::map<std::string,std::pair<casadi_int,std::string>>", [&]() { return read_std_map_std_string_std_pair_casadi_int_std_string(); });
    field(record, "ImporterInternal::external", "std::map<std::string,std::pair<bool,std::string>>", [&]() { return read_std_map_std_string_std_pair_bool_std_string(); });
    --depth;
}

void layout_ImporterInternal_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ImporterInternal::type"] = field(record, "ImporterInternal::type", "std::string", [&]() { return string(); });
    --depth;
}

void layout_InfSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_Input_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("IOInstruction::serialize_body"));
    layout_IOInstruction_serialize_body(record, scope);
    --depth;
}

void layout_IntegerSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
    field(record, "ConstantSX::value", "int", [&]() { return number("int"); });
    --depth;
}

void layout_Integrator_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("OracleFunction::serialize_body"));
    layout_OracleFunction_serialize_body(record, scope);
    version(record, "Integrator", 3);
    field(record, "Integrator::sp_jac_dae", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Integrator::sp_jac_rdae", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Integrator::t0", "double", [&]() { return number("double"); });
    field(record, "Integrator::tout", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "Integrator::nfwd", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nadj", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::rdae", "Function", [&]() { return read_Function(); });
    field(record, "Integrator::nx", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nz", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nq", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nx1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nz1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nq1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nrx", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nrz", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nrq", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nuq", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nrx1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nrz1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nrq1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nuq1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::np", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nrp", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::np1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nrp1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nu", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nu1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::ne", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::ntmp", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::nom_x", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "Integrator::nom_z", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "Integrator::augmented_options", "Dict", [&]() { return read_Dict(); });
    field(record, "Integrator::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "Integrator::print_stats", "bool", [&]() { return boolvalue(); });
    field(record, "Integrator::transition", "Function", [&]() { return read_Function(); });
    field(record, "Integrator::max_event_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::max_events", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Integrator::event_tol", "double", [&]() { return number("double"); });
    field(record, "Integrator::event_acceptable_tol", "double", [&]() { return number("double"); });
    --depth;
}

void layout_Integrator_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("OracleFunction::serialize_type"));
    layout_OracleFunction_serialize_type(record, scope);
    record["layouts"].a.push_back(JsonValue("PluginInterface<Integrator>::serialize_type"));
    layout_PluginInterface_Integrator_serialize_type(record, scope);
    --depth;
}

void layout_Interpolant_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "Interpolant", 2);
    field(record, "Interpolant::ndim", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Interpolant::m", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Interpolant::grid", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "Interpolant::offset", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Interpolant::values", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "Interpolant::lookup_modes", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "Interpolant::batch_x", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Interpolant_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_type"));
    layout_FunctionInternal_serialize_type(record, scope);
    record["layouts"].a.push_back(JsonValue("PluginInterface<Interpolant>::serialize_type"));
    layout_PluginInterface_Interpolant_serialize_type_2(record, scope);
    --depth;
}

void layout_Inverse_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_IpoptInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "IpoptInterface", 3);
    field(record, "IpoptInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "IpoptInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "IpoptInterface::exact_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "IpoptInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "IpoptInterface::pass_nonlinear_variables", "bool", [&]() { return boolvalue(); });
    field(record, "IpoptInterface::nl_ex", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "IpoptInterface::var_string_md", "Dict", [&]() { return read_Dict(); });
    field(record, "IpoptInterface::var_integer_md", "Dict", [&]() { return read_Dict(); });
    field(record, "IpoptInterface::var_numeric_md", "Dict", [&]() { return read_Dict(); });
    field(record, "IpoptInterface::con_string_md", "Dict", [&]() { return read_Dict(); });
    field(record, "IpoptInterface::con_integer_md", "Dict", [&]() { return read_Dict(); });
    field(record, "IpoptInterface::con_numeric_md", "Dict", [&]() { return read_Dict(); });
    scope["IpoptInterface::convexify"] = field(record, "IpoptInterface::convexify", "bool", [&]() { return boolvalue(); });
    if (truth(scope.at("IpoptInterface::convexify"))) {
        record["layouts"].a.push_back(JsonValue("Convexify::serialize"));
        scope["prefix"] = JsonValue("IpoptInterface::");
        layout_Convexify_serialize(record, scope);
    }
    field(record, "IpoptInterface::clip_inactive_lam", "bool", [&]() { return boolvalue(); });
    field(record, "IpoptInterface::inactive_lam_strategy", "std::string", [&]() { return string(); });
    field(record, "IpoptInterface::inactive_lam_value", "double", [&]() { return number("double"); });
    --depth;
}

void layout_Ipqp_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "Ipqp", 1);
    field(record, "Ipqp::kkt", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Ipqp::print_iter", "bool", [&]() { return boolvalue(); });
    field(record, "Ipqp::print_header", "bool", [&]() { return boolvalue(); });
    field(record, "Ipqp::print_info", "bool", [&]() { return boolvalue(); });
    field(record, "Ipqp::linear_solver", "std::string", [&]() { return string(); });
    field(record, "Ipqp::linear_solver_options", "Dict", [&]() { return read_Dict(); });
    field(record, "Ipqp::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Ipqp::pr_tol", "double", [&]() { return number("double"); });
    field(record, "Ipqp::du_tol", "double", [&]() { return number("double"); });
    field(record, "Ipqp::co_tol", "double", [&]() { return number("double"); });
    field(record, "Ipqp::mu_tol", "double", [&]() { return number("double"); });
    --depth;
}

void layout_KinsolInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Rootfinder::serialize_body"));
    layout_Rootfinder_serialize_body(record, scope);
    --depth;
}

void layout_KnitroInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "KnitroInterface", 2);
    field(record, "KnitroInterface::contype", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "KnitroInterface::comp_type", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "KnitroInterface::comp_i1", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "KnitroInterface::comp_i2", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "KnitroInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "KnitroInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "KnitroInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "KnitroInterface::options_file", "std::string", [&]() { return string(); });
    --depth;
}

void layout_Kron_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Kron_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Kron::kind"] = field(record, "Kron::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_KronContract_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "KronContract::inner", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_KronContract_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["KronContract::kind"] = field(record, "KronContract::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_LapackLu_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    version(record, "LapackLu", 1);
    field(record, "LapackLu::equilibriate", "bool", [&]() { return boolvalue(); });
    field(record, "LapackLu::allow_equilibration_failure", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_LapackQr_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    field(record, "LapackQr::max_nrhs", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_LinearInterpolant_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Interpolant::serialize_body"));
    layout_Interpolant_serialize_body(record, scope);
    field(record, "LinearInterpolant::lookup_mode", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_LinearInterpolant_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Interpolant::serialize_type"));
    layout_Interpolant_serialize_type(record, scope);
    version(record, "LinearInterpolant", 1);
    scope["LinearInterpolant::type"] = field(record, "LinearInterpolant::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_LinearInterpolantJac_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    --depth;
}

void layout_LinearInterpolantJac_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_type"));
    layout_FunctionInternal_serialize_type(record, scope);
    record["layouts"].a.push_back(JsonValue(">PluginInterface<Interpolant>::serialize_type"));
    layout_PluginInterface_Interpolant_serialize_type(record, scope);
    version(record, "LinearInterpolant", 1);
    scope["LinearInterpolant::type"] = field(record, "LinearInterpolant::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_Linsol_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    --depth;
}

void layout_LinsolCall_Tr_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Solve<Tr>::serialize_body"));
    layout_Solve_Tr_serialize_body(record, scope);
    field(record, "Solve::Linsol", "Linsol", [&]() { return read_Linsol(); });
    --depth;
}

void layout_LinsolCall_Tr_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Solve<Tr>::serialize_type"));
    layout_Solve_Tr_serialize_type(record, scope);
    --depth;
}

void layout_LinsolInternal_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("ProtoFunction::serialize_body"));
    layout_ProtoFunction_serialize_body(record, scope);
    field(record, "LinsolInternal::sp", "Sparsity", [&]() { return read_Sparsity(); });
    --depth;
}

void layout_LinsolInternal_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("ProtoFunction::serialize_type"));
    layout_ProtoFunction_serialize_type(record, scope);
    record["layouts"].a.push_back(JsonValue("PluginInterface<LinsolInternal>::serialize_type"));
    layout_PluginInterface_LinsolInternal_serialize_type(record, scope);
    --depth;
}

void layout_LinsolLdl_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    version(record, "LinsolLdl", 1);
    field(record, "LinsolLdl::p", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "LinsolLdl::sp_Lt", "Sparsity", [&]() { return read_Sparsity(); });
    --depth;
}

void layout_LinsolQr_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    version(record, "LinsolQr", 2);
    field(record, "LinsolQr::prinv", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "LinsolQr::pc", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "LinsolQr::sp_v", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "LinsolQr::sp_r", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "LinsolQr::eps", "double", [&]() { return number("double"); });
    field(record, "LinsolQr::n_cache", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_LinsolTridiag_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    --depth;
}

void layout_LogSumExp_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Low_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "Low::lookup_mode", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Lsqr_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    --depth;
}

void layout_MMax_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_MMin_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_MX_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    --depth;
}

void layout_MXFunction_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("XFunction<MXFunction,MX,MXNode>::serialize_body"));
    layout_XFunction_MXFunction_MX_MXNode_serialize_body(record, scope);
    version(record, "MXFunction", 3);
    scope["MXFunction::n_instr"] = field(record, "MXFunction::n_instr", "size_t", [&]() { return number("size_t"); });
    const auto count_5 = this->count(scope.at("MXFunction::n_instr"));
    for (uint64_t i_6 = 0; i_6 < count_5; ++i_6) {
        field(record, "MXFunction::alg::data", "MX", [&]() { return read_MX(); });
        field(record, "MXFunction::alg::arg", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
        field(record, "MXFunction::alg::res", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    }
    field(record, "MXFunction::workloc", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "MXFunction::free_vars", "std::vector<MX>", [&]() { return read_std_vector_MX(); });
    field(record, "MXFunction::default_in", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "MXFunction::live_variables", "bool", [&]() { return boolvalue(); });
    field(record, "MXFunction::print_instructions", "bool", [&]() { return boolvalue(); });
    field(record, "MXFunction::dump_trace", "bool", [&]() { return boolvalue(); });
    record["layouts"].a.push_back(JsonValue("XFunction<MXFunction,MX,MXNode>::delayed_serialize_members"));
    layout_XFunction_MXFunction_MX_MXNode_delayed_serialize_members(record, scope);
    --depth;
}

void layout_MXNode_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    fail("unlowered serialization call");
    --depth;
}

void layout_MXNode_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "MXNode::deps", "std::vector<MX>", [&]() { return read_std_vector_MX(); });
    field(record, "MXNode::sp", "Sparsity", [&]() { return read_Sparsity(); });
    --depth;
}

void layout_MXNode_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["MXNode::op"] = field(record, "MXNode::op", "int", [&]() { return number("int"); });
    --depth;
}

void layout_Ma27Interface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    --depth;
}

void layout_MadmpecInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "MadmpecInterface", 1);
    field(record, "MadmpecInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "MadmpecInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "MadmpecInterface::exact_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "MadmpecInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "MadmpecInterface::convexify", "bool", [&]() { return boolvalue(); });
    field(record, "MadmpecInterface::ind_cc1", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "MadmpecInterface::ind_cc2", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "MadmpecInterface::cctypes", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_MadnlpInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "MadnlpInterface", 2);
    field(record, "MadnlpInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "MadnlpInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "MadnlpInterface::exact_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "MadnlpInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "MadnlpInterface::convexify", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_Map_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    field(record, "Map::f", "Function", [&]() { return read_Function(); });
    field(record, "Map::n", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Map_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_type"));
    layout_FunctionInternal_serialize_type(record, scope);
    scope["Map::class_name"] = field(record, "Map::class_name", "std::string", [&]() { return string(); });
    --depth;
}

void layout_MapSum_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    field(record, "MapSum::f", "Function", [&]() { return read_Function(); });
    field(record, "MapSum::n", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "MapSum::reduce_in", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "MapSum::reduce_out", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    --depth;
}

void layout_MapSum_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_type"));
    layout_FunctionInternal_serialize_type(record, scope);
    scope["MapSum::class_name"] = field(record, "MapSum::class_name", "std::string", [&]() { return string(); });
    --depth;
}

void layout_Matrix_SXElem_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "Matrix::sparsity", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Matrix::nonzeros", "std::vector<SXElem>", [&]() { return read_std_vector_SXElem(); });
    --depth;
}

void layout_Matrix_casadi_int_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "Matrix::sparsity", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Matrix::nonzeros", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_Matrix_double_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "Matrix::sparsity", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Matrix::nonzeros", "std::vector<double>", [&]() { return read_std_vector_double(); });
    --depth;
}

void layout_MinusInfSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_MinusOneSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_Monitor_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "Monitor::comment", "std::string", [&]() { return string(); });
    --depth;
}

void layout_MosekInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "MosekInterface", 1);
    field(record, "MosekInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_MultipleOutput_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Multiplication_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "Multiplication::blas", "std::string", [&]() { return string(); });
    --depth;
}

void layout_Multiplication_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Multiplication::kind"] = field(record, "Multiplication::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_MumpsInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    version(record, "Mumps", 1);
    field(record, "MumpsInterface::symmetric", "bool", [&]() { return boolvalue(); });
    field(record, "MumpsInterface::posdef", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_NanSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_Newton_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Rootfinder::serialize_body"));
    layout_Rootfinder_serialize_body(record, scope);
    version(record, "Newton", 1);
    field(record, "Newton::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Newton::abstol", "double", [&]() { return number("double"); });
    field(record, "Newton::abstolStep", "double", [&]() { return number("double"); });
    field(record, "Newton::print_iteration", "bool", [&]() { return boolvalue(); });
    field(record, "Newton::line_search", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_Nlpsol_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("OracleFunction::serialize_body"));
    layout_OracleFunction_serialize_body(record, scope);
    version(record, "Nlpsol", 5);
    field(record, "Nlpsol::nx", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Nlpsol::ng", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Nlpsol::np", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Nlpsol::fcallback", "Function", [&]() { return read_Function(); });
    field(record, "Nlpsol::callback_step", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Nlpsol::eval_errors_fatal", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::warn_initial_bounds", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::iteration_callback_ignore_errors", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::calc_multipliers", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::calc_lam_x", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::calc_lam_p", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::calc_f", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::calc_g", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::min_lam", "double", [&]() { return number("double"); });
    field(record, "Nlpsol::bound_consistency", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::no_nlp_grad", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::discrete", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "Nlpsol::equality", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    field(record, "Nlpsol::mi", "bool", [&]() { return boolvalue(); });
    field(record, "Nlpsol::sens_linsol", "std::string", [&]() { return string(); });
    field(record, "Nlpsol::sens_linsol_options", "Dict", [&]() { return read_Dict(); });
    field(record, "Nlpsol::detect_simple_bounds_is_simple", "std::vector<char>", [&]() { return read_std_vector_char(); });
    field(record, "Nlpsol::detect_simple_bounds_parts", "Function", [&]() { return read_Function(); });
    field(record, "Nlpsol::detect_simple_bounds_target_x", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_Nlpsol_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("OracleFunction::serialize_type"));
    layout_OracleFunction_serialize_type(record, scope);
    record["layouts"].a.push_back(JsonValue("PluginInterface<Nlpsol>::serialize_type"));
    layout_PluginInterface_Nlpsol_serialize_type(record, scope);
    --depth;
}

void layout_Norm1_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Norm::serialize_body"));
    layout_Norm_serialize_body(record, scope);
    --depth;
}

void layout_Norm2_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Norm::serialize_body"));
    layout_Norm_serialize_body(record, scope);
    --depth;
}

void layout_Norm_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_NormF_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Norm::serialize_body"));
    layout_Norm_serialize_body(record, scope);
    --depth;
}

void layout_NormInf_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Norm::serialize_body"));
    layout_Norm_serialize_body(record, scope);
    --depth;
}

void layout_OmpMap_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Map::serialize_body"));
    layout_Map_serialize_body(record, scope);
    --depth;
}

void layout_OneSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_OnnxFunction_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "OnnxFunction", 2);
    field(record, "OnnxFunction::model_data", "std::string", [&]() { return string(); });
    record["layouts"].a.push_back(JsonValue("pack_tensors"));
    scope["d"] = JsonValue("OnnxFunction::in");
    layout_pack_tensors(record, scope);
    record["layouts"].a.push_back(JsonValue("pack_tensors"));
    scope["d"] = JsonValue("OnnxFunction::out");
    layout_pack_tensors(record, scope);
    record["layouts"].a.push_back(JsonValue("pack_tensors"));
    scope["d"] = JsonValue("OnnxFunction::all_in");
    layout_pack_tensors(record, scope);
    field(record, "OnnxFunction::in_src", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "OnnxFunction::in_val", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "OnnxFunction::model_inputs", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "OnnxFunction::model_outputs", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "OnnxFunction::fwd_dim", "std::string", [&]() { return string(); });
    field(record, "OnnxFunction::adj_dim", "std::string", [&]() { return string(); });
    field(record, "OnnxFunction::input_values", "std::map<std::string,std::vector<double>>", [&]() { return read_std_map_std_string_std_vector_double(); });
    field(record, "OnnxFunction::model_path", "std::string", [&]() { return string(); });
    field(record, "OnnxFunction::dim_bindings", "std::map<std::string,casadi_int>", [&]() { return read_std_map_std_string_casadi_int(); });
    field(record, "OnnxFunction::input_shapes", "std::map<std::string,std::vector<casadi_int>>", [&]() { return read_std_map_std_string_std_vector_casadi_int(); });
    field(record, "OnnxFunction::derivative_opts", "Dict", [&]() { return read_Dict(); });
    field(record, "OnnxFunction::builder_opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_OnnxFunction_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_type"));
    layout_FunctionInternal_serialize_type(record, scope);
    record["layouts"].a.push_back(JsonValue("PluginInterface<OnnxFunction>::serialize_type"));
    layout_PluginInterface_OnnxFunction_serialize_type(record, scope);
    --depth;
}

void layout_OnnxRuntimeInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("OnnxFunction::serialize_body"));
    layout_OnnxFunction_serialize_body(record, scope);
    version(record, "OnnxRuntimeInterface", 1);
    field(record, "OnnxRuntimeInterface::provider", "std::string", [&]() { return string(); });
    --depth;
}

void layout_OoqpInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "OoqpInterface", 1);
    field(record, "OoqpInterface::spAT", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "OoqpInterface::nQ", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OoqpInterface::nH", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OoqpInterface::nA", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OoqpInterface::print_level", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OoqpInterface::mutol", "double", [&]() { return number("double"); });
    field(record, "OoqpInterface::artol", "double", [&]() { return number("double"); });
    --depth;
}

void layout_OracleFunction_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "OracleFunction", 3);
    field(record, "OracleFunction::oracle", "Function", [&]() { return read_Function(); });
    field(record, "OracleFunction::common_options", "Dict", [&]() { return read_Dict(); });
    field(record, "OracleFunction::specific_options", "Dict", [&]() { return read_Dict(); });
    field(record, "OracleFunction::show_eval_warnings", "bool", [&]() { return boolvalue(); });
    field(record, "OracleFunction::max_num_threads", "int", [&]() { return number("int"); });
    scope["OracleFunction::all_functions::size"] = field(record, "OracleFunction::all_functions::size", "size_t", [&]() { return number("size_t"); });
    const auto count_7 = this->count(scope.at("OracleFunction::all_functions::size"));
    for (uint64_t i_8 = 0; i_8 < count_7; ++i_8) {
        field(record, "OracleFunction::all_functions::key", "std::string", [&]() { return string(); });
        scope["OracleFunction::all_functions::value::jit"] = field(record, "OracleFunction::all_functions::value::jit", "bool", [&]() { return boolvalue(); });
        if ((truth(scope.at("FunctionInternal::jit")) && truth(scope.at("OracleFunction::all_functions::value::jit")))) {
            if ((scope.at("FunctionInternal::jit_serialize")).scalar == "source") {
                field(record, "OracleFunction::all_functions::value::f", "Function", [&]() { return read_Function(); });
            } else {
                field(record, "OracleFunction::all_functions::value::f_name", "std::string", [&]() { return string(); });
            }
        } else {
            field(record, "OracleFunction::all_functions::value::f", "Function", [&]() { return read_Function(); });
        }
        field(record, "OracleFunction::all_functions::value::monitored", "bool", [&]() { return boolvalue(); });
    }
    field(record, "OracleFunction::monitor", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, "OracleFunction::stride_arg", "size_t", [&]() { return number("size_t"); });
    field(record, "OracleFunction::stride_res", "size_t", [&]() { return number("size_t"); });
    field(record, "OracleFunction::stride_iw", "size_t", [&]() { return number("size_t"); });
    field(record, "OracleFunction::stride_w", "size_t", [&]() { return number("size_t"); });
    --depth;
}

void layout_OracleFunction_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_type"));
    layout_FunctionInternal_serialize_type(record, scope);
    --depth;
}

void layout_OsqpInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "OsqpInterface", 2);
    field(record, "OsqpInterface::nnzHupp", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::nnzA", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::warm_start_primal", "bool", [&]() { return boolvalue(); });
    field(record, "OsqpInterface::warm_start_dual", "bool", [&]() { return boolvalue(); });
    field(record, "OsqpInterface::settings::rho", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::sigma", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::scaling", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::adaptive_rho", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::adaptive_rho_interval", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::adaptive_rho_tolerance", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::eps_abs", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::eps_rel", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::eps_prim_inf", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::eps_dual_inf", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::alpha", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::delta", "double", [&]() { return number("double"); });
    field(record, "OsqpInterface::settings::polish", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::polish_refine_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::verbose", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::scaled_termination", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::check_termination", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::settings::warm_start", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "OsqpInterface::rho_initial", "double", [&]() { return number("double"); });
    --depth;
}

void layout_Output_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("IOInstruction::serialize_body"));
    layout_IOInstruction_serialize_body(record, scope);
    --depth;
}

void layout_OutputNode_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "OutputNode::oind", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_OutputSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "OutputSX::dep", "SXElem", [&]() { return read_SXElem(); });
    field(record, "OutputSX::oind", "int", [&]() { return number("int"); });
    --depth;
}

void layout_PiqpInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "PiqpInterface", 1);
    field(record, "PiqpInterface::nnzH", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "PiqpInterface::nnzA", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "PiqpInterface::settings::rho_init", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::delta_init", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::eps_abs", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::eps_rel", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::check_duality_gap", "bool", [&]() { return boolvalue(); });
    field(record, "PiqpInterface::settings::eps_duality_gap_abs", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::eps_duality_gap_rel", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::reg_lower_limit", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::reg_finetune_lower_limit", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::reg_finetune_primal_update_threshold", "size_t", [&]() { return number("size_t"); });
    field(record, "PiqpInterface::settings::reg_finetune_dual_update_threshold", "size_t", [&]() { return number("size_t"); });
    field(record, "PiqpInterface::settings::max_iter", "size_t", [&]() { return number("size_t"); });
    field(record, "PiqpInterface::settings::max_factor_retires", "size_t", [&]() { return number("size_t"); });
    field(record, "PiqpInterface::settings::preconditioner_scale_cost", "bool", [&]() { return boolvalue(); });
    field(record, "PiqpInterface::settings::preconditioner_iter", "size_t", [&]() { return number("size_t"); });
    field(record, "PiqpInterface::settings::tau", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::iterative_refinement_always_enabled", "bool", [&]() { return boolvalue(); });
    field(record, "PiqpInterface::settings::iterative_refinement_eps_abs", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::iterative_refinement_eps_rel", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::iterative_refinement_max_iter", "size_t", [&]() { return number("size_t"); });
    field(record, "PiqpInterface::settings::iterative_refinement_min_improvement_rate", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::iterative_refinement_static_regularization_eps", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::iterative_refinement_static_regularization_rel", "double", [&]() { return number("double"); });
    field(record, "PiqpInterface::settings::verbose", "bool", [&]() { return boolvalue(); });
    field(record, "PiqpInterface::settings::compute_timings", "bool", [&]() { return boolvalue(); });
    field(record, "PiqpInterface::settings::kkt_solver", "std::string", [&]() { return string(); });
    --depth;
}

void layout_PluginInterface_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["PluginInterface::plugin_name"] = field(record, "PluginInterface::plugin_name", "std::string", [&]() { return string(); });
    --depth;
}

void layout_Project_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Project_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Project::type"] = field(record, "Project::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_ProtoFunction_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    fail("unlowered serialization call");
    --depth;
}

void layout_ProtoFunction_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    version(record, "ProtoFunction", 2);
    field(record, "ProtoFunction::name", "std::string", [&]() { return string(); });
    field(record, "ProtoFunction::verbose", "bool", [&]() { return boolvalue(); });
    field(record, "ProtoFunction::print_time", "bool", [&]() { return boolvalue(); });
    field(record, "ProtoFunction::record_time", "bool", [&]() { return boolvalue(); });
    field(record, "ProtoFunction::regularity_check", "bool", [&]() { return boolvalue(); });
    field(record, "ProtoFunction::error_on_fail", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_ProtoFunction_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    --depth;
}

void layout_ProxqpInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "ProxqpInterface", 1);
    field(record, "ProxqpInterface::warm_start_primal", "bool", [&]() { return boolvalue(); });
    field(record, "ProxqpInterface::warm_start_dual", "bool", [&]() { return boolvalue(); });
    field(record, "ProxqpInterface::settings::default_rho", "double", [&]() { return number("double"); });
    field(record, "ProxqpInterface::settings::default_mu_eq", "double", [&]() { return number("double"); });
    field(record, "ProxqpInterface::settings::default_mu_in", "double", [&]() { return number("double"); });
    field(record, "ProxqpInterface::settings::eps_abs", "double", [&]() { return number("double"); });
    field(record, "ProxqpInterface::settings::eps_rel", "double", [&]() { return number("double"); });
    field(record, "ProxqpInterface::settings::max_iter", "double", [&]() { return number("double"); });
    field(record, "ProxqpInterface::settings::verbose", "bool", [&]() { return boolvalue(); });
    field(record, "ProxqpInterface::settings::sparse_backend", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_PseudoDenseMultiplication_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Multiplication::serialize_body"));
    layout_Multiplication_serialize_body(record, scope);
    field(record, "PseudoDenseMultiplication::a", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "PseudoDenseMultiplication::b", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "PseudoDenseMultiplication::c", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_PseudoDenseMultiplication_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Multiplication::kind"] = field(record, "Multiplication::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_QpToNlp_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "QpToNlp", 1);
    field(record, "QpToNlp::solver", "Function", [&]() { return read_Function(); });
    --depth;
}

void layout_QpoasesInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "QpoasesInterface", 1);
    field(record, "QpoasesInterface::max_nWSR", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "QpoasesInterface::max_cputime", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::hess", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "QpoasesInterface::sparse", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::schur", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::max_schur", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "QpoasesInterface::linsol_plugin", "std::string", [&]() { return string(); });
    field(record, "QpoasesInterface::ops::printLevel", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "QpoasesInterface::ops::enableRamping", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::ops::enableFarBounds", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::ops::enableFlippingBounds", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::ops::enableRegularisation", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::ops::enableFullLITests", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::ops::enableNZCTests", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::ops::enableDriftCorrection", "int", [&]() { return number("int"); });
    field(record, "QpoasesInterface::ops::enableCholeskyRefactorisation", "int", [&]() { return number("int"); });
    field(record, "QpoasesInterface::ops::enableEqualities", "bool", [&]() { return boolvalue(); });
    field(record, "QpoasesInterface::ops::terminationTolerance", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::boundTolerance", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::boundRelaxation", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::epsNum", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::epsDen", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::maxPrimalJump", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::maxDualJump", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::initialRamping", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::finalRamping", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::initialFarBounds", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::growFarBounds", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::initialStatusBounds", "std::string", [&]() { return string(); });
    field(record, "QpoasesInterface::ops::epsFlipping", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::numRegularisationSteps", "int", [&]() { return number("int"); });
    field(record, "QpoasesInterface::ops::epsRegularisation", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::numRefinementSteps", "int", [&]() { return number("int"); });
    field(record, "QpoasesInterface::ops::epsIterRef", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::epsLITests", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::epsNZCTests", "double", [&]() { return number("double"); });
    field(record, "QpoasesInterface::ops::enableInertiaCorrection", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_Qrqp_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "Qrqp", 1);
    field(record, "Qrqp::AT", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Qrqp::kkt", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Qrqp::sp_v", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Qrqp::sp_r", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Qrqp::prinv", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Qrqp::pc", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Qrqp::print_iter", "bool", [&]() { return boolvalue(); });
    field(record, "Qrqp::print_header", "bool", [&]() { return boolvalue(); });
    field(record, "Qrqp::print_info", "bool", [&]() { return boolvalue(); });
    field(record, "Qrqp::print_lincomb_", "bool", [&]() { return boolvalue(); });
    field(record, "Qrqp::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Qrqp::min_lam", "double", [&]() { return number("double"); });
    field(record, "Qrqp::constr_viol_tol", "double", [&]() { return number("double"); });
    field(record, "Qrqp::dual_inf_tol", "double", [&]() { return number("double"); });
    --depth;
}

void layout_Qrsqp_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    --depth;
}

void layout_Rank1_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_RealtypeSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
    field(record, "ConstantSX::value", "double", [&]() { return number("double"); });
    --depth;
}

void layout_Reshape_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Resource_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    --depth;
}

void layout_ResourceInternal_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    version(record, "ResourceInternal", 1);
    fail("unlowered serialization call");
    fail("unlowered serialization call");
    --depth;
}

void layout_ResourceInternal_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ResourceInternal::serialize_mode"] = field(record, "ResourceInternal::serialize_mode", "std::string", [&]() { return string(); });
    --depth;
}

void layout_ResourceInternal_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ResourceInternal::type"] = field(record, "ResourceInternal::type", "std::string", [&]() { return string(); });
    --depth;
}

void layout_Rootfinder_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("OracleFunction::serialize_body"));
    layout_OracleFunction_serialize_body(record, scope);
    version(record, "Rootfinder", 3);
    field(record, "Rootfinder::n", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Rootfinder::linsol", "Linsol", [&]() { return read_Linsol(); });
    field(record, "Rootfinder::sp_jac", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Rootfinder::u_c", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Rootfinder::iin", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Rootfinder::iout", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Rootfinder_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("OracleFunction::serialize_type"));
    layout_OracleFunction_serialize_type(record, scope);
    record["layouts"].a.push_back(JsonValue("PluginInterface<Rootfinder>::serialize_type"));
    layout_PluginInterface_Rootfinder_serialize_type(record, scope);
    --depth;
}

void layout_RungeKutta_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FixedStepIntegrator::serialize_body"));
    layout_FixedStepIntegrator_serialize_body(record, scope);
    version(record, "RungeKutta", 2);
    --depth;
}

void layout_SLEQPInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "SLEQPInterface", 1);
    field(record, "SLEQPInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "SLEQPInterface::max_iter", "int", [&]() { return number("int"); });
    field(record, "SLEQPInterface::max_wall_time", "double", [&]() { return number("double"); });
    field(record, "SLEQPInterface::print_level", "int", [&]() { return number("int"); });
    field(record, "SLEQPInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_SXElem_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered serialization call");
    --depth;
}

void layout_SXFunction_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("XFunction<SXFunction,SX,SXNode>::serialize_body"));
    layout_XFunction_SXFunction_SX_SXNode_serialize_body(record, scope);
    version(record, "SXFunction", 4);
    scope["SXFunction::n_instr"] = field(record, "SXFunction::n_instr", "size_t", [&]() { return number("size_t"); });
    field(record, "SXFunction::worksize", "size_t", [&]() { return number("size_t"); });
    field(record, "SXFunction::free_vars", "std::vector<SXElem>", [&]() { return read_std_vector_SXElem(); });
    field(record, "SXFunction::operations", "std::vector<SXElem>", [&]() { return read_std_vector_SXElem(); });
    field(record, "SXFunction::constants", "std::vector<SXElem>", [&]() { return read_std_vector_SXElem(); });
    field(record, "SXFunction::default_in", "std::vector<double>", [&]() { return read_std_vector_double(); });
    field(record, "SXFunction::call_sz_arg", "size_t", [&]() { return number("size_t"); });
    field(record, "SXFunction::call_sz_res", "size_t", [&]() { return number("size_t"); });
    field(record, "SXFunction::call_sz_iw", "size_t", [&]() { return number("size_t"); });
    field(record, "SXFunction::call_sz_w", "size_t", [&]() { return number("size_t"); });
    field(record, "SXFunction::call_sz_arg", "size_t", [&]() { return number("size_t"); });
    field(record, "SXFunction::call_sz_res", "size_t", [&]() { return number("size_t"); });
    scope["SXFunction::call_el_size"] = field(record, "SXFunction::call_el_size", "size_t", [&]() { return number("size_t"); });
    const auto count_9 = this->count(scope.at("SXFunction::call_el_size"));
    for (uint64_t i_10 = 0; i_10 < count_9; ++i_10) {
        field(record, "SXFunction::call_el_f", "Function", [&]() { return read_Function(); });
        field(record, "SXFunction::call_el_dep", "std::vector<int>", [&]() { return read_std_vector_int(); });
        field(record, "SXFunction::call_el_res", "std::vector<int>", [&]() { return read_std_vector_int(); });
        field(record, "SXFunction::call_el_copy_elision_arg", "std::vector<int>", [&]() { return read_std_vector_int(); });
        field(record, "SXFunction::call_el_copy_elision_offset", "std::vector<int>", [&]() { return read_std_vector_int(); });
    }
    field(record, "SXFunction::copy_elision", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    const auto count_11 = this->count(scope.at("SXFunction::n_instr"));
    for (uint64_t i_12 = 0; i_12 < count_11; ++i_12) {
        field(record, "SXFunction::ScalarAtomic::op", "int", [&]() { return number("int"); });
        field(record, "SXFunction::ScalarAtomic::i0", "int", [&]() { return number("int"); });
        field(record, "SXFunction::ScalarAtomic::i1", "int", [&]() { return number("int"); });
        field(record, "SXFunction::ScalarAtomic::i2", "int", [&]() { return number("int"); });
    }
    field(record, "SXFunction::live_variables", "bool", [&]() { return boolvalue(); });
    field(record, "SXFunction::print_instructions", "bool", [&]() { return boolvalue(); });
    field(record, "SXFunction::dump_trace", "bool", [&]() { return boolvalue(); });
    record["layouts"].a.push_back(JsonValue("XFunction<SXFunction,SX,SXNode>::delayed_serialize_members"));
    layout_XFunction_SXFunction_SX_SXNode_delayed_serialize_members(record, scope);
    --depth;
}

void layout_SXNode_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["SXNode::op"] = field(record, "SXNode::op", "casadi_int", [&]() { return number("casadi_int"); });
    fail("unlowered serialization call");
    --depth;
}

void layout_Scpgen_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    --depth;
}

void layout_SetNonzerosParam_Add_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_SetNonzerosParamParam_Add_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("SetNonzerosParam<Add>::serialize_body"));
    layout_SetNonzerosParam_Add_serialize_body(record, scope);
    --depth;
}

void layout_SetNonzerosParamParam_Add_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["SetNonzerosParam::type"] = field(record, "SetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_SetNonzerosParamSlice_Add_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "SetNonzerosParamSlice::outer", "Slice", [&]() { return read_Slice(); });
    --depth;
}

void layout_SetNonzerosParamSlice_Add_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["SetNonzerosParam::type"] = field(record, "SetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_SetNonzerosParamVector_Add_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_SetNonzerosParamVector_Add_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["SetNonzerosParam::type"] = field(record, "SetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_SetNonzerosSlice2_Add_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "SetNonzerosSlice2::inner", "Slice", [&]() { return read_Slice(); });
    field(record, "SetNonzerosSlice2::outer", "Slice", [&]() { return read_Slice(); });
    --depth;
}

void layout_SetNonzerosSlice2_Add_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["SetNonzeros::type"] = field(record, "SetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_SetNonzerosSlice_Add_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "SetNonzerosSlice::slice", "Slice", [&]() { return read_Slice(); });
    --depth;
}

void layout_SetNonzerosSlice_Add_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["SetNonzeros::type"] = field(record, "SetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_SetNonzerosSliceParam_Add_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "SetNonzerosSliceParam::inner", "Slice", [&]() { return read_Slice(); });
    --depth;
}

void layout_SetNonzerosSliceParam_Add_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["SetNonzerosParam::type"] = field(record, "SetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_SetNonzerosVector_Add_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "SetNonzerosVector::nonzeros", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_SetNonzerosVector_Add_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["SetNonzeros::type"] = field(record, "SetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_Slice_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "Slice::start", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Slice::stop", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Slice::step", "casadi_int", [&]() { return number("casadi_int"); });
    --depth;
}

void layout_Smoothing_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FiniteDiff::serialize_body"));
    layout_FiniteDiff_serialize_body(record, scope);
    --depth;
}

void layout_SnoptInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "SnoptInterface", 1);
    field(record, "SnoptInterface::jacf_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "SnoptInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "SnoptInterface::nnJac", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SnoptInterface::nnObj", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SnoptInterface::nnCon", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SnoptInterface::A_structure", "IM", [&]() { return read_IM(); });
    field(record, "SnoptInterface::m", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SnoptInterface::iObj", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SnoptInterface::jacF_row", "bool", [&]() { return boolvalue(); });
    field(record, "SnoptInterface::dummyrow", "bool", [&]() { return boolvalue(); });
    field(record, "SnoptInterface::Cold_", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SnoptInterface::inf", "double", [&]() { return number("double"); });
    field(record, "SnoptInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_Solve_Tr_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Solve_Tr_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    field(record, "Solve::Tr", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_SparseDenseKron_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Kron::serialize_body"));
    layout_Kron_serialize_body(record, scope);
    --depth;
}

void layout_SparseDenseKron_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Kron::kind"] = field(record, "Kron::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_SparseDenseKronContract_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("KronContract::serialize_body"));
    layout_KronContract_serialize_body(record, scope);
    --depth;
}

void layout_SparseDenseKronContract_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["KronContract::kind"] = field(record, "KronContract::kind", "std::string", [&]() { return string(); });
    --depth;
}

void layout_Sparsify_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Project::serialize_body"));
    layout_Project_serialize_body(record, scope);
    --depth;
}

void layout_Sparsify_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Project::type"] = field(record, "Project::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_Sparsity_serialize(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Predicate has no serialized field");
    --depth;
}

void layout_SparsityCast_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Split_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MultipleOutput::serialize_body"));
    layout_MultipleOutput_serialize_body(record, scope);
    field(record, "Split::offset", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "Split::output_sparsity", "std::vector<Sparsity>", [&]() { return read_std_vector_Sparsity(); });
    --depth;
}

void layout_SqicInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    --depth;
}

void layout_Sqpmethod_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "Sqpmethod", 3);
    field(record, "Sqpmethod::qpsol", "Function", [&]() { return read_Function(); });
    field(record, "Sqpmethod::qpsol_ela", "Function", [&]() { return read_Function(); });
    field(record, "Sqpmethod::exact_hessian", "bool", [&]() { return boolvalue(); });
    field(record, "Sqpmethod::max_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Sqpmethod::min_iter", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Sqpmethod::lbfgs_memory", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Sqpmethod::tol_pr_", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::tol_du_", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::min_step_size_", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::c1", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::beta", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::max_iter_ls_", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Sqpmethod::merit_memsize_", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "Sqpmethod::beta", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::print_header", "bool", [&]() { return boolvalue(); });
    field(record, "Sqpmethod::print_iteration", "bool", [&]() { return boolvalue(); });
    field(record, "Sqpmethod::print_status", "bool", [&]() { return boolvalue(); });
    field(record, "Sqpmethod::elastic_mode", "bool", [&]() { return boolvalue(); });
    field(record, "Sqpmethod::gamma_0", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::gamma_max", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::gamma_1_min", "double", [&]() { return number("double"); });
    field(record, "Sqpmethod::init_feasible", "bool", [&]() { return boolvalue(); });
    field(record, "Sqpmethod::so_corr", "bool", [&]() { return boolvalue(); });
    field(record, "Sqpmethod::Hsp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Sqpmethod::Asp", "Sparsity", [&]() { return read_Sparsity(); });
    scope["Sqpmethod::convexify"] = field(record, "Sqpmethod::convexify", "bool", [&]() { return boolvalue(); });
    if (truth(scope.at("Sqpmethod::convexify"))) {
        record["layouts"].a.push_back(JsonValue("Convexify::serialize"));
        scope["prefix"] = JsonValue("Sqpmethod::");
        layout_Convexify_serialize(record, scope);
    }
    --depth;
}

void layout_SundialsInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Integrator::serialize_body"));
    layout_Integrator_serialize_body(record, scope);
    version(record, "SundialsInterface", 2);
    field(record, "SundialsInterface::abstol", "double", [&]() { return number("double"); });
    field(record, "SundialsInterface::reltol", "double", [&]() { return number("double"); });
    field(record, "SundialsInterface::max_num_steps", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SundialsInterface::stop_at_end", "bool", [&]() { return boolvalue(); });
    field(record, "SundialsInterface::quad_err_con", "bool", [&]() { return boolvalue(); });
    field(record, "SundialsInterface::steps_per_checkpoint", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SundialsInterface::disable_internal_warnings", "bool", [&]() { return boolvalue(); });
    field(record, "SundialsInterface::max_multistep_order", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SundialsInterface::linear_solver", "std::string", [&]() { return string(); });
    field(record, "SundialsInterface::linear_solver_options", "Dict", [&]() { return read_Dict(); });
    field(record, "SundialsInterface::max_krylov", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SundialsInterface::use_precon", "bool", [&]() { return boolvalue(); });
    field(record, "SundialsInterface::second_order_correction", "bool", [&]() { return boolvalue(); });
    field(record, "SundialsInterface::step0", "double", [&]() { return number("double"); });
    field(record, "SundialsInterface::max_step_size", "double", [&]() { return number("double"); });
    field(record, "SundialsInterface::nonlin_conv_coeff", "double", [&]() { return number("double"); });
    field(record, "SundialsInterface::max_order", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SundialsInterface::scale_abstol", "bool", [&]() { return boolvalue(); });
    field(record, "SundialsInterface::linsolF", "Linsol", [&]() { return read_Linsol(); });
    field(record, "SundialsInterface::newton_scheme", "int", [&]() { return number("int"); });
    field(record, "SundialsInterface::interp", "int", [&]() { return number("int"); });
    --depth;
}

void layout_SuperscsInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "SuperscsInterface", 1);
    field(record, "SuperscsInterface::settings::normalize", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::scale", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::rho_x", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::max_time_milliseconds", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::max_iters", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::previous_max_iters", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::eps", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::alpha", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::cg_rate", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::verbose", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::warm_start", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::do_super_scs", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::k0", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::c_bl", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::k1", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::k2", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::c1", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::sse", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::ls", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::beta", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::sigma", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::direction", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::thetabar", "double", [&]() { return number("double"); });
    field(record, "SuperscsInterface::settings::memory", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::tRule", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::broyden_init_scaling", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::do_record_progress", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::settings::do_override_streams", "casadi_int", [&]() { return number("casadi_int"); });
    field(record, "SuperscsInterface::Hp", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "SuperscsInterface::HL_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "SuperscsInterface::f", "Function", [&]() { return read_Function(); });
    field(record, "SuperscsInterface::At", "IM", [&]() { return read_IM(); });
    field(record, "SuperscsInterface::lookup", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "SuperscsInterface::perturb", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, "SuperscsInterface::opts", "Dict", [&]() { return read_Dict(); });
    record["layouts"].a.push_back(JsonValue("Conic::serialize"));
    layout_Conic_serialize(record, scope);
    --depth;
}

void layout_Switch_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "Switch", 1);
    field(record, "Switch::f", "std::vector<Function>", [&]() { return read_std_vector_Function(); });
    field(record, "Switch::f_def", "Function", [&]() { return read_Function(); });
    field(record, "Switch::project_in", "bool", [&]() { return boolvalue(); });
    field(record, "Switch::project_out", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_SymbolicMX_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "SymbolicMX::name", "std::string", [&]() { return string(); });
    --depth;
}

void layout_SymbolicQr_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("LinsolInternal::serialize_body"));
    layout_LinsolInternal_serialize_body(record, scope);
    version(record, "SymbolicQr", 1);
    field(record, "SymbolicQr::factorize", "Function", [&]() { return read_Function(); });
    field(record, "SymbolicQr::solve", "Function", [&]() { return read_Function(); });
    field(record, "SymbolicQr::solveT", "Function", [&]() { return read_Function(); });
    field(record, "SymbolicQr::fopts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_SymbolicSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "SymbolicSX::name", "std::string", [&]() { return string(); });
    --depth;
}

void layout_ThreadMap_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Map::serialize_body"));
    layout_Map_serialize_body(record, scope);
    --depth;
}

void layout_Transpose_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    --depth;
}

void layout_Transpose_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["Transpose::dense"] = field(record, "Transpose::dense", "bool", [&]() { return boolvalue(); });
    --depth;
}

void layout_UnaryMX_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
    layout_MXNode_serialize_body(record, scope);
    field(record, "UnaryMX::op", "int", [&]() { return number("int"); });
    --depth;
}

void layout_UnarySX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "UnarySX::dep", "SXElem", [&]() { return read_SXElem(); });
    --depth;
}

void layout_UnoInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "UnoInterface", 1);
    field(record, "UnoInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "UnoInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "UnoInterface::opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_Vertcat_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Concat::serialize_body"));
    layout_Concat_serialize_body(record, scope);
    --depth;
}

void layout_Vertsplit_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Split::serialize_body"));
    layout_Split_serialize_body(record, scope);
    --depth;
}

void layout_WorhpInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Nlpsol::serialize_body"));
    layout_Nlpsol_serialize_body(record, scope);
    version(record, "WorhpInterface", 1);
    field(record, "WorhpInterface::jacg_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "WorhpInterface::hesslag_sp", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "WorhpInterface::bool_opts", "std::map<std::string,bool>", [&]() { return read_std_map_std_string_bool(); });
    field(record, "WorhpInterface::int_opts", "std::map<std::string,casadi_int>", [&]() { return read_std_map_std_string_casadi_int(); });
    field(record, "WorhpInterface::double_opts", "std::map<std::string,double>", [&]() { return read_std_map_std_string_double(); });
    field(record, "WorhpInterface::qp_opts", "Dict", [&]() { return read_Dict(); });
    --depth;
}

void layout_XFunction_MXFunction_MX_MXNode_delayed_serialize_members(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "XFunction::out", "std::vector<MX>", [&]() { return read_std_vector_MX(); });
    --depth;
}

void layout_XFunction_MXFunction_MX_MXNode_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "XFunction", 1);
    field(record, "XFunction::in", "std::vector<MX>", [&]() { return read_std_vector_MX(); });
    --depth;
}

void layout_XFunction_SXFunction_SX_SXNode_delayed_serialize_members(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "XFunction::out", "std::vector<SX>", [&]() { return read_std_vector_SX(); });
    --depth;
}

void layout_XFunction_SXFunction_SX_SXNode_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("FunctionInternal::serialize_body"));
    layout_FunctionInternal_serialize_body(record, scope);
    version(record, "XFunction", 1);
    field(record, "XFunction::in", "std::vector<SX>", [&]() { return read_std_vector_SX(); });
    --depth;
}

void layout_XpressInterface_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Conic::serialize_body"));
    layout_Conic_serialize_body(record, scope);
    version(record, "XpressInterface", 2);
    field(record, "XpressInterface::opts", "Dict", [&]() { return read_Dict(); });
    field(record, "XpressInterface::mip_start", "bool", [&]() { return boolvalue(); });
    field(record, "XpressInterface::log_file", "std::string", [&]() { return string(); });
    field(record, "XpressInterface::compute_iis", "bool", [&]() { return boolvalue(); });
    field(record, "XpressInterface::sos_settype", "std::vector<char>", [&]() { return read_std_vector_char(); });
    field(record, "XpressInterface::sos_setstart", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "XpressInterface::sos_setind", "std::vector<int>", [&]() { return read_std_vector_int(); });
    field(record, "XpressInterface::sos_refval", "std::vector<double>", [&]() { return read_std_vector_double(); });
    --depth;
}

void layout_ZeroByZero_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    --depth;
}

void layout_ZeroByZero_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("MXNode::serialize_type"));
    layout_MXNode_serialize_type(record, scope);
    scope["ConstantMX::type"] = field(record, "ConstantMX::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_ZeroSX_serialize_node(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
    --depth;
}

void layout_ZipMemResource_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("ResourceInternal::serialize_body"));
    layout_ResourceInternal_serialize_body(record, scope);
    version(record, "ZipMemResource", 1);
    field(record, "ZipMemResource::blob", "std::stringstream", [&]() { return streamvalue(); });
    --depth;
}

void layout_ZipResource_serialize_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("ResourceInternal::serialize_body"));
    layout_ResourceInternal_serialize_body(record, scope);
    version(record, "ZipResource", 1);
    if ((scope.at("ResourceInternal::serialize_mode")).scalar == "embed") {
        field(record, "ZipMemResource::blob", "std::stringstream", [&]() { return streamvalue(); });
    } else {
        field(record, "ZipResource::path", "std::string", [&]() { return string(); });
    }
    --depth;
}

void layout_ZipResource_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("unlowered else branch");
    --depth;
}

void layout_pack_tensors(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, (std::string((scope.at("d")).scalar) + "::names"), "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    field(record, (std::string((scope.at("d")).scalar) + "::shapes"), "std::vector<std::vector<casadi_int>>", [&]() { return read_std_vector_std_vector_casadi_int(); });
    field(record, (std::string((scope.at("d")).scalar) + "::elem_types"), "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    field(record, (std::string((scope.at("d")).scalar) + "::numels"), "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

void layout_PluginInterface_Interpolant_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Serialization layout absent from scheme: >PluginInterface<Interpolant>::serialize_type");
    --depth;
}

void layout_PluginInterface_Conic_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Serialization layout absent from scheme: PluginInterface<Conic>::serialize_type");
    --depth;
}

void layout_PluginInterface_Integrator_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Serialization layout absent from scheme: PluginInterface<Integrator>::serialize_type");
    --depth;
}

void layout_PluginInterface_Interpolant_serialize_type_2(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Serialization layout absent from scheme: PluginInterface<Interpolant>::serialize_type");
    --depth;
}

void layout_PluginInterface_LinsolInternal_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Serialization layout absent from scheme: PluginInterface<LinsolInternal>::serialize_type");
    --depth;
}

void layout_PluginInterface_Nlpsol_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Serialization layout absent from scheme: PluginInterface<Nlpsol>::serialize_type");
    --depth;
}

void layout_PluginInterface_OnnxFunction_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Serialization layout absent from scheme: PluginInterface<OnnxFunction>::serialize_type");
    --depth;
}

void layout_PluginInterface_Rootfinder_serialize_type(JsonValue& record, Scope& scope) {
    enter_layout();
    fail("Serialization layout absent from scheme: PluginInterface<Rootfinder>::serialize_type");
    --depth;
}

void read_DM_body(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "Matrix::sparsity", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Matrix::nonzeros", "std::vector<double>", [&]() { return read_std_vector_double(); });
    --depth;
}

JsonValue read_DM() {
    return object("DM", "", false, &Reader::read_DM_body);
}

void read_Fmu_body(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["FmuInternal::type"] = field(record, "FmuInternal::type", "std::string", [&]() { return string(); });
    const auto tag_13 = (scope.at("FmuInternal::type")).scalar;
    if (tag_13 == "Fmu2") {
        record["layouts"].a.push_back(JsonValue("Fmu2::serialize_body"));
        layout_Fmu2_serialize_body(record, scope);
    } else if (tag_13 == "Fmu3") {
        record["layouts"].a.push_back(JsonValue("Fmu3::serialize_body"));
        layout_Fmu3_serialize_body(record, scope);
    } else {
        fail("Unknown serialization discriminator");
    }
    --depth;
}

JsonValue read_Fmu() {
    return object("Fmu", "F", true, &Reader::read_Fmu_body);
}

void read_Function_body(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["Function::null"] = field(record, "Function::null", "bool", [&]() { return boolvalue(); });
    if ((!(truth(scope.at("Function::null"))))) {
        scope["FunctionInternal::base_function"] = field(record, "FunctionInternal::base_function", "std::string", [&]() { return string(); });
        const auto tag_14 = (scope.at("FunctionInternal::base_function")).scalar;
        if (tag_14 == "BackwardDiff") {
            record["layouts"].a.push_back(JsonValue("BackwardDiff::serialize_body"));
            layout_BackwardDiff_serialize_body(record, scope);
        } else if (tag_14 == "BlazingSplineFunction") {
            record["layouts"].a.push_back(JsonValue("BlazingSplineFunction::serialize_body"));
            layout_BlazingSplineFunction_serialize_body(record, scope);
        } else if (tag_14 == "CentralDiff") {
            record["layouts"].a.push_back(JsonValue("CentralDiff::serialize_body"));
            layout_CentralDiff_serialize_body(record, scope);
        } else if (tag_14 == "Conic") {
            scope["PluginInterface::plugin_name"] = field(record, "PluginInterface::plugin_name", "std::string", [&]() { return string(); });
            const auto tag_15 = (scope.at("PluginInterface::plugin_name")).scalar;
            if (tag_15 == "cbc") {
                record["layouts"].a.push_back(JsonValue("CbcInterface::serialize_body"));
                layout_CbcInterface_serialize_body(record, scope);
            } else if (tag_15 == "clarabel") {
                record["layouts"].a.push_back(JsonValue("ClarabelInterface::serialize_body"));
                layout_ClarabelInterface_serialize_body(record, scope);
            } else if (tag_15 == "clp") {
                record["layouts"].a.push_back(JsonValue("ClpInterface::serialize_body"));
                layout_ClpInterface_serialize_body(record, scope);
            } else if (tag_15 == "cplex") {
                record["layouts"].a.push_back(JsonValue("CplexInterface::serialize_body"));
                layout_CplexInterface_serialize_body(record, scope);
            } else if (tag_15 == "daqp") {
                record["layouts"].a.push_back(JsonValue("DaqpInterface::serialize_body"));
                layout_DaqpInterface_serialize_body(record, scope);
            } else if (tag_15 == "fatrop") {
                record["layouts"].a.push_back(JsonValue("FatropConicInterface::serialize_body"));
                layout_FatropConicInterface_serialize_body(record, scope);
            } else if (tag_15 == "gurobi") {
                record["layouts"].a.push_back(JsonValue("GurobiInterface::serialize_body"));
                layout_GurobiInterface_serialize_body(record, scope);
            } else if (tag_15 == "highs") {
                record["layouts"].a.push_back(JsonValue("HighsInterface::serialize_body"));
                layout_HighsInterface_serialize_body(record, scope);
            } else if (tag_15 == "hpipm") {
                record["layouts"].a.push_back(JsonValue("HpipmInterface::serialize_body"));
                layout_HpipmInterface_serialize_body(record, scope);
            } else if (tag_15 == "hpmpc") {
                record["layouts"].a.push_back(JsonValue("HpmpcInterface::serialize_body"));
                layout_HpmpcInterface_serialize_body(record, scope);
            } else if (tag_15 == "ipqp") {
                record["layouts"].a.push_back(JsonValue("Ipqp::serialize_body"));
                layout_Ipqp_serialize_body(record, scope);
            } else if (tag_15 == "mosek") {
                record["layouts"].a.push_back(JsonValue("MosekInterface::serialize_body"));
                layout_MosekInterface_serialize_body(record, scope);
            } else if (tag_15 == "nlpsol") {
                record["layouts"].a.push_back(JsonValue("QpToNlp::serialize_body"));
                layout_QpToNlp_serialize_body(record, scope);
            } else if (tag_15 == "ooqp") {
                record["layouts"].a.push_back(JsonValue("OoqpInterface::serialize_body"));
                layout_OoqpInterface_serialize_body(record, scope);
            } else if (tag_15 == "osqp") {
                record["layouts"].a.push_back(JsonValue("OsqpInterface::serialize_body"));
                layout_OsqpInterface_serialize_body(record, scope);
            } else if (tag_15 == "piqp") {
                record["layouts"].a.push_back(JsonValue("PiqpInterface::serialize_body"));
                layout_PiqpInterface_serialize_body(record, scope);
            } else if (tag_15 == "proxqp") {
                record["layouts"].a.push_back(JsonValue("ProxqpInterface::serialize_body"));
                layout_ProxqpInterface_serialize_body(record, scope);
            } else if (tag_15 == "qpoases") {
                record["layouts"].a.push_back(JsonValue("QpoasesInterface::serialize_body"));
                layout_QpoasesInterface_serialize_body(record, scope);
            } else if (tag_15 == "qrqp") {
                record["layouts"].a.push_back(JsonValue("Qrqp::serialize_body"));
                layout_Qrqp_serialize_body(record, scope);
            } else if (tag_15 == "sqic") {
                record["layouts"].a.push_back(JsonValue("SqicInterface::serialize_body"));
                layout_SqicInterface_serialize_body(record, scope);
            } else if (tag_15 == "superscs") {
                record["layouts"].a.push_back(JsonValue("SuperscsInterface::serialize_body"));
                layout_SuperscsInterface_serialize_body(record, scope);
            } else if (tag_15 == "xpress") {
                record["layouts"].a.push_back(JsonValue("XpressInterface::serialize_body"));
                layout_XpressInterface_serialize_body(record, scope);
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "External") {
            version(record, "GenericExternal", 1);
            scope["GenericExternal::type"] = field(record, "GenericExternal::type", "char", [&]() { return JsonValue(byte()); });
            const auto tag_16 = (scope.at("GenericExternal::type")).scalar;
            if (tag_16 == "103") {
                record["layouts"].a.push_back(JsonValue("External::serialize_body"));
                layout_External_serialize_body(record, scope);
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "FmuFunction") {
            record["layouts"].a.push_back(JsonValue("FmuFunction::serialize_body"));
            layout_FmuFunction_serialize_body(record, scope);
        } else if (tag_14 == "ForwardDiff") {
            record["layouts"].a.push_back(JsonValue("ForwardDiff::serialize_body"));
            layout_ForwardDiff_serialize_body(record, scope);
        } else if (tag_14 == "Integrator") {
            scope["PluginInterface::plugin_name"] = field(record, "PluginInterface::plugin_name", "std::string", [&]() { return string(); });
            const auto tag_17 = (scope.at("PluginInterface::plugin_name")).scalar;
            if (tag_17 == "collocation") {
                record["layouts"].a.push_back(JsonValue("Collocation::serialize_body"));
                layout_Collocation_serialize_body(record, scope);
            } else if (tag_17 == "cvodes") {
                record["layouts"].a.push_back(JsonValue("CvodesInterface::serialize_body"));
                layout_CvodesInterface_serialize_body(record, scope);
            } else if (tag_17 == "idas") {
                record["layouts"].a.push_back(JsonValue("IdasInterface::serialize_body"));
                layout_IdasInterface_serialize_body(record, scope);
            } else if (tag_17 == "rk") {
                record["layouts"].a.push_back(JsonValue("RungeKutta::serialize_body"));
                layout_RungeKutta_serialize_body(record, scope);
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "Interpolant") {
            scope["PluginInterface::plugin_name"] = field(record, "PluginInterface::plugin_name", "std::string", [&]() { return string(); });
            const auto tag_18 = (scope.at("PluginInterface::plugin_name")).scalar;
            if (tag_18 == "bspline") {
                record["layouts"].a.push_back(JsonValue("BSplineInterpolant::serialize_body"));
                layout_BSplineInterpolant_serialize_body(record, scope);
            } else if (tag_18 == "linear") {
                version(record, "LinearInterpolant", 1);
                scope["LinearInterpolant::type"] = field(record, "LinearInterpolant::type", "char", [&]() { return JsonValue(byte()); });
                const auto tag_19 = (scope.at("LinearInterpolant::type")).scalar;
                if (tag_19 == "102") {
                    record["layouts"].a.push_back(JsonValue("LinearInterpolant::serialize_body"));
                    layout_LinearInterpolant_serialize_body(record, scope);
                } else if (tag_19 == "106") {
                    record["layouts"].a.push_back(JsonValue("LinearInterpolantJac::serialize_body"));
                    layout_LinearInterpolantJac_serialize_body(record, scope);
                } else {
                    fail("Unknown serialization discriminator");
                }
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "MXFunction") {
            record["layouts"].a.push_back(JsonValue("MXFunction::serialize_body"));
            layout_MXFunction_serialize_body(record, scope);
        } else if (tag_14 == "Map") {
            scope["Map::class_name"] = field(record, "Map::class_name", "std::string", [&]() { return string(); });
            const auto tag_20 = (scope.at("Map::class_name")).scalar;
            if (tag_20 == "Map") {
                record["layouts"].a.push_back(JsonValue("Map::serialize_body"));
                layout_Map_serialize_body(record, scope);
            } else if (tag_20 == "OmpMap") {
                record["layouts"].a.push_back(JsonValue("OmpMap::serialize_body"));
                layout_OmpMap_serialize_body(record, scope);
            } else if (tag_20 == "ThreadMap") {
                record["layouts"].a.push_back(JsonValue("ThreadMap::serialize_body"));
                layout_ThreadMap_serialize_body(record, scope);
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "MapSum") {
            scope["MapSum::class_name"] = field(record, "MapSum::class_name", "std::string", [&]() { return string(); });
            const auto tag_21 = (scope.at("MapSum::class_name")).scalar;
            if (tag_21 == "MapSum") {
                record["layouts"].a.push_back(JsonValue("MapSum::serialize_body"));
                layout_MapSum_serialize_body(record, scope);
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "Nlpsol") {
            scope["PluginInterface::plugin_name"] = field(record, "PluginInterface::plugin_name", "std::string", [&]() { return string(); });
            const auto tag_22 = (scope.at("PluginInterface::plugin_name")).scalar;
            if (tag_22 == "alpaqa") {
                record["layouts"].a.push_back(JsonValue("AlpaqaInterface::serialize_body"));
                layout_AlpaqaInterface_serialize_body(record, scope);
            } else if (tag_22 == "ampl") {
                record["layouts"].a.push_back(JsonValue("AmplInterface::serialize_body"));
                layout_AmplInterface_serialize_body(record, scope);
            } else if (tag_22 == "blocksqp") {
                record["layouts"].a.push_back(JsonValue("Blocksqp::serialize_body"));
                layout_Blocksqp_serialize_body(record, scope);
            } else if (tag_22 == "bonmin") {
                record["layouts"].a.push_back(JsonValue("BonminInterface::serialize_body"));
                layout_BonminInterface_serialize_body(record, scope);
            } else if (tag_22 == "ccopt") {
                record["layouts"].a.push_back(JsonValue("MadmpecInterface::serialize_body"));
                layout_MadmpecInterface_serialize_body(record, scope);
            } else if (tag_22 == "conopt") {
                record["layouts"].a.push_back(JsonValue("ConoptInterface::serialize_body"));
                layout_ConoptInterface_serialize_body(record, scope);
            } else if (tag_22 == "fatrop") {
                record["layouts"].a.push_back(JsonValue("FatropInterface::serialize_body"));
                layout_FatropInterface_serialize_body(record, scope);
            } else if (tag_22 == "feasiblesqpmethod") {
                record["layouts"].a.push_back(JsonValue("Feasiblesqpmethod::serialize_body"));
                layout_Feasiblesqpmethod_serialize_body(record, scope);
            } else if (tag_22 == "ipopt") {
                record["layouts"].a.push_back(JsonValue("IpoptInterface::serialize_body"));
                layout_IpoptInterface_serialize_body(record, scope);
            } else if (tag_22 == "knitro") {
                record["layouts"].a.push_back(JsonValue("KnitroInterface::serialize_body"));
                layout_KnitroInterface_serialize_body(record, scope);
            } else if (tag_22 == "madnlp") {
                record["layouts"].a.push_back(JsonValue("MadnlpInterface::serialize_body"));
                layout_MadnlpInterface_serialize_body(record, scope);
            } else if (tag_22 == "qrsqp") {
                record["layouts"].a.push_back(JsonValue("Qrsqp::serialize_body"));
                layout_Qrsqp_serialize_body(record, scope);
            } else if (tag_22 == "scpgen") {
                record["layouts"].a.push_back(JsonValue("Scpgen::serialize_body"));
                layout_Scpgen_serialize_body(record, scope);
            } else if (tag_22 == "sleqp") {
                record["layouts"].a.push_back(JsonValue("SLEQPInterface::serialize_body"));
                layout_SLEQPInterface_serialize_body(record, scope);
            } else if (tag_22 == "snopt") {
                record["layouts"].a.push_back(JsonValue("SnoptInterface::serialize_body"));
                layout_SnoptInterface_serialize_body(record, scope);
            } else if (tag_22 == "sqpmethod") {
                record["layouts"].a.push_back(JsonValue("Sqpmethod::serialize_body"));
                layout_Sqpmethod_serialize_body(record, scope);
            } else if (tag_22 == "uno") {
                record["layouts"].a.push_back(JsonValue("UnoInterface::serialize_body"));
                layout_UnoInterface_serialize_body(record, scope);
            } else if (tag_22 == "worhp") {
                record["layouts"].a.push_back(JsonValue("WorhpInterface::serialize_body"));
                layout_WorhpInterface_serialize_body(record, scope);
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "Onnx") {
            scope["PluginInterface::plugin_name"] = field(record, "PluginInterface::plugin_name", "std::string", [&]() { return string(); });
            const auto tag_23 = (scope.at("PluginInterface::plugin_name")).scalar;
            if (tag_23 == "ort") {
                record["layouts"].a.push_back(JsonValue("OnnxRuntimeInterface::serialize_body"));
                layout_OnnxRuntimeInterface_serialize_body(record, scope);
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "Rootfinder") {
            scope["PluginInterface::plugin_name"] = field(record, "PluginInterface::plugin_name", "std::string", [&]() { return string(); });
            const auto tag_24 = (scope.at("PluginInterface::plugin_name")).scalar;
            if (tag_24 == "bisection") {
                record["layouts"].a.push_back(JsonValue("Bisection::serialize_body"));
                layout_Bisection_serialize_body(record, scope);
            } else if (tag_24 == "fast_newton") {
                record["layouts"].a.push_back(JsonValue("FastNewton::serialize_body"));
                layout_FastNewton_serialize_body(record, scope);
            } else if (tag_24 == "kinsol") {
                record["layouts"].a.push_back(JsonValue("KinsolInterface::serialize_body"));
                layout_KinsolInterface_serialize_body(record, scope);
            } else if (tag_24 == "newton") {
                record["layouts"].a.push_back(JsonValue("Newton::serialize_body"));
                layout_Newton_serialize_body(record, scope);
            } else if (tag_24 == "nlpsol") {
                record["layouts"].a.push_back(JsonValue("ImplicitToNlp::serialize_body"));
                layout_ImplicitToNlp_serialize_body(record, scope);
            } else {
                fail("Unknown serialization discriminator");
            }
        } else if (tag_14 == "SXFunction") {
            record["layouts"].a.push_back(JsonValue("SXFunction::serialize_body"));
            layout_SXFunction_serialize_body(record, scope);
        } else if (tag_14 == "Smoothing") {
            record["layouts"].a.push_back(JsonValue("Smoothing::serialize_body"));
            layout_Smoothing_serialize_body(record, scope);
        } else if (tag_14 == "Switch") {
            record["layouts"].a.push_back(JsonValue("Switch::serialize_body"));
            layout_Switch_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    }
    --depth;
}

JsonValue read_Function() {
    return object("Function", "F", true, &Reader::read_Function_body);
}

void read_GenericType_body(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["GenericType::type"] = field(record, "GenericType::type", "int", [&]() { return number("int"); });
    const auto tag_25 = (scope.at("GenericType::type")).scalar;
    if (tag_25 == "1") {
        field(record, "GenericType::d", "bool", [&]() { return boolvalue(); });
    } else if (tag_25 == "10") {
        field(record, "GenericType::d", "std::vector<std::string>", [&]() { return read_std_vector_std_string(); });
    } else if (tag_25 == "11") {
        field(record, "GenericType::d", "Dict", [&]() { return read_Dict(); });
    } else if (tag_25 == "12") {
        field(record, "GenericType::d", "Function", [&]() { return read_Function(); });
    } else if (tag_25 == "13") {
        field(record, "GenericType::d", "std::vector<Function>", [&]() { return read_std_vector_Function(); });
    } else if (tag_25 == "14") {
        field(record, "GenericType::d", "void*", [&]() { return primitive("void*"); });
    } else if (tag_25 == "16") {
        field(record, "GenericType::d", "std::vector<std::vector<std::string>>", [&]() { return read_std_vector_std_vector_std_string(); });
    } else if (tag_25 == "17") {
        field(record, "GenericType::d", "std::vector<Dict>", [&]() { return read_std_vector_Dict(); });
    } else if (tag_25 == "18") {
        field(record, "GenericType::d", "std::vector<std::vector<GenericType>>", [&]() { return read_std_vector_std_vector_GenericType(); });
    } else if (tag_25 == "19") {
        field(record, "GenericType::d", "std::vector<GenericType>", [&]() { return read_std_vector_GenericType(); });
    } else if (tag_25 == "2") {
        field(record, "GenericType::d", "casadi_int", [&]() { return number("casadi_int"); });
    } else if (tag_25 == "3") {
        field(record, "GenericType::d", "double", [&]() { return number("double"); });
    } else if (tag_25 == "4") {
        field(record, "GenericType::d", "std::string", [&]() { return string(); });
    } else if (tag_25 == "5") {
        field(record, "GenericType::d", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    } else if (tag_25 == "6") {
        field(record, "GenericType::d", "std::vector<std::vector<casadi_int>>", [&]() { return read_std_vector_std_vector_casadi_int(); });
    } else if (tag_25 == "7") {
        field(record, "GenericType::d", "std::vector<bool>", [&]() { return read_std_vector_bool(); });
    } else if (tag_25 == "8") {
        field(record, "GenericType::d", "std::vector<double>", [&]() { return read_std_vector_double(); });
    } else if (tag_25 == "9") {
        field(record, "GenericType::d", "std::vector<std::vector<double>>", [&]() { return read_std_vector_std_vector_double(); });
    } else {
        fail("Unknown serialization discriminator");
    }
    --depth;
}

JsonValue read_GenericType() {
    return object("GenericType", "G", true, &Reader::read_GenericType_body);
}

void read_IM_body(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "Matrix::sparsity", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Matrix::nonzeros", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

JsonValue read_IM() {
    return object("IM", "", false, &Reader::read_IM_body);
}

void read_Importer_body(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["ImporterInternal::type"] = field(record, "ImporterInternal::type", "std::string", [&]() { return string(); });
    const auto tag_26 = (scope.at("ImporterInternal::type")).scalar;
    if (tag_26 == "DllLibrary") {
        record["layouts"].a.push_back(JsonValue("ImporterInternal::serialize_body"));
        layout_ImporterInternal_serialize_body(record, scope);
    } else {
        fail("Unknown serialization discriminator");
    }
    --depth;
}

JsonValue read_Importer() {
    return object("Importer", "M", true, &Reader::read_Importer_body);
}

void read_Linsol_body(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["PluginInterface::plugin_name"] = field(record, "PluginInterface::plugin_name", "std::string", [&]() { return string(); });
    const auto tag_27 = (scope.at("PluginInterface::plugin_name")).scalar;
    if (tag_27 == "csparse") {
        record["layouts"].a.push_back(JsonValue("CsparseInterface::serialize_body"));
        layout_CsparseInterface_serialize_body(record, scope);
    } else if (tag_27 == "csparsecholesky") {
        record["layouts"].a.push_back(JsonValue("CSparseCholeskyInterface::serialize_body"));
        layout_CSparseCholeskyInterface_serialize_body(record, scope);
    } else if (tag_27 == "lapacklu") {
        record["layouts"].a.push_back(JsonValue("LapackLu::serialize_body"));
        layout_LapackLu_serialize_body(record, scope);
    } else if (tag_27 == "lapackqr") {
        record["layouts"].a.push_back(JsonValue("LapackQr::serialize_body"));
        layout_LapackQr_serialize_body(record, scope);
    } else if (tag_27 == "ldl") {
        record["layouts"].a.push_back(JsonValue("LinsolLdl::serialize_body"));
        layout_LinsolLdl_serialize_body(record, scope);
    } else if (tag_27 == "lsqr") {
        record["layouts"].a.push_back(JsonValue("Lsqr::serialize_body"));
        layout_Lsqr_serialize_body(record, scope);
    } else if (tag_27 == "ma27") {
        record["layouts"].a.push_back(JsonValue("Ma27Interface::serialize_body"));
        layout_Ma27Interface_serialize_body(record, scope);
    } else if (tag_27 == "mumps") {
        record["layouts"].a.push_back(JsonValue("MumpsInterface::serialize_body"));
        layout_MumpsInterface_serialize_body(record, scope);
    } else if (tag_27 == "qr") {
        record["layouts"].a.push_back(JsonValue("LinsolQr::serialize_body"));
        layout_LinsolQr_serialize_body(record, scope);
    } else if (tag_27 == "symbolicqr") {
        record["layouts"].a.push_back(JsonValue("SymbolicQr::serialize_body"));
        layout_SymbolicQr_serialize_body(record, scope);
    } else if (tag_27 == "tridiag") {
        record["layouts"].a.push_back(JsonValue("LinsolTridiag::serialize_body"));
        layout_LinsolTridiag_serialize_body(record, scope);
    } else {
        fail("Unknown serialization discriminator");
    }
    --depth;
}

JsonValue read_Linsol() {
    return object("Linsol", "L", true, &Reader::read_Linsol_body);
}

void read_MX_body(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["MXNode::op"] = field(record, "MXNode::op", "int", [&]() { return number("int"); });
    const auto tag_28 = (scope.at("MXNode::op")).scalar;
    if (tag_28 == "-1") {
        record["layouts"].a.push_back(JsonValue("OutputNode::serialize_body"));
        layout_OutputNode_serialize_body(record, scope);
    } else if (tag_28 == "0") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "1") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "10") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "100") {
        scope["KronContract::kind"] = field(record, "KronContract::kind", "std::string", [&]() { return string(); });
        const auto tag_29 = (scope.at("KronContract::kind")).scalar;
        if (tag_29 == "base") {
            record["layouts"].a.push_back(JsonValue("KronContract::serialize_body"));
            layout_KronContract_serialize_body(record, scope);
        } else if (tag_29 == "dense") {
            record["layouts"].a.push_back(JsonValue("DenseKronContract::serialize_body"));
            layout_DenseKronContract_serialize_body(record, scope);
        } else if (tag_29 == "dense_sparse") {
            record["layouts"].a.push_back(JsonValue("DenseSparseKronContract::serialize_body"));
            layout_DenseSparseKronContract_serialize_body(record, scope);
        } else if (tag_29 == "sparse_dense") {
            record["layouts"].a.push_back(JsonValue("SparseDenseKronContract::serialize_body"));
            layout_SparseDenseKronContract_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "11") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "12") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "13") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "14") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "15") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "16") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "17") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "18") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "19") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "2") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "20") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "21") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "22") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "23") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "24") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "25") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "26") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "27") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "28") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "29") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "3") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "30") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "31") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "32") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "33") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "34") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "35") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "36") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "37") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "38") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "39") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "4") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "40") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "41") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "42") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "43") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "44") {
        scope["ConstantMX::type"] = field(record, "ConstantMX::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_30 = (scope.at("ConstantMX::type")).scalar;
        if (tag_30 == "102") {
            record["layouts"].a.push_back(JsonValue("ConstantFile::serialize_body"));
            layout_ConstantFile_serialize_body(record, scope);
        } else if (tag_30 == "109") {
            record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
            layout_MXNode_serialize_body(record, scope);
        } else if (tag_30 == "112") {
            record["layouts"].a.push_back(JsonValue("ConstantPool::serialize_body"));
            layout_ConstantPool_serialize_body(record, scope);
        } else if (tag_30 == "122") {
        } else if (tag_30 == "48") {
            record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
            layout_MXNode_serialize_body(record, scope);
        } else if (tag_30 == "49") {
            record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
            layout_MXNode_serialize_body(record, scope);
        } else if (tag_30 == "68") {
            field(record, "Constant::value", "double", [&]() { return number("double"); });
            record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
            layout_MXNode_serialize_body(record, scope);
        } else if (tag_30 == "73") {
            field(record, "Constant::value", "casadi_int", [&]() { return number("casadi_int"); });
            record["layouts"].a.push_back(JsonValue("MXNode::serialize_body"));
            layout_MXNode_serialize_body(record, scope);
        } else if (tag_30 == "97") {
            record["layouts"].a.push_back(JsonValue("ConstantDM::serialize_body"));
            layout_ConstantDM_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "45") {
        record["layouts"].a.push_back(JsonValue("Input::serialize_body"));
        layout_Input_serialize_body(record, scope);
    } else if (tag_28 == "46") {
        record["layouts"].a.push_back(JsonValue("Output::serialize_body"));
        layout_Output_serialize_body(record, scope);
    } else if (tag_28 == "47") {
        record["layouts"].a.push_back(JsonValue("SymbolicMX::serialize_body"));
        layout_SymbolicMX_serialize_body(record, scope);
    } else if (tag_28 == "48") {
        record["layouts"].a.push_back(JsonValue("Call::serialize_body"));
        layout_Call_serialize_body(record, scope);
    } else if (tag_28 == "49") {
        record["layouts"].a.push_back(JsonValue("Find::serialize_body"));
        layout_Find_serialize_body(record, scope);
    } else if (tag_28 == "5") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "50") {
        record["layouts"].a.push_back(JsonValue("Low::serialize_body"));
        layout_Low_serialize_body(record, scope);
    } else if (tag_28 == "52") {
        scope["Multiplication::kind"] = field(record, "Multiplication::kind", "std::string", [&]() { return string(); });
        const auto tag_31 = (scope.at("Multiplication::kind")).scalar;
        if (tag_31 == "base") {
            record["layouts"].a.push_back(JsonValue("Multiplication::serialize_body"));
            layout_Multiplication_serialize_body(record, scope);
        } else if (tag_31 == "dense") {
            record["layouts"].a.push_back(JsonValue("DenseMultiplication::serialize_body"));
            layout_DenseMultiplication_serialize_body(record, scope);
        } else if (tag_31 == "dense_sparse") {
            record["layouts"].a.push_back(JsonValue("DenseSparseMultiplication::serialize_body"));
            layout_DenseSparseMultiplication_serialize_body(record, scope);
        } else if (tag_31 == "pseudo_dense") {
            record["layouts"].a.push_back(JsonValue("PseudoDenseMultiplication::serialize_body"));
            layout_PseudoDenseMultiplication_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "53") {
        field(record, "Solve::Tr", "bool", [&]() { return boolvalue(); });
        record["layouts"].a.push_back(JsonValue("LinsolCall<Tr>::serialize_body"));
        layout_LinsolCall_Tr_serialize_body(record, scope);
    } else if (tag_28 == "54") {
        scope["Transpose::dense"] = field(record, "Transpose::dense", "bool", [&]() { return boolvalue(); });
        const auto tag_32 = (scope.at("Transpose::dense")).scalar;
        if (tag_32 == "false") {
            record["layouts"].a.push_back(JsonValue("Transpose::serialize_body"));
            layout_Transpose_serialize_body(record, scope);
        } else if (tag_32 == "true") {
            record["layouts"].a.push_back(JsonValue("DenseTranspose::serialize_body"));
            layout_DenseTranspose_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "55") {
        record["layouts"].a.push_back(JsonValue("Determinant::serialize_body"));
        layout_Determinant_serialize_body(record, scope);
    } else if (tag_28 == "56") {
        record["layouts"].a.push_back(JsonValue("Inverse::serialize_body"));
        layout_Inverse_serialize_body(record, scope);
    } else if (tag_28 == "57") {
        record["layouts"].a.push_back(JsonValue("Dot::serialize_body"));
        layout_Dot_serialize_body(record, scope);
    } else if (tag_28 == "58") {
        record["layouts"].a.push_back(JsonValue("Bilin::serialize_body"));
        layout_Bilin_serialize_body(record, scope);
    } else if (tag_28 == "59") {
        record["layouts"].a.push_back(JsonValue("Rank1::serialize_body"));
        layout_Rank1_serialize_body(record, scope);
    } else if (tag_28 == "6") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "60") {
        record["layouts"].a.push_back(JsonValue("Horzcat::serialize_body"));
        layout_Horzcat_serialize_body(record, scope);
    } else if (tag_28 == "61") {
        record["layouts"].a.push_back(JsonValue("Vertcat::serialize_body"));
        layout_Vertcat_serialize_body(record, scope);
    } else if (tag_28 == "62") {
        record["layouts"].a.push_back(JsonValue("Diagcat::serialize_body"));
        layout_Diagcat_serialize_body(record, scope);
    } else if (tag_28 == "63") {
        record["layouts"].a.push_back(JsonValue("Horzsplit::serialize_body"));
        layout_Horzsplit_serialize_body(record, scope);
    } else if (tag_28 == "64") {
        record["layouts"].a.push_back(JsonValue("Vertsplit::serialize_body"));
        layout_Vertsplit_serialize_body(record, scope);
    } else if (tag_28 == "65") {
        record["layouts"].a.push_back(JsonValue("Diagsplit::serialize_body"));
        layout_Diagsplit_serialize_body(record, scope);
    } else if (tag_28 == "66") {
        record["layouts"].a.push_back(JsonValue("Reshape::serialize_body"));
        layout_Reshape_serialize_body(record, scope);
    } else if (tag_28 == "69") {
        scope["GetNonzeros::type"] = field(record, "GetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_33 = (scope.at("GetNonzeros::type")).scalar;
        if (tag_33 == "97") {
            record["layouts"].a.push_back(JsonValue("GetNonzerosVector::serialize_body"));
            layout_GetNonzerosVector_serialize_body(record, scope);
        } else if (tag_33 == "98") {
            record["layouts"].a.push_back(JsonValue("GetNonzerosSlice::serialize_body"));
            layout_GetNonzerosSlice_serialize_body(record, scope);
        } else if (tag_33 == "99") {
            record["layouts"].a.push_back(JsonValue("GetNonzerosSlice2::serialize_body"));
            layout_GetNonzerosSlice2_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "7") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "70") {
        scope["GetNonzerosParam::type"] = field(record, "GetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_34 = (scope.at("GetNonzerosParam::type")).scalar;
        if (tag_34 == "100") {
            record["layouts"].a.push_back(JsonValue("GetNonzerosParamParam::serialize_body"));
            layout_GetNonzerosParamParam_serialize_body(record, scope);
        } else if (tag_34 == "97") {
            record["layouts"].a.push_back(JsonValue("GetNonzerosParamVector::serialize_body"));
            layout_GetNonzerosParamVector_serialize_body(record, scope);
        } else if (tag_34 == "98") {
            record["layouts"].a.push_back(JsonValue("GetNonzerosParamSlice::serialize_body"));
            layout_GetNonzerosParamSlice_serialize_body(record, scope);
        } else if (tag_34 == "99") {
            record["layouts"].a.push_back(JsonValue("GetNonzerosSliceParam::serialize_body"));
            layout_GetNonzerosSliceParam_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "71") {
        scope["SetNonzeros::type"] = field(record, "SetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_35 = (scope.at("SetNonzeros::type")).scalar;
        if (tag_35 == "97") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosVector<Add>::serialize_body"));
            layout_SetNonzerosVector_Add_serialize_body(record, scope);
        } else if (tag_35 == "98") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosSlice<Add>::serialize_body"));
            layout_SetNonzerosSlice_Add_serialize_body(record, scope);
        } else if (tag_35 == "99") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosSlice2<Add>::serialize_body"));
            layout_SetNonzerosSlice2_Add_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "72") {
        scope["SetNonzerosParam::type"] = field(record, "SetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_36 = (scope.at("SetNonzerosParam::type")).scalar;
        if (tag_36 == "100") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosParamParam<Add>::serialize_body"));
            layout_SetNonzerosParamParam_Add_serialize_body(record, scope);
        } else if (tag_36 == "97") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosParamVector<Add>::serialize_body"));
            layout_SetNonzerosParamVector_Add_serialize_body(record, scope);
        } else if (tag_36 == "98") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosParamSlice<Add>::serialize_body"));
            layout_SetNonzerosParamSlice_Add_serialize_body(record, scope);
        } else if (tag_36 == "99") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosSliceParam<Add>::serialize_body"));
            layout_SetNonzerosSliceParam_Add_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "73") {
        scope["SetNonzeros::type"] = field(record, "SetNonzeros::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_37 = (scope.at("SetNonzeros::type")).scalar;
        if (tag_37 == "97") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosVector<Add>::serialize_body"));
            layout_SetNonzerosVector_Add_serialize_body(record, scope);
        } else if (tag_37 == "98") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosSlice<Add>::serialize_body"));
            layout_SetNonzerosSlice_Add_serialize_body(record, scope);
        } else if (tag_37 == "99") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosSlice2<Add>::serialize_body"));
            layout_SetNonzerosSlice2_Add_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "74") {
        scope["SetNonzerosParam::type"] = field(record, "SetNonzerosParam::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_38 = (scope.at("SetNonzerosParam::type")).scalar;
        if (tag_38 == "100") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosParamParam<Add>::serialize_body"));
            layout_SetNonzerosParamParam_Add_serialize_body(record, scope);
        } else if (tag_38 == "97") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosParamVector<Add>::serialize_body"));
            layout_SetNonzerosParamVector_Add_serialize_body(record, scope);
        } else if (tag_38 == "98") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosParamSlice<Add>::serialize_body"));
            layout_SetNonzerosParamSlice_Add_serialize_body(record, scope);
        } else if (tag_38 == "99") {
            record["layouts"].a.push_back(JsonValue("SetNonzerosSliceParam<Add>::serialize_body"));
            layout_SetNonzerosSliceParam_Add_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "75") {
        scope["Project::type"] = field(record, "Project::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_39 = (scope.at("Project::type")).scalar;
        if (tag_39 == "100") {
            record["layouts"].a.push_back(JsonValue("Densify::serialize_body"));
            layout_Densify_serialize_body(record, scope);
        } else if (tag_39 == "110") {
            record["layouts"].a.push_back(JsonValue("Project::serialize_body"));
            layout_Project_serialize_body(record, scope);
        } else if (tag_39 == "115") {
            record["layouts"].a.push_back(JsonValue("Sparsify::serialize_body"));
            layout_Sparsify_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "76") {
        record["layouts"].a.push_back(JsonValue("Assertion::serialize_body"));
        layout_Assertion_serialize_body(record, scope);
    } else if (tag_28 == "77") {
        record["layouts"].a.push_back(JsonValue("Monitor::serialize_body"));
        layout_Monitor_serialize_body(record, scope);
    } else if (tag_28 == "78") {
        record["layouts"].a.push_back(JsonValue("Norm2::serialize_body"));
        layout_Norm2_serialize_body(record, scope);
    } else if (tag_28 == "79") {
        record["layouts"].a.push_back(JsonValue("Norm1::serialize_body"));
        layout_Norm1_serialize_body(record, scope);
    } else if (tag_28 == "8") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "80") {
        record["layouts"].a.push_back(JsonValue("NormInf::serialize_body"));
        layout_NormInf_serialize_body(record, scope);
    } else if (tag_28 == "81") {
        record["layouts"].a.push_back(JsonValue("NormF::serialize_body"));
        layout_NormF_serialize_body(record, scope);
    } else if (tag_28 == "82") {
        record["layouts"].a.push_back(JsonValue("MMin::serialize_body"));
        layout_MMin_serialize_body(record, scope);
    } else if (tag_28 == "83") {
        record["layouts"].a.push_back(JsonValue("MMax::serialize_body"));
        layout_MMax_serialize_body(record, scope);
    } else if (tag_28 == "84") {
        record["layouts"].a.push_back(JsonValue("HorzRepmat::serialize_body"));
        layout_HorzRepmat_serialize_body(record, scope);
    } else if (tag_28 == "85") {
        record["layouts"].a.push_back(JsonValue("HorzRepsum::serialize_body"));
        layout_HorzRepsum_serialize_body(record, scope);
    } else if (tag_28 == "86") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "87") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "88") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "89") {
        record["layouts"].a.push_back(JsonValue("Einstein::serialize_body"));
        layout_Einstein_serialize_body(record, scope);
    } else if (tag_28 == "9") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "90") {
        scope["BSpline::type"] = field(record, "BSpline::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_40 = (scope.at("BSpline::type")).scalar;
        if (tag_40 == "110") {
            record["layouts"].a.push_back(JsonValue("BSpline::serialize_body"));
            layout_BSpline_serialize_body(record, scope);
        } else if (tag_40 == "112") {
            record["layouts"].a.push_back(JsonValue("BSplineParametric::serialize_body"));
            layout_BSplineParametric_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_28 == "91") {
        record["layouts"].a.push_back(JsonValue("Convexify::serialize_body"));
        layout_Convexify_serialize_body(record, scope);
    } else if (tag_28 == "92") {
        record["layouts"].a.push_back(JsonValue("SparsityCast::serialize_body"));
        layout_SparsityCast_serialize_body(record, scope);
    } else if (tag_28 == "93") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "94") {
        record["layouts"].a.push_back(JsonValue("UnaryMX::serialize_body"));
        layout_UnaryMX_serialize_body(record, scope);
    } else if (tag_28 == "95") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "96") {
        record["layouts"].a.push_back(JsonValue("LogSumExp::serialize_body"));
        layout_LogSumExp_serialize_body(record, scope);
    } else if (tag_28 == "97") {
        field(record, "BinaryMX::scalar_flags", "char", [&]() { return JsonValue(byte()); });
        record["layouts"].a.push_back(JsonValue("BinaryMX<ScX,ScY>::serialize_body"));
        layout_BinaryMX_ScX_ScY_serialize_body(record, scope);
    } else if (tag_28 == "98") {
        record["layouts"].a.push_back(JsonValue("Dump::serialize_body"));
        layout_Dump_serialize_body(record, scope);
    } else if (tag_28 == "99") {
        scope["Kron::kind"] = field(record, "Kron::kind", "std::string", [&]() { return string(); });
        const auto tag_41 = (scope.at("Kron::kind")).scalar;
        if (tag_41 == "base") {
            record["layouts"].a.push_back(JsonValue("Kron::serialize_body"));
            layout_Kron_serialize_body(record, scope);
        } else if (tag_41 == "dense") {
            record["layouts"].a.push_back(JsonValue("DenseKron::serialize_body"));
            layout_DenseKron_serialize_body(record, scope);
        } else if (tag_41 == "dense_sparse") {
            record["layouts"].a.push_back(JsonValue("DenseSparseKron::serialize_body"));
            layout_DenseSparseKron_serialize_body(record, scope);
        } else if (tag_41 == "sparse_dense") {
            record["layouts"].a.push_back(JsonValue("SparseDenseKron::serialize_body"));
            layout_SparseDenseKron_serialize_body(record, scope);
        } else {
            fail("Unknown serialization discriminator");
        }
    } else {
        fail("Unknown serialization discriminator");
    }
    --depth;
}

JsonValue read_MX() {
    return object("MX", "X", true, &Reader::read_MX_body);
}

void read_Resource_body(JsonValue& record, Scope& scope) {
    enter_layout();
    version(record, "ResourceInternal", 1);
    scope["ResourceInternal::type"] = field(record, "ResourceInternal::type", "std::string", [&]() { return string(); });
    const auto tag_42 = (scope.at("ResourceInternal::type")).scalar;
    if (tag_42 == "DirResource") {
        record["layouts"].a.push_back(JsonValue("DirResource::serialize_body"));
        layout_DirResource_serialize_body(record, scope);
    } else if (tag_42 == "ZipMemResource") {
        record["layouts"].a.push_back(JsonValue("ZipMemResource::serialize_body"));
        layout_ZipMemResource_serialize_body(record, scope);
    } else if (tag_42 == "ZipResource") {
        record["layouts"].a.push_back(JsonValue("ZipResource::serialize_body"));
        layout_ZipResource_serialize_body(record, scope);
    } else {
        fail("Unknown serialization discriminator");
    }
    --depth;
}

JsonValue read_Resource() {
    return object("Resource", "R", true, &Reader::read_Resource_body);
}

void read_SX_body(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "Matrix::sparsity", "Sparsity", [&]() { return read_Sparsity(); });
    field(record, "Matrix::nonzeros", "std::vector<SXElem>", [&]() { return read_std_vector_SXElem(); });
    --depth;
}

JsonValue read_SX() {
    return object("SX", "", false, &Reader::read_SX_body);
}

void read_SXElem_body(JsonValue& record, Scope& scope) {
    enter_layout();
    scope["SXNode::op"] = field(record, "SXNode::op", "casadi_int", [&]() { return number("casadi_int"); });
    const auto tag_43 = (scope.at("SXNode::op")).scalar;
    if (tag_43 == "-1") {
        record["layouts"].a.push_back(JsonValue("OutputSX::serialize_node"));
        layout_OutputSX_serialize_node(record, scope);
    } else if (tag_43 == "0") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "1") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "10") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "11") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "12") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "13") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "14") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "15") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "16") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "17") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "18") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "19") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "2") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "20") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "21") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "22") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "23") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "24") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "25") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "26") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "27") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "28") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "29") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "3") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "30") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "31") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "32") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "33") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "34") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "35") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "36") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "37") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "38") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "39") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "4") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "40") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "41") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "42") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "43") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "44") {
        scope["ConstantSX::type"] = field(record, "ConstantSX::type", "char", [&]() { return JsonValue(byte()); });
        const auto tag_44 = (scope.at("ConstantSX::type")).scalar;
        if (tag_44 == "102") {
        } else if (tag_44 == "105") {
            field(record, "ConstantSX::value", "int", [&]() { return number("int"); });
        } else if (tag_44 == "109") {
        } else if (tag_44 == "110") {
        } else if (tag_44 == "114") {
            field(record, "ConstantSX::value", "double", [&]() { return number("double"); });
        } else if (tag_44 == "48") {
        } else if (tag_44 == "49") {
        } else if (tag_44 == "70") {
        } else {
            fail("Unknown serialization discriminator");
        }
    } else if (tag_43 == "47") {
        record["layouts"].a.push_back(JsonValue("SymbolicSX::serialize_node"));
        layout_SymbolicSX_serialize_node(record, scope);
    } else if (tag_43 == "48") {
        record["layouts"].a.push_back(JsonValue("CallSX::serialize_node"));
        layout_CallSX_serialize_node(record, scope);
    } else if (tag_43 == "5") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "6") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "7") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "8") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "86") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "87") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "88") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "9") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "93") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "94") {
        record["layouts"].a.push_back(JsonValue("UnarySX::serialize_node"));
        layout_UnarySX_serialize_node(record, scope);
    } else if (tag_43 == "95") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else if (tag_43 == "97") {
        record["layouts"].a.push_back(JsonValue("BinarySX::serialize_node"));
        layout_BinarySX_serialize_node(record, scope);
    } else {
        fail("Unknown serialization discriminator");
    }
    --depth;
}

JsonValue read_SXElem() {
    return object("SXElem", "E", true, &Reader::read_SXElem_body);
}

void read_Slice_body(JsonValue& record, Scope& scope) {
    enter_layout();
    record["layouts"].a.push_back(JsonValue("Slice::serialize"));
    layout_Slice_serialize(record, scope);
    --depth;
}

JsonValue read_Slice() {
    return object("Slice", "S", false, &Reader::read_Slice_body);
}

void read_Sparsity_body(JsonValue& record, Scope& scope) {
    enter_layout();
    field(record, "SparsityInternal::compressed", "std::vector<casadi_int>", [&]() { return read_std_vector_casadi_int(); });
    --depth;
}

JsonValue read_Sparsity() {
    return object("Sparsity", "S", true, &Reader::read_Sparsity_body);
}

JsonValue read_std_vector_double() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(number("double"));
    }
    return result;
}

JsonValue read_std_vector_casadi_int() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(number("casadi_int"));
    }
    return result;
}

JsonValue read_std_vector_std_vector_double() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_std_vector_double());
    }
    return result;
}

JsonValue read_std_vector_std_string() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(string());
    }
    return result;
}

JsonValue read_std_vector_int() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(number("int"));
    }
    return result;
}

JsonValue read_std_vector_char() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(JsonValue(byte()));
    }
    return result;
}

JsonValue read_std_vector_bool() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(boolvalue());
    }
    return result;
}

JsonValue read_std_vector_SXElem() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_SXElem());
    }
    return result;
}

JsonValue read_std_vector_std_vector_int() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_std_vector_int());
    }
    return result;
}

JsonValue read_std_vector_unsignedint() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(number("unsignedint"));
    }
    return result;
}

JsonValue read_std_vector_size_t() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(number("size_t"));
    }
    return result;
}

JsonValue read_std_vector_Sparsity() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_Sparsity());
    }
    return result;
}

JsonValue read_std_map_std_string_std_vector_size_t() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(read_std_vector_size_t());
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue read_std_vector_std_vector_size_t() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_std_vector_size_t());
    }
    return result;
}

JsonValue read_std_vector_Function() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_Function());
    }
    return result;
}

JsonValue read_std_pair_casadi_int_std_string() {
    decoration('p');
    JsonValue result = JsonValue::array();
    result.a.push_back(number("casadi_int"));
    result.a.push_back(string());
    return result;
}

JsonValue read_std_map_std_string_std_pair_casadi_int_std_string() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(read_std_pair_casadi_int_std_string());
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue read_std_pair_bool_std_string() {
    decoration('p');
    JsonValue result = JsonValue::array();
    result.a.push_back(boolvalue());
    result.a.push_back(string());
    return result;
}

JsonValue read_std_map_std_string_std_pair_bool_std_string() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(read_std_pair_bool_std_string());
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue read_std_vector_MX() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_MX());
    }
    return result;
}

JsonValue read_std_map_std_string_std_vector_double() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(read_std_vector_double());
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue read_std_map_std_string_casadi_int() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(number("casadi_int"));
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue read_std_map_std_string_std_vector_casadi_int() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(read_std_vector_casadi_int());
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue read_std_map_std_string_bool() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(boolvalue());
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue read_std_map_std_string_double() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(number("double"));
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue read_std_vector_SX() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_SX());
    }
    return result;
}

JsonValue read_std_vector_std_vector_casadi_int() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_std_vector_casadi_int());
    }
    return result;
}

JsonValue read_std_vector_std_vector_std_string() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_std_vector_std_string());
    }
    return result;
}

JsonValue read_std_vector_Dict() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_Dict());
    }
    return result;
}

JsonValue read_std_vector_GenericType() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_GenericType());
    }
    return result;
}

JsonValue read_std_vector_std_vector_GenericType() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_std_vector_GenericType());
    }
    return result;
}

JsonValue read_std_vector_DM() {
    decoration('V');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        result.a.push_back(read_DM());
    }
    return result;
}

JsonValue read_Dict() {
    decoration('D');
    JsonValue result = JsonValue::array();
    const auto n = count(number("casadi_int"));
    for (uint64_t i = 0; i < n; ++i) {
        JsonValue entry = JsonValue::array();
        entry.a.push_back(string());
        entry.a.push_back(read_GenericType());
        result.a.push_back(std::move(entry));
    }
    JsonValue map = JsonValue::object();
    map["$map"] = std::move(result);
    return map;
}

JsonValue value(const std::string& type) {
    if (type == "DM") return read_DM();
    if (type == "Fmu") return read_Fmu();
    if (type == "Function") return read_Function();
    if (type == "GenericType") return read_GenericType();
    if (type == "IM") return read_IM();
    if (type == "Importer") return read_Importer();
    if (type == "Linsol") return read_Linsol();
    if (type == "MX") return read_MX();
    if (type == "Resource") return read_Resource();
    if (type == "SX") return read_SX();
    if (type == "SXElem") return read_SXElem();
    if (type == "Slice") return read_Slice();
    if (type == "Sparsity") return read_Sparsity();
    if (type == "std::vector<double>") return read_std_vector_double();
    if (type == "std::vector<casadi_int>") return read_std_vector_casadi_int();
    if (type == "std::vector<std::vector<double>>") return read_std_vector_std_vector_double();
    if (type == "std::vector<std::string>") return read_std_vector_std_string();
    if (type == "std::vector<int>") return read_std_vector_int();
    if (type == "std::vector<char>") return read_std_vector_char();
    if (type == "std::vector<bool>") return read_std_vector_bool();
    if (type == "std::vector<SXElem>") return read_std_vector_SXElem();
    if (type == "std::vector<std::vector<int>>") return read_std_vector_std_vector_int();
    if (type == "std::vector<unsignedint>") return read_std_vector_unsignedint();
    if (type == "std::vector<size_t>") return read_std_vector_size_t();
    if (type == "std::vector<Sparsity>") return read_std_vector_Sparsity();
    if (type == "std::map<std::string,std::vector<size_t>>") return read_std_map_std_string_std_vector_size_t();
    if (type == "std::vector<std::vector<size_t>>") return read_std_vector_std_vector_size_t();
    if (type == "std::vector<Function>") return read_std_vector_Function();
    if (type == "std::pair<casadi_int,std::string>") return read_std_pair_casadi_int_std_string();
    if (type == "std::map<std::string,std::pair<casadi_int,std::string>>") return read_std_map_std_string_std_pair_casadi_int_std_string();
    if (type == "std::pair<bool,std::string>") return read_std_pair_bool_std_string();
    if (type == "std::map<std::string,std::pair<bool,std::string>>") return read_std_map_std_string_std_pair_bool_std_string();
    if (type == "std::vector<MX>") return read_std_vector_MX();
    if (type == "std::map<std::string,std::vector<double>>") return read_std_map_std_string_std_vector_double();
    if (type == "std::map<std::string,casadi_int>") return read_std_map_std_string_casadi_int();
    if (type == "std::map<std::string,std::vector<casadi_int>>") return read_std_map_std_string_std_vector_casadi_int();
    if (type == "std::map<std::string,bool>") return read_std_map_std_string_bool();
    if (type == "std::map<std::string,double>") return read_std_map_std_string_double();
    if (type == "std::vector<SX>") return read_std_vector_SX();
    if (type == "std::vector<std::vector<casadi_int>>") return read_std_vector_std_vector_casadi_int();
    if (type == "std::vector<std::vector<std::string>>") return read_std_vector_std_vector_std_string();
    if (type == "std::vector<Dict>") return read_std_vector_Dict();
    if (type == "std::vector<GenericType>") return read_std_vector_GenericType();
    if (type == "std::vector<std::vector<GenericType>>") return read_std_vector_std_vector_GenericType();
    if (type == "std::vector<DM>") return read_std_vector_DM();
    if (type == "Dict") return read_Dict();
    return primitive(type);
}
