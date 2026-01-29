#!/usr/bin/env Rscript
# tools/00_setup.R
# Create expected folders + empty module files (idempotent).

pkg_root <- "."
stopifnot(file.exists(file.path(pkg_root, "DESCRIPTION")))

dirs <- c("legacy","R","tools")
for (d in dirs) if (!dir.exists(d)) dir.create(d, recursive = TRUE)

targets <- c("data_input.R","estimation.R","model_selection.R","irf.R","diagnostics.R","constraints.R","utils.R")
for (t in targets) {
  p <- file.path("R", t)
  if (!file.exists(p)) {
    cat(sprintf("# %s\n# Auto-created by tools/00_setup.R\n\n", t), file = p)
  }
}
cat("Setup complete.\n")
