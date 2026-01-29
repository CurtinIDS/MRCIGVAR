# MRCIGVAR refactor + rename tools (v3)

This folder contains scripts to help you:
1) inventory legacy functions
2) split legacy scripts into topic-based files under `R/`
3) rename functions consistently and update call-sites
4) generate backwards-compatible aliases (optional)

## Expected repo layout

From your package root (where DESCRIPTION lives):

- legacy/         # put the old scripts here (e.g., VAR_c.R, MRVAR_c.R, ...)
- R/              # the package R code (created automatically if missing)
- tools/          # these scripts + CSV maps

## Quick start (recommended)

```bash
# from package root
Rscript tools/00_setup.R
Rscript tools/01_generate_maps.R
Rscript tools/02_split_to_modules.R
Rscript tools/03_apply_renames.R
Rscript tools/04_check_coverage.R
```

## Files

- `tools/rename_map.csv`  
  The master map. Edit this if you want different names/modules.

Columns:
- old_name, new_name
- module: one of data_input.R, estimation.R, model_selection.R, irf.R, diagnostics.R, constraints.R, utils.R
- keep_old_alias: TRUE/FALSE (wrapper old name -> new name)
- status: proposed/approved

## Notes

- These scripts assume functions are defined as `name <- function(...)` or `name = function(...)`.
- Roxygen blocks (`#'`) immediately above a function will be carried with it when splitting.
- The rename step uses the R parser to avoid replacing inside strings/comments.
