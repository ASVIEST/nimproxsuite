type
  proxsuite_c_context* {.incompleteStruct.} = object
  enum_proxsuite_c_error_code* {.pure, size:sizeof(cint).} = enum
    PROXSUITE_C_OK = 0,
    PROXSUITE_C_BAD_ALLOC = 1,
    PROXSUITE_C_INVALID_ARG = 2,
    PROXSUITE_C_EXCEPTION = 3,
    PROXSUITE_C_UNKNOWN_ERROR = 4
  proxsuite_c_error_code* = enum_proxsuite_c_error_code
  proxsuite_c_error_handler* = proc (a0 :ptr proxsuite_c_context; a1 :proxsuite_c_error_code; a2 :cstring; a3 :pointer) {.cdecl.}
  proxsuite_c_dense_matrix_double* {.bycopy.} = object
    data* :ptr cdouble
    rows* :int64
    cols* :int64
  proxsuite_c_dense_vector_double* {.bycopy.} = object
    data* :ptr cdouble
    size* :int64
  proxsuite_c_sparse_matrix_double_int* {.bycopy.} = object
    rows* :int64
    cols* :int64
    nnz* :int64
    outer_indices* :ptr cint
    inner_indices* :ptr cint
    values* :ptr cdouble
  proxsuite_c_sparse_matrix_bool_int* {.bycopy.} = object
    rows* :int64
    cols* :int64
    nnz* :int64
    outer_indices* :ptr cint
    inner_indices* :ptr cint
    values* :ptr bool
  enum_proxsuite_c_dense_backend* {.pure, size:sizeof(cint).} = enum
    PROXSUITE_C_DENSE_BACKEND_AUTOMATIC = 0,
    PROXSUITE_C_DENSE_BACKEND_PRIMAL_DUAL_LDLT = 1,
    PROXSUITE_C_DENSE_BACKEND_PRIMAL_LDLT = 2
  proxsuite_c_dense_backend* = enum_proxsuite_c_dense_backend
  enum_proxsuite_c_eigen_value_estimate_method_option* {.pure, size:sizeof(cint).} = enum
    PROXSUITE_C_EIGEN_VALUE_ESTIMATE_METHOD_OPTION_POWER_ITERATION = 0,
    PROXSUITE_C_EIGEN_VALUE_ESTIMATE_METHOD_OPTION_EXACT_METHOD = 1
  proxsuite_c_eigen_value_estimate_method_option* = enum_proxsuite_c_eigen_value_estimate_method_option
  enum_proxsuite_c_hessian_type* {.pure, size:sizeof(cint).} = enum
    PROXSUITE_C_HESSIAN_TYPE_ZERO = 0,
    PROXSUITE_C_HESSIAN_TYPE_DENSE = 1,
    PROXSUITE_C_HESSIAN_TYPE_DIAGONAL = 2
  proxsuite_c_hessian_type* = enum_proxsuite_c_hessian_type
  enum_proxsuite_c_initial_guess_status* {.pure, size:sizeof(cint).} = enum
    PROXSUITE_C_INITIAL_GUESS_STATUS_NO_INITIAL_GUESS = 0,
    PROXSUITE_C_INITIAL_GUESS_STATUS_EQUALITY_CONSTRAINED_INITIAL_GUESS = 1,
    PROXSUITE_C_INITIAL_GUESS_STATUS_WARM_START_WITH_PREVIOUS_RESULT = 2,
    PROXSUITE_C_INITIAL_GUESS_STATUS_WARM_START = 3,
    PROXSUITE_C_INITIAL_GUESS_STATUS_COLD_START_WITH_PREVIOUS_RESULT = 4
  proxsuite_c_initial_guess_status* = enum_proxsuite_c_initial_guess_status
  enum_proxsuite_c_merit_function_type* {.pure, size:sizeof(cint).} = enum
    PROXSUITE_C_MERIT_FUNCTION_TYPE_GPDAL = 0,
    PROXSUITE_C_MERIT_FUNCTION_TYPE_PDAL = 1
  proxsuite_c_merit_function_type* = enum_proxsuite_c_merit_function_type
  enum_proxsuite_c_qp_solver_output* {.pure, size:sizeof(cint).} = enum
    PROXSUITE_C_QP_SOLVER_OUTPUT_PROXQP_SOLVED = 0,
    PROXSUITE_C_QP_SOLVER_OUTPUT_PROXQP_MAX_ITER_REACHED = 1,
    PROXSUITE_C_QP_SOLVER_OUTPUT_PROXQP_PRIMAL_INFEASIBLE = 2,
    PROXSUITE_C_QP_SOLVER_OUTPUT_PROXQP_SOLVED_CLOSEST_PRIMAL_FEASIBLE = 3,
    PROXSUITE_C_QP_SOLVER_OUTPUT_PROXQP_DUAL_INFEASIBLE = 4,
    PROXSUITE_C_QP_SOLVER_OUTPUT_PROXQP_NOT_RUN = 5
  proxsuite_c_qp_solver_output* = enum_proxsuite_c_qp_solver_output
  enum_proxsuite_c_sparse_backend* {.pure, size:sizeof(cint).} = enum
    PROXSUITE_C_SPARSE_BACKEND_AUTOMATIC = 0,
    PROXSUITE_C_SPARSE_BACKEND_SPARSE_CHOLESKY = 1,
    PROXSUITE_C_SPARSE_BACKEND_MATRIX_FREE = 2
  proxsuite_c_sparse_backend* = enum_proxsuite_c_sparse_backend
  proxsuite_c_backward_data_double* {.incompleteStruct.} = object
  proxsuite_c_dense_batch_qp_double* {.incompleteStruct.} = object
  proxsuite_c_dense_qp_double* {.incompleteStruct.} = object
  proxsuite_c_info_double* {.incompleteStruct.} = object
  proxsuite_c_proxqp_dense_model_double* {.incompleteStruct.} = object
  proxsuite_c_proxqp_dense_workspace_double* {.incompleteStruct.} = object
  proxsuite_c_proxqp_sparse_model_double_int* {.incompleteStruct.} = object
  proxsuite_c_results_double* {.incompleteStruct.} = object
  proxsuite_c_settings_double* {.incompleteStruct.} = object
  proxsuite_c_sparse_batch_qp_double_int* {.incompleteStruct.} = object
  proxsuite_c_sparse_qp_double_int* {.incompleteStruct.} = object

when defined(macosx):
  {.error: "nimproxsuite does not support macOS yet".}

const cproxsuiteLib* {.strdefine.} =
  when defined(windows):
    "cproxsuite.dll"
  else:
    "libcproxsuite.so"

when defined(feature.nimproxsuite.linkStatic):
  const cproxsuiteStaticLib* {.strdefine: "nimproxsuite.staticLib".} = "libcproxsuite.a"

  {.passL: cproxsuiteStaticLib.}
  when defined(windows):
    # UCRT automaticly links math
    {.passL: "-lc++".}
  elif defined(linux):
    {.passL: "-lc++".}
    {.passL: "-lm".}

proc proxsuite_c_context_create*() :ptr proxsuite_c_context {.importc:"proxsuite_c_context_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_context_destroy*(ctx :ptr proxsuite_c_context) {.importc:"proxsuite_c_context_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_context_set_error_handler*(ctx :ptr proxsuite_c_context; handler :proxsuite_c_error_handler; userdata :pointer) {.importc:"proxsuite_c_context_set_error_handler", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_context_get_error_code*(ctx :ptr proxsuite_c_context) :proxsuite_c_error_code {.importc:"proxsuite_c_context_get_error_code", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_context_get_error_msg*(ctx :ptr proxsuite_c_context) :cstring {.importc:"proxsuite_c_context_get_error_msg", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_string_free*(value :cstring) {.importc:"proxsuite_c_string_free", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double) {.importc:"proxsuite_c_backward_data_double_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_create*(ctx :ptr proxsuite_c_context) :ptr proxsuite_c_backward_data_double {.importc:"proxsuite_c_backward_data_double_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_get_d_l_d_h*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_backward_data_double_get_d_l_d_h", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_get_d_l_dg*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_backward_data_double_get_d_l_dg", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_get_d_l_d_a*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_backward_data_double_get_d_l_d_a", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_get_d_l_db*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_backward_data_double_get_d_l_db", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_get_d_l_d_c*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_backward_data_double_get_d_l_d_c", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_get_d_l_du*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_backward_data_double_get_d_l_du", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_get_d_l_dl*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_backward_data_double_get_d_l_dl", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_backward_data_double_initialize*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_backward_data_double; n :int64; n_eq :int64; n_in :int64) {.importc:"proxsuite_c_backward_data_double_initialize", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_batch_qp_double_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_batch_qp_double) {.importc:"proxsuite_c_dense_batch_qp_double_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_batch_qp_double_create*(ctx :ptr proxsuite_c_context; batch_size :int64) :ptr proxsuite_c_dense_batch_qp_double {.importc:"proxsuite_c_dense_batch_qp_double_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_batch_qp_double_init_qp_in_place*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_batch_qp_double; dim :int64; n_eq :int64; n_in :int64) :ptr proxsuite_c_dense_qp_double {.importc:"proxsuite_c_dense_batch_qp_double_init_qp_in_place", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_batch_qp_double_insert*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_batch_qp_double; qp :ptr proxsuite_c_dense_qp_double) {.importc:"proxsuite_c_dense_batch_qp_double_insert", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_batch_qp_double_size*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_batch_qp_double) :int64 {.importc:"proxsuite_c_dense_batch_qp_double_size", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_batch_qp_double_get*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_batch_qp_double; i :int64) :ptr proxsuite_c_dense_qp_double {.importc:"proxsuite_c_dense_batch_qp_double_get", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) {.importc:"proxsuite_c_dense_qp_double_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_create*(ctx :ptr proxsuite_c_context; n :int64; n_eq :int64; n_in :int64; box_constraints :bool; hessian_type :proxsuite_c_hessian_type; dense_backend :proxsuite_c_dense_backend) :ptr proxsuite_c_dense_qp_double {.importc:"proxsuite_c_dense_qp_double_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_get_results*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) :ptr proxsuite_c_results_double {.importc:"proxsuite_c_dense_qp_double_get_results", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_get_settings*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) :ptr proxsuite_c_settings_double {.importc:"proxsuite_c_dense_qp_double_get_settings", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_get_model*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) :ptr proxsuite_c_proxqp_dense_model_double {.importc:"proxsuite_c_dense_qp_double_get_model", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_is_box_constrained*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) :bool {.importc:"proxsuite_c_dense_qp_double_is_box_constrained", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_which_hessian_type*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) :proxsuite_c_hessian_type {.importc:"proxsuite_c_dense_qp_double_which_hessian_type", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_which_dense_backend*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) :proxsuite_c_dense_backend {.importc:"proxsuite_c_dense_qp_double_which_dense_backend", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_init*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double; h :ptr proxsuite_c_dense_matrix_double; g :ptr proxsuite_c_dense_vector_double; a :ptr proxsuite_c_dense_matrix_double; b :ptr proxsuite_c_dense_vector_double; c :ptr proxsuite_c_dense_matrix_double; l :ptr proxsuite_c_dense_vector_double; u :ptr proxsuite_c_dense_vector_double; compute_preconditioner :bool; rho :ptr cdouble; mu_eq :ptr cdouble; mu_in :ptr cdouble; manual_minimal_h_eigenvalue :ptr cdouble) {.importc:"proxsuite_c_dense_qp_double_init", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_init_2*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double; h :ptr proxsuite_c_dense_matrix_double; g :ptr proxsuite_c_dense_vector_double; a :ptr proxsuite_c_dense_matrix_double; b :ptr proxsuite_c_dense_vector_double; c :ptr proxsuite_c_dense_matrix_double; l :ptr proxsuite_c_dense_vector_double; u :ptr proxsuite_c_dense_vector_double; l_box :ptr proxsuite_c_dense_vector_double; u_box :ptr proxsuite_c_dense_vector_double; compute_preconditioner :bool; rho :ptr cdouble; mu_eq :ptr cdouble; mu_in :ptr cdouble; manual_minimal_h_eigenvalue :ptr cdouble) {.importc:"proxsuite_c_dense_qp_double_init_2", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_solve*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) {.importc:"proxsuite_c_dense_qp_double_solve", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_solve_2*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double; x :ptr proxsuite_c_dense_vector_double; y :ptr proxsuite_c_dense_vector_double; z :ptr proxsuite_c_dense_vector_double) {.importc:"proxsuite_c_dense_qp_double_solve_2", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_update*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double; h :ptr proxsuite_c_dense_matrix_double; g :ptr proxsuite_c_dense_vector_double; a :ptr proxsuite_c_dense_matrix_double; b :ptr proxsuite_c_dense_vector_double; c :ptr proxsuite_c_dense_matrix_double; l :ptr proxsuite_c_dense_vector_double; u :ptr proxsuite_c_dense_vector_double; update_preconditioner :bool; rho :ptr cdouble; mu_eq :ptr cdouble; mu_in :ptr cdouble; manual_minimal_h_eigenvalue :ptr cdouble) {.importc:"proxsuite_c_dense_qp_double_update", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_update_2*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double; h :ptr proxsuite_c_dense_matrix_double; g :ptr proxsuite_c_dense_vector_double; a :ptr proxsuite_c_dense_matrix_double; b :ptr proxsuite_c_dense_vector_double; c :ptr proxsuite_c_dense_matrix_double; l :ptr proxsuite_c_dense_vector_double; u :ptr proxsuite_c_dense_vector_double; l_box :ptr proxsuite_c_dense_vector_double; u_box :ptr proxsuite_c_dense_vector_double; update_preconditioner :bool; rho :ptr cdouble; mu_eq :ptr cdouble; mu_in :ptr cdouble; manual_minimal_h_eigenvalue :ptr cdouble) {.importc:"proxsuite_c_dense_qp_double_update_2", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_dense_qp_double_cleanup*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_dense_qp_double) {.importc:"proxsuite_c_dense_qp_double_cleanup", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) {.importc:"proxsuite_c_info_double_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_create*(ctx :ptr proxsuite_c_context) :ptr proxsuite_c_info_double {.importc:"proxsuite_c_info_double_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_mu_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_mu_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_mu_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_mu_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_mu_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_mu_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_mu_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_mu_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_rho*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_rho", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_rho*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_rho", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_iter*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :int64 {.importc:"proxsuite_c_info_double_get_iter", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_iter*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :int64) {.importc:"proxsuite_c_info_double_set_iter", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_iter_ext*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :int64 {.importc:"proxsuite_c_info_double_get_iter_ext", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_iter_ext*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :int64) {.importc:"proxsuite_c_info_double_set_iter_ext", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_run_time*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_run_time", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_run_time*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_run_time", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_setup_time*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_setup_time", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_setup_time*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_setup_time", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_solve_time*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_solve_time", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_solve_time*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_solve_time", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_duality_gap*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_duality_gap", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_duality_gap*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_duality_gap", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_pri_res*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_pri_res", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_pri_res*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_pri_res", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_dua_res*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_dua_res", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_dua_res*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_dua_res", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_iterative_residual*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_iterative_residual", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_iterative_residual*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_iterative_residual", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_obj_value*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_obj_value", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_obj_value*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_obj_value", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_status*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :proxsuite_c_qp_solver_output {.importc:"proxsuite_c_info_double_get_status", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_status*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :proxsuite_c_qp_solver_output) {.importc:"proxsuite_c_info_double_set_status", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_rho_updates*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :int64 {.importc:"proxsuite_c_info_double_get_rho_updates", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_rho_updates*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :int64) {.importc:"proxsuite_c_info_double_set_rho_updates", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_mu_updates*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :int64 {.importc:"proxsuite_c_info_double_get_mu_updates", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_mu_updates*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :int64) {.importc:"proxsuite_c_info_double_set_mu_updates", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_sparse_backend*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :proxsuite_c_sparse_backend {.importc:"proxsuite_c_info_double_get_sparse_backend", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_sparse_backend*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :proxsuite_c_sparse_backend) {.importc:"proxsuite_c_info_double_set_sparse_backend", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_get_minimal_h_eigenvalue_estimate*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double) :cdouble {.importc:"proxsuite_c_info_double_get_minimal_h_eigenvalue_estimate", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_info_double_set_minimal_h_eigenvalue_estimate*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_info_double; value :cdouble) {.importc:"proxsuite_c_info_double_set_minimal_h_eigenvalue_estimate", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) {.importc:"proxsuite_c_proxqp_dense_model_double_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_create*(ctx :ptr proxsuite_c_context; n :int64; n_eq :int64; n_in :int64) :ptr proxsuite_c_proxqp_dense_model_double {.importc:"proxsuite_c_proxqp_dense_model_double_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_h*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_proxqp_dense_model_double_get_h", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_g*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_model_double_get_g", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_a*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_proxqp_dense_model_double_get_a", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_b*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_model_double_get_b", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_c*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_proxqp_dense_model_double_get_c", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_l*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_model_double_get_l", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_u*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_model_double_get_u", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_dim*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :int64 {.importc:"proxsuite_c_proxqp_dense_model_double_get_dim", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_n_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :int64 {.importc:"proxsuite_c_proxqp_dense_model_double_get_n_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_n_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :int64 {.importc:"proxsuite_c_proxqp_dense_model_double_get_n_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_n_total*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :int64 {.importc:"proxsuite_c_proxqp_dense_model_double_get_n_total", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_get_backward_data*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double) :ptr proxsuite_c_backward_data_double {.importc:"proxsuite_c_proxqp_dense_model_double_get_backward_data", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_model_double_is_valid*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_model_double; box_constraints :bool) :bool {.importc:"proxsuite_c_proxqp_dense_model_double_is_valid", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) {.importc:"proxsuite_c_proxqp_dense_workspace_double_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_create*(ctx :ptr proxsuite_c_context; n :int64; n_eq :int64; n_in :int64) :ptr proxsuite_c_proxqp_dense_workspace_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_h_scaled*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_h_scaled", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_g_scaled*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_g_scaled", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_a_scaled*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_a_scaled", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_c_scaled*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_c_scaled", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_b_scaled*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_b_scaled", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_u_scaled*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_u_scaled", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_l_scaled*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_l_scaled", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_x_prev*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_x_prev", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_y_prev*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_y_prev", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_z_prev*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_z_prev", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_kkt*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_matrix_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_kkt", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_current_bijection_map_ptr*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :pointer {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_current_bijection_map_ptr", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_new_bijection_map_ptr*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :pointer {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_new_bijection_map_ptr", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_active_set_up_ptr*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :pointer {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_active_set_up_ptr", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_active_set_low_ptr*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :pointer {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_active_set_low_ptr", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_active_inequalities_ptr*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :pointer {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_active_inequalities_ptr", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_hdx*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_hdx", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_cdx*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_cdx", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_adx*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_adx", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_active_part_z*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_active_part_z", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_alphas_ptr*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :pointer {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_alphas_ptr", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_dw_aug*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_dw_aug", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_rhs*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_rhs", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_err*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_err", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_dual_feasibility_rhs_2*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :cdouble {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_dual_feasibility_rhs_2", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_correction_guess_rhs_g*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :cdouble {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_correction_guess_rhs_g", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_correction_guess_rhs_b*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :cdouble {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_correction_guess_rhs_b", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_alpha*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :cdouble {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_alpha", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_dual_residual_scaled*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_dual_residual_scaled", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_primal_residual_in_scaled_up*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_primal_residual_in_scaled_up", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_primal_residual_in_scaled_up_plus_alpha_cdx*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_primal_residual_in_scaled_up_plus_alpha_cdx", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_primal_residual_in_scaled_low_plus_alpha_cdx*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_primal_residual_in_scaled_low_plus_alpha_cdx", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_c_tz*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_c_tz", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_constraints_changed*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :bool {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_constraints_changed", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_dirty*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :bool {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_dirty", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_refactorize*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :bool {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_refactorize", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_proximal_parameter_update*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :bool {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_proximal_parameter_update", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_is_initialized*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :bool {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_is_initialized", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_dense_workspace_double_get_n_c*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_dense_workspace_double) :int64 {.importc:"proxsuite_c_proxqp_dense_workspace_double_get_n_c", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) {.importc:"proxsuite_c_proxqp_sparse_model_double_int_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_create*(ctx :ptr proxsuite_c_context; n :int64; n_eq :int64; n_in :int64) :ptr proxsuite_c_proxqp_sparse_model_double_int {.importc:"proxsuite_c_proxqp_sparse_model_double_int_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_g*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_g", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_b*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_b", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_l*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_l", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_u*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_u", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_dim*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :int64 {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_dim", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_n_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :int64 {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_n_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_n_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :int64 {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_n_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_h_nnz*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :int64 {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_h_nnz", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_a_nnz*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :int64 {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_a_nnz", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_proxqp_sparse_model_double_int_get_c_nnz*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_proxqp_sparse_model_double_int) :int64 {.importc:"proxsuite_c_proxqp_sparse_model_double_int_get_c_nnz", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_results_double_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_results_double) {.importc:"proxsuite_c_results_double_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_results_double_create*(ctx :ptr proxsuite_c_context; n :int64; n_eq :int64; n_in :int64) :ptr proxsuite_c_results_double {.importc:"proxsuite_c_results_double_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_results_double_get_x*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_results_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_results_double_get_x", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_results_double_get_y*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_results_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_results_double_get_y", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_results_double_get_z*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_results_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_results_double_get_z", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_results_double_get_se*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_results_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_results_double_get_se", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_results_double_get_si*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_results_double) :proxsuite_c_dense_vector_double {.importc:"proxsuite_c_results_double_get_si", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_results_double_get_info*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_results_double) :ptr proxsuite_c_info_double {.importc:"proxsuite_c_results_double_get_info", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) {.importc:"proxsuite_c_settings_double_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_create*(ctx :ptr proxsuite_c_context) :ptr proxsuite_c_settings_double {.importc:"proxsuite_c_settings_double_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_default_rho*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_default_rho", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_default_rho*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_default_rho", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_default_mu_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_default_mu_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_default_mu_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_default_mu_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_default_mu_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_default_mu_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_default_mu_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_default_mu_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_alpha_bcl*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_alpha_bcl", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_alpha_bcl*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_alpha_bcl", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_beta_bcl*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_beta_bcl", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_beta_bcl*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_beta_bcl", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_refactor_dual_feasibility_threshold*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_refactor_dual_feasibility_threshold", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_refactor_dual_feasibility_threshold*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_refactor_dual_feasibility_threshold", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_refactor_rho_threshold*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_refactor_rho_threshold", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_refactor_rho_threshold*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_refactor_rho_threshold", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_mu_min_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_mu_min_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_mu_min_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_mu_min_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_mu_min_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_mu_min_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_mu_min_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_mu_min_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_mu_max_eq_inv*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_mu_max_eq_inv", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_mu_max_eq_inv*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_mu_max_eq_inv", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_mu_max_in_inv*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_mu_max_in_inv", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_mu_max_in_inv*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_mu_max_in_inv", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_mu_update_factor*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_mu_update_factor", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_mu_update_factor*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_mu_update_factor", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_cold_reset_mu_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_cold_reset_mu_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_cold_reset_mu_eq*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_cold_reset_mu_eq", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_cold_reset_mu_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_cold_reset_mu_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_cold_reset_mu_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_cold_reset_mu_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_max_iter*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :int64 {.importc:"proxsuite_c_settings_double_get_max_iter", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_max_iter*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :int64) {.importc:"proxsuite_c_settings_double_set_max_iter", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_max_iter_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :int64 {.importc:"proxsuite_c_settings_double_get_max_iter_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_max_iter_in*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :int64) {.importc:"proxsuite_c_settings_double_set_max_iter_in", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_eps_abs*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_eps_abs", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_eps_abs*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_eps_abs", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_eps_rel*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_eps_rel", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_eps_rel*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_eps_rel", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_eps_primal_inf*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_eps_primal_inf", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_eps_primal_inf*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_eps_primal_inf", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_eps_dual_inf*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_eps_dual_inf", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_eps_dual_inf*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_eps_dual_inf", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_nb_iterative_refinement*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :int64 {.importc:"proxsuite_c_settings_double_get_nb_iterative_refinement", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_nb_iterative_refinement*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :int64) {.importc:"proxsuite_c_settings_double_set_nb_iterative_refinement", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_initial_guess*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :proxsuite_c_initial_guess_status {.importc:"proxsuite_c_settings_double_get_initial_guess", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_initial_guess*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :proxsuite_c_initial_guess_status) {.importc:"proxsuite_c_settings_double_set_initial_guess", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_sparse_backend*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :proxsuite_c_sparse_backend {.importc:"proxsuite_c_settings_double_get_sparse_backend", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_sparse_backend*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :proxsuite_c_sparse_backend) {.importc:"proxsuite_c_settings_double_set_sparse_backend", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_preconditioner_accuracy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_preconditioner_accuracy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_preconditioner_accuracy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_preconditioner_accuracy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_preconditioner_max_iter*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :int64 {.importc:"proxsuite_c_settings_double_get_preconditioner_max_iter", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_preconditioner_max_iter*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :int64) {.importc:"proxsuite_c_settings_double_set_preconditioner_max_iter", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_compute_timings*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :bool {.importc:"proxsuite_c_settings_double_get_compute_timings", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_compute_timings*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :bool) {.importc:"proxsuite_c_settings_double_set_compute_timings", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_compute_preconditioner*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :bool {.importc:"proxsuite_c_settings_double_get_compute_preconditioner", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_compute_preconditioner*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :bool) {.importc:"proxsuite_c_settings_double_set_compute_preconditioner", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_update_preconditioner*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :bool {.importc:"proxsuite_c_settings_double_get_update_preconditioner", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_update_preconditioner*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :bool) {.importc:"proxsuite_c_settings_double_set_update_preconditioner", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_check_duality_gap*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :bool {.importc:"proxsuite_c_settings_double_get_check_duality_gap", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_check_duality_gap*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :bool) {.importc:"proxsuite_c_settings_double_set_check_duality_gap", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_eps_duality_gap_abs*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_eps_duality_gap_abs", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_eps_duality_gap_abs*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_eps_duality_gap_abs", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_eps_duality_gap_rel*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_eps_duality_gap_rel", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_eps_duality_gap_rel*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_eps_duality_gap_rel", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_verbose*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :bool {.importc:"proxsuite_c_settings_double_get_verbose", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_verbose*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :bool) {.importc:"proxsuite_c_settings_double_set_verbose", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_bcl_update*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :bool {.importc:"proxsuite_c_settings_double_get_bcl_update", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_bcl_update*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :bool) {.importc:"proxsuite_c_settings_double_set_bcl_update", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_merit_function_type*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :proxsuite_c_merit_function_type {.importc:"proxsuite_c_settings_double_get_merit_function_type", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_merit_function_type*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :proxsuite_c_merit_function_type) {.importc:"proxsuite_c_settings_double_set_merit_function_type", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_alpha_gpdal*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_alpha_gpdal", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_alpha_gpdal*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_alpha_gpdal", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_primal_infeasibility_solving*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :bool {.importc:"proxsuite_c_settings_double_get_primal_infeasibility_solving", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_primal_infeasibility_solving*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :bool) {.importc:"proxsuite_c_settings_double_set_primal_infeasibility_solving", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_frequence_infeasibility_check*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :int64 {.importc:"proxsuite_c_settings_double_get_frequence_infeasibility_check", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_frequence_infeasibility_check*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :int64) {.importc:"proxsuite_c_settings_double_set_frequence_infeasibility_check", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_get_default_h_eigenvalue_estimate*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double) :cdouble {.importc:"proxsuite_c_settings_double_get_default_h_eigenvalue_estimate", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_settings_double_set_default_h_eigenvalue_estimate*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_settings_double; value :cdouble) {.importc:"proxsuite_c_settings_double_set_default_h_eigenvalue_estimate", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_batch_qp_double_int_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_batch_qp_double_int) {.importc:"proxsuite_c_sparse_batch_qp_double_int_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_batch_qp_double_int_create*(ctx :ptr proxsuite_c_context; batch_size :culong) :ptr proxsuite_c_sparse_batch_qp_double_int {.importc:"proxsuite_c_sparse_batch_qp_double_int_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_batch_qp_double_int_init_qp_in_place*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_batch_qp_double_int; dim :int64; n_eq :int64; n_in :int64) :ptr proxsuite_c_sparse_qp_double_int {.importc:"proxsuite_c_sparse_batch_qp_double_int_init_qp_in_place", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_batch_qp_double_int_size*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_batch_qp_double_int) :int64 {.importc:"proxsuite_c_sparse_batch_qp_double_int_size", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_batch_qp_double_int_get*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_batch_qp_double_int; i :int64) :ptr proxsuite_c_sparse_qp_double_int {.importc:"proxsuite_c_sparse_batch_qp_double_int_get", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_destroy*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int) {.importc:"proxsuite_c_sparse_qp_double_int_destroy", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_create*(ctx :ptr proxsuite_c_context; n :int64; n_eq :int64; n_in :int64) :ptr proxsuite_c_sparse_qp_double_int {.importc:"proxsuite_c_sparse_qp_double_int_create", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_create_1*(ctx :ptr proxsuite_c_context; h_mask :ptr proxsuite_c_sparse_matrix_bool_int; a_mask :ptr proxsuite_c_sparse_matrix_bool_int; c_mask :ptr proxsuite_c_sparse_matrix_bool_int) :ptr proxsuite_c_sparse_qp_double_int {.importc:"proxsuite_c_sparse_qp_double_int_create_1", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_get_model*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int) :ptr proxsuite_c_proxqp_sparse_model_double_int {.importc:"proxsuite_c_sparse_qp_double_int_get_model", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_get_results*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int) :ptr proxsuite_c_results_double {.importc:"proxsuite_c_sparse_qp_double_int_get_results", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_get_settings*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int) :ptr proxsuite_c_settings_double {.importc:"proxsuite_c_sparse_qp_double_int_get_settings", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_init*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int; h :ptr proxsuite_c_sparse_matrix_double_int; g :ptr proxsuite_c_dense_vector_double; a :ptr proxsuite_c_sparse_matrix_double_int; b :ptr proxsuite_c_dense_vector_double; c :ptr proxsuite_c_sparse_matrix_double_int; l :ptr proxsuite_c_dense_vector_double; u :ptr proxsuite_c_dense_vector_double; compute_preconditioner :bool; rho :ptr cdouble; mu_eq :ptr cdouble; mu_in :ptr cdouble; manual_minimal_h_eigenvalue :ptr cdouble) {.importc:"proxsuite_c_sparse_qp_double_int_init", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_update*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int; h :ptr proxsuite_c_sparse_matrix_double_int; g :ptr proxsuite_c_dense_vector_double; a :ptr proxsuite_c_sparse_matrix_double_int; b :ptr proxsuite_c_dense_vector_double; c :ptr proxsuite_c_sparse_matrix_double_int; l :ptr proxsuite_c_dense_vector_double; u :ptr proxsuite_c_dense_vector_double; update_preconditioner :bool; rho :ptr cdouble; mu_eq :ptr cdouble; mu_in :ptr cdouble; manual_minimal_h_eigenvalue :ptr cdouble) {.importc:"proxsuite_c_sparse_qp_double_int_update", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_solve*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int) {.importc:"proxsuite_c_sparse_qp_double_int_solve", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_solve_2*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int; x :ptr proxsuite_c_dense_vector_double; y :ptr proxsuite_c_dense_vector_double; z :ptr proxsuite_c_dense_vector_double) {.importc:"proxsuite_c_sparse_qp_double_int_solve_2", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_sparse_qp_double_int_cleanup*(ctx :ptr proxsuite_c_context; self :ptr proxsuite_c_sparse_qp_double_int) {.importc:"proxsuite_c_sparse_qp_double_int_cleanup", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_module_estimate_minimal_eigen_value_of_symmetric_matrix*(ctx :ptr proxsuite_c_context; h :ptr proxsuite_c_dense_matrix_double; estimate_method_option :proxsuite_c_eigen_value_estimate_method_option; power_iteration_accuracy :cdouble; nb_power_iteration :int64) :cdouble {.importc:"proxsuite_c_module_estimate_minimal_eigen_value_of_symmetric_matrix", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_module_estimate_minimal_eigen_value_of_symmetric_matrix_2*(ctx :ptr proxsuite_c_context; h :ptr proxsuite_c_sparse_matrix_double_int; power_iteration_accuracy :cdouble; nb_power_iteration :int64) :cdouble {.importc:"proxsuite_c_module_estimate_minimal_eigen_value_of_symmetric_matrix_2", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_module_print_version*(ctx :ptr proxsuite_c_context; delimiter :cstring) :cstring {.importc:"proxsuite_c_module_print_version", cdecl, dynlib:cproxsuiteLib.}
proc proxsuite_c_module_check_version_at_least*(ctx :ptr proxsuite_c_context; major_version :int32; minor_version :int32; patch_version :int32) :bool {.importc:"proxsuite_c_module_check_version_at_least", cdecl, dynlib:cproxsuiteLib.}
