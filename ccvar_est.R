#' Estimation of CCIVAR
#'
#' This function estimates parameters of a specified conditional cointegrated VAR based on provided data.
#'
#' @param res a CCIVAR object that can be an output of CCIVARData containing at least n1,n2, Y, X, and crk.
#'
#' @return a CCIVAR object with estimated parameter values, AIC, BIC, conditional VECM in a regression format.
#'
#' @examples
#' T = 100
#' res_d <- CCIVARData(n1=4,n2=3,crk=3,p=3,T=T,type="const")
#' res_e <- CCIVARest(res=res_d)
#' res_e$Summary
#'
#' @export
ccivar_est <- function (res)
{
  n = res$n1
  p = res$p
  crk = res$crk
  Y = as.matrix(res$Y)
  if (is.null(colnames(Y)))
    colnames(Y) = paste0(rep("Y", ncol(Y)), c(1:ncol(Y)))
  type = res$type
  T = dim(Y)[1]
  X = res$X
  if (is.null(colnames(X)))
    colnames(X) = paste0(rep("X", ncol(X)), c(1:ncol(X)))
  if (!anyNA(X)) if (is.null(colnames(X))) colnames(X) = paste0(rep("exog", ncol(X)), c(1:ncol(X)))
  if (type == "none" | type == "exog0")     Model = "I"
  if (type == "const" | type == "exog1")    Model = "III"
  if (type == "trend")                      Model = "IV"
  P = matrix(0, 2, 3)
  P[, 1] = p
  Co = res$Co * 0
  #      cvecm(y=Y,x=X,model="II",type = "eigen", crk=2, p = 3, q = 0.95)
  tst <- cvecm(y=Y,x=X,model=Model,type = "eigen", crk=crk, p = p, q = 0.95)
  param = tst[[2]][[1]]
  if (type=="trend") beta = tst$beta[-1,] else beta = tst$beta
  CIVAREST = cvecm2_cvar(param = param, beta = beta, p = c(crk,p - 1, p-1),N2 = ncol(X))
  B = CIVAREST[[1]]
  Bx = CIVAREST[[2]]
  C = CIVAREST[[3]]
  alpha <- t(param[1:crk,]); dim(alpha) = c(n,crk)
  #if (type=="trend")   C1 = rowSums(alpha)  else C1 = NA
  if (type=="trend")   C1 = alpha%*%t(as.matrix(tst$beta))[,1]  else C1 = NA
  LREG = tst[[2]]
  sigma = t(LREG$residuals) %*% (LREG$residuals)/(T)
  resid = Y * 0
  resid[(p + 1):T, ] = LREG$residuals
  if (type == "const" | type == "exog1")
    Co = C
  if (type == "exog0") {
    Co[, 2:(1 + dim(CIVAREST[[3]])[2])] = CIVAREST[[3]]
  }
  res$By <- B
  res$Bx <- Bx
  res$Co <- Co
  res$C1 <- C1
  res$Sigma <- sigma
  res$resid <- resid
  LH = -(T * n/2) * log(2 * pi) - (T * n/2) + ((T)/2) * log(det(solve(sigma)))
  AIC = 2 * n * (dim(tst[[2]][[1]])[1]) + n * (n + 1) - 2 *
    LH
  BIC = log(T) * (n * (dim(tst[[2]][[1]])[1]) + n * (n + 1)/2) -
    2 * LH
  LH_N = 2 * n * (dim(tst[[2]][[1]])[1]) + n * (n + 1)
  if (is.null(colnames(Y)))
    colnames(Y) = sprintf("Y%s", 1:n)
  estimation_result = summary_civar(lm1 = LREG, sname = "Z2")
  Summary = list(estimation_result, LH, AIC, BIC, LH_N, tst$erg)
  names(Summary) = c("Estimation_Results", "LH_function_Value","AIC", "BIC", "LH_N", "Johansen_Test")
  res$tst = tst
  res$Summary = Summary
  return(res)
}

