Refactor Tools v2

1) Put legacy scripts into ./legacy/
2) Ensure you have a package skeleton with ./R/
3) Run:
   Rscript tools/split_functions.R

Outputs:
- R/*.R topic files (data_input.R, estimation.R, model_selection.R, irf.R, diagnostics.R, constraints.R, utils.R)
- tools/function_index.csv (function -> target -> source file)
- tools/split_log.txt (parse failures and warnings)
