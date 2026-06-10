#' Mixed VECM with I(0) and I(1) variables
#'
#' This function generates and estimates a mixed VECM with I(0) and I(1) variables
#'
#' @param n	: dimension of the mixed CIVAR
#' @param p	: lag of the mixed CIVAR
#' @param T : number of observations or length of the generated data
#' @param r : number of unit roots in the joint CIVAR
#' @param k  : number of I(0) variables
#' @param type : types of the deterministic components in the conditional CIVAR
#' @param Bo : coefficient matrix of the mixed CIVAR
#' @param Y : data of the mixed CIVAR
#' @param X : data of the exogenous variables
#' @param D : transformation matrix to mix the I(0) and I(1) components
#' @param Go : pre-loaded selection matrix
#' @param B : coefficient matrix of the mixed CIVAR
#' @param Sigma : covariance matrix of the residuals
#'
#' @return  a list contains estimation and test results of the mixed VECM
#' @examples
#'
#' #RR <- MIxCIVARData(n=9,p=2,T=209,r=5,k=2,type="const",Bo=NA,Y=NA,D=NA)
#' ## DGP of I(1) and I(0) mixed VECM
#' #plot(ts(RR$Y))
#' #
#' #### testing the mixed VECM via testing the restrictions on beta
#' #res_d <- CIVARData(n=9,p=2,T=209,type="const",crk=4)
#' #res_e = CIVARest(res=res_d)
#' #res_e$Summary
#' #n = 9; crk = 4; k = 2; r = 5
#' #CC  <- c(8,9,17,18)
#' #GG  <- c(19:25,28:34)
#' #G = diag(n*crk); psi=matrix(1,n*crk,1)
#' #### this implies there is no restrictions on the adjustment coefficients alpha
#' #H = diag(n*crk);              H2 = H[,-c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n),CC,GG)]
#' #### only normalization
#' #h = matrix(0,n*crk,1);         h[c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n)),1] <- 1
#' #phi = matrix(1,ncol(H2),1)
#' ### check consistency of the restrictions    G%*%psi; H2%*%phi + h
#' #
#' #G%*%psi; H2%*%phi + h
#' #
#' #ABtest = CIVARTest(res=res_d,H=H2,h=h,phi=phi,G=G,Dxflag=0)
#' #ABtest$betar
#' #ABtest$alphar
#' #ABtest$VECMR$coefficients
#' #ABtest$LR
#' #1-pchisq(ABtest$LR,14)   ### The Ho of last two are I(0) is rejected
#' #
#' #res_d$Y = RR$Y           ### replacing the data of two I(0) variables
#' #ABtest = CIVARTest(res=res_d,H=H2,h=h,phi=phi,G=G,Dxflag=0)
#' #ABtest$betar
#' #ABtest$alphar
#' #ABtest$VECMR$coefficients
#' #ABtest$LR
#' #1-pchisq(ABtest$LR,14)  ### The Ho of last two are I(0) cannot be rejected
#' #
#' #RR$GABtest$LR           ## RR contains the same LR
#' #
#' #
#' @export
#'
mixed_civar_data = function(n,p,T,r,k,type,Bo=NA,Y=NA,X=NA,D=NA,Go=NA,B=NA,Sigma = NA) {
  
  if (anyNA(Bo)) {
    repeat {
      res_d  = VARData(n=n,p=p,T=T,type=type)
      Bo <- res_d$B
      Bo[,1:r,p] = 0
      if (max(Mod(STAT(Bo))) < 0.9) break
    }
  }
  res_d  = var_data(n=n,p=p,T=T,B=Bo,type=type)
  U = res_d$U
  Z = as.matrix(res_d$Y[,1:r]); for (i in 2:T) Z[i,] = Z[i-1,]+Z[i,]
  X <- res_d$Y[,(r+1):n]
  #plot(ts(cbind(Z,X)))
  
  if (anyNA(D)) {
    D = matrix(stats::rnorm(n*n),n,n)
    #solve(D)
    #D[1:(n-k),(n-k+1):n] <-0
    D[(n-k+1):n,1:(n-k)] <-0
    #D[(n-k+1):n,1:r] <-0
  }
  YS = cbind(Z,X)%*%t(D)
  #plot(ts(YS))
  crk <- n-r
  ########### restricted CIVAR
  
  B1 <- Bo
  B1[1:r,1:r,1]    =  Bo[1:r,1:r,1]  +  diag(r)
  B1[1:n,1:r,p]    = -Bo[1:n,1:r,p-1]
  if (p>2) for (i in 2:(p-1)) B1[1:n,1:r,i]  = Bo[1:n,1:r,i] - Bo[1:n,1:r,i-1]
  #STAT(B1)
  
  if (anyNA(B)) {
    B2 <- B1*0
    for (i in 1:p) B2[,,i] <- D%*%B1[,,i]%*%solve(D)
  } else B2 <- B
  
  #STAT(B2)
  
  #Co = seq(1,n,1)/seq(1,n,1)
  #U[1:2,] <- 0
  #res_d  = VARData(n=n,p=p,T=T,B=Bo,Co=Co*0,type="const",U=U,Yo=U[1:p,]*0)
  #ZZ <- res_d$Y[,1:r]; Z = ZZ*0; for (i in 3:T) Z[i,] = Z[i-1,]+ZZ[i,];X <- res_d$Y[,(r+1):n]
  #res_dd = VARData(n=n,p=p,T=T,B=B1,Co=Co*0,type="const",U=U,Yo=Yo)
  #res_ddd= VARData(n=n,p=p,T=T,B=B2,Co=Co*0,type="const",U=U%*%t(D),Yo=U[1:p,]*0)
  #Y =  cbind(Z,X)%*%t(D)
  #res_ddd$Y - Y
  
  ##############
  res_d <- civar_data(n=n,p=p,T=T,B=B2,type=type,crk=crk,Sigma=Sigma)
  #plot(ts(res_d$Y))
  if (!anyNA(Y)) res_d$Y <-Y
  #res_d$Y <- Y
  #plot(ts(res_d$Y))
  res_e = civar_estimate(res=res_d)
  
  G = diag(n*crk); psi=matrix(1,n*crk,1)          #### this implies there is no restrictions on the adjustment coefficient alpha
  H = diag(n*crk);              H2 = H[,-c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n))]   #### only normalization
  h = matrix(0,n*crk,1);        h[c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n)),1] <- 1 ;
  phi = matrix(1,(n-1)*crk,1)
  
  ### second set of normalization beta' = (I,beta_2') not done
  G = diag(n*crk); psi=matrix(1,n*crk,1)          #### this implies there is no restrictions on the adjustment coefficient alpha
  H = diag(n*crk);              H2 = H[,-c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n))]   #### only normalization
  h = matrix(0,n*crk,1);        h[c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n)),1] <- 1 ;
  phi = matrix(1,(n-1)*crk,1)
  
  ### check restrictions: G%*%psi  ; H2%*%phi+h
  ### c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n))
  
  ABtest = civat_test(res=res_d,H=H2,h=h,phi=phi,G=G,Dxflag=0)
  
  
  ABtest$betar
  ABtest$alphar
  ABtest$VECMR$coefficients
  ABtest$LR
  1-stats::pchisq(ABtest$LR,1)   ### the fourth is the used restrictions
  
  
  ##################
  CCo = seq(n-k,(n-r-k)*n,n)
  CC  <-CCo+1
  if (k > 1) for (i in 2:k) CC = cbind(CC,CCo+i)
  CC = as.vector(t(CC))
  GGo = 1:(n-k)
  GG <- (n-r-k)*n + GGo
  if (k>1) for (i in 2:k) GG = cbind(GG,GGo+(n-r-k+i-1)*n)
  GG <- as.vector(t(GG))
  GG0 = 1:r
  GG1 <- (n-r-k)*n + GG0
  #GG1 <- c(2,3)
  if (k>1) for (i in 2:k) GG1 = cbind(GG1,GG0+(n-r-k+i-1)*n)
  GG1 <- as.vector(GG1)
  G = diag(n*crk); psi=matrix(1,n*crk,1)          #### this implies there is no restrictions on the adjustment coefficient alpha
  H = diag(n*crk);              H2 = H[,-c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n),GG1)]   #### normalization + I(0) B31=0
  h = matrix(0,n*crk,1);        h[c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n)),1] <- 1 ;
  phi = matrix(1,(n-1)*crk-k*r,1)
  
  ### check restrictions: G%*%psi  ; H2%*%phi+h
  ### c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n))
  
  AABtest = civar_test(res=res_d,H=H2,h=h,phi=phi,G=G,Dxflag=0)
  
  AABtest$betar
  AABtest$alphar
  AABtest$VECMR$coefficients
  AABtest$LR
  1-stats::pchisq(AABtest$LR,k*(n-r))   ### the fourth is the used restrictions
  #plot(ts(res_d$Y))
  
  
  #################
  
  
  CCo = seq(n-k,(n-r-k)*n,n)
  CC  <-CCo+1
  if (k > 1) for (i in 2:k) CC = cbind(CC,CCo+i)
  CC = as.vector(t(CC))
  GGo = 1:(n-k)
  GG <- (n-r-k)*n + GGo
  if (k>1) for (i in 2:k) GG = cbind(GG,GGo+(n-r-k+i-1)*n)
  GG <- as.vector(t(GG))
  ## GG <- c(14,15,16,17,18)
  G = diag(n*crk); psi=matrix(1,n*crk,1)          #### this implies there is no restrictions on the adjustment coefficient alpha
  H = diag(n*crk);              H2 = H[,-c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n),GG)]   #### normalization + I(0) B31=0,B32=0
  h = matrix(0,n*crk,1);        h[c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n)),1] <- 1 ;
  phi = matrix(1,(n-1)*crk-k*(n-k),1)
  ### H2 = H[,-c(1,3,8,5,6,7)]; h[3]=-1; phi = matrix(1,2,1)
  ### check restrictions: G%*%psi  ; H2%*%phi+h
  ### c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n))
  
  ABtest = civar_test(res=res_d,H=H2,h=h,phi=phi,G=G,Dxflag=0)
  
  ABtest$betar
  ABtest$alphar
  ABtest$VECMR$coefficients
  ABtest$LR
  1-stats::pchisq(ABtest$LR,k*r)   ### the fourth is the used restrictions the degree of freedom is n*h-h*h
  
  
  
  
  
  
  
  #########################
  
  G = diag(n*crk); psi=matrix(1,n*crk,1)          #### this implies there is no restrictions on the adjustment coefficient alpha
  H = diag(n*crk);              H2 = H[,-c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n),CC,GG)]   #### normalization I(0) B31=0, B32=0, B23=0
  h = matrix(0,n*crk,1);        h[c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n)),1] <- 1 ;
  phi = matrix(1,(n-1)*crk-k*(n-r-k)-k*(n-k),1)
  
  ### H2 = H[,-c(1,3,4,8,5,6,7)]; h[3]=-1; phi = matrix(1,1,1)
  
  ### check restrictions: G%*%psi  ; H2%*%phi+h
  ### c(seq(1,(n-r-k)*n,n),seq((n-r-k+1)*n,(n-r)*n,n))
  nG = 0
  if (!anyNA(Go)) { G = Go; nG = dim(Go)[1]-dim(Go)[2] }
  GABtest = CIVARTest(res=res_d,H=H2,h=h,phi=phi,G=G,Dxflag=0)
  
  GABtest$betar
  GABtest$alphar
  GABtest$VECMR$coefficients
  GABtest$LR
  1-stats::pchisq(GABtest$LR,k*r+nG)   ### the fourth is the used restrictions
  # collect restricted estimates
  BB3 <- res_d$B*0
  #BB3[,,1] <- GABtest$alphar%*%t(GABtest$betar)
  #AA  <- t(GABtest$LSKOEFR[1:((p-1)*n),])
  #dim(AA) <- c(n,n,(p-1))
  #BB3[,,2:p] <- AA
  #B3 <-CIB3B(BB3)
  #res_e$B <- B3
  #res_e$Sigma <- t(GABtest$VECMR$residuals)%*%GABtest$VECMR$residuals/T
  #for (i in 1:n) {
  #    res_e$tst$VECMS[[i]]$coefficients[(n-r+1):nrow(res_e$tst$VECMS[[i]]$coefficients),] <- GABtest$VECMRS[[i]]$coefficients;
  #    res_e$tst$VECMS[[i]]$coefficients[1:(n-r),1] <- GABtest$alpha[i,];
  #}
  BB3[,,1] <- GABtest$alphar%*%t(GABtest$betar)
  AA  <- t(GABtest$LSKOEFR[1:((p-1)*n),])
  dim(AA) <- c(n,n,(p-1))
  BB3[,,2:p] <- AA
  B3 <-CIB3B(BB3)
  res_e$B <- B3
  ##### transforming back to B
  
  #####
  res_e$Sigma <- t(GABtest$VECMR$residuals)%*%GABtest$VECMR$residuals/T
  for (i in 1:n) {
    res_e$tst$VECMS[[i]]$coefficients[(n-r+1):nrow(res_e$tst$VECMS[[i]]$coefficients),] <- GABtest$VECMRS[[i]]$coefficients;
    res_e$tst$VECMS[[i]]$coefficients[1:(n-r),1] <- GABtest$alpha[i,];
  }
  RR<-list(D,Bo,res_d$Y,AABtest, ABtest, GABtest,res_e,res_d,1-stats::pchisq(AABtest$LR,1),1-stats::pchisq(ABtest$LR,k*r), 1-stats::pchisq(GABtest$LR,k*r),k)
  names(RR) = c("D","Bo","Y","AABtest", "ABtest", "GABtest","res_e","res_d","p-value_A","p-value_E", "p-value_W","k")
  return(RR)
}
