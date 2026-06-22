# compat-legacy-aliases.R
# Auto-generated wrappers for backwards compatibility (legacy function names).
#
# This file intentionally contains NO roxygen2 comments (no lines starting with #').
# That prevents devtools::document()/roxygen2 from generating separate .Rd pages for legacy aliases.
#
# Do not edit by hand - edit tools/rename_map.csv then rerun tools/04_generate_aliases.R

# Legacy alias for AB_CIVARTest()
AB_CIVARTest <- function(...) {
  .Deprecated(new = "ab_civar_test")
  ab_civar_test(...)
}

# Legacy alias for ABC_MRCIVARestm()
ABC_MRCIVARestm <- function(...) {
  .Deprecated(new = "abc_mrciva_test")
  abc_mrcivar_test(...)
}

# Legacy alias for abLRtest2()
abLRtest2 <- function(...) {
  .Deprecated(new = "ab_l_rtest2")
  ab_l_rtest2(...)
}

# Legacy alias for ABSVAR()
ABSVAR <- function(...) {
  .Deprecated(new = "absvar")
  absvar(...)
}

# Legacy alias for ACCIRFconfR()
ACCIRFconfR <- function(...) {
  .Deprecated(new = "accirf_conf_r")
  accirf_conf_r(...)
}

# Legacy alias for B2CIB()
B2CIB <- function(...) {
  .Deprecated(new = "b2_cib")
  b2_cib(...)
}

# Legacy alias for Bo2Ao()
Bo2Ao <- function(...) {
  .Deprecated(new = "bo2_ao")
  bo2_ao(...)
}

# Legacy alias for BoAo2TBoAo()
BoAo2TBoAo <- function(...) {
  .Deprecated(new = "bo_ao2_t_bo_ao")
  bo_ao2_t_bo_ao(...)
}

# Legacy alias for BoAoW2G()
BoAoW2G <- function(...) {
  .Deprecated(new = "bo_ao_w2_g")
  bo_ao_w2_g(...)
}

# Legacy alias for BoAoWs2Gs()
BoAoWs2Gs <- function(...) {
  .Deprecated(new = "bo_ao_ws2_gs")
  bo_ao_ws2_gs(...)
}

# Legacy alias for CCIVARData()
CCIVARData <- function(...) {
  .Deprecated(new = "ccivar_data")
  ccivar_data(...)
}

# Legacy alias for CCIVARest()
CCIVARest <- function(...) {
  .Deprecated(new = "ccivar_estimate")
  ccivar_estimate(...)
}

# Legacy alias for CIA2A()
CIA2A <- function(...) {
  .Deprecated(new = "cia2_a")
  cia2_a(...)
}

# Legacy alias for CIB2B()
CIB2B <- function(...) {
  .Deprecated(new = "cib2_b")
  cib2_b(...)
}

# Legacy alias for CIB3B()
CIB3B <- function(...) {
  .Deprecated(new = "cib3_b")
  cib3_b(...)
}

# Legacy alias for CIGVAR_Select()
CIGVAR_Select <- function(...) {
  .Deprecated(new = "cigvar_select_")
  cigvar_select_(...)
}

# Legacy alias for CIGVARData()
CIGVARData <- function(...) {
  .Deprecated(new = "cigvar_data")
  cigvar_data(...)
}

# Legacy alias for CIGVARest()
CIGVARest <- function(...) {
  .Deprecated(new = "cigvar_estimate")
  cigvar_estimate(...)
}

# Legacy alias for CIVARData()
CIVARData <- function(...) {
  .Deprecated(new = "civar_data")
  civar_data(...)
}

# Legacy alias for CIVARest()
CIVARest <- function(...) {
  .Deprecated(new = "civar_estimate")
  civar_estimate(...)
}

# Legacy alias for CIVARTest()
CIVARTest <- function(...) {
  .Deprecated(new = "civar_test")
  civar_test(...)
}

# Legacy alias for CVECM2CVAR()
CVECM2CVAR <- function(...) {
  .Deprecated(new = "cvecm2_cvar")
  cvecm2_cvar(...)
}

# Legacy alias for Embed()
Embed <- function(...) {
  .Deprecated(new = "embed_ts")
  embed_ts(...)
}

# Legacy alias for girf_MRCIGVAR_RM()
girf_MRCIGVAR_RM <- function(...) {
  .Deprecated(new = "girf_mrcigvar_rm")
  girf_mrcigvar_rm(...)
}

# Legacy alias for girf_MRCIGVAR_RM_CB()
girf_MRCIGVAR_RM_CB <- function(...) {
  .Deprecated(new = "girf_mrcigvar_rm_cb")
  girf_mrcigvar_rm_cb(...)
}

# Legacy alias for girf_MRCIVAR_RM()
girf_MRCIVAR_RM <- function(...) {
  .Deprecated(new = "girf_mrcivar_rm")
  girf_mrcivar_rm(...)
}

# Legacy alias for girf_MRCIVAR_RM_CB()
girf_MRCIVAR_RM_CB <- function(...) {
  .Deprecated(new = "girf_mrcivar_rm_cb")
  girf_mrcivar_rm_cb(...)
}

# Legacy alias for girf_MRGVAR_RM()
girf_MRGVAR_RM <- function(...) {
  .Deprecated(new = "girf_mrgvar_rm")
  girf_mrgvar_rm(...)
}

# Legacy alias for girf_MRGVAR_RM_CB()
girf_MRGVAR_RM_CB <- function(...) {
  .Deprecated(new = "girf_mrgvar_rm_cb")
  girf_mrgvar_rm_cb(...)
}

# Legacy alias for girf_MRVAR_RM()
girf_MRVAR_RM <- function(...) {
  .Deprecated(new = "girf_mrvar_rm")
  girf_mrvar_rm(...)
}

# Legacy alias for girf_MRVAR_RM_CB()
girf_MRVAR_RM_CB <- function(...) {
  .Deprecated(new = "girf_mrvar_rm_cb")
  girf_mrvar_rm_cb(...)
}

# Legacy alias for GVAR_Select()
GVAR_Select <- function(...) {
  .Deprecated(new = "gvar_select_")
  gvar_select_(...)
}

# Legacy alias for GVARData()
GVARData <- function(...) {
  .Deprecated(new = "gvar_data")
  gvar_data(...)
}

# Legacy alias for GVARest()
GVARest <- function(...) {
  .Deprecated(new = "gvar_estimate")
  gvar_estimate(...)
}

# Legacy alias for GW2BoAo()
GW2BoAo <- function(...) {
  .Deprecated(new = "gw2_bo_ao")
  gw2_bo_ao(...)
}

# Legacy alias for INVI()
INVI <- function(...) {
  .Deprecated(new = "invi")
  invi(...)
}

# Legacy alias for irf_B_sigma()
irf_B_sigma <- function(...) {
  .Deprecated(new = "irf_from_params")
  irf_from_params(...)
}

# Legacy alias for irf_CIGVAR_CB()
irf_CIGVAR_CB <- function(...) {
  .Deprecated(new = "irf_cigvar_cb")
  irf_cigvar_cb(...)
}

# Legacy alias for irf_CIVAR_CB()
irf_CIVAR_CB <- function(...) {
  .Deprecated(new = "irf_civar_cb")
  irf_civar_cb(...)
}

# Legacy alias for irf_GloabalResponse_CB()
irf_GloabalResponse_CB <- function(...) {
  .Deprecated(new = "irf_global_response_cb")
  irf_global_response_cb(...)
}

# Legacy alias for IRF_graph()
IRF_graph <- function(...) {
  .Deprecated(new = "plot_irf")
  plot_irf(...)
}

# Legacy alias for irf_GVAR()
irf_GVAR <- function(...) {
  .Deprecated(new = "irf_gvar")
  irf_gvar(...)
}

# Legacy alias for irf_GVAR_CB()
irf_GVAR_CB <- function(...) {
  .Deprecated(new = "irf_gvar_cb")
  irf_gvar_cb(...)
}

# Legacy alias for irf_MRCIGVAR()
irf_MRCIGVAR <- function(...) {
  .Deprecated(new = "irf_mrcigvar")
  irf_mrcigvar(...)
}

# Legacy alias for irf_MRCIGVAR_CB()
irf_MRCIGVAR_CB <- function(...) {
  .Deprecated(new = "irf_mrcigvar_cb")
  irf_mrcigvar_cb(...)
}

# Legacy alias for irf_MRCIVAR_CB()
irf_MRCIVAR_CB <- function(...) {
  .Deprecated(new = "irf_mrcivar_cb")
  irf_mrcivar_cb(...)
}

# Legacy alias for irf_MRGVAR()
irf_MRGVAR <- function(...) {
  .Deprecated(new = "irf_mrgvar")
  irf_mrgvar(...)
}

# Legacy alias for irf_MRGVAR_CB()
irf_MRGVAR_CB <- function(...) {
  .Deprecated(new = "irf_mrgvar_cb")
  irf_mrgvar_cb(...)
}

# Legacy alias for irf_MRVAR_CB()
irf_MRVAR_CB <- function(...) {
  .Deprecated(new = "irf_mrvar_cb")
  irf_mrvar_cb(...)
}

# Legacy alias for irf_MRVAR_NM()
irf_MRVAR_NM <- function(...) {
  .Deprecated(new = "irf_mrvar_nm")
  irf_mrvar_nm(...)
}

# Legacy alias for irf_MRVAR_NM_CB()
irf_MRVAR_NM_CB <- function(...) {
  .Deprecated(new = "irf_mrvar_nm_cb")
  irf_mrvar_nm_cb(...)
}

# Legacy alias for irf_VAR_CB()
irf_VAR_CB <- function(...) {
  .Deprecated(new = "irf_var_cb")
  irf_var_cb(...)
}

# Legacy alias for JointX()
JointX <- function(...) {
  .Deprecated(new = "bind_exogenous_by_state")
  bind_exogenous_by_state(...)
}

# Legacy alias for MIxCIVARData()
MIxCIVARData <- function(...) {
  .Deprecated(new = "mixed_civar_data")
  mixed_civar_data(...)
}

# Legacy alias for MRCIGVAR_Select()
MRCIGVAR_Select <- function(...) {
  .Deprecated(new = "mrcigvar_select_")
  mrcigvar_select_(...)
}

# Legacy alias for MRCIGVARData()
MRCIGVARData <- function(...) {
  .Deprecated(new = "mrcigvar_data")
  mrcigvar_data(...)
}

# Legacy alias for MRCIGVARDataR()
MRCIGVARDataR <- function(...) {
  .Deprecated(new = "mrcigvar_data_r")
  mrcigvar_data_r(...)
}

# Legacy alias for MRCIGVARest()
MRCIGVARest <- function(...) {
  .Deprecated(new = "mrcigvar_estimate")
  mrcigvar_estimate(...)
}

# Legacy alias for MRCIVAR_Selectm()
MRCIVAR_Selectm <- function(...) {
  .Deprecated(new = "mrcivar_select")
  mrcivar_select(...)
}

# Legacy alias for MRCIVARDatam()
MRCIVARDatam <- function(...) {
  .Deprecated(new = "mrcivar_data")
  mrcivar_data(...)
}

# Legacy alias for MRCIVARestm1()
MRCIVARestm1 <- function(...) {
  .Deprecated(new = "mrcivar_estimate")
  mrcivar_estimate(...)
}

# Legacy alias for MRCVECMest2()
MRCVECMest2 <- function(...) {
  .Deprecated(new = "mrcvec_mest2")
  mrcvec_mest2(...)
}

# Legacy alias for MRCVECMestm()
MRCVECMestm <- function(...) {
  .Deprecated(new = "mrcvec_mestm")
  mrcvec_mestm(...)
}

# Legacy alias for MRGVAR_Select()
MRGVAR_Select <- function(...) {
  .Deprecated(new = "mrgvar_select_")
  mrgvar_select_(...)
}

# Legacy alias for MRGVARData()
MRGVARData <- function(...) {
  .Deprecated(new = "mrgvar_data")
  mrgvar_data(...)
}

# Legacy alias for MRGVARDataR()
MRGVARDataR <- function(...) {
  .Deprecated(new = "mrgvar_data_r")
  mrgvar_data_r(...)
}

# Legacy alias for MRGVARest()
MRGVARest <- function(...) {
  .Deprecated(new = "mrgvar_estimate")
  mrgvar_estimate(...)
}

# Legacy alias for MRVAR_Select()
MRVAR_Select <- function(...) {
  .Deprecated(new = "mrvar_select_")
  mrvar_select_(...)
}

# Legacy alias for MRVAR_Select_Summary()
MRVAR_Select_Summary <- function(...) {
  .Deprecated(new = "mrvar_select__summary")
  mrvar_select__summary(...)
}

# Legacy alias for MRVARData()
MRVARData <- function(...) {
  .Deprecated(new = "mrvar_data")
  mrvar_data(...)
}

# Legacy alias for MRVARest()
MRVARest <- function(...) {
  .Deprecated(new = "mrvar_estimate")
  mrvar_estimate(...)
}

# Legacy alias for NoutofT()
NoutofT <- function(...) {
  .Deprecated(new = "sample_n_out_of_t")
  sample_n_out_of_t(...)
}

# Legacy alias for Redex()
Redex <- function(...) {
  .Deprecated(new = "redex")
  redex(...)
}

# Legacy alias for rnormSIGMA()
rnormSIGMA <- function(...) {
  .Deprecated(new = "rnorm_sigma")
  rnorm_sigma(...)
}

# Legacy alias for rnormSIGMA_cond()
rnormSIGMA_cond <- function(...) {
  .Deprecated(new = "rnorm_sigma_cond")
  rnorm_sigma_cond(...)
}

# Legacy alias for Roots2coef()
Roots2coef <- function(...) {
  .Deprecated(new = "roots_to_coef")
  roots_to_coef(...)
}

# Legacy alias for RZSt2VECM()
RZSt2VECM <- function(...) {
  .Deprecated(new = "rz_st2_vecm")
  rz_st2_vecm(...)
}

# Legacy alias for ShiftZ2()
ShiftZ2 <- function(...) {
  .Deprecated(new = "shift_z2")
  shift_z2(...)
}

# Legacy alias for ShiftZ2m()
ShiftZ2m <- function(...) {
  .Deprecated(new = "shift_z2m")
  shift_z2m(...)
}

# Legacy alias for SigmaNPD()
SigmaNPD <- function(...) {
  .Deprecated(new = "sigma_npd")
  sigma_npd(...)
}

# Legacy alias for SigmaNPDSelectR()
SigmaNPDSelectR <- function(...) {
  .Deprecated(new = "sigma_npd_select_r")
  sigma_npd_select_r(...)
}

# Legacy alias for STAT()
STAT <- function(...) {
  .Deprecated(new = "spectral_radius")
  spectral_radius(...)
}

# Legacy alias for summaryCIVAR()
summaryCIVAR <- function(...) {
  .Deprecated(new = "summary_civar")
  summary_civar(...)
}

# Legacy alias for SW2comb()
SW2comb <- function(...) {
  .Deprecated(new = "sw2comb")
  sw2comb(...)
}

# Legacy alias for Type()
Type <- function(...) {
  .Deprecated(new = "infer_deterministic_type")
  infer_deterministic_type(...)
}

# Legacy alias for U1()
U1 <- function(...) {
  .Deprecated(new = "u1")
  u1(...)
}

# Legacy alias for VARB_commtrend()
VARB_commtrend <- function(...) {
  .Deprecated(new = "varb_commtrend")
  varb_commtrend(...)
}

# Legacy alias for VARBS_commtrend()
VARBS_commtrend <- function(...) {
  .Deprecated(new = "varbs_commtrend")
  varbs_commtrend(...)
}

# Legacy alias for VARData()
VARData <- function(...) {
  .Deprecated(new = "var_data")
  var_data(...)
}

# Legacy alias for VARest()
VARest <- function(...) {
  .Deprecated(new = "var_estimate")
  var_estimate(...)
}

# Legacy alias for VECM2VAR()
VECM2VAR <- function(...) {
  .Deprecated(new = "vecm2_var")
  vecm2_var(...)
}

# Legacy alias for VECM2VARm()
VECM2VARm <- function(...) {
  .Deprecated(new = "vecm2_va_rm")
  vecm2_va_rm(...)
}

# Legacy alias for W2Wmat()
W2Wmat <- function(...) {
  .Deprecated(new = "w2_wmat")
  w2_wmat(...)
}

# Legacy alias for xABF()
xABF <- function(...) {
  .Deprecated(new = "x_abf")
  x_abf(...)
}

