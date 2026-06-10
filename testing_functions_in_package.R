remove.packages("MRCIGVAR")
library(MRCIGVAR)
library(devtools)
setwd("C:\\Users\\297230e\\OneDrive - Curtin\\Research\\MRCIGVAR_UNO\\MRCIGVAR")
devtools::load_all()


library(MRCIGVAR)

n <- 4
p <- matrix(0, nrow = n, ncol = 3)
p[, 1] <- 2
p[, 2] <- 2

res_d <- cigvar_data(
  m = 2,
  n = n,
  p = p,
  T = 200,
  type = "const",
  DFYflag = 0
)

res_e <- cigvar_estimate(res_d)
res_e$Summary

sel <- cigvar_select_(res = res_e, L_V = c(3, 3))
sel[which.min(sel[, ncol(sel)]), ]

irf_cb <- irf_cigvar_cb(
  res = res_e,
  nstep = 12,
  comb = NA,
  irf = "gen1",
  runs = 50,
  conf = c(0.05, 0.95)
)

pp <-plot_irf(irf_cb, response = c(1, 2), impulse = c(1, 2), ncol = 2)



###########################################






res_d = var_data(n=2,p=2,T=100,type="const")
res_e = var_estimate(res=res_d);
IRF_CB = irf_var_cb(res=res_e,nstep=20, comb=NA, irf = "gen1", runs = 100, conf = c(0.05, 0.95))
IRF_list <-plot_irf(IRF_CB)
res_e$Summary



























