var __typeError = (msg) => {
  throw TypeError(msg);
};
var __accessCheck = (obj, member, msg) => member.has(obj) || __typeError("Cannot " + msg);
var __privateGet = (obj, member, getter) => (__accessCheck(obj, member, "read from private field"), getter ? getter.call(obj) : member.get(obj));
var __privateAdd = (obj, member, value) => member.has(obj) ? __typeError("Cannot add the same private member more than once") : member instanceof WeakSet ? member.add(obj) : member.set(obj, value);
var __privateSet = (obj, member, value, setter) => (__accessCheck(obj, member, "write to private field"), setter ? setter.call(obj, value) : member.set(obj, value), value);

// src/generated.js
function layout_AlpaqaInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "AlpaqaInterface", 1);
  r.field(record, "AlpaqaInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "AlpaqaInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_AmplInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Assertion_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "Assertion::fail_message", "std::string", () => r.string());
  --r.depth;
}
function layout_BSpline_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("BSplineCommon::serialize_body");
  layout_BSplineCommon_serialize_body(r, record, scope);
  r.field(record, "BSpline::coeffs", "std::vector<double>", () => read_std_vector_double(r));
  --r.depth;
}
function layout_BSplineCommon_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "BSplineCommon::knots", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "BSplineCommon::offset", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "BSplineCommon::degree", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "BSplineCommon::m", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "BSplineCommon::lookup_mode", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "BSplineCommon::strides", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "BSplineCommon::coeffs_dims", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "BSplineCommon::coeffs_size", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "BSplineCommon::jac_cache_", "MX", () => read_MX(r));
  --r.depth;
}
function layout_BSplineInterpolant_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Interpolant::serialize_body");
  layout_Interpolant_serialize_body(r, record, scope);
  r.version(record, "BSplineInterpolant", 1);
  r.field(record, "BSplineInterpolant::s", "Function", () => read_Function(r));
  --r.depth;
}
function layout_BSplineParametric_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("BSplineCommon::serialize_body");
  layout_BSplineCommon_serialize_body(r, record, scope);
  --r.depth;
}
function layout_BackwardDiff_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("ForwardDiff::serialize_body");
  layout_ForwardDiff_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Bilin_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "BinaryMX::op", "int", () => r.number("int"));
  --r.depth;
}
function layout_BinarySX_serialize_node(r, record, scope) {
  r.enterLayout();
  r.field(record, "UnarySX::dep0", "SXElem", () => read_SXElem(r));
  r.field(record, "UnarySX::dep1", "SXElem", () => read_SXElem(r));
  --r.depth;
}
function layout_Bisection_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Rootfinder::serialize_body");
  layout_Rootfinder_serialize_body(r, record, scope);
  r.version(record, "Bisection", 1);
  r.field(record, "Bisection::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Bisection::max_search", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Bisection::search_step", "double", () => r.number("double"));
  r.field(record, "Bisection::abstol", "double", () => r.number("double"));
  r.field(record, "Bisection::abstol_step", "double", () => r.number("double"));
  r.field(record, "Bisection::lb", "double", () => r.number("double"));
  r.field(record, "Bisection::ub", "double", () => r.number("double"));
  --r.depth;
}
function layout_BlazingSplineFunction_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "BlazingSplineFunction", 2);
  r.field(record, "BlazingSplineFunction::diff_order", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "BlazingSplineFunction::precompute_coeff", "bool", () => r.boolean());
  r.field(record, "BlazingSplineFunction::precompute_grid", "bool", () => r.boolean());
  r.field(record, "BlazingSplineFunction::knots", "std::vector<std::vector<double>>", () => read_std_vector_std_vector_double(r));
  r.field(record, "BlazingSplineFunction::lookup_modes", "std::vector<std::string>", () => read_std_vector_std_string(r));
  scope["BlazingSplineFunction::parametric_knots"] = r.field(record, "BlazingSplineFunction::parametric_knots", "bool", () => r.boolean());
  if (scope["BlazingSplineFunction::parametric_knots"]) {
    r.field(record, "BlazingSplineFunction::knots_offset", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
    r.field(record, "BlazingSplineFunction::inv_input", "bool", () => r.boolean());
  }
  r.field(record, "BlazingSplineFunction::pedantic_mode_order", "std::string", () => r.string());
  r.field(record, "BlazingSplineFunction::pedantic_mode_size", "std::string", () => r.string());
  --r.depth;
}
function layout_Blocksqp_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "Blocksqp", 1);
  r.field(record, "Blocksqp::nblocks", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::blocks", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Blocksqp::dim", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Blocksqp::nnz_H", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::Asp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Blocksqp::Hsp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Blocksqp::exact_hess_lag_sp_", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Blocksqp::linsol_plugin", "std::string", () => r.string());
  r.field(record, "Blocksqp::print_header", "bool", () => r.boolean());
  r.field(record, "Blocksqp::print_iteration", "bool", () => r.boolean());
  r.field(record, "Blocksqp::eps", "double", () => r.number("double"));
  r.field(record, "Blocksqp::opttol", "double", () => r.number("double"));
  r.field(record, "Blocksqp::nlinfeastol", "double", () => r.number("double"));
  r.field(record, "Blocksqp::schur", "bool", () => r.boolean());
  r.field(record, "Blocksqp::globalization", "bool", () => r.boolean());
  r.field(record, "Blocksqp::restore_feas", "bool", () => r.boolean());
  r.field(record, "Blocksqp::max_line_search", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::max_consec_reduced_steps", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::max_consec_skipped_updates", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::max_it_qp", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::warmstart", "bool", () => r.boolean());
  r.field(record, "Blocksqp::qp_init", "bool", () => r.boolean());
  r.field(record, "Blocksqp::block_hess", "bool", () => r.boolean());
  r.field(record, "Blocksqp::hess_scaling", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::fallback_scaling", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::max_time_qp", "double", () => r.number("double"));
  r.field(record, "Blocksqp::ini_hess_diag", "double", () => r.number("double"));
  r.field(record, "Blocksqp::col_eps", "double", () => r.number("double"));
  r.field(record, "Blocksqp::col_tau1", "double", () => r.number("double"));
  r.field(record, "Blocksqp::col_tau2", "double", () => r.number("double"));
  r.field(record, "Blocksqp::hess_damp", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::hess_damp_fac", "double", () => r.number("double"));
  r.field(record, "Blocksqp::hess_update", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::fallback_update", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::hess_lim_mem", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::hess_memsize", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::which_second_derv", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::skip_first_globalization", "bool", () => r.boolean());
  r.field(record, "Blocksqp::conv_strategy", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::max_conv_qp", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::max_soc_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Blocksqp::gamma_theta", "double", () => r.number("double"));
  r.field(record, "Blocksqp::gamma_f", "double", () => r.number("double"));
  r.field(record, "Blocksqp::kappa_soc", "double", () => r.number("double"));
  r.field(record, "Blocksqp::kappa_f", "double", () => r.number("double"));
  r.field(record, "Blocksqp::theta_max", "double", () => r.number("double"));
  r.field(record, "Blocksqp::theta_min", "double", () => r.number("double"));
  r.field(record, "Blocksqp::delta", "double", () => r.number("double"));
  r.field(record, "Blocksqp::s_theta", "double", () => r.number("double"));
  r.field(record, "Blocksqp::s_f", "double", () => r.number("double"));
  r.field(record, "Blocksqp::kappa_minus", "double", () => r.number("double"));
  r.field(record, "Blocksqp::kappa_plus", "double", () => r.number("double"));
  r.field(record, "Blocksqp::kappa_plus_max", "double", () => r.number("double"));
  r.field(record, "Blocksqp::delta_h0", "double", () => r.number("double"));
  r.field(record, "Blocksqp::eta", "double", () => r.number("double"));
  r.field(record, "Blocksqp::obj_lo", "double", () => r.number("double"));
  r.field(record, "Blocksqp::obj_up", "double", () => r.number("double"));
  r.field(record, "Blocksqp::rho", "double", () => r.number("double"));
  r.field(record, "Blocksqp::zeta", "double", () => r.number("double"));
  r.field(record, "Blocksqp::rp_solver", "Function", () => read_Function(r));
  r.field(record, "Blocksqp::print_maxit_reached", "bool", () => r.boolean());
  --r.depth;
}
function layout_BonminInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "BonminInterface", 1);
  r.field(record, "BonminInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "BonminInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "BonminInterface::exact_hessian", "bool", () => r.boolean());
  r.field(record, "BonminInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "BonminInterface::sos1_weights", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "BonminInterface::sos1_indices", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "BonminInterface::sos1_priorities", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "BonminInterface::sos1_starts", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "BonminInterface::sos1_types", "std::vector<char>", () => read_std_vector_char(r));
  r.field(record, "BonminInterface::sos1_types", "std::vector<char>", () => read_std_vector_char(r));
  r.field(record, "BonminInterface::sos_num", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "BonminInterface::sos_num_nz", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "BonminInterface::pass_nonlinear_variables", "bool", () => r.boolean());
  r.field(record, "BonminInterface::pass_nonlinear_constraints", "bool", () => r.boolean());
  r.field(record, "BonminInterface::nl_ex", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "BonminInterface::nl_g", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "BonminInterface::var_string_md", "Dict", () => read_Dict(r));
  r.field(record, "BonminInterface::var_integer_md", "Dict", () => read_Dict(r));
  r.field(record, "BonminInterface::var_numeric_md", "Dict", () => read_Dict(r));
  r.field(record, "BonminInterface::con_string_md", "Dict", () => read_Dict(r));
  r.field(record, "BonminInterface::con_integer_md", "Dict", () => read_Dict(r));
  r.field(record, "BonminInterface::con_numeric_md", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_CSparseCholeskyInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Call_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MultipleOutput::serialize_body");
  layout_MultipleOutput_serialize_body(r, record, scope);
  r.field(record, "Call::fcn", "Function", () => read_Function(r));
  --r.depth;
}
function layout_CallSX_serialize_node(r, record, scope) {
  r.enterLayout();
  r.field(record, "CallSX::f", "Function", () => read_Function(r));
  r.field(record, "CallSX::dep", "std::vector<SXElem>", () => read_std_vector_SXElem(r));
  --r.depth;
}
function layout_CbcInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "CbcInterface", 1);
  r.field(record, "CbcInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "CbcInterface::sos_groups", "std::vector<std::vector<int>>", () => read_std_vector_std_vector_int(r));
  r.field(record, "CbcInterface::sos_weights", "std::vector<std::vector<double>>", () => read_std_vector_std_vector_double(r));
  r.field(record, "CbcInterface::sos_types", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "CbcInterface::hot_start", "bool", () => r.boolean());
  --r.depth;
}
function layout_CentralDiff_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FiniteDiff::serialize_body");
  layout_FiniteDiff_serialize_body(r, record, scope);
  --r.depth;
}
function layout_ClarabelInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "ClarabelInterface", 1);
  r.field(record, "ClarabelInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_ClpInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "ClpInterface", 1);
  r.field(record, "ClpInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_Collocation_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("ImplicitFixedStepIntegrator::serialize_body");
  layout_ImplicitFixedStepIntegrator_serialize_body(r, record, scope);
  r.version(record, "Collocation", 2);
  r.field(record, "Collocation::deg", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Collocation::collocation_scheme", "std::string", () => r.string());
  --r.depth;
}
function layout_Concat_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Conic_serialize(r, record, scope) {
  r.enterLayout();
  r.field(record, "Conic::SDPToSOCPMem::r", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Conic::SDPToSOCPMem::AT", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Conic::SDPToSOCPMem::A_mapping", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Conic::SDPToSOCPMem::map_Q", "IM", () => read_IM(r));
  r.field(record, "Conic::SDPToSOCPMem::map_P", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Conic::SDPToSOCPMem::indval_size", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_Conic_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "Conic", 4);
  r.field(record, "Conic::discrete", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "Conic::equality", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "Conic::print_problem", "bool", () => r.boolean());
  r.field(record, "Conic::solver_version_check", "bool", () => r.boolean());
  r.field(record, "Conic::H", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Conic::A", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Conic::Q", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Conic::P", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Conic::nx", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Conic::na", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Conic::np", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_ConoptInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "ConoptInterface", 1);
  r.field(record, "ConoptInterface::exact_hessian", "bool", () => r.boolean());
  r.field(record, "ConoptInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "ConoptInterface::gradf_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "ConoptInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "ConoptInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "ConoptInterface::optfile", "std::string", () => r.string());
  r.field(record, "ConoptInterface::warm_start", "bool", () => r.boolean());
  r.field(record, "ConoptInterface::debug", "bool", () => r.boolean());
  --r.depth;
}
function layout_ConstantDM_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "ConstantMX::nonzeros", "std::vector<double>", () => read_std_vector_double(r));
  --r.depth;
}
function layout_ConstantFile_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "ConstantFile::fname", "std::string", () => r.string());
  r.field(record, "ConstantFile::x", "std::vector<double>", () => read_std_vector_double(r));
  --r.depth;
}
function layout_ConstantPool_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "ConstantPool::name", "std::string", () => r.string());
  r.field(record, "ConstantPool::x", "std::vector<double>", () => read_std_vector_double(r));
  --r.depth;
}
function layout_Convexify_serialize(r, record, scope) {
  r.enterLayout();
  r.version(record, String(scope["prefix"]) + String("Convexify"), 1);
  r.field(record, String(scope["prefix"]) + String("Convexify::type_in"), "int", () => r.number("int"));
  r.field(record, String(scope["prefix"]) + String("Convexify::strategy"), "int", () => r.number("int"));
  r.field(record, String(scope["prefix"]) + String("Convexify::margin"), "double", () => r.number("double"));
  r.field(record, String(scope["prefix"]) + String("Convexify::max_iter_eig"), "casadi_int", () => r.number("casadi_int"));
  r.field(record, String(scope["prefix"]) + String("Convexify::scc_offset"), "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, String(scope["prefix"]) + String("Convexify::scc_mapping"), "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, String(scope["prefix"]) + String("Convexify::Hsp_project"), "int", () => r.number("int"));
  r.field(record, String(scope["prefix"]) + String("Convexify::scc_transform"), "int", () => r.number("int"));
  r.field(record, String(scope["prefix"]) + String("Convexify::verbose"), "int", () => r.number("int"));
  r.field(record, String(scope["prefix"]) + String("Convexify::Hsp"), "Sparsity", () => read_Sparsity(r));
  r.field(record, String(scope["prefix"]) + String("Convexify::Hrsp"), "Sparsity", () => read_Sparsity(r));
  --r.depth;
}
function layout_Convexify_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  record.layouts.push("Convexify::serialize");
  scope["prefix"] = "";
  layout_Convexify_serialize(r, record, scope);
  --r.depth;
}
function layout_CplexInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "CplexInterface", 1);
  r.field(record, "CplexInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "CplexInterface::qp_method", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "CplexInterface::dump_to_file", "bool", () => r.boolean());
  r.field(record, "CplexInterface::tol", "double", () => r.number("double"));
  r.field(record, "CplexInterface::dep_check", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "CplexInterface::warm_start", "bool", () => r.boolean());
  r.field(record, "CplexInterface::mip_start", "bool", () => r.boolean());
  r.field(record, "CplexInterface::mip", "bool", () => r.boolean());
  r.field(record, "CplexInterface::ctype", "std::vector<char>", () => read_std_vector_char(r));
  r.field(record, "CplexInterface::sos_weights", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "CplexInterface::sos_beg", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "CplexInterface::sos_ind", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "CplexInterface::sos_types", "std::vector<char>", () => read_std_vector_char(r));
  record.layouts.push("Conic::serialize");
  layout_Conic_serialize(r, record, scope);
  --r.depth;
}
function layout_CsparseInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  --r.depth;
}
function layout_CvodesInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("SundialsInterface::serialize_body");
  layout_SundialsInterface_serialize_body(r, record, scope);
  r.version(record, "CvodesInterface", 3);
  r.field(record, "CvodesInterface::lmm", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "CvodesInterface::iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "CvodesInterface::min_step_size", "double", () => r.number("double"));
  r.field(record, "CvodesInterface::always_recalculate_jacobian", "bool", () => r.boolean());
  --r.depth;
}
function layout_DaqpInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "DaqpInterface", 1);
  r.field(record, "DaqpInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_DenseKron_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Kron::serialize_body");
  layout_Kron_serialize_body(r, record, scope);
  --r.depth;
}
function layout_DenseKronContract_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("KronContract::serialize_body");
  layout_KronContract_serialize_body(r, record, scope);
  --r.depth;
}
function layout_DenseMultiplication_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Multiplication::serialize_body");
  layout_Multiplication_serialize_body(r, record, scope);
  --r.depth;
}
function layout_DenseSparseKron_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Kron::serialize_body");
  layout_Kron_serialize_body(r, record, scope);
  --r.depth;
}
function layout_DenseSparseKronContract_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("KronContract::serialize_body");
  layout_KronContract_serialize_body(r, record, scope);
  --r.depth;
}
function layout_DenseSparseMultiplication_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Multiplication::serialize_body");
  layout_Multiplication_serialize_body(r, record, scope);
  --r.depth;
}
function layout_DenseTranspose_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Transpose::serialize_body");
  layout_Transpose_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Densify_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Project::serialize_body");
  layout_Project_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Determinant_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "Determinant::linsol", "Linsol", () => read_Linsol(r));
  --r.depth;
}
function layout_Diagcat_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Concat::serialize_body");
  layout_Concat_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Diagsplit_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Split::serialize_body");
  layout_Split_serialize_body(r, record, scope);
  --r.depth;
}
function layout_DirResource_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("ResourceInternal::serialize_body");
  layout_ResourceInternal_serialize_body(r, record, scope);
  r.version(record, "DirResource", 1);
  if (scope["ResourceInternal::serialize_mode"] === "embed") {
    r.field(record, "ZipMemResource::blob", "std::stringstream", () => r.stream());
  } else {
    r.field(record, "DirResource::path", "std::string", () => r.string());
  }
  --r.depth;
}
function layout_Dot_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Dump_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.version(record, "Dump", 1);
  r.field(record, "Dump::base_filename", "std::string", () => r.string());
  r.field(record, "Dump::dir", "std::string", () => r.string());
  r.field(record, "Dump::format", "std::string", () => r.string());
  r.field(record, "Dump::verbose", "bool", () => r.boolean());
  --r.depth;
}
function layout_Einstein_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "Einstein::dim_c", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::dim_a", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::dim_b", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::c", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::a", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::b", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::iter_dims", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::strides_a", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::strides_b", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::strides_c", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Einstein::n_iter", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_External_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "External", 2);
  r.field(record, "External::int_data", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "External::real_data", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "External::string_data", "std::string", () => r.string());
  r.field(record, "External::li", "Importer", () => read_Importer(r));
  r.field(record, "External::config_args", "std::vector<std::string>", () => read_std_vector_std_string(r));
  --r.depth;
}
function layout_FastNewton_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Rootfinder::serialize_body");
  layout_Rootfinder_serialize_body(r, record, scope);
  r.version(record, "Newton", 1);
  r.field(record, "Newton::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Newton::abstol", "double", () => r.number("double"));
  r.field(record, "Newton::abstolStep", "double", () => r.number("double"));
  r.field(record, "Newton::jac_g_x", "Function", () => read_Function(r));
  r.field(record, "Newton::sp_v", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Newton::sp_r", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Newton::prinv", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Newton::pc", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function layout_FatropConicInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "FatropConicInterface", 1);
  --r.depth;
}
function layout_FatropInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "FatropInterface", 1);
  r.field(record, "FatropInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FatropInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FatropInterface::exact_hessian", "bool", () => r.boolean());
  r.field(record, "FatropInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "FatropInterface::convexify", "bool", () => r.boolean());
  r.field(record, "FatropInterface::Isp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FatropInterface::ABsp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FatropInterface::CDsp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FatropInterface::RSQsp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FatropInterface::AB_blocks", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::CD_blocks", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::RSQ_blocks", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::I_blocks", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::nxs", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::nus", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::ngs", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::N", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FatropInterface::structure_detection", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FatropInterface::AB_offsets", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::CD_offsets", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::RSQ_offsets", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::I_offsets", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FatropInterface::debug", "bool", () => r.boolean());
  --r.depth;
}
function layout_Feasiblesqpmethod_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "Feasiblesqpmethod", 3);
  r.field(record, "Feasiblesqpmethod::qpsol", "Function", () => read_Function(r));
  r.field(record, "Feasiblesqpmethod::exact_hessian", "bool", () => r.boolean());
  r.field(record, "Feasiblesqpmethod::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Feasiblesqpmethod::min_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Feasiblesqpmethod::lbfgs_memory", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Feasiblesqpmethod::tol_pr_", "double", () => r.number("double"));
  r.field(record, "Feasiblesqpmethod::tol_du_", "double", () => r.number("double"));
  r.field(record, "Feasiblesqpmethod::print_header", "bool", () => r.boolean());
  r.field(record, "Feasiblesqpmethod::print_iteration", "bool", () => r.boolean());
  r.field(record, "Feasiblesqpmethod::print_status", "bool", () => r.boolean());
  r.field(record, "Feasiblesqpmethod::init_feasible", "bool", () => r.boolean());
  r.field(record, "Feasiblesqpmethod::Hsp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Feasiblesqpmethod::Asp", "Sparsity", () => read_Sparsity(r));
  scope["Feasiblesqpmethod::convexify"] = r.field(record, "Feasiblesqpmethod::convexify", "bool", () => r.boolean());
  if (scope["Feasiblesqpmethod::convexify"]) {
    record.layouts.push("Convexify::serialize");
    scope["prefix"] = "Feasiblesqpmethod::";
    layout_Convexify_serialize(r, record, scope);
  }
  --r.depth;
}
function layout_Find_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_FiniteDiff_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "FiniteDiff", 1);
  r.field(record, "FiniteDiff::n", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FiniteDiff::h_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FiniteDiff::h", "double", () => r.number("double"));
  r.field(record, "FiniteDiff::n_z", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FiniteDiff::n_y", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FiniteDiff::u_aim", "double", () => r.number("double"));
  r.field(record, "FiniteDiff::h_min", "double", () => r.number("double"));
  r.field(record, "FiniteDiff::h_max", "double", () => r.number("double"));
  r.field(record, "FiniteDiff::reltol", "double", () => r.number("double"));
  r.field(record, "FiniteDiff::abstol", "double", () => r.number("double"));
  r.field(record, "FiniteDiff::smoothing", "double", () => r.number("double"));
  --r.depth;
}
function layout_FixedStepIntegrator_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Integrator::serialize_body");
  layout_Integrator_serialize_body(r, record, scope);
  r.version(record, "FixedStepIntegrator", 3);
  r.field(record, "FixedStepIntegrator::nk_target", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FixedStepIntegrator::disc", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FixedStepIntegrator::nv", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FixedStepIntegrator::nv1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FixedStepIntegrator::nrv", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FixedStepIntegrator::nrv1", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_Fmu2_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FmuInternal::serialize_body");
  layout_FmuInternal_serialize_body(r, record, scope);
  r.version(record, "Fmu2", 2);
  r.field(record, "Fmu2::vr_real", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu2::vr_integer", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu2::vr_boolean", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu2::vr_string", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu2::init_real", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "Fmu2::init_integer", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "Fmu2::init_boolean", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "Fmu2::init_string", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu2::vn_aux_real", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu2::vn_aux_integer", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu2::vn_aux_boolean", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu2::vn_aux_string", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu2::vr_aux_real", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu2::vr_aux_integer", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu2::vr_aux_boolean", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu2::vr_aux_string", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  --r.depth;
}
function layout_Fmu3_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FmuInternal::serialize_body");
  layout_FmuInternal_serialize_body(r, record, scope);
  r.version(record, "Fmu3", 1);
  r.field(record, "Fmu3::vr_real", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu3::vr_integer", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu3::vr_boolean", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu3::vr_string", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu3::init_real", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "Fmu3::init_integer", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "Fmu3::init_boolean", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "Fmu3::init_string", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu3::vn_aux_real", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu3::vn_aux_integer", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu3::vn_aux_boolean", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu3::vn_aux_string", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Fmu3::vr_aux_real", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu3::vr_aux_integer", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu3::vr_aux_boolean", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "Fmu3::vr_aux_string", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  --r.depth;
}
function layout_FmuFunction_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "FmuFunction", 6);
  r.field(record, "FmuFunction::Fmu", "Fmu", () => read_Fmu(r));
  const count_1 = r.count(scope["FunctionInternal::sp_in"].length);
  for (let i_2 = 0; i_2 < count_1; ++i_2) {
    r.field(record, "FmuFunction::in::type", "int", () => r.number("int"));
    r.field(record, "FmuFunction::in::ind", "size_t", () => r.number("size_t"));
  }
  const count_3 = r.count(scope["FunctionInternal::sp_out"].length);
  for (let i_4 = 0; i_4 < count_3; ++i_4) {
    r.field(record, "FmuFunction::out::type", "int", () => r.number("int"));
    r.field(record, "FmuFunction::out::ind", "size_t", () => r.number("size_t"));
    r.field(record, "FmuFunction::out::wrt", "size_t", () => r.number("size_t"));
    r.field(record, "FmuFunction::out::rbegin", "size_t", () => r.number("size_t"));
    r.field(record, "FmuFunction::out::rend", "size_t", () => r.number("size_t"));
    r.field(record, "FmuFunction::out::cbegin", "size_t", () => r.number("size_t"));
    r.field(record, "FmuFunction::out::cend", "size_t", () => r.number("size_t"));
  }
  r.field(record, "FmuFunction::jac_in", "std::vector<size_t>", () => read_std_vector_size_t(r));
  r.field(record, "FmuFunction::jac_out", "std::vector<size_t>", () => read_std_vector_size_t(r));
  r.field(record, "FmuFunction::jac_nom_in", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "FmuFunction::sp_trans", "std::vector<Sparsity>", () => read_std_vector_Sparsity(r));
  r.field(record, "FmuFunction::sp_trans_map", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FmuFunction::has_jac", "bool", () => r.boolean());
  r.field(record, "FmuFunction::has_fwd", "bool", () => r.boolean());
  r.field(record, "FmuFunction::has_adj", "bool", () => r.boolean());
  r.field(record, "FmuFunction::has_hess", "bool", () => r.boolean());
  r.field(record, "FmuFunction::uses_directional_derivatives", "bool", () => r.boolean());
  r.field(record, "FmuFunction::uses_adjoint_derivatives", "bool", () => r.boolean());
  r.field(record, "FmuFunction::nfwd", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FmuFunction::nadj", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FmuFunction::validate_forward", "bool", () => r.boolean());
  r.field(record, "FmuFunction::validate_hessian", "bool", () => r.boolean());
  r.field(record, "FmuFunction::make_symmetric", "bool", () => r.boolean());
  r.field(record, "FmuFunction::step", "double", () => r.number("double"));
  r.field(record, "FmuFunction::fd_flip", "bool", () => r.boolean());
  r.field(record, "FmuFunction::abstol", "double", () => r.number("double"));
  r.field(record, "FmuFunction::reltol", "double", () => r.number("double"));
  r.field(record, "FmuFunction::print_progress", "bool", () => r.boolean());
  r.field(record, "FmuFunction::new_jacobian", "bool", () => r.boolean());
  r.field(record, "FmuFunction::new_forward", "bool", () => r.boolean());
  r.field(record, "FmuFunction::new_hessian", "bool", () => r.boolean());
  r.field(record, "FmuFunction::hessian_coloring", "bool", () => r.boolean());
  r.field(record, "FmuFunction::asymmetric_hessian_coloring", "bool", () => r.boolean());
  r.field(record, "FmuFunction::enable_forward_jacobian", "bool", () => r.boolean());
  r.field(record, "FmuFunction::enable_adjoint_jacobian", "bool", () => r.boolean());
  r.field(record, "FmuFunction::enable_adjoint_hessian", "bool", () => r.boolean());
  r.field(record, "FmuFunction::validate_ad_file", "std::string", () => r.string());
  r.field(record, "FmuFunction::fd", "int", () => r.number("int"));
  r.field(record, "FmuFunction::parallelization", "int", () => r.number("int"));
  r.field(record, "FmuFunction::init_stats", "Dict", () => read_Dict(r));
  r.field(record, "FmuFunction::jac_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuFunction::hess_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuFunction::adj_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuFunction::jac_colors", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuFunction::adj_colors", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuFunction::hess_colors", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuFunction::hess_uni_colors", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuFunction::which_hess_color", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FmuFunction::nonlin", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "FmuFunction::max_jac_tasks", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FmuFunction::max_hess_tasks", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FmuFunction::max_n_tasks", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_FmuInternal_serialize_body(r, record, scope) {
  r.enterLayout();
  r.version(record, "FmuInternal", 4);
  r.field(record, "FmuInternal::name", "std::string", () => r.string());
  r.field(record, "FmuInternal::scheme_in", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "FmuInternal::scheme_out", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "FmuInternal::scheme", "std::map<std::string,std::vector<size_t>>", () => read_std_map_std_string_std_vector_size_t(r));
  r.field(record, "FmuInternal::aux", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "FmuInternal::iind", "std::vector<size_t>", () => read_std_vector_size_t(r));
  r.field(record, "FmuInternal::iind_map", "std::vector<size_t>", () => read_std_vector_size_t(r));
  r.field(record, "FmuInternal::oind", "std::vector<size_t>", () => read_std_vector_size_t(r));
  r.field(record, "FmuInternal::oind_map", "std::vector<size_t>", () => read_std_vector_size_t(r));
  r.field(record, "FmuInternal::has_independent", "bool", () => r.boolean());
  r.field(record, "FmuInternal::nominal_in", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "FmuInternal::nominal_out", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "FmuInternal::min_in", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "FmuInternal::min_out", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "FmuInternal::max_in", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "FmuInternal::max_out", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "FmuInternal::vn_in", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "FmuInternal::vn_out", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "FmuInternal::vr_in", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "FmuInternal::vr_out", "std::vector<unsignedint>", () => read_std_vector_unsignedint(r));
  r.field(record, "FmuInternal::value_in", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "FmuInternal::ired", "std::vector<std::vector<size_t>>", () => read_std_vector_std_vector_size_t(r));
  r.field(record, "FmuInternal::ored", "std::vector<std::vector<size_t>>", () => read_std_vector_std_vector_size_t(r));
  r.field(record, "FmuInternal::jac_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuInternal::hess_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "FmuInternal::resource", "Resource", () => read_Resource(r));
  r.field(record, "FmuInternal::fmutol", "double", () => r.number("double"));
  r.field(record, "FmuInternal::instance_name", "std::string", () => r.string());
  r.field(record, "FmuInternal::instantiation_token", "std::string", () => r.string());
  r.field(record, "FmuInternal::logging_on", "bool", () => r.boolean());
  r.field(record, "FmuInternal::number_of_event_indicators", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FmuInternal::provides_directional_derivatives", "bool", () => r.boolean());
  r.field(record, "FmuInternal::provides_adjoint_derivatives", "bool", () => r.boolean());
  r.field(record, "FmuInternal::can_be_instantiated_only_once_per_process", "bool", () => r.boolean());
  r.field(record, "FmuInternal::start_time", "double", () => r.number("double"));
  r.field(record, "FmuInternal::nx", "size_t", () => r.number("size_t"));
  r.field(record, "FmuInternal::do_evaluation_dance", "bool", () => r.boolean());
  --r.depth;
}
function layout_ForwardDiff_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FiniteDiff::serialize_body");
  layout_FiniteDiff_serialize_body(r, record, scope);
  --r.depth;
}
function layout_FunctionInternal_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("ProtoFunction::serialize_body");
  layout_ProtoFunction_serialize_body(r, record, scope);
  r.version(record, "FunctionInternal", 8);
  r.field(record, "FunctionInternal::is_diff_in", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "FunctionInternal::is_diff_out", "std::vector<bool>", () => read_std_vector_bool(r));
  scope["FunctionInternal::sp_in"] = r.field(record, "FunctionInternal::sp_in", "std::vector<Sparsity>", () => read_std_vector_Sparsity(r));
  scope["FunctionInternal::sp_out"] = r.field(record, "FunctionInternal::sp_out", "std::vector<Sparsity>", () => read_std_vector_Sparsity(r));
  r.field(record, "FunctionInternal::name_in", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "FunctionInternal::name_out", "std::vector<std::string>", () => read_std_vector_std_string(r));
  scope["FunctionInternal::jit"] = r.field(record, "FunctionInternal::jit", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::jit_cleanup", "bool", () => r.boolean());
  scope["FunctionInternal::jit_serialize"] = r.field(record, "FunctionInternal::jit_serialize", "std::string", () => r.string());
  if (scope["FunctionInternal::jit_serialize"] === "link" || scope["FunctionInternal::jit_serialize"] === "embed") {
    r.field(record, "FunctionInternal::jit_library", "std::string", () => r.string());
    if (scope["FunctionInternal::jit_serialize"] === "embed") {
      r.field(record, "FunctionInternal::jit_binary", "std::stringstream", () => r.stream());
    }
  }
  r.field(record, "FunctionInternal::jit_temp_suffix", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::jit_base_name", "std::string", () => r.string());
  r.field(record, "FunctionInternal::jit_options", "Dict", () => read_Dict(r));
  r.field(record, "FunctionInternal::compiler_plugin", "std::string", () => r.string());
  r.field(record, "FunctionInternal::has_refcount", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::cache_init", "Dict", () => read_Dict(r));
  r.field(record, "FunctionInternal::derivative_of", "Function", () => read_Function(r));
  r.field(record, "FunctionInternal::jac_penalty", "double", () => r.number("double"));
  r.field(record, "FunctionInternal::enable_forward", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::enable_reverse", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::enable_jacobian", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::enable_fd", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::enable_forward_op", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::enable_reverse_op", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::enable_jacobian_op", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::enable_fd_op", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::ad_weight", "double", () => r.number("double"));
  r.field(record, "FunctionInternal::ad_weight_sp", "double", () => r.number("double"));
  r.field(record, "FunctionInternal::always_inline", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::never_inline", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::max_num_dir", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FunctionInternal::inputs_check", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::fd_step", "double", () => r.number("double"));
  r.field(record, "FunctionInternal::fd_method", "std::string", () => r.string());
  r.field(record, "FunctionInternal::print_in", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::print_out", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::print_canonical", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::max_io", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "FunctionInternal::dump_in", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::dump_out", "bool", () => r.boolean());
  r.field(record, "FunctionInternal::dump_dir", "std::string", () => r.string());
  r.field(record, "FunctionInternal::dump_format", "std::string", () => r.string());
  r.field(record, "FunctionInternal::forward_options", "Dict", () => read_Dict(r));
  r.field(record, "FunctionInternal::reverse_options", "Dict", () => read_Dict(r));
  r.field(record, "FunctionInternal::jacobian_options", "Dict", () => read_Dict(r));
  r.field(record, "FunctionInternal::der_options", "Dict", () => read_Dict(r));
  r.field(record, "FunctionInternal::custom_jacobian", "Function", () => read_Function(r));
  r.field(record, "FunctionInternal::registered_functions", "std::vector<Function>", () => read_std_vector_Function(r));
  r.field(record, "FunctionInternal::sz_arg_per", "size_t", () => r.number("size_t"));
  r.field(record, "FunctionInternal::sz_res_per", "size_t", () => r.number("size_t"));
  r.field(record, "FunctionInternal::sz_iw_per", "size_t", () => r.number("size_t"));
  r.field(record, "FunctionInternal::sz_w_per", "size_t", () => r.number("size_t"));
  r.field(record, "FunctionInternal::sz_arg_tmp", "size_t", () => r.number("size_t"));
  r.field(record, "FunctionInternal::sz_res_tmp", "size_t", () => r.number("size_t"));
  r.field(record, "FunctionInternal::sz_iw_tmp", "size_t", () => r.number("size_t"));
  r.field(record, "FunctionInternal::sz_w_tmp", "size_t", () => r.number("size_t"));
  --r.depth;
}
function layout_GetNonzeros_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_GetNonzerosParam_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_GetNonzerosParamParam_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("GetNonzerosParam::serialize_body");
  layout_GetNonzerosParam_serialize_body(r, record, scope);
  --r.depth;
}
function layout_GetNonzerosParamSlice_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("GetNonzerosParam::serialize_body");
  layout_GetNonzerosParam_serialize_body(r, record, scope);
  r.field(record, "GetNonzerosParamSlice::outer", "Slice", () => read_Slice(r));
  --r.depth;
}
function layout_GetNonzerosParamVector_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("GetNonzerosParam::serialize_body");
  layout_GetNonzerosParam_serialize_body(r, record, scope);
  --r.depth;
}
function layout_GetNonzerosSlice2_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("GetNonzeros::serialize_body");
  layout_GetNonzeros_serialize_body(r, record, scope);
  r.field(record, "GetNonzerosSlice2::inner", "Slice", () => read_Slice(r));
  r.field(record, "GetNonzerosSlice2::outer", "Slice", () => read_Slice(r));
  --r.depth;
}
function layout_GetNonzerosSlice_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("GetNonzeros::serialize_body");
  layout_GetNonzeros_serialize_body(r, record, scope);
  r.field(record, "GetNonzerosSlice::slice", "Slice", () => read_Slice(r));
  --r.depth;
}
function layout_GetNonzerosSliceParam_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("GetNonzerosParam::serialize_body");
  layout_GetNonzerosParam_serialize_body(r, record, scope);
  r.field(record, "GetNonzerosSliceParam::inner", "Slice", () => read_Slice(r));
  --r.depth;
}
function layout_GetNonzerosVector_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("GetNonzeros::serialize_body");
  layout_GetNonzeros_serialize_body(r, record, scope);
  r.field(record, "GetNonzerosVector::nonzeros", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function layout_GurobiInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "GurobiInterface", 2);
  r.field(record, "GurobiInterface::lazy_constraints_callback", "Function", () => read_Function(r));
  r.field(record, "GurobiInterface::vtype", "std::vector<char>", () => read_std_vector_char(r));
  r.field(record, "GurobiInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "GurobiInterface::sos_weights", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "GurobiInterface::sos_beg", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "GurobiInterface::sos_ind", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "GurobiInterface::sos_types", "std::vector<int>", () => read_std_vector_int(r));
  record.layouts.push("Conic::serialize");
  layout_Conic_serialize(r, record, scope);
  --r.depth;
}
function layout_HighsInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "HighsInterface", 1);
  r.field(record, "HighsInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_HorzRepmat_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "HorzRepmat::n", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_HorzRepsum_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "HorzRepsum::n", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_Horzcat_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Concat::serialize_body");
  layout_Concat_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Horzsplit_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Split::serialize_body");
  layout_Split_serialize_body(r, record, scope);
  --r.depth;
}
function layout_HpipmInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "HpipmInterface", 1);
  --r.depth;
}
function layout_HpmpcInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  --r.depth;
}
function layout_IOInstruction_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "IOInstruction::ind", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "IOInstruction::segment", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "IOInstruction::offset", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_IdasInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("SundialsInterface::serialize_body");
  layout_SundialsInterface_serialize_body(r, record, scope);
  r.version(record, "IdasInterface", 2);
  r.field(record, "IdasInterface::cj_scaling", "bool", () => r.boolean());
  r.field(record, "IdasInterface::calc_ic", "bool", () => r.boolean());
  r.field(record, "IdasInterface::calc_icB", "bool", () => r.boolean());
  r.field(record, "IdasInterface::suppress_algebraic", "bool", () => r.boolean());
  r.field(record, "IdasInterface::abstolv", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "IdasInterface::first_time", "double", () => r.number("double"));
  r.field(record, "IdasInterface::init_xdot", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "IdasInterface::max_step_size", "double", () => r.number("double"));
  r.field(record, "IdasInterface::y_c", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function layout_ImplicitFixedStepIntegrator_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FixedStepIntegrator::serialize_body");
  layout_FixedStepIntegrator_serialize_body(r, record, scope);
  r.version(record, "ImplicitFixedStepIntegrator", 2);
  --r.depth;
}
function layout_ImplicitToNlp_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Rootfinder::serialize_body");
  layout_Rootfinder_serialize_body(r, record, scope);
  --r.depth;
}
function layout_ImporterInternal_serialize_body(r, record, scope) {
  r.enterLayout();
  r.version(record, "ImporterInternal", 1);
  r.field(record, "ImporterInternal::name", "std::string", () => r.string());
  r.field(record, "ImporterInternal::meta", "std::map<std::string,std::pair<casadi_int,std::string>>", () => read_std_map_std_string_std_pair_casadi_int_std_string(r));
  r.field(record, "ImporterInternal::external", "std::map<std::string,std::pair<bool,std::string>>", () => read_std_map_std_string_std_pair_bool_std_string(r));
  --r.depth;
}
function layout_Input_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("IOInstruction::serialize_body");
  layout_IOInstruction_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Integrator_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("OracleFunction::serialize_body");
  layout_OracleFunction_serialize_body(r, record, scope);
  r.version(record, "Integrator", 3);
  r.field(record, "Integrator::sp_jac_dae", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Integrator::sp_jac_rdae", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Integrator::t0", "double", () => r.number("double"));
  r.field(record, "Integrator::tout", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "Integrator::nfwd", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nadj", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::rdae", "Function", () => read_Function(r));
  r.field(record, "Integrator::nx", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nz", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nq", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nx1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nz1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nq1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nrx", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nrz", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nrq", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nuq", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nrx1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nrz1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nrq1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nuq1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::np", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nrp", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::np1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nrp1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nu", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nu1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::ne", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::ntmp", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::nom_x", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "Integrator::nom_z", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "Integrator::augmented_options", "Dict", () => read_Dict(r));
  r.field(record, "Integrator::opts", "Dict", () => read_Dict(r));
  r.field(record, "Integrator::print_stats", "bool", () => r.boolean());
  r.field(record, "Integrator::transition", "Function", () => read_Function(r));
  r.field(record, "Integrator::max_event_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::max_events", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Integrator::event_tol", "double", () => r.number("double"));
  r.field(record, "Integrator::event_acceptable_tol", "double", () => r.number("double"));
  --r.depth;
}
function layout_Interpolant_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "Interpolant", 2);
  r.field(record, "Interpolant::ndim", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Interpolant::m", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Interpolant::grid", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "Interpolant::offset", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Interpolant::values", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "Interpolant::lookup_modes", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "Interpolant::batch_x", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_Inverse_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_IpoptInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "IpoptInterface", 3);
  r.field(record, "IpoptInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "IpoptInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "IpoptInterface::exact_hessian", "bool", () => r.boolean());
  r.field(record, "IpoptInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "IpoptInterface::pass_nonlinear_variables", "bool", () => r.boolean());
  r.field(record, "IpoptInterface::nl_ex", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "IpoptInterface::var_string_md", "Dict", () => read_Dict(r));
  r.field(record, "IpoptInterface::var_integer_md", "Dict", () => read_Dict(r));
  r.field(record, "IpoptInterface::var_numeric_md", "Dict", () => read_Dict(r));
  r.field(record, "IpoptInterface::con_string_md", "Dict", () => read_Dict(r));
  r.field(record, "IpoptInterface::con_integer_md", "Dict", () => read_Dict(r));
  r.field(record, "IpoptInterface::con_numeric_md", "Dict", () => read_Dict(r));
  scope["IpoptInterface::convexify"] = r.field(record, "IpoptInterface::convexify", "bool", () => r.boolean());
  if (scope["IpoptInterface::convexify"]) {
    record.layouts.push("Convexify::serialize");
    scope["prefix"] = "IpoptInterface::";
    layout_Convexify_serialize(r, record, scope);
  }
  r.field(record, "IpoptInterface::clip_inactive_lam", "bool", () => r.boolean());
  r.field(record, "IpoptInterface::inactive_lam_strategy", "std::string", () => r.string());
  r.field(record, "IpoptInterface::inactive_lam_value", "double", () => r.number("double"));
  --r.depth;
}
function layout_Ipqp_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "Ipqp", 1);
  r.field(record, "Ipqp::kkt", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Ipqp::print_iter", "bool", () => r.boolean());
  r.field(record, "Ipqp::print_header", "bool", () => r.boolean());
  r.field(record, "Ipqp::print_info", "bool", () => r.boolean());
  r.field(record, "Ipqp::linear_solver", "std::string", () => r.string());
  r.field(record, "Ipqp::linear_solver_options", "Dict", () => read_Dict(r));
  r.field(record, "Ipqp::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Ipqp::pr_tol", "double", () => r.number("double"));
  r.field(record, "Ipqp::du_tol", "double", () => r.number("double"));
  r.field(record, "Ipqp::co_tol", "double", () => r.number("double"));
  r.field(record, "Ipqp::mu_tol", "double", () => r.number("double"));
  --r.depth;
}
function layout_KinsolInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Rootfinder::serialize_body");
  layout_Rootfinder_serialize_body(r, record, scope);
  --r.depth;
}
function layout_KnitroInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "KnitroInterface", 2);
  r.field(record, "KnitroInterface::contype", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "KnitroInterface::comp_type", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "KnitroInterface::comp_i1", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "KnitroInterface::comp_i2", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "KnitroInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "KnitroInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "KnitroInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "KnitroInterface::options_file", "std::string", () => r.string());
  --r.depth;
}
function layout_Kron_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_KronContract_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "KronContract::inner", "bool", () => r.boolean());
  --r.depth;
}
function layout_LapackLu_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  r.version(record, "LapackLu", 1);
  r.field(record, "LapackLu::equilibriate", "bool", () => r.boolean());
  r.field(record, "LapackLu::allow_equilibration_failure", "bool", () => r.boolean());
  --r.depth;
}
function layout_LapackQr_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  r.field(record, "LapackQr::max_nrhs", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_LinearInterpolant_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Interpolant::serialize_body");
  layout_Interpolant_serialize_body(r, record, scope);
  r.field(record, "LinearInterpolant::lookup_mode", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function layout_LinearInterpolantJac_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  --r.depth;
}
function layout_LinsolCall_Tr_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Solve<Tr>::serialize_body");
  layout_Solve_Tr_serialize_body(r, record, scope);
  r.field(record, "Solve::Linsol", "Linsol", () => read_Linsol(r));
  --r.depth;
}
function layout_LinsolInternal_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("ProtoFunction::serialize_body");
  layout_ProtoFunction_serialize_body(r, record, scope);
  r.field(record, "LinsolInternal::sp", "Sparsity", () => read_Sparsity(r));
  --r.depth;
}
function layout_LinsolLdl_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  r.version(record, "LinsolLdl", 1);
  r.field(record, "LinsolLdl::p", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "LinsolLdl::sp_Lt", "Sparsity", () => read_Sparsity(r));
  --r.depth;
}
function layout_LinsolQr_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  r.version(record, "LinsolQr", 2);
  r.field(record, "LinsolQr::prinv", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "LinsolQr::pc", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "LinsolQr::sp_v", "Sparsity", () => read_Sparsity(r));
  r.field(record, "LinsolQr::sp_r", "Sparsity", () => read_Sparsity(r));
  r.field(record, "LinsolQr::eps", "double", () => r.number("double"));
  r.field(record, "LinsolQr::n_cache", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_LinsolTridiag_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  --r.depth;
}
function layout_LogSumExp_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Low_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "Low::lookup_mode", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_Lsqr_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  --r.depth;
}
function layout_MMax_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_MMin_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_MXFunction_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("XFunction<MXFunction,MX,MXNode>::serialize_body");
  layout_XFunction_MXFunction_MX_MXNode_serialize_body(r, record, scope);
  r.version(record, "MXFunction", 3);
  scope["MXFunction::n_instr"] = r.field(record, "MXFunction::n_instr", "size_t", () => r.number("size_t"));
  const count_5 = r.count(scope["MXFunction::n_instr"]);
  for (let i_6 = 0; i_6 < count_5; ++i_6) {
    r.field(record, "MXFunction::alg::data", "MX", () => read_MX(r));
    r.field(record, "MXFunction::alg::arg", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
    r.field(record, "MXFunction::alg::res", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  }
  r.field(record, "MXFunction::workloc", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "MXFunction::free_vars", "std::vector<MX>", () => read_std_vector_MX(r));
  r.field(record, "MXFunction::default_in", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "MXFunction::live_variables", "bool", () => r.boolean());
  r.field(record, "MXFunction::print_instructions", "bool", () => r.boolean());
  r.field(record, "MXFunction::dump_trace", "bool", () => r.boolean());
  record.layouts.push("XFunction<MXFunction,MX,MXNode>::delayed_serialize_members");
  layout_XFunction_MXFunction_MX_MXNode_delayed_serialize_members(r, record, scope);
  --r.depth;
}
function layout_MXNode_serialize_body(r, record, scope) {
  r.enterLayout();
  r.field(record, "MXNode::deps", "std::vector<MX>", () => read_std_vector_MX(r));
  r.field(record, "MXNode::sp", "Sparsity", () => read_Sparsity(r));
  --r.depth;
}
function layout_Ma27Interface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  --r.depth;
}
function layout_MadmpecInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "MadmpecInterface", 1);
  r.field(record, "MadmpecInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "MadmpecInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "MadmpecInterface::exact_hessian", "bool", () => r.boolean());
  r.field(record, "MadmpecInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "MadmpecInterface::convexify", "bool", () => r.boolean());
  r.field(record, "MadmpecInterface::ind_cc1", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "MadmpecInterface::ind_cc2", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "MadmpecInterface::cctypes", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function layout_MadnlpInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "MadnlpInterface", 2);
  r.field(record, "MadnlpInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "MadnlpInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "MadnlpInterface::exact_hessian", "bool", () => r.boolean());
  r.field(record, "MadnlpInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "MadnlpInterface::convexify", "bool", () => r.boolean());
  --r.depth;
}
function layout_Map_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.field(record, "Map::f", "Function", () => read_Function(r));
  r.field(record, "Map::n", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_MapSum_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.field(record, "MapSum::f", "Function", () => read_Function(r));
  r.field(record, "MapSum::n", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "MapSum::reduce_in", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "MapSum::reduce_out", "std::vector<bool>", () => read_std_vector_bool(r));
  --r.depth;
}
function layout_Monitor_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "Monitor::comment", "std::string", () => r.string());
  --r.depth;
}
function layout_MosekInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "MosekInterface", 1);
  r.field(record, "MosekInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_MultipleOutput_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Multiplication_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "Multiplication::blas", "std::string", () => r.string());
  --r.depth;
}
function layout_MumpsInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  r.version(record, "Mumps", 1);
  r.field(record, "MumpsInterface::symmetric", "bool", () => r.boolean());
  r.field(record, "MumpsInterface::posdef", "bool", () => r.boolean());
  --r.depth;
}
function layout_Newton_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Rootfinder::serialize_body");
  layout_Rootfinder_serialize_body(r, record, scope);
  r.version(record, "Newton", 1);
  r.field(record, "Newton::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Newton::abstol", "double", () => r.number("double"));
  r.field(record, "Newton::abstolStep", "double", () => r.number("double"));
  r.field(record, "Newton::print_iteration", "bool", () => r.boolean());
  r.field(record, "Newton::line_search", "bool", () => r.boolean());
  --r.depth;
}
function layout_Nlpsol_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("OracleFunction::serialize_body");
  layout_OracleFunction_serialize_body(r, record, scope);
  r.version(record, "Nlpsol", 5);
  r.field(record, "Nlpsol::nx", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Nlpsol::ng", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Nlpsol::np", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Nlpsol::fcallback", "Function", () => read_Function(r));
  r.field(record, "Nlpsol::callback_step", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Nlpsol::eval_errors_fatal", "bool", () => r.boolean());
  r.field(record, "Nlpsol::warn_initial_bounds", "bool", () => r.boolean());
  r.field(record, "Nlpsol::iteration_callback_ignore_errors", "bool", () => r.boolean());
  r.field(record, "Nlpsol::calc_multipliers", "bool", () => r.boolean());
  r.field(record, "Nlpsol::calc_lam_x", "bool", () => r.boolean());
  r.field(record, "Nlpsol::calc_lam_p", "bool", () => r.boolean());
  r.field(record, "Nlpsol::calc_f", "bool", () => r.boolean());
  r.field(record, "Nlpsol::calc_g", "bool", () => r.boolean());
  r.field(record, "Nlpsol::min_lam", "double", () => r.number("double"));
  r.field(record, "Nlpsol::bound_consistency", "bool", () => r.boolean());
  r.field(record, "Nlpsol::no_nlp_grad", "bool", () => r.boolean());
  r.field(record, "Nlpsol::discrete", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "Nlpsol::equality", "std::vector<bool>", () => read_std_vector_bool(r));
  r.field(record, "Nlpsol::mi", "bool", () => r.boolean());
  r.field(record, "Nlpsol::sens_linsol", "std::string", () => r.string());
  r.field(record, "Nlpsol::sens_linsol_options", "Dict", () => read_Dict(r));
  r.field(record, "Nlpsol::detect_simple_bounds_is_simple", "std::vector<char>", () => read_std_vector_char(r));
  r.field(record, "Nlpsol::detect_simple_bounds_parts", "Function", () => read_Function(r));
  r.field(record, "Nlpsol::detect_simple_bounds_target_x", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function layout_Norm1_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Norm::serialize_body");
  layout_Norm_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Norm2_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Norm::serialize_body");
  layout_Norm_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Norm_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_NormF_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Norm::serialize_body");
  layout_Norm_serialize_body(r, record, scope);
  --r.depth;
}
function layout_NormInf_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Norm::serialize_body");
  layout_Norm_serialize_body(r, record, scope);
  --r.depth;
}
function layout_OmpMap_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Map::serialize_body");
  layout_Map_serialize_body(r, record, scope);
  --r.depth;
}
function layout_OnnxFunction_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "OnnxFunction", 2);
  r.field(record, "OnnxFunction::model_data", "std::string", () => r.string());
  record.layouts.push("pack_tensors");
  scope["d"] = "OnnxFunction::in";
  layout_pack_tensors(r, record, scope);
  record.layouts.push("pack_tensors");
  scope["d"] = "OnnxFunction::out";
  layout_pack_tensors(r, record, scope);
  record.layouts.push("pack_tensors");
  scope["d"] = "OnnxFunction::all_in";
  layout_pack_tensors(r, record, scope);
  r.field(record, "OnnxFunction::in_src", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "OnnxFunction::in_val", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "OnnxFunction::model_inputs", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "OnnxFunction::model_outputs", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "OnnxFunction::fwd_dim", "std::string", () => r.string());
  r.field(record, "OnnxFunction::adj_dim", "std::string", () => r.string());
  r.field(record, "OnnxFunction::input_values", "std::map<std::string,std::vector<double>>", () => read_std_map_std_string_std_vector_double(r));
  r.field(record, "OnnxFunction::model_path", "std::string", () => r.string());
  r.field(record, "OnnxFunction::dim_bindings", "std::map<std::string,casadi_int>", () => read_std_map_std_string_casadi_int(r));
  r.field(record, "OnnxFunction::input_shapes", "std::map<std::string,std::vector<casadi_int>>", () => read_std_map_std_string_std_vector_casadi_int(r));
  r.field(record, "OnnxFunction::derivative_opts", "Dict", () => read_Dict(r));
  r.field(record, "OnnxFunction::builder_opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_OnnxRuntimeInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("OnnxFunction::serialize_body");
  layout_OnnxFunction_serialize_body(r, record, scope);
  r.version(record, "OnnxRuntimeInterface", 1);
  r.field(record, "OnnxRuntimeInterface::provider", "std::string", () => r.string());
  --r.depth;
}
function layout_OoqpInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "OoqpInterface", 1);
  r.field(record, "OoqpInterface::spAT", "Sparsity", () => read_Sparsity(r));
  r.field(record, "OoqpInterface::nQ", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OoqpInterface::nH", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OoqpInterface::nA", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OoqpInterface::print_level", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OoqpInterface::mutol", "double", () => r.number("double"));
  r.field(record, "OoqpInterface::artol", "double", () => r.number("double"));
  --r.depth;
}
function layout_OracleFunction_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "OracleFunction", 3);
  r.field(record, "OracleFunction::oracle", "Function", () => read_Function(r));
  r.field(record, "OracleFunction::common_options", "Dict", () => read_Dict(r));
  r.field(record, "OracleFunction::specific_options", "Dict", () => read_Dict(r));
  r.field(record, "OracleFunction::show_eval_warnings", "bool", () => r.boolean());
  r.field(record, "OracleFunction::max_num_threads", "int", () => r.number("int"));
  scope["OracleFunction::all_functions::size"] = r.field(record, "OracleFunction::all_functions::size", "size_t", () => r.number("size_t"));
  const count_7 = r.count(scope["OracleFunction::all_functions::size"]);
  for (let i_8 = 0; i_8 < count_7; ++i_8) {
    r.field(record, "OracleFunction::all_functions::key", "std::string", () => r.string());
    scope["OracleFunction::all_functions::value::jit"] = r.field(record, "OracleFunction::all_functions::value::jit", "bool", () => r.boolean());
    if (scope["FunctionInternal::jit"] && scope["OracleFunction::all_functions::value::jit"]) {
      if (scope["FunctionInternal::jit_serialize"] === "source") {
        r.field(record, "OracleFunction::all_functions::value::f", "Function", () => read_Function(r));
      } else {
        r.field(record, "OracleFunction::all_functions::value::f_name", "std::string", () => r.string());
      }
    } else {
      r.field(record, "OracleFunction::all_functions::value::f", "Function", () => read_Function(r));
    }
    r.field(record, "OracleFunction::all_functions::value::monitored", "bool", () => r.boolean());
  }
  r.field(record, "OracleFunction::monitor", "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, "OracleFunction::stride_arg", "size_t", () => r.number("size_t"));
  r.field(record, "OracleFunction::stride_res", "size_t", () => r.number("size_t"));
  r.field(record, "OracleFunction::stride_iw", "size_t", () => r.number("size_t"));
  r.field(record, "OracleFunction::stride_w", "size_t", () => r.number("size_t"));
  --r.depth;
}
function layout_OsqpInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "OsqpInterface", 2);
  r.field(record, "OsqpInterface::nnzHupp", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::nnzA", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::warm_start_primal", "bool", () => r.boolean());
  r.field(record, "OsqpInterface::warm_start_dual", "bool", () => r.boolean());
  r.field(record, "OsqpInterface::settings::rho", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::sigma", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::scaling", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::adaptive_rho", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::adaptive_rho_interval", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::adaptive_rho_tolerance", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::eps_abs", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::eps_rel", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::eps_prim_inf", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::eps_dual_inf", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::alpha", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::delta", "double", () => r.number("double"));
  r.field(record, "OsqpInterface::settings::polish", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::polish_refine_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::verbose", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::scaled_termination", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::check_termination", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::settings::warm_start", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "OsqpInterface::rho_initial", "double", () => r.number("double"));
  --r.depth;
}
function layout_Output_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("IOInstruction::serialize_body");
  layout_IOInstruction_serialize_body(r, record, scope);
  --r.depth;
}
function layout_OutputNode_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "OutputNode::oind", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_OutputSX_serialize_node(r, record, scope) {
  r.enterLayout();
  r.field(record, "OutputSX::dep", "SXElem", () => read_SXElem(r));
  r.field(record, "OutputSX::oind", "int", () => r.number("int"));
  --r.depth;
}
function layout_PiqpInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "PiqpInterface", 1);
  r.field(record, "PiqpInterface::nnzH", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "PiqpInterface::nnzA", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "PiqpInterface::settings::rho_init", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::delta_init", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::eps_abs", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::eps_rel", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::check_duality_gap", "bool", () => r.boolean());
  r.field(record, "PiqpInterface::settings::eps_duality_gap_abs", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::eps_duality_gap_rel", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::reg_lower_limit", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::reg_finetune_lower_limit", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::reg_finetune_primal_update_threshold", "size_t", () => r.number("size_t"));
  r.field(record, "PiqpInterface::settings::reg_finetune_dual_update_threshold", "size_t", () => r.number("size_t"));
  r.field(record, "PiqpInterface::settings::max_iter", "size_t", () => r.number("size_t"));
  r.field(record, "PiqpInterface::settings::max_factor_retires", "size_t", () => r.number("size_t"));
  r.field(record, "PiqpInterface::settings::preconditioner_scale_cost", "bool", () => r.boolean());
  r.field(record, "PiqpInterface::settings::preconditioner_iter", "size_t", () => r.number("size_t"));
  r.field(record, "PiqpInterface::settings::tau", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::iterative_refinement_always_enabled", "bool", () => r.boolean());
  r.field(record, "PiqpInterface::settings::iterative_refinement_eps_abs", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::iterative_refinement_eps_rel", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::iterative_refinement_max_iter", "size_t", () => r.number("size_t"));
  r.field(record, "PiqpInterface::settings::iterative_refinement_min_improvement_rate", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::iterative_refinement_static_regularization_eps", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::iterative_refinement_static_regularization_rel", "double", () => r.number("double"));
  r.field(record, "PiqpInterface::settings::verbose", "bool", () => r.boolean());
  r.field(record, "PiqpInterface::settings::compute_timings", "bool", () => r.boolean());
  r.field(record, "PiqpInterface::settings::kkt_solver", "std::string", () => r.string());
  --r.depth;
}
function layout_Project_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_ProtoFunction_serialize_body(r, record, scope) {
  r.enterLayout();
  r.version(record, "ProtoFunction", 2);
  r.field(record, "ProtoFunction::name", "std::string", () => r.string());
  r.field(record, "ProtoFunction::verbose", "bool", () => r.boolean());
  r.field(record, "ProtoFunction::print_time", "bool", () => r.boolean());
  r.field(record, "ProtoFunction::record_time", "bool", () => r.boolean());
  r.field(record, "ProtoFunction::regularity_check", "bool", () => r.boolean());
  r.field(record, "ProtoFunction::error_on_fail", "bool", () => r.boolean());
  --r.depth;
}
function layout_ProxqpInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "ProxqpInterface", 1);
  r.field(record, "ProxqpInterface::warm_start_primal", "bool", () => r.boolean());
  r.field(record, "ProxqpInterface::warm_start_dual", "bool", () => r.boolean());
  r.field(record, "ProxqpInterface::settings::default_rho", "double", () => r.number("double"));
  r.field(record, "ProxqpInterface::settings::default_mu_eq", "double", () => r.number("double"));
  r.field(record, "ProxqpInterface::settings::default_mu_in", "double", () => r.number("double"));
  r.field(record, "ProxqpInterface::settings::eps_abs", "double", () => r.number("double"));
  r.field(record, "ProxqpInterface::settings::eps_rel", "double", () => r.number("double"));
  r.field(record, "ProxqpInterface::settings::max_iter", "double", () => r.number("double"));
  r.field(record, "ProxqpInterface::settings::verbose", "bool", () => r.boolean());
  r.field(record, "ProxqpInterface::settings::sparse_backend", "bool", () => r.boolean());
  --r.depth;
}
function layout_PseudoDenseMultiplication_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Multiplication::serialize_body");
  layout_Multiplication_serialize_body(r, record, scope);
  r.field(record, "PseudoDenseMultiplication::a", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "PseudoDenseMultiplication::b", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "PseudoDenseMultiplication::c", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_QpToNlp_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "QpToNlp", 1);
  r.field(record, "QpToNlp::solver", "Function", () => read_Function(r));
  --r.depth;
}
function layout_QpoasesInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "QpoasesInterface", 1);
  r.field(record, "QpoasesInterface::max_nWSR", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "QpoasesInterface::max_cputime", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::hess", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "QpoasesInterface::sparse", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::schur", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::max_schur", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "QpoasesInterface::linsol_plugin", "std::string", () => r.string());
  r.field(record, "QpoasesInterface::ops::printLevel", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "QpoasesInterface::ops::enableRamping", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::ops::enableFarBounds", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::ops::enableFlippingBounds", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::ops::enableRegularisation", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::ops::enableFullLITests", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::ops::enableNZCTests", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::ops::enableDriftCorrection", "int", () => r.number("int"));
  r.field(record, "QpoasesInterface::ops::enableCholeskyRefactorisation", "int", () => r.number("int"));
  r.field(record, "QpoasesInterface::ops::enableEqualities", "bool", () => r.boolean());
  r.field(record, "QpoasesInterface::ops::terminationTolerance", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::boundTolerance", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::boundRelaxation", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::epsNum", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::epsDen", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::maxPrimalJump", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::maxDualJump", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::initialRamping", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::finalRamping", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::initialFarBounds", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::growFarBounds", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::initialStatusBounds", "std::string", () => r.string());
  r.field(record, "QpoasesInterface::ops::epsFlipping", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::numRegularisationSteps", "int", () => r.number("int"));
  r.field(record, "QpoasesInterface::ops::epsRegularisation", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::numRefinementSteps", "int", () => r.number("int"));
  r.field(record, "QpoasesInterface::ops::epsIterRef", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::epsLITests", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::epsNZCTests", "double", () => r.number("double"));
  r.field(record, "QpoasesInterface::ops::enableInertiaCorrection", "bool", () => r.boolean());
  --r.depth;
}
function layout_Qrqp_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "Qrqp", 1);
  r.field(record, "Qrqp::AT", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Qrqp::kkt", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Qrqp::sp_v", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Qrqp::sp_r", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Qrqp::prinv", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Qrqp::pc", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Qrqp::print_iter", "bool", () => r.boolean());
  r.field(record, "Qrqp::print_header", "bool", () => r.boolean());
  r.field(record, "Qrqp::print_info", "bool", () => r.boolean());
  r.field(record, "Qrqp::print_lincomb_", "bool", () => r.boolean());
  r.field(record, "Qrqp::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Qrqp::min_lam", "double", () => r.number("double"));
  r.field(record, "Qrqp::constr_viol_tol", "double", () => r.number("double"));
  r.field(record, "Qrqp::dual_inf_tol", "double", () => r.number("double"));
  --r.depth;
}
function layout_Qrsqp_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Rank1_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Reshape_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_ResourceInternal_serialize_body(r, record, scope) {
  r.enterLayout();
  scope["ResourceInternal::serialize_mode"] = r.field(record, "ResourceInternal::serialize_mode", "std::string", () => r.string());
  --r.depth;
}
function layout_Rootfinder_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("OracleFunction::serialize_body");
  layout_OracleFunction_serialize_body(r, record, scope);
  r.version(record, "Rootfinder", 3);
  r.field(record, "Rootfinder::n", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Rootfinder::linsol", "Linsol", () => read_Linsol(r));
  r.field(record, "Rootfinder::sp_jac", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Rootfinder::u_c", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Rootfinder::iin", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Rootfinder::iout", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_RungeKutta_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FixedStepIntegrator::serialize_body");
  layout_FixedStepIntegrator_serialize_body(r, record, scope);
  r.version(record, "RungeKutta", 2);
  --r.depth;
}
function layout_SLEQPInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "SLEQPInterface", 1);
  r.field(record, "SLEQPInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "SLEQPInterface::max_iter", "int", () => r.number("int"));
  r.field(record, "SLEQPInterface::max_wall_time", "double", () => r.number("double"));
  r.field(record, "SLEQPInterface::print_level", "int", () => r.number("int"));
  r.field(record, "SLEQPInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_SXFunction_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("XFunction<SXFunction,SX,SXNode>::serialize_body");
  layout_XFunction_SXFunction_SX_SXNode_serialize_body(r, record, scope);
  r.version(record, "SXFunction", 4);
  scope["SXFunction::n_instr"] = r.field(record, "SXFunction::n_instr", "size_t", () => r.number("size_t"));
  r.field(record, "SXFunction::worksize", "size_t", () => r.number("size_t"));
  r.field(record, "SXFunction::free_vars", "std::vector<SXElem>", () => read_std_vector_SXElem(r));
  r.field(record, "SXFunction::operations", "std::vector<SXElem>", () => read_std_vector_SXElem(r));
  r.field(record, "SXFunction::constants", "std::vector<SXElem>", () => read_std_vector_SXElem(r));
  r.field(record, "SXFunction::default_in", "std::vector<double>", () => read_std_vector_double(r));
  r.field(record, "SXFunction::call_sz_arg", "size_t", () => r.number("size_t"));
  r.field(record, "SXFunction::call_sz_res", "size_t", () => r.number("size_t"));
  r.field(record, "SXFunction::call_sz_iw", "size_t", () => r.number("size_t"));
  r.field(record, "SXFunction::call_sz_w", "size_t", () => r.number("size_t"));
  r.field(record, "SXFunction::call_sz_arg", "size_t", () => r.number("size_t"));
  r.field(record, "SXFunction::call_sz_res", "size_t", () => r.number("size_t"));
  scope["SXFunction::call_el_size"] = r.field(record, "SXFunction::call_el_size", "size_t", () => r.number("size_t"));
  const count_9 = r.count(scope["SXFunction::call_el_size"]);
  for (let i_10 = 0; i_10 < count_9; ++i_10) {
    r.field(record, "SXFunction::call_el_f", "Function", () => read_Function(r));
    r.field(record, "SXFunction::call_el_dep", "std::vector<int>", () => read_std_vector_int(r));
    r.field(record, "SXFunction::call_el_res", "std::vector<int>", () => read_std_vector_int(r));
    r.field(record, "SXFunction::call_el_copy_elision_arg", "std::vector<int>", () => read_std_vector_int(r));
    r.field(record, "SXFunction::call_el_copy_elision_offset", "std::vector<int>", () => read_std_vector_int(r));
  }
  r.field(record, "SXFunction::copy_elision", "std::vector<bool>", () => read_std_vector_bool(r));
  const count_11 = r.count(scope["SXFunction::n_instr"]);
  for (let i_12 = 0; i_12 < count_11; ++i_12) {
    r.field(record, "SXFunction::ScalarAtomic::op", "int", () => r.number("int"));
    r.field(record, "SXFunction::ScalarAtomic::i0", "int", () => r.number("int"));
    r.field(record, "SXFunction::ScalarAtomic::i1", "int", () => r.number("int"));
    r.field(record, "SXFunction::ScalarAtomic::i2", "int", () => r.number("int"));
  }
  r.field(record, "SXFunction::live_variables", "bool", () => r.boolean());
  r.field(record, "SXFunction::print_instructions", "bool", () => r.boolean());
  r.field(record, "SXFunction::dump_trace", "bool", () => r.boolean());
  record.layouts.push("XFunction<SXFunction,SX,SXNode>::delayed_serialize_members");
  layout_XFunction_SXFunction_SX_SXNode_delayed_serialize_members(r, record, scope);
  --r.depth;
}
function layout_Scpgen_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  --r.depth;
}
function layout_SetNonzerosParam_Add_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("SetNonzerosParam<Add>::serialize_body");
  layout_SetNonzerosParam_Add_serialize_body(r, record, scope);
  --r.depth;
}
function layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "SetNonzerosParamSlice::outer", "Slice", () => read_Slice(r));
  --r.depth;
}
function layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "SetNonzerosSlice2::inner", "Slice", () => read_Slice(r));
  r.field(record, "SetNonzerosSlice2::outer", "Slice", () => read_Slice(r));
  --r.depth;
}
function layout_SetNonzerosSlice_Add_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "SetNonzerosSlice::slice", "Slice", () => read_Slice(r));
  --r.depth;
}
function layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "SetNonzerosSliceParam::inner", "Slice", () => read_Slice(r));
  --r.depth;
}
function layout_SetNonzerosVector_Add_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "SetNonzerosVector::nonzeros", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function layout_Slice_serialize(r, record, scope) {
  r.enterLayout();
  r.field(record, "Slice::start", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Slice::stop", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Slice::step", "casadi_int", () => r.number("casadi_int"));
  --r.depth;
}
function layout_Smoothing_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FiniteDiff::serialize_body");
  layout_FiniteDiff_serialize_body(r, record, scope);
  --r.depth;
}
function layout_SnoptInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "SnoptInterface", 1);
  r.field(record, "SnoptInterface::jacf_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "SnoptInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "SnoptInterface::nnJac", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SnoptInterface::nnObj", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SnoptInterface::nnCon", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SnoptInterface::A_structure", "IM", () => read_IM(r));
  r.field(record, "SnoptInterface::m", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SnoptInterface::iObj", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SnoptInterface::jacF_row", "bool", () => r.boolean());
  r.field(record, "SnoptInterface::dummyrow", "bool", () => r.boolean());
  r.field(record, "SnoptInterface::Cold_", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SnoptInterface::inf", "double", () => r.number("double"));
  r.field(record, "SnoptInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_Solve_Tr_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_SparseDenseKron_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Kron::serialize_body");
  layout_Kron_serialize_body(r, record, scope);
  --r.depth;
}
function layout_SparseDenseKronContract_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("KronContract::serialize_body");
  layout_KronContract_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Sparsify_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Project::serialize_body");
  layout_Project_serialize_body(r, record, scope);
  --r.depth;
}
function layout_SparsityCast_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Split_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MultipleOutput::serialize_body");
  layout_MultipleOutput_serialize_body(r, record, scope);
  r.field(record, "Split::offset", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "Split::output_sparsity", "std::vector<Sparsity>", () => read_std_vector_Sparsity(r));
  --r.depth;
}
function layout_SqicInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Sqpmethod_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "Sqpmethod", 3);
  r.field(record, "Sqpmethod::qpsol", "Function", () => read_Function(r));
  r.field(record, "Sqpmethod::qpsol_ela", "Function", () => read_Function(r));
  r.field(record, "Sqpmethod::exact_hessian", "bool", () => r.boolean());
  r.field(record, "Sqpmethod::max_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Sqpmethod::min_iter", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Sqpmethod::lbfgs_memory", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Sqpmethod::tol_pr_", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::tol_du_", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::min_step_size_", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::c1", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::beta", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::max_iter_ls_", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Sqpmethod::merit_memsize_", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "Sqpmethod::beta", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::print_header", "bool", () => r.boolean());
  r.field(record, "Sqpmethod::print_iteration", "bool", () => r.boolean());
  r.field(record, "Sqpmethod::print_status", "bool", () => r.boolean());
  r.field(record, "Sqpmethod::elastic_mode", "bool", () => r.boolean());
  r.field(record, "Sqpmethod::gamma_0", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::gamma_max", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::gamma_1_min", "double", () => r.number("double"));
  r.field(record, "Sqpmethod::init_feasible", "bool", () => r.boolean());
  r.field(record, "Sqpmethod::so_corr", "bool", () => r.boolean());
  r.field(record, "Sqpmethod::Hsp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Sqpmethod::Asp", "Sparsity", () => read_Sparsity(r));
  scope["Sqpmethod::convexify"] = r.field(record, "Sqpmethod::convexify", "bool", () => r.boolean());
  if (scope["Sqpmethod::convexify"]) {
    record.layouts.push("Convexify::serialize");
    scope["prefix"] = "Sqpmethod::";
    layout_Convexify_serialize(r, record, scope);
  }
  --r.depth;
}
function layout_SundialsInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Integrator::serialize_body");
  layout_Integrator_serialize_body(r, record, scope);
  r.version(record, "SundialsInterface", 2);
  r.field(record, "SundialsInterface::abstol", "double", () => r.number("double"));
  r.field(record, "SundialsInterface::reltol", "double", () => r.number("double"));
  r.field(record, "SundialsInterface::max_num_steps", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SundialsInterface::stop_at_end", "bool", () => r.boolean());
  r.field(record, "SundialsInterface::quad_err_con", "bool", () => r.boolean());
  r.field(record, "SundialsInterface::steps_per_checkpoint", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SundialsInterface::disable_internal_warnings", "bool", () => r.boolean());
  r.field(record, "SundialsInterface::max_multistep_order", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SundialsInterface::linear_solver", "std::string", () => r.string());
  r.field(record, "SundialsInterface::linear_solver_options", "Dict", () => read_Dict(r));
  r.field(record, "SundialsInterface::max_krylov", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SundialsInterface::use_precon", "bool", () => r.boolean());
  r.field(record, "SundialsInterface::second_order_correction", "bool", () => r.boolean());
  r.field(record, "SundialsInterface::step0", "double", () => r.number("double"));
  r.field(record, "SundialsInterface::max_step_size", "double", () => r.number("double"));
  r.field(record, "SundialsInterface::nonlin_conv_coeff", "double", () => r.number("double"));
  r.field(record, "SundialsInterface::max_order", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SundialsInterface::scale_abstol", "bool", () => r.boolean());
  r.field(record, "SundialsInterface::linsolF", "Linsol", () => read_Linsol(r));
  r.field(record, "SundialsInterface::newton_scheme", "int", () => r.number("int"));
  r.field(record, "SundialsInterface::interp", "int", () => r.number("int"));
  --r.depth;
}
function layout_SuperscsInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "SuperscsInterface", 1);
  r.field(record, "SuperscsInterface::settings::normalize", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::scale", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::rho_x", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::max_time_milliseconds", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::max_iters", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::previous_max_iters", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::eps", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::alpha", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::cg_rate", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::verbose", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::warm_start", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::do_super_scs", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::k0", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::c_bl", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::k1", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::k2", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::c1", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::sse", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::ls", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::beta", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::sigma", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::direction", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::thetabar", "double", () => r.number("double"));
  r.field(record, "SuperscsInterface::settings::memory", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::tRule", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::broyden_init_scaling", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::do_record_progress", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::settings::do_override_streams", "casadi_int", () => r.number("casadi_int"));
  r.field(record, "SuperscsInterface::Hp", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "SuperscsInterface::HL_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "SuperscsInterface::f", "Function", () => read_Function(r));
  r.field(record, "SuperscsInterface::At", "IM", () => read_IM(r));
  r.field(record, "SuperscsInterface::lookup", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "SuperscsInterface::perturb", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, "SuperscsInterface::opts", "Dict", () => read_Dict(r));
  record.layouts.push("Conic::serialize");
  layout_Conic_serialize(r, record, scope);
  --r.depth;
}
function layout_Switch_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "Switch", 1);
  r.field(record, "Switch::f", "std::vector<Function>", () => read_std_vector_Function(r));
  r.field(record, "Switch::f_def", "Function", () => read_Function(r));
  r.field(record, "Switch::project_in", "bool", () => r.boolean());
  r.field(record, "Switch::project_out", "bool", () => r.boolean());
  --r.depth;
}
function layout_SymbolicMX_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "SymbolicMX::name", "std::string", () => r.string());
  --r.depth;
}
function layout_SymbolicQr_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("LinsolInternal::serialize_body");
  layout_LinsolInternal_serialize_body(r, record, scope);
  r.version(record, "SymbolicQr", 1);
  r.field(record, "SymbolicQr::factorize", "Function", () => read_Function(r));
  r.field(record, "SymbolicQr::solve", "Function", () => read_Function(r));
  r.field(record, "SymbolicQr::solveT", "Function", () => read_Function(r));
  r.field(record, "SymbolicQr::fopts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_SymbolicSX_serialize_node(r, record, scope) {
  r.enterLayout();
  r.field(record, "SymbolicSX::name", "std::string", () => r.string());
  --r.depth;
}
function layout_ThreadMap_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Map::serialize_body");
  layout_Map_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Transpose_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  --r.depth;
}
function layout_UnaryMX_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("MXNode::serialize_body");
  layout_MXNode_serialize_body(r, record, scope);
  r.field(record, "UnaryMX::op", "int", () => r.number("int"));
  --r.depth;
}
function layout_UnarySX_serialize_node(r, record, scope) {
  r.enterLayout();
  r.field(record, "UnarySX::dep", "SXElem", () => read_SXElem(r));
  --r.depth;
}
function layout_UnoInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "UnoInterface", 1);
  r.field(record, "UnoInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "UnoInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "UnoInterface::opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_Vertcat_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Concat::serialize_body");
  layout_Concat_serialize_body(r, record, scope);
  --r.depth;
}
function layout_Vertsplit_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Split::serialize_body");
  layout_Split_serialize_body(r, record, scope);
  --r.depth;
}
function layout_WorhpInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Nlpsol::serialize_body");
  layout_Nlpsol_serialize_body(r, record, scope);
  r.version(record, "WorhpInterface", 1);
  r.field(record, "WorhpInterface::jacg_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "WorhpInterface::hesslag_sp", "Sparsity", () => read_Sparsity(r));
  r.field(record, "WorhpInterface::bool_opts", "std::map<std::string,bool>", () => read_std_map_std_string_bool(r));
  r.field(record, "WorhpInterface::int_opts", "std::map<std::string,casadi_int>", () => read_std_map_std_string_casadi_int(r));
  r.field(record, "WorhpInterface::double_opts", "std::map<std::string,double>", () => read_std_map_std_string_double(r));
  r.field(record, "WorhpInterface::qp_opts", "Dict", () => read_Dict(r));
  --r.depth;
}
function layout_XFunction_MXFunction_MX_MXNode_delayed_serialize_members(r, record, scope) {
  r.enterLayout();
  r.field(record, "XFunction::out", "std::vector<MX>", () => read_std_vector_MX(r));
  --r.depth;
}
function layout_XFunction_MXFunction_MX_MXNode_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "XFunction", 1);
  r.field(record, "XFunction::in", "std::vector<MX>", () => read_std_vector_MX(r));
  --r.depth;
}
function layout_XFunction_SXFunction_SX_SXNode_delayed_serialize_members(r, record, scope) {
  r.enterLayout();
  r.field(record, "XFunction::out", "std::vector<SX>", () => read_std_vector_SX(r));
  --r.depth;
}
function layout_XFunction_SXFunction_SX_SXNode_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("FunctionInternal::serialize_body");
  layout_FunctionInternal_serialize_body(r, record, scope);
  r.version(record, "XFunction", 1);
  r.field(record, "XFunction::in", "std::vector<SX>", () => read_std_vector_SX(r));
  --r.depth;
}
function layout_XpressInterface_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Conic::serialize_body");
  layout_Conic_serialize_body(r, record, scope);
  r.version(record, "XpressInterface", 2);
  r.field(record, "XpressInterface::opts", "Dict", () => read_Dict(r));
  r.field(record, "XpressInterface::mip_start", "bool", () => r.boolean());
  r.field(record, "XpressInterface::log_file", "std::string", () => r.string());
  r.field(record, "XpressInterface::compute_iis", "bool", () => r.boolean());
  r.field(record, "XpressInterface::sos_settype", "std::vector<char>", () => read_std_vector_char(r));
  r.field(record, "XpressInterface::sos_setstart", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "XpressInterface::sos_setind", "std::vector<int>", () => read_std_vector_int(r));
  r.field(record, "XpressInterface::sos_refval", "std::vector<double>", () => read_std_vector_double(r));
  --r.depth;
}
function layout_ZipMemResource_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("ResourceInternal::serialize_body");
  layout_ResourceInternal_serialize_body(r, record, scope);
  r.version(record, "ZipMemResource", 1);
  r.field(record, "ZipMemResource::blob", "std::stringstream", () => r.stream());
  --r.depth;
}
function layout_ZipResource_serialize_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("ResourceInternal::serialize_body");
  layout_ResourceInternal_serialize_body(r, record, scope);
  r.version(record, "ZipResource", 1);
  if (scope["ResourceInternal::serialize_mode"] === "embed") {
    r.field(record, "ZipMemResource::blob", "std::stringstream", () => r.stream());
  } else {
    r.field(record, "ZipResource::path", "std::string", () => r.string());
  }
  --r.depth;
}
function layout_pack_tensors(r, record, scope) {
  r.enterLayout();
  r.field(record, String(scope["d"]) + String("::names"), "std::vector<std::string>", () => read_std_vector_std_string(r));
  r.field(record, String(scope["d"]) + String("::shapes"), "std::vector<std::vector<casadi_int>>", () => read_std_vector_std_vector_casadi_int(r));
  r.field(record, String(scope["d"]) + String("::elem_types"), "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  r.field(record, String(scope["d"]) + String("::numels"), "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function read_DM_body(r, record, scope) {
  r.enterLayout();
  r.field(record, "Matrix::sparsity", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Matrix::nonzeros", "std::vector<double>", () => read_std_vector_double(r));
  --r.depth;
}
function read_DM(r) {
  return r.object("DM", null, false, read_DM_body);
}
function read_Fmu_body(r, record, scope) {
  r.enterLayout();
  scope["FmuInternal::type"] = r.field(record, "FmuInternal::type", "std::string", () => r.string());
  const tag_13 = String(scope["FmuInternal::type"]);
  switch (tag_13) {
    case "Fmu2": {
      record.layouts.push("Fmu2::serialize_body");
      layout_Fmu2_serialize_body(r, record, scope);
      break;
    }
    case "Fmu3": {
      record.layouts.push("Fmu3::serialize_body");
      layout_Fmu3_serialize_body(r, record, scope);
      break;
    }
    default:
      r.fail("Unknown serialization discriminator");
  }
  --r.depth;
}
function read_Fmu(r) {
  return r.object("Fmu", "F", true, read_Fmu_body);
}
function read_Function_body(r, record, scope) {
  r.enterLayout();
  scope["Function::null"] = r.field(record, "Function::null", "bool", () => r.boolean());
  if (!scope["Function::null"]) {
    scope["FunctionInternal::base_function"] = r.field(record, "FunctionInternal::base_function", "std::string", () => r.string());
    const tag_14 = String(scope["FunctionInternal::base_function"]);
    switch (tag_14) {
      case "BackwardDiff": {
        record.layouts.push("BackwardDiff::serialize_body");
        layout_BackwardDiff_serialize_body(r, record, scope);
        break;
      }
      case "BlazingSplineFunction": {
        record.layouts.push("BlazingSplineFunction::serialize_body");
        layout_BlazingSplineFunction_serialize_body(r, record, scope);
        break;
      }
      case "CentralDiff": {
        record.layouts.push("CentralDiff::serialize_body");
        layout_CentralDiff_serialize_body(r, record, scope);
        break;
      }
      case "Conic": {
        scope["PluginInterface::plugin_name"] = r.field(record, "PluginInterface::plugin_name", "std::string", () => r.string());
        const tag_15 = String(scope["PluginInterface::plugin_name"]);
        switch (tag_15) {
          case "cbc": {
            record.layouts.push("CbcInterface::serialize_body");
            layout_CbcInterface_serialize_body(r, record, scope);
            break;
          }
          case "clarabel": {
            record.layouts.push("ClarabelInterface::serialize_body");
            layout_ClarabelInterface_serialize_body(r, record, scope);
            break;
          }
          case "clp": {
            record.layouts.push("ClpInterface::serialize_body");
            layout_ClpInterface_serialize_body(r, record, scope);
            break;
          }
          case "cplex": {
            record.layouts.push("CplexInterface::serialize_body");
            layout_CplexInterface_serialize_body(r, record, scope);
            break;
          }
          case "daqp": {
            record.layouts.push("DaqpInterface::serialize_body");
            layout_DaqpInterface_serialize_body(r, record, scope);
            break;
          }
          case "fatrop": {
            record.layouts.push("FatropConicInterface::serialize_body");
            layout_FatropConicInterface_serialize_body(r, record, scope);
            break;
          }
          case "gurobi": {
            record.layouts.push("GurobiInterface::serialize_body");
            layout_GurobiInterface_serialize_body(r, record, scope);
            break;
          }
          case "highs": {
            record.layouts.push("HighsInterface::serialize_body");
            layout_HighsInterface_serialize_body(r, record, scope);
            break;
          }
          case "hpipm": {
            record.layouts.push("HpipmInterface::serialize_body");
            layout_HpipmInterface_serialize_body(r, record, scope);
            break;
          }
          case "hpmpc": {
            record.layouts.push("HpmpcInterface::serialize_body");
            layout_HpmpcInterface_serialize_body(r, record, scope);
            break;
          }
          case "ipqp": {
            record.layouts.push("Ipqp::serialize_body");
            layout_Ipqp_serialize_body(r, record, scope);
            break;
          }
          case "mosek": {
            record.layouts.push("MosekInterface::serialize_body");
            layout_MosekInterface_serialize_body(r, record, scope);
            break;
          }
          case "nlpsol": {
            record.layouts.push("QpToNlp::serialize_body");
            layout_QpToNlp_serialize_body(r, record, scope);
            break;
          }
          case "ooqp": {
            record.layouts.push("OoqpInterface::serialize_body");
            layout_OoqpInterface_serialize_body(r, record, scope);
            break;
          }
          case "osqp": {
            record.layouts.push("OsqpInterface::serialize_body");
            layout_OsqpInterface_serialize_body(r, record, scope);
            break;
          }
          case "piqp": {
            record.layouts.push("PiqpInterface::serialize_body");
            layout_PiqpInterface_serialize_body(r, record, scope);
            break;
          }
          case "proxqp": {
            record.layouts.push("ProxqpInterface::serialize_body");
            layout_ProxqpInterface_serialize_body(r, record, scope);
            break;
          }
          case "qpoases": {
            record.layouts.push("QpoasesInterface::serialize_body");
            layout_QpoasesInterface_serialize_body(r, record, scope);
            break;
          }
          case "qrqp": {
            record.layouts.push("Qrqp::serialize_body");
            layout_Qrqp_serialize_body(r, record, scope);
            break;
          }
          case "sqic": {
            record.layouts.push("SqicInterface::serialize_body");
            layout_SqicInterface_serialize_body(r, record, scope);
            break;
          }
          case "superscs": {
            record.layouts.push("SuperscsInterface::serialize_body");
            layout_SuperscsInterface_serialize_body(r, record, scope);
            break;
          }
          case "xpress": {
            record.layouts.push("XpressInterface::serialize_body");
            layout_XpressInterface_serialize_body(r, record, scope);
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "External": {
        r.version(record, "GenericExternal", 1);
        scope["GenericExternal::type"] = r.field(record, "GenericExternal::type", "char", () => r.byte());
        const tag_16 = String(scope["GenericExternal::type"]);
        switch (tag_16) {
          case "103": {
            record.layouts.push("External::serialize_body");
            layout_External_serialize_body(r, record, scope);
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "FmuFunction": {
        record.layouts.push("FmuFunction::serialize_body");
        layout_FmuFunction_serialize_body(r, record, scope);
        break;
      }
      case "ForwardDiff": {
        record.layouts.push("ForwardDiff::serialize_body");
        layout_ForwardDiff_serialize_body(r, record, scope);
        break;
      }
      case "Integrator": {
        scope["PluginInterface::plugin_name"] = r.field(record, "PluginInterface::plugin_name", "std::string", () => r.string());
        const tag_17 = String(scope["PluginInterface::plugin_name"]);
        switch (tag_17) {
          case "collocation": {
            record.layouts.push("Collocation::serialize_body");
            layout_Collocation_serialize_body(r, record, scope);
            break;
          }
          case "cvodes": {
            record.layouts.push("CvodesInterface::serialize_body");
            layout_CvodesInterface_serialize_body(r, record, scope);
            break;
          }
          case "idas": {
            record.layouts.push("IdasInterface::serialize_body");
            layout_IdasInterface_serialize_body(r, record, scope);
            break;
          }
          case "rk": {
            record.layouts.push("RungeKutta::serialize_body");
            layout_RungeKutta_serialize_body(r, record, scope);
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "Interpolant": {
        scope["PluginInterface::plugin_name"] = r.field(record, "PluginInterface::plugin_name", "std::string", () => r.string());
        const tag_18 = String(scope["PluginInterface::plugin_name"]);
        switch (tag_18) {
          case "bspline": {
            record.layouts.push("BSplineInterpolant::serialize_body");
            layout_BSplineInterpolant_serialize_body(r, record, scope);
            break;
          }
          case "linear": {
            r.version(record, "LinearInterpolant", 1);
            scope["LinearInterpolant::type"] = r.field(record, "LinearInterpolant::type", "char", () => r.byte());
            const tag_19 = String(scope["LinearInterpolant::type"]);
            switch (tag_19) {
              case "102": {
                record.layouts.push("LinearInterpolant::serialize_body");
                layout_LinearInterpolant_serialize_body(r, record, scope);
                break;
              }
              case "106": {
                record.layouts.push("LinearInterpolantJac::serialize_body");
                layout_LinearInterpolantJac_serialize_body(r, record, scope);
                break;
              }
              default:
                r.fail("Unknown serialization discriminator");
            }
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "MXFunction": {
        record.layouts.push("MXFunction::serialize_body");
        layout_MXFunction_serialize_body(r, record, scope);
        break;
      }
      case "Map": {
        scope["Map::class_name"] = r.field(record, "Map::class_name", "std::string", () => r.string());
        const tag_20 = String(scope["Map::class_name"]);
        switch (tag_20) {
          case "Map": {
            record.layouts.push("Map::serialize_body");
            layout_Map_serialize_body(r, record, scope);
            break;
          }
          case "OmpMap": {
            record.layouts.push("OmpMap::serialize_body");
            layout_OmpMap_serialize_body(r, record, scope);
            break;
          }
          case "ThreadMap": {
            record.layouts.push("ThreadMap::serialize_body");
            layout_ThreadMap_serialize_body(r, record, scope);
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "MapSum": {
        scope["MapSum::class_name"] = r.field(record, "MapSum::class_name", "std::string", () => r.string());
        const tag_21 = String(scope["MapSum::class_name"]);
        switch (tag_21) {
          case "MapSum": {
            record.layouts.push("MapSum::serialize_body");
            layout_MapSum_serialize_body(r, record, scope);
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "Nlpsol": {
        scope["PluginInterface::plugin_name"] = r.field(record, "PluginInterface::plugin_name", "std::string", () => r.string());
        const tag_22 = String(scope["PluginInterface::plugin_name"]);
        switch (tag_22) {
          case "alpaqa": {
            record.layouts.push("AlpaqaInterface::serialize_body");
            layout_AlpaqaInterface_serialize_body(r, record, scope);
            break;
          }
          case "ampl": {
            record.layouts.push("AmplInterface::serialize_body");
            layout_AmplInterface_serialize_body(r, record, scope);
            break;
          }
          case "blocksqp": {
            record.layouts.push("Blocksqp::serialize_body");
            layout_Blocksqp_serialize_body(r, record, scope);
            break;
          }
          case "bonmin": {
            record.layouts.push("BonminInterface::serialize_body");
            layout_BonminInterface_serialize_body(r, record, scope);
            break;
          }
          case "ccopt": {
            record.layouts.push("MadmpecInterface::serialize_body");
            layout_MadmpecInterface_serialize_body(r, record, scope);
            break;
          }
          case "conopt": {
            record.layouts.push("ConoptInterface::serialize_body");
            layout_ConoptInterface_serialize_body(r, record, scope);
            break;
          }
          case "fatrop": {
            record.layouts.push("FatropInterface::serialize_body");
            layout_FatropInterface_serialize_body(r, record, scope);
            break;
          }
          case "feasiblesqpmethod": {
            record.layouts.push("Feasiblesqpmethod::serialize_body");
            layout_Feasiblesqpmethod_serialize_body(r, record, scope);
            break;
          }
          case "ipopt": {
            record.layouts.push("IpoptInterface::serialize_body");
            layout_IpoptInterface_serialize_body(r, record, scope);
            break;
          }
          case "knitro": {
            record.layouts.push("KnitroInterface::serialize_body");
            layout_KnitroInterface_serialize_body(r, record, scope);
            break;
          }
          case "madnlp": {
            record.layouts.push("MadnlpInterface::serialize_body");
            layout_MadnlpInterface_serialize_body(r, record, scope);
            break;
          }
          case "qrsqp": {
            record.layouts.push("Qrsqp::serialize_body");
            layout_Qrsqp_serialize_body(r, record, scope);
            break;
          }
          case "scpgen": {
            record.layouts.push("Scpgen::serialize_body");
            layout_Scpgen_serialize_body(r, record, scope);
            break;
          }
          case "sleqp": {
            record.layouts.push("SLEQPInterface::serialize_body");
            layout_SLEQPInterface_serialize_body(r, record, scope);
            break;
          }
          case "snopt": {
            record.layouts.push("SnoptInterface::serialize_body");
            layout_SnoptInterface_serialize_body(r, record, scope);
            break;
          }
          case "sqpmethod": {
            record.layouts.push("Sqpmethod::serialize_body");
            layout_Sqpmethod_serialize_body(r, record, scope);
            break;
          }
          case "uno": {
            record.layouts.push("UnoInterface::serialize_body");
            layout_UnoInterface_serialize_body(r, record, scope);
            break;
          }
          case "worhp": {
            record.layouts.push("WorhpInterface::serialize_body");
            layout_WorhpInterface_serialize_body(r, record, scope);
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "Onnx": {
        scope["PluginInterface::plugin_name"] = r.field(record, "PluginInterface::plugin_name", "std::string", () => r.string());
        const tag_23 = String(scope["PluginInterface::plugin_name"]);
        switch (tag_23) {
          case "ort": {
            record.layouts.push("OnnxRuntimeInterface::serialize_body");
            layout_OnnxRuntimeInterface_serialize_body(r, record, scope);
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "Rootfinder": {
        scope["PluginInterface::plugin_name"] = r.field(record, "PluginInterface::plugin_name", "std::string", () => r.string());
        const tag_24 = String(scope["PluginInterface::plugin_name"]);
        switch (tag_24) {
          case "bisection": {
            record.layouts.push("Bisection::serialize_body");
            layout_Bisection_serialize_body(r, record, scope);
            break;
          }
          case "fast_newton": {
            record.layouts.push("FastNewton::serialize_body");
            layout_FastNewton_serialize_body(r, record, scope);
            break;
          }
          case "kinsol": {
            record.layouts.push("KinsolInterface::serialize_body");
            layout_KinsolInterface_serialize_body(r, record, scope);
            break;
          }
          case "newton": {
            record.layouts.push("Newton::serialize_body");
            layout_Newton_serialize_body(r, record, scope);
            break;
          }
          case "nlpsol": {
            record.layouts.push("ImplicitToNlp::serialize_body");
            layout_ImplicitToNlp_serialize_body(r, record, scope);
            break;
          }
          default:
            r.fail("Unknown serialization discriminator");
        }
        break;
      }
      case "SXFunction": {
        record.layouts.push("SXFunction::serialize_body");
        layout_SXFunction_serialize_body(r, record, scope);
        break;
      }
      case "Smoothing": {
        record.layouts.push("Smoothing::serialize_body");
        layout_Smoothing_serialize_body(r, record, scope);
        break;
      }
      case "Switch": {
        record.layouts.push("Switch::serialize_body");
        layout_Switch_serialize_body(r, record, scope);
        break;
      }
      default:
        r.fail("Unknown serialization discriminator");
    }
  }
  --r.depth;
}
function read_Function(r) {
  return r.object("Function", "F", true, read_Function_body);
}
function read_GenericType_body(r, record, scope) {
  r.enterLayout();
  scope["GenericType::type"] = r.field(record, "GenericType::type", "int", () => r.number("int"));
  const tag_25 = String(scope["GenericType::type"]);
  switch (tag_25) {
    case "1": {
      r.field(record, "GenericType::d", "bool", () => r.boolean());
      break;
    }
    case "10": {
      r.field(record, "GenericType::d", "std::vector<std::string>", () => read_std_vector_std_string(r));
      break;
    }
    case "11": {
      r.field(record, "GenericType::d", "Dict", () => read_Dict(r));
      break;
    }
    case "12": {
      r.field(record, "GenericType::d", "Function", () => read_Function(r));
      break;
    }
    case "13": {
      r.field(record, "GenericType::d", "std::vector<Function>", () => read_std_vector_Function(r));
      break;
    }
    case "14": {
      r.field(record, "GenericType::d", "void*", () => r.primitive("void*"));
      break;
    }
    case "16": {
      r.field(record, "GenericType::d", "std::vector<std::vector<std::string>>", () => read_std_vector_std_vector_std_string(r));
      break;
    }
    case "17": {
      r.field(record, "GenericType::d", "std::vector<Dict>", () => read_std_vector_Dict(r));
      break;
    }
    case "18": {
      r.field(record, "GenericType::d", "std::vector<std::vector<GenericType>>", () => read_std_vector_std_vector_GenericType(r));
      break;
    }
    case "19": {
      r.field(record, "GenericType::d", "std::vector<GenericType>", () => read_std_vector_GenericType(r));
      break;
    }
    case "2": {
      r.field(record, "GenericType::d", "casadi_int", () => r.number("casadi_int"));
      break;
    }
    case "3": {
      r.field(record, "GenericType::d", "double", () => r.number("double"));
      break;
    }
    case "4": {
      r.field(record, "GenericType::d", "std::string", () => r.string());
      break;
    }
    case "5": {
      r.field(record, "GenericType::d", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
      break;
    }
    case "6": {
      r.field(record, "GenericType::d", "std::vector<std::vector<casadi_int>>", () => read_std_vector_std_vector_casadi_int(r));
      break;
    }
    case "7": {
      r.field(record, "GenericType::d", "std::vector<bool>", () => read_std_vector_bool(r));
      break;
    }
    case "8": {
      r.field(record, "GenericType::d", "std::vector<double>", () => read_std_vector_double(r));
      break;
    }
    case "9": {
      r.field(record, "GenericType::d", "std::vector<std::vector<double>>", () => read_std_vector_std_vector_double(r));
      break;
    }
    default:
      r.fail("Unknown serialization discriminator");
  }
  --r.depth;
}
function read_GenericType(r) {
  return r.object("GenericType", "G", true, read_GenericType_body);
}
function read_IM_body(r, record, scope) {
  r.enterLayout();
  r.field(record, "Matrix::sparsity", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Matrix::nonzeros", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function read_IM(r) {
  return r.object("IM", null, false, read_IM_body);
}
function read_Importer_body(r, record, scope) {
  r.enterLayout();
  scope["ImporterInternal::type"] = r.field(record, "ImporterInternal::type", "std::string", () => r.string());
  const tag_26 = String(scope["ImporterInternal::type"]);
  switch (tag_26) {
    case "DllLibrary": {
      record.layouts.push("ImporterInternal::serialize_body");
      layout_ImporterInternal_serialize_body(r, record, scope);
      break;
    }
    default:
      r.fail("Unknown serialization discriminator");
  }
  --r.depth;
}
function read_Importer(r) {
  return r.object("Importer", "M", true, read_Importer_body);
}
function read_Linsol_body(r, record, scope) {
  r.enterLayout();
  scope["PluginInterface::plugin_name"] = r.field(record, "PluginInterface::plugin_name", "std::string", () => r.string());
  const tag_27 = String(scope["PluginInterface::plugin_name"]);
  switch (tag_27) {
    case "csparse": {
      record.layouts.push("CsparseInterface::serialize_body");
      layout_CsparseInterface_serialize_body(r, record, scope);
      break;
    }
    case "csparsecholesky": {
      record.layouts.push("CSparseCholeskyInterface::serialize_body");
      layout_CSparseCholeskyInterface_serialize_body(r, record, scope);
      break;
    }
    case "lapacklu": {
      record.layouts.push("LapackLu::serialize_body");
      layout_LapackLu_serialize_body(r, record, scope);
      break;
    }
    case "lapackqr": {
      record.layouts.push("LapackQr::serialize_body");
      layout_LapackQr_serialize_body(r, record, scope);
      break;
    }
    case "ldl": {
      record.layouts.push("LinsolLdl::serialize_body");
      layout_LinsolLdl_serialize_body(r, record, scope);
      break;
    }
    case "lsqr": {
      record.layouts.push("Lsqr::serialize_body");
      layout_Lsqr_serialize_body(r, record, scope);
      break;
    }
    case "ma27": {
      record.layouts.push("Ma27Interface::serialize_body");
      layout_Ma27Interface_serialize_body(r, record, scope);
      break;
    }
    case "mumps": {
      record.layouts.push("MumpsInterface::serialize_body");
      layout_MumpsInterface_serialize_body(r, record, scope);
      break;
    }
    case "qr": {
      record.layouts.push("LinsolQr::serialize_body");
      layout_LinsolQr_serialize_body(r, record, scope);
      break;
    }
    case "symbolicqr": {
      record.layouts.push("SymbolicQr::serialize_body");
      layout_SymbolicQr_serialize_body(r, record, scope);
      break;
    }
    case "tridiag": {
      record.layouts.push("LinsolTridiag::serialize_body");
      layout_LinsolTridiag_serialize_body(r, record, scope);
      break;
    }
    default:
      r.fail("Unknown serialization discriminator");
  }
  --r.depth;
}
function read_Linsol(r) {
  return r.object("Linsol", "L", true, read_Linsol_body);
}
function read_MX_body(r, record, scope) {
  r.enterLayout();
  scope["MXNode::op"] = r.field(record, "MXNode::op", "int", () => r.number("int"));
  const tag_28 = String(scope["MXNode::op"]);
  switch (tag_28) {
    case "-1": {
      record.layouts.push("OutputNode::serialize_body");
      layout_OutputNode_serialize_body(r, record, scope);
      break;
    }
    case "0": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "1": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "10": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "100": {
      scope["KronContract::kind"] = r.field(record, "KronContract::kind", "std::string", () => r.string());
      const tag_29 = String(scope["KronContract::kind"]);
      switch (tag_29) {
        case "base": {
          record.layouts.push("KronContract::serialize_body");
          layout_KronContract_serialize_body(r, record, scope);
          break;
        }
        case "dense": {
          record.layouts.push("DenseKronContract::serialize_body");
          layout_DenseKronContract_serialize_body(r, record, scope);
          break;
        }
        case "dense_sparse": {
          record.layouts.push("DenseSparseKronContract::serialize_body");
          layout_DenseSparseKronContract_serialize_body(r, record, scope);
          break;
        }
        case "sparse_dense": {
          record.layouts.push("SparseDenseKronContract::serialize_body");
          layout_SparseDenseKronContract_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "11": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "12": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "13": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "14": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "15": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "16": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "17": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "18": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "19": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "2": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "20": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "21": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "22": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "23": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "24": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "25": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "26": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "27": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "28": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "29": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "3": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "30": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "31": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "32": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "33": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "34": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "35": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "36": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "37": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "38": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "39": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "4": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "40": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "41": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "42": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "43": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "44": {
      scope["ConstantMX::type"] = r.field(record, "ConstantMX::type", "char", () => r.byte());
      const tag_30 = String(scope["ConstantMX::type"]);
      switch (tag_30) {
        case "102": {
          record.layouts.push("ConstantFile::serialize_body");
          layout_ConstantFile_serialize_body(r, record, scope);
          break;
        }
        case "109": {
          record.layouts.push("MXNode::serialize_body");
          layout_MXNode_serialize_body(r, record, scope);
          break;
        }
        case "112": {
          record.layouts.push("ConstantPool::serialize_body");
          layout_ConstantPool_serialize_body(r, record, scope);
          break;
        }
        case "122": {
          break;
        }
        case "48": {
          record.layouts.push("MXNode::serialize_body");
          layout_MXNode_serialize_body(r, record, scope);
          break;
        }
        case "49": {
          record.layouts.push("MXNode::serialize_body");
          layout_MXNode_serialize_body(r, record, scope);
          break;
        }
        case "68": {
          r.field(record, "Constant::value", "double", () => r.number("double"));
          record.layouts.push("MXNode::serialize_body");
          layout_MXNode_serialize_body(r, record, scope);
          break;
        }
        case "73": {
          r.field(record, "Constant::value", "casadi_int", () => r.number("casadi_int"));
          record.layouts.push("MXNode::serialize_body");
          layout_MXNode_serialize_body(r, record, scope);
          break;
        }
        case "97": {
          record.layouts.push("ConstantDM::serialize_body");
          layout_ConstantDM_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "45": {
      record.layouts.push("Input::serialize_body");
      layout_Input_serialize_body(r, record, scope);
      break;
    }
    case "46": {
      record.layouts.push("Output::serialize_body");
      layout_Output_serialize_body(r, record, scope);
      break;
    }
    case "47": {
      record.layouts.push("SymbolicMX::serialize_body");
      layout_SymbolicMX_serialize_body(r, record, scope);
      break;
    }
    case "48": {
      record.layouts.push("Call::serialize_body");
      layout_Call_serialize_body(r, record, scope);
      break;
    }
    case "49": {
      record.layouts.push("Find::serialize_body");
      layout_Find_serialize_body(r, record, scope);
      break;
    }
    case "5": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "50": {
      record.layouts.push("Low::serialize_body");
      layout_Low_serialize_body(r, record, scope);
      break;
    }
    case "52": {
      scope["Multiplication::kind"] = r.field(record, "Multiplication::kind", "std::string", () => r.string());
      const tag_31 = String(scope["Multiplication::kind"]);
      switch (tag_31) {
        case "base": {
          record.layouts.push("Multiplication::serialize_body");
          layout_Multiplication_serialize_body(r, record, scope);
          break;
        }
        case "dense": {
          record.layouts.push("DenseMultiplication::serialize_body");
          layout_DenseMultiplication_serialize_body(r, record, scope);
          break;
        }
        case "dense_sparse": {
          record.layouts.push("DenseSparseMultiplication::serialize_body");
          layout_DenseSparseMultiplication_serialize_body(r, record, scope);
          break;
        }
        case "pseudo_dense": {
          record.layouts.push("PseudoDenseMultiplication::serialize_body");
          layout_PseudoDenseMultiplication_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "53": {
      r.field(record, "Solve::Tr", "bool", () => r.boolean());
      record.layouts.push("LinsolCall<Tr>::serialize_body");
      layout_LinsolCall_Tr_serialize_body(r, record, scope);
      break;
    }
    case "54": {
      scope["Transpose::dense"] = r.field(record, "Transpose::dense", "bool", () => r.boolean());
      const tag_32 = String(scope["Transpose::dense"]);
      switch (tag_32) {
        case "false": {
          record.layouts.push("Transpose::serialize_body");
          layout_Transpose_serialize_body(r, record, scope);
          break;
        }
        case "true": {
          record.layouts.push("DenseTranspose::serialize_body");
          layout_DenseTranspose_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "55": {
      record.layouts.push("Determinant::serialize_body");
      layout_Determinant_serialize_body(r, record, scope);
      break;
    }
    case "56": {
      record.layouts.push("Inverse::serialize_body");
      layout_Inverse_serialize_body(r, record, scope);
      break;
    }
    case "57": {
      record.layouts.push("Dot::serialize_body");
      layout_Dot_serialize_body(r, record, scope);
      break;
    }
    case "58": {
      record.layouts.push("Bilin::serialize_body");
      layout_Bilin_serialize_body(r, record, scope);
      break;
    }
    case "59": {
      record.layouts.push("Rank1::serialize_body");
      layout_Rank1_serialize_body(r, record, scope);
      break;
    }
    case "6": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "60": {
      record.layouts.push("Horzcat::serialize_body");
      layout_Horzcat_serialize_body(r, record, scope);
      break;
    }
    case "61": {
      record.layouts.push("Vertcat::serialize_body");
      layout_Vertcat_serialize_body(r, record, scope);
      break;
    }
    case "62": {
      record.layouts.push("Diagcat::serialize_body");
      layout_Diagcat_serialize_body(r, record, scope);
      break;
    }
    case "63": {
      record.layouts.push("Horzsplit::serialize_body");
      layout_Horzsplit_serialize_body(r, record, scope);
      break;
    }
    case "64": {
      record.layouts.push("Vertsplit::serialize_body");
      layout_Vertsplit_serialize_body(r, record, scope);
      break;
    }
    case "65": {
      record.layouts.push("Diagsplit::serialize_body");
      layout_Diagsplit_serialize_body(r, record, scope);
      break;
    }
    case "66": {
      record.layouts.push("Reshape::serialize_body");
      layout_Reshape_serialize_body(r, record, scope);
      break;
    }
    case "69": {
      scope["GetNonzeros::type"] = r.field(record, "GetNonzeros::type", "char", () => r.byte());
      const tag_33 = String(scope["GetNonzeros::type"]);
      switch (tag_33) {
        case "97": {
          record.layouts.push("GetNonzerosVector::serialize_body");
          layout_GetNonzerosVector_serialize_body(r, record, scope);
          break;
        }
        case "98": {
          record.layouts.push("GetNonzerosSlice::serialize_body");
          layout_GetNonzerosSlice_serialize_body(r, record, scope);
          break;
        }
        case "99": {
          record.layouts.push("GetNonzerosSlice2::serialize_body");
          layout_GetNonzerosSlice2_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "7": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "70": {
      scope["GetNonzerosParam::type"] = r.field(record, "GetNonzerosParam::type", "char", () => r.byte());
      const tag_34 = String(scope["GetNonzerosParam::type"]);
      switch (tag_34) {
        case "100": {
          record.layouts.push("GetNonzerosParamParam::serialize_body");
          layout_GetNonzerosParamParam_serialize_body(r, record, scope);
          break;
        }
        case "97": {
          record.layouts.push("GetNonzerosParamVector::serialize_body");
          layout_GetNonzerosParamVector_serialize_body(r, record, scope);
          break;
        }
        case "98": {
          record.layouts.push("GetNonzerosParamSlice::serialize_body");
          layout_GetNonzerosParamSlice_serialize_body(r, record, scope);
          break;
        }
        case "99": {
          record.layouts.push("GetNonzerosSliceParam::serialize_body");
          layout_GetNonzerosSliceParam_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "71": {
      scope["SetNonzeros::type"] = r.field(record, "SetNonzeros::type", "char", () => r.byte());
      const tag_35 = String(scope["SetNonzeros::type"]);
      switch (tag_35) {
        case "97": {
          record.layouts.push("SetNonzerosVector<Add>::serialize_body");
          layout_SetNonzerosVector_Add_serialize_body(r, record, scope);
          break;
        }
        case "98": {
          record.layouts.push("SetNonzerosSlice<Add>::serialize_body");
          layout_SetNonzerosSlice_Add_serialize_body(r, record, scope);
          break;
        }
        case "99": {
          record.layouts.push("SetNonzerosSlice2<Add>::serialize_body");
          layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "72": {
      scope["SetNonzerosParam::type"] = r.field(record, "SetNonzerosParam::type", "char", () => r.byte());
      const tag_36 = String(scope["SetNonzerosParam::type"]);
      switch (tag_36) {
        case "100": {
          record.layouts.push("SetNonzerosParamParam<Add>::serialize_body");
          layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope);
          break;
        }
        case "97": {
          record.layouts.push("SetNonzerosParamVector<Add>::serialize_body");
          layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope);
          break;
        }
        case "98": {
          record.layouts.push("SetNonzerosParamSlice<Add>::serialize_body");
          layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope);
          break;
        }
        case "99": {
          record.layouts.push("SetNonzerosSliceParam<Add>::serialize_body");
          layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "73": {
      scope["SetNonzeros::type"] = r.field(record, "SetNonzeros::type", "char", () => r.byte());
      const tag_37 = String(scope["SetNonzeros::type"]);
      switch (tag_37) {
        case "97": {
          record.layouts.push("SetNonzerosVector<Add>::serialize_body");
          layout_SetNonzerosVector_Add_serialize_body(r, record, scope);
          break;
        }
        case "98": {
          record.layouts.push("SetNonzerosSlice<Add>::serialize_body");
          layout_SetNonzerosSlice_Add_serialize_body(r, record, scope);
          break;
        }
        case "99": {
          record.layouts.push("SetNonzerosSlice2<Add>::serialize_body");
          layout_SetNonzerosSlice2_Add_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "74": {
      scope["SetNonzerosParam::type"] = r.field(record, "SetNonzerosParam::type", "char", () => r.byte());
      const tag_38 = String(scope["SetNonzerosParam::type"]);
      switch (tag_38) {
        case "100": {
          record.layouts.push("SetNonzerosParamParam<Add>::serialize_body");
          layout_SetNonzerosParamParam_Add_serialize_body(r, record, scope);
          break;
        }
        case "97": {
          record.layouts.push("SetNonzerosParamVector<Add>::serialize_body");
          layout_SetNonzerosParamVector_Add_serialize_body(r, record, scope);
          break;
        }
        case "98": {
          record.layouts.push("SetNonzerosParamSlice<Add>::serialize_body");
          layout_SetNonzerosParamSlice_Add_serialize_body(r, record, scope);
          break;
        }
        case "99": {
          record.layouts.push("SetNonzerosSliceParam<Add>::serialize_body");
          layout_SetNonzerosSliceParam_Add_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "75": {
      scope["Project::type"] = r.field(record, "Project::type", "char", () => r.byte());
      const tag_39 = String(scope["Project::type"]);
      switch (tag_39) {
        case "100": {
          record.layouts.push("Densify::serialize_body");
          layout_Densify_serialize_body(r, record, scope);
          break;
        }
        case "110": {
          record.layouts.push("Project::serialize_body");
          layout_Project_serialize_body(r, record, scope);
          break;
        }
        case "115": {
          record.layouts.push("Sparsify::serialize_body");
          layout_Sparsify_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "76": {
      record.layouts.push("Assertion::serialize_body");
      layout_Assertion_serialize_body(r, record, scope);
      break;
    }
    case "77": {
      record.layouts.push("Monitor::serialize_body");
      layout_Monitor_serialize_body(r, record, scope);
      break;
    }
    case "78": {
      record.layouts.push("Norm2::serialize_body");
      layout_Norm2_serialize_body(r, record, scope);
      break;
    }
    case "79": {
      record.layouts.push("Norm1::serialize_body");
      layout_Norm1_serialize_body(r, record, scope);
      break;
    }
    case "8": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "80": {
      record.layouts.push("NormInf::serialize_body");
      layout_NormInf_serialize_body(r, record, scope);
      break;
    }
    case "81": {
      record.layouts.push("NormF::serialize_body");
      layout_NormF_serialize_body(r, record, scope);
      break;
    }
    case "82": {
      record.layouts.push("MMin::serialize_body");
      layout_MMin_serialize_body(r, record, scope);
      break;
    }
    case "83": {
      record.layouts.push("MMax::serialize_body");
      layout_MMax_serialize_body(r, record, scope);
      break;
    }
    case "84": {
      record.layouts.push("HorzRepmat::serialize_body");
      layout_HorzRepmat_serialize_body(r, record, scope);
      break;
    }
    case "85": {
      record.layouts.push("HorzRepsum::serialize_body");
      layout_HorzRepsum_serialize_body(r, record, scope);
      break;
    }
    case "86": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "87": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "88": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "89": {
      record.layouts.push("Einstein::serialize_body");
      layout_Einstein_serialize_body(r, record, scope);
      break;
    }
    case "9": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "90": {
      scope["BSpline::type"] = r.field(record, "BSpline::type", "char", () => r.byte());
      const tag_40 = String(scope["BSpline::type"]);
      switch (tag_40) {
        case "110": {
          record.layouts.push("BSpline::serialize_body");
          layout_BSpline_serialize_body(r, record, scope);
          break;
        }
        case "112": {
          record.layouts.push("BSplineParametric::serialize_body");
          layout_BSplineParametric_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "91": {
      record.layouts.push("Convexify::serialize_body");
      layout_Convexify_serialize_body(r, record, scope);
      break;
    }
    case "92": {
      record.layouts.push("SparsityCast::serialize_body");
      layout_SparsityCast_serialize_body(r, record, scope);
      break;
    }
    case "93": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "94": {
      record.layouts.push("UnaryMX::serialize_body");
      layout_UnaryMX_serialize_body(r, record, scope);
      break;
    }
    case "95": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "96": {
      record.layouts.push("LogSumExp::serialize_body");
      layout_LogSumExp_serialize_body(r, record, scope);
      break;
    }
    case "97": {
      r.field(record, "BinaryMX::scalar_flags", "char", () => r.byte());
      record.layouts.push("BinaryMX<ScX,ScY>::serialize_body");
      layout_BinaryMX_ScX_ScY_serialize_body(r, record, scope);
      break;
    }
    case "98": {
      record.layouts.push("Dump::serialize_body");
      layout_Dump_serialize_body(r, record, scope);
      break;
    }
    case "99": {
      scope["Kron::kind"] = r.field(record, "Kron::kind", "std::string", () => r.string());
      const tag_41 = String(scope["Kron::kind"]);
      switch (tag_41) {
        case "base": {
          record.layouts.push("Kron::serialize_body");
          layout_Kron_serialize_body(r, record, scope);
          break;
        }
        case "dense": {
          record.layouts.push("DenseKron::serialize_body");
          layout_DenseKron_serialize_body(r, record, scope);
          break;
        }
        case "dense_sparse": {
          record.layouts.push("DenseSparseKron::serialize_body");
          layout_DenseSparseKron_serialize_body(r, record, scope);
          break;
        }
        case "sparse_dense": {
          record.layouts.push("SparseDenseKron::serialize_body");
          layout_SparseDenseKron_serialize_body(r, record, scope);
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    default:
      r.fail("Unknown serialization discriminator");
  }
  --r.depth;
}
function read_MX(r) {
  return r.object("MX", "X", true, read_MX_body);
}
function read_Resource_body(r, record, scope) {
  r.enterLayout();
  r.version(record, "ResourceInternal", 1);
  scope["ResourceInternal::type"] = r.field(record, "ResourceInternal::type", "std::string", () => r.string());
  const tag_42 = String(scope["ResourceInternal::type"]);
  switch (tag_42) {
    case "DirResource": {
      record.layouts.push("DirResource::serialize_body");
      layout_DirResource_serialize_body(r, record, scope);
      break;
    }
    case "ZipMemResource": {
      record.layouts.push("ZipMemResource::serialize_body");
      layout_ZipMemResource_serialize_body(r, record, scope);
      break;
    }
    case "ZipResource": {
      record.layouts.push("ZipResource::serialize_body");
      layout_ZipResource_serialize_body(r, record, scope);
      break;
    }
    default:
      r.fail("Unknown serialization discriminator");
  }
  --r.depth;
}
function read_Resource(r) {
  return r.object("Resource", "R", true, read_Resource_body);
}
function read_SX_body(r, record, scope) {
  r.enterLayout();
  r.field(record, "Matrix::sparsity", "Sparsity", () => read_Sparsity(r));
  r.field(record, "Matrix::nonzeros", "std::vector<SXElem>", () => read_std_vector_SXElem(r));
  --r.depth;
}
function read_SX(r) {
  return r.object("SX", null, false, read_SX_body);
}
function read_SXElem_body(r, record, scope) {
  r.enterLayout();
  scope["SXNode::op"] = r.field(record, "SXNode::op", "casadi_int", () => r.number("casadi_int"));
  const tag_43 = String(scope["SXNode::op"]);
  switch (tag_43) {
    case "-1": {
      record.layouts.push("OutputSX::serialize_node");
      layout_OutputSX_serialize_node(r, record, scope);
      break;
    }
    case "0": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "1": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "10": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "11": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "12": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "13": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "14": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "15": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "16": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "17": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "18": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "19": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "2": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "20": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "21": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "22": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "23": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "24": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "25": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "26": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "27": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "28": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "29": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "3": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "30": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "31": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "32": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "33": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "34": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "35": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "36": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "37": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "38": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "39": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "4": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "40": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "41": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "42": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "43": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "44": {
      scope["ConstantSX::type"] = r.field(record, "ConstantSX::type", "char", () => r.byte());
      const tag_44 = String(scope["ConstantSX::type"]);
      switch (tag_44) {
        case "102": {
          break;
        }
        case "105": {
          r.field(record, "ConstantSX::value", "int", () => r.number("int"));
          break;
        }
        case "109": {
          break;
        }
        case "110": {
          break;
        }
        case "114": {
          r.field(record, "ConstantSX::value", "double", () => r.number("double"));
          break;
        }
        case "48": {
          break;
        }
        case "49": {
          break;
        }
        case "70": {
          break;
        }
        default:
          r.fail("Unknown serialization discriminator");
      }
      break;
    }
    case "47": {
      record.layouts.push("SymbolicSX::serialize_node");
      layout_SymbolicSX_serialize_node(r, record, scope);
      break;
    }
    case "48": {
      record.layouts.push("CallSX::serialize_node");
      layout_CallSX_serialize_node(r, record, scope);
      break;
    }
    case "5": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "6": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "7": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "8": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "86": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "87": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "88": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "9": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "93": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "94": {
      record.layouts.push("UnarySX::serialize_node");
      layout_UnarySX_serialize_node(r, record, scope);
      break;
    }
    case "95": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    case "97": {
      record.layouts.push("BinarySX::serialize_node");
      layout_BinarySX_serialize_node(r, record, scope);
      break;
    }
    default:
      r.fail("Unknown serialization discriminator");
  }
  --r.depth;
}
function read_SXElem(r) {
  return r.object("SXElem", "E", true, read_SXElem_body);
}
function read_Slice_body(r, record, scope) {
  r.enterLayout();
  record.layouts.push("Slice::serialize");
  layout_Slice_serialize(r, record, scope);
  --r.depth;
}
function read_Slice(r) {
  return r.object("Slice", "S", false, read_Slice_body);
}
function read_Sparsity_body(r, record, scope) {
  r.enterLayout();
  r.field(record, "SparsityInternal::compressed", "std::vector<casadi_int>", () => read_std_vector_casadi_int(r));
  --r.depth;
}
function read_Sparsity(r) {
  return r.object("Sparsity", "S", true, read_Sparsity_body);
}
function read_std_vector_double(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => r.number("double"));
}
function read_std_vector_casadi_int(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => r.number("casadi_int"));
}
function read_std_vector_std_vector_double(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_std_vector_double(r));
}
function read_std_vector_std_string(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => r.string());
}
function read_std_vector_int(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => r.number("int"));
}
function read_std_vector_char(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => r.byte());
}
function read_std_vector_bool(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => r.boolean());
}
function read_std_vector_SXElem(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_SXElem(r));
}
function read_std_vector_std_vector_int(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_std_vector_int(r));
}
function read_std_vector_unsignedint(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => r.number("unsignedint"));
}
function read_std_vector_size_t(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => r.number("size_t"));
}
function read_std_vector_Sparsity(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_Sparsity(r));
}
function read_std_map_std_string_std_vector_size_t(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), read_std_vector_size_t(r)]) };
}
function read_std_vector_std_vector_size_t(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_std_vector_size_t(r));
}
function read_std_vector_Function(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_Function(r));
}
function read_std_pair_casadi_int_std_string(r) {
  r.decoration("p");
  return [r.number("casadi_int"), r.string()];
}
function read_std_map_std_string_std_pair_casadi_int_std_string(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), read_std_pair_casadi_int_std_string(r)]) };
}
function read_std_pair_bool_std_string(r) {
  r.decoration("p");
  return [r.boolean(), r.string()];
}
function read_std_map_std_string_std_pair_bool_std_string(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), read_std_pair_bool_std_string(r)]) };
}
function read_std_vector_MX(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_MX(r));
}
function read_std_map_std_string_std_vector_double(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), read_std_vector_double(r)]) };
}
function read_std_map_std_string_casadi_int(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), r.number("casadi_int")]) };
}
function read_std_map_std_string_std_vector_casadi_int(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), read_std_vector_casadi_int(r)]) };
}
function read_std_map_std_string_bool(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), r.boolean()]) };
}
function read_std_map_std_string_double(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), r.number("double")]) };
}
function read_std_vector_SX(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_SX(r));
}
function read_std_vector_std_vector_casadi_int(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_std_vector_casadi_int(r));
}
function read_std_vector_std_vector_std_string(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_std_vector_std_string(r));
}
function read_std_vector_Dict(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_Dict(r));
}
function read_std_vector_GenericType(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_GenericType(r));
}
function read_std_vector_std_vector_GenericType(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_std_vector_GenericType(r));
}
function read_std_vector_DM(r) {
  r.decoration("V");
  return Array.from({ length: r.count(r.number("casadi_int")) }, () => read_DM(r));
}
function read_Dict(r) {
  r.decoration("D");
  return { $map: Array.from({ length: r.count(r.number("casadi_int")) }, () => [r.string(), read_GenericType(r)]) };
}
var readers = {
  "DM": read_DM,
  "Fmu": read_Fmu,
  "Function": read_Function,
  "GenericType": read_GenericType,
  "IM": read_IM,
  "Importer": read_Importer,
  "Linsol": read_Linsol,
  "MX": read_MX,
  "Resource": read_Resource,
  "SX": read_SX,
  "SXElem": read_SXElem,
  "Slice": read_Slice,
  "Sparsity": read_Sparsity,
  "std::vector<double>": read_std_vector_double,
  "std::vector<casadi_int>": read_std_vector_casadi_int,
  "std::vector<std::vector<double>>": read_std_vector_std_vector_double,
  "std::vector<std::string>": read_std_vector_std_string,
  "std::vector<int>": read_std_vector_int,
  "std::vector<char>": read_std_vector_char,
  "std::vector<bool>": read_std_vector_bool,
  "std::vector<SXElem>": read_std_vector_SXElem,
  "std::vector<std::vector<int>>": read_std_vector_std_vector_int,
  "std::vector<unsignedint>": read_std_vector_unsignedint,
  "std::vector<size_t>": read_std_vector_size_t,
  "std::vector<Sparsity>": read_std_vector_Sparsity,
  "std::map<std::string,std::vector<size_t>>": read_std_map_std_string_std_vector_size_t,
  "std::vector<std::vector<size_t>>": read_std_vector_std_vector_size_t,
  "std::vector<Function>": read_std_vector_Function,
  "std::pair<casadi_int,std::string>": read_std_pair_casadi_int_std_string,
  "std::map<std::string,std::pair<casadi_int,std::string>>": read_std_map_std_string_std_pair_casadi_int_std_string,
  "std::pair<bool,std::string>": read_std_pair_bool_std_string,
  "std::map<std::string,std::pair<bool,std::string>>": read_std_map_std_string_std_pair_bool_std_string,
  "std::vector<MX>": read_std_vector_MX,
  "std::map<std::string,std::vector<double>>": read_std_map_std_string_std_vector_double,
  "std::map<std::string,casadi_int>": read_std_map_std_string_casadi_int,
  "std::map<std::string,std::vector<casadi_int>>": read_std_map_std_string_std_vector_casadi_int,
  "std::map<std::string,bool>": read_std_map_std_string_bool,
  "std::map<std::string,double>": read_std_map_std_string_double,
  "std::vector<SX>": read_std_vector_SX,
  "std::vector<std::vector<casadi_int>>": read_std_vector_std_vector_casadi_int,
  "std::vector<std::vector<std::string>>": read_std_vector_std_vector_std_string,
  "std::vector<Dict>": read_std_vector_Dict,
  "std::vector<GenericType>": read_std_vector_GenericType,
  "std::vector<std::vector<GenericType>>": read_std_vector_std_vector_GenericType,
  "std::vector<DM>": read_std_vector_DM,
  "Dict": read_Dict
};
var metadata = {
  "wire": {
    "magic": 123456789012345,
    "protocol": 3
  },
  "reader": {
    "file_types": {
      "0": "Sparsity",
      "1": "MX",
      "10": "std::vector<Sparsity>",
      "11": "std::vector<MX>",
      "12": "std::vector<DM>",
      "13": "std::vector<SX>",
      "15": "std::vector<Function>",
      "16": "std::vector<GenericType>",
      "17": "std::vector<casadi_int>",
      "18": "std::vector<double>",
      "19": "std::vector<std::string>",
      "2": "DM",
      "20": "MX",
      "21": "SX",
      "22": "std::vector<MX>",
      "23": "std::vector<SX>",
      "3": "SX",
      "4": "Linsol",
      "5": "Function",
      "6": "GenericType",
      "7": "casadi_int",
      "8": "double",
      "9": "std::string"
    },
    "file_prefixes": {
      "1": "Function",
      "11": "Function",
      "13": "Function",
      "20": "std::vector<MX>",
      "21": "std::vector<SX>",
      "22": "std::vector<MX>",
      "23": "std::vector<SX>",
      "3": "Function"
    }
  }
};

// src/source.js
var EncodedSource = class {
  constructor(text, { lazy = false, maxBytes = 1024 * 1024 * 1024 } = {}) {
    if (typeof text !== "string") throw Error("Expected .casadi file text");
    this.text = text.trim();
    this.byteLength = this.text.length / 2;
    this.decodedBytes = 0;
    if (!Number.isSafeInteger(this.byteLength) || this.byteLength > maxBytes)
      throw Error("Invalid .casadi encoding or file too large");
    if (!lazy && /[^a-p]/.test(this.text))
      throw Error("Invalid .casadi encoding");
  }
  byte(offset) {
    if (!Number.isSafeInteger(offset) || offset < 0 || offset >= this.byteLength)
      throw Error("Encoded source offset out of bounds");
    const a = this.text.charCodeAt(2 * offset) - 97, b = this.text.charCodeAt(2 * offset + 1) - 97;
    if (a < 0 || a > 15 || b < 0 || b > 15)
      throw Error("Invalid .casadi encoding at byte " + offset);
    this.decodedBytes++;
    return a | b << 4;
  }
  read(offset, length) {
    if (!Number.isSafeInteger(length) || length < 0 || offset < 0 || offset + length > this.byteLength)
      throw Error("Encoded source range out of bounds");
    return Uint8Array.from({ length }, (_, i) => this.byte(offset + i));
  }
  view(offset, length) {
    return new DataView(this.read(offset, length).buffer);
  }
};
var _source;
var LazyBlob = class {
  constructor(source, offset, byteLength) {
    __privateAdd(this, _source);
    __privateSet(this, _source, source);
    this.offset = offset;
    this.byteLength = byteLength;
  }
  read(offset = 0, length = this.byteLength - offset) {
    if (!Number.isSafeInteger(offset) || !Number.isSafeInteger(length) || offset < 0 || length < 0 || offset + length > this.byteLength)
      throw Error("Blob slice out of bounds");
    return __privateGet(this, _source).read(this.offset + offset, length);
  }
  toJSON() {
    return {
      kind: "deferred_bytes",
      offset: this.offset,
      byteLength: this.byteLength,
      encoding: "casadi-nibbles"
    };
  }
};
_source = new WeakMap();
var _file;
var LazyFileBlob = class {
  constructor(file, offset, byteLength) {
    __privateAdd(this, _file);
    __privateSet(this, _file, file);
    this.offset = offset;
    this.byteLength = byteLength;
  }
  async read(offset = 0, length = this.byteLength - offset) {
    if (!Number.isSafeInteger(offset) || !Number.isSafeInteger(length) || offset < 0 || length < 0 || offset + length > this.byteLength)
      throw Error("Blob slice out of bounds");
    const text = await __privateGet(this, _file).slice(2 * (this.offset + offset), 2 * (this.offset + offset + length)).text();
    return new EncodedSource(text).read(0, length);
  }
  toJSON() {
    return {
      kind: "deferred_file_bytes",
      offset: this.offset,
      byteLength: this.byteLength,
      encoding: "casadi-nibbles"
    };
  }
};
_file = new WeakMap();
var MissingPage = class extends Error {
  constructor(index) {
    super("Encoded page not loaded");
    this.index = index;
  }
};
var PagedSource = class {
  constructor(size, { maxBytes = 1024 * 1024 * 1024 } = {}) {
    if (!Number.isSafeInteger(size) || size % 2 || size / 2 > maxBytes)
      throw Error("Invalid encoded file size");
    this.byteLength = size / 2;
    this.pageBytes = 16384;
    this.pages = /* @__PURE__ */ new Map();
  }
  byte(offset) {
    if (!Number.isSafeInteger(offset) || offset < 0 || offset >= this.byteLength)
      throw Error("Source offset out of bounds");
    const index = Math.floor(offset / this.pageBytes), page = this.pages.get(index);
    if (!page) throw new MissingPage(index);
    return page.byte(offset - index * this.pageBytes);
  }
  read(offset, length) {
    return Uint8Array.from({ length }, (_, i) => this.byte(offset + i));
  }
  view(offset, length) {
    return new DataView(this.read(offset, length).buffer);
  }
};

// src/index.js
var Reader = class {
  constructor(text, options) {
    this.scheme = metadata;
    if (options.scheme)
      throw Error("Generate a reader for a custom scheme before decoding");
    this.source = new EncodedSource(text, options);
    this.pos = 0;
    this.objects = [];
    this.shared = [];
    this.debug = false;
    this.lazy = !!options.lazy;
    this.depth = 0;
    this.maxItems = options.maxItems ?? 1e6;
    this.lazyThreshold = options.lazyThreshold ?? 65536;
  }
  fail(message) {
    throw Error(`.casadi byte ${this.pos}: ${message}`);
  }
  take(n) {
    if (!Number.isSafeInteger(n) || n < 0 || n > this.source.byteLength - this.pos)
      this.fail("Truncated or excessive payload");
    const p = this.pos;
    this.pos += n;
    return p;
  }
  count(n) {
    if (!Number.isSafeInteger(n) || n < 0 || n > this.maxItems)
      this.fail("Invalid or excessive collection size");
    return n;
  }
  byte() {
    return this.source.byte(this.take(1));
  }
  decoration(tag) {
    if (this.debug && this.byte() !== tag.charCodeAt(0))
      this.fail("Expected wire decoration " + tag);
  }
  name(name) {
    if (this.debug && this.string() !== name)
      this.fail("Expected serialized field " + name);
  }
  number(type) {
    this.decoration(
      { int: "i", unsignedint: "u", casadi_int: "J", size_t: "K", double: "d" }[type]
    );
    const sizes = {
      int: 4,
      unsignedint: 4,
      casadi_int: 8,
      size_t: 8,
      double: 8
    };
    const n = sizes[type], view = this.source.view(this.take(n), n);
    if (type === "double") {
      const value2 = view.getFloat64(0, true);
      return Number.isFinite(value2) ? value2 : { $float: String(value2) };
    }
    if (type === "int") return view.getInt32(0, true);
    if (type === "unsignedint") return view.getUint32(0, true);
    const value = type === "size_t" ? view.getBigUint64(0, true) : view.getBigInt64(0, true);
    return value > BigInt(Number.MAX_SAFE_INTEGER) || value < BigInt(Number.MIN_SAFE_INTEGER) ? { $integer: String(value) } : Number(value);
  }
  string() {
    this.decoration("s");
    const n = this.number("int"), offset = this.take(n);
    if (this.lazy && n >= this.lazyThreshold)
      return new LazyBlob(this.source, offset, n);
    const bytes = this.source.read(offset, n);
    try {
      return new TextDecoder("utf8", { fatal: true }).decode(bytes);
    } catch {
      return this.lazy ? new LazyBlob(this.source, offset, n) : { $bytes: Array.from(bytes) };
    }
  }
  enterLayout() {
    if (++this.depth > 256) this.fail("Layout nesting limit exceeded");
  }
  field(record, name, type, read) {
    this.name(name);
    const value = read();
    record.fields.push({ name, type, value });
    this.count(record.fields.length);
    return value;
  }
  version(record, base, expected) {
    const value = this.field(
      record,
      base + "::serialization::version",
      "int",
      () => this.number("int")
    );
    if (value !== expected) this.fail(`Unsupported ${base} version ${value}`);
  }
  value(type) {
    return Object.hasOwn(readers, type) ? readers[type](this) : this.primitive(type);
  }
  primitive(cppType) {
    const type = cppType;
    if (["int", "unsignedint", "casadi_int", "size_t", "double"].includes(type))
      return this.number(type);
    if (type === "char") return this.byte();
    if (type === "bool") return this.boolean();
    if (type === "std::string") return this.string();
    if (type === "std::istream" || type === "std::stringstream")
      return this.stream();
    this.fail("Unknown serialization type: " + type);
  }
  boolean() {
    this.decoration("b");
    const b = this.byte();
    if (b > 1) this.fail("Invalid boolean");
    return !!b;
  }
  stream() {
    this.decoration("B");
    const n = this.number("size_t"), offset = this.take(n);
    return this.lazy ? new LazyBlob(this.source, offset, n) : { $bytes: Array.from(this.source.read(offset, n)) };
  }
  object(type, decoration, shared, read) {
    if (decoration) this.decoration(decoration);
    if (shared) {
      this.name("Shared::flag");
      const flag = this.byte();
      if (flag === 114) {
        this.name("Shared::reference");
        const id2 = this.number("casadi_int");
        if (!Number.isSafeInteger(id2) || id2 < 0 || id2 >= this.shared.length)
          this.fail("Invalid shared reference");
        return { $ref: this.shared[id2] };
      }
      if (flag !== 100) this.fail("Invalid shared definition");
    }
    const record = { type, fields: [], layouts: [] };
    read(this, record, /* @__PURE__ */ Object.create(null));
    if (!shared) return record;
    this.count(this.objects.length + 1);
    const id = this.objects.length;
    this.objects.push(record);
    this.shared.push(id);
    return { $ref: id };
  }
  decode(options) {
    if (this.number("casadi_int") !== this.scheme.wire.magic)
      this.fail("Invalid serialization magic");
    if (this.number("casadi_int") !== this.scheme.wire.protocol)
      this.fail("Unsupported serialization protocol");
    const debug = this.byte();
    if (debug > 1) this.fail("Invalid debug flag");
    this.debug = !!debug;
    const roots = [];
    if (options.type) roots.push(this.value(options.type));
    else
      while (this.pos < this.source.byteLength) {
        const tag = this.byte(), type = this.scheme.reader.file_types?.[tag];
        if (!type) this.fail("Unsupported serialized file type " + tag);
        const prefix = this.scheme.reader.file_prefixes?.[tag];
        if (prefix) this.value(prefix);
        roots.push(this.value(type));
      }
    if (this.pos !== this.source.byteLength)
      this.fail("Trailing serialization data");
    return {
      format: "casadi_serialization",
      version: 1,
      serializationProtocol: this.scheme.wire.protocol,
      root: roots.length === 1 && Object.hasOwn(roots[0], "$ref") ? roots[0].$ref : null,
      roots,
      objects: this.objects
    };
  }
};
function decode(text, options = {}) {
  return new Reader(text, options).decode(options);
}
async function open(file, options = {}) {
  if (!options.lazy) return decode(await file.text(), options);
  const source = new PagedSource(file.size, options);
  for (; ; ) {
    const reader = new Reader("", options);
    reader.source = source;
    try {
      const document = reader.decode(options);
      const convert = (value) => {
        if (value instanceof LazyBlob)
          return new LazyFileBlob(file, value.offset, value.byteLength);
        if (Array.isArray(value)) return value.map(convert);
        if (value && typeof value === "object")
          for (const key of Object.keys(value))
            value[key] = convert(value[key]);
        return value;
      };
      return convert(document);
    } catch (error) {
      if (!(error instanceof MissingPage)) throw error;
      const start = error.index * source.pageBytes * 2;
      const text = await file.slice(start, Math.min(file.size, start + source.pageBytes * 2)).text();
      if (text.length % 2 || /[^a-p]/.test(text))
        throw Error("Invalid .casadi encoding in file page");
      source.pages.set(error.index, new EncodedSource(text, { lazy: true }));
    }
  }
}
var decodeCasadi = decode;
export {
  LazyBlob,
  decode,
  decodeCasadi,
  open
};
