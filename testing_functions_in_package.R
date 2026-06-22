remove.packages("MRCIGVAR")
library(MRCIGVAR)
library(devtools)
setwd("C:\\Users\\297230e\\OneDrive - Curtin\\Research\\MRCIGVAR_UNO\\MRCIGVAR")
devtools::load_all()

devtools::document()

devtools::check()

devtools::install()



#library(MRCIGVAR)


###########################################






res_d = var_data(n=2,p=2,T=100,type="const")
res_e = var_estimate(res=res_d);
IRF_CB = irf_var_cb(res=res_e,nstep=20, comb=NA, irf = "gen1", runs = 100, conf = c(0.05, 0.95))
IRF_list <-plot_irf(IRF_CB)
res_e$Summary



























