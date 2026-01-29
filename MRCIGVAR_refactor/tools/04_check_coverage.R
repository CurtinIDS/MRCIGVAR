#!/usr/bin/env Rscript
# tools/04_check_coverage.R
# Check that every old function is present (as new name) after split+rename.

source("tools/helpers.R")

stopifnot(file.exists("tools/rename_map.csv"))
map <- read.csv("tools/rename_map.csv", stringsAsFactors = FALSE)

if (!dir.exists("R")) stop("Missing ./R folder.")
r_files <- list.files("R", pattern = "\\.R$", full.names = TRUE)

found <- character()
for (f in r_files) {
  txt <- read_text(f)
  starts <- find_function_starts(txt)
  if (nrow(starts)) found <- c(found, starts$name)
}
found <- unique(found)

missing_new <- setdiff(unique(map$new_name), found)
missing_old <- setdiff(unique(map$old_name), found) # for aliases we may still see old

cat(sprintf("Functions expected (new_name): %d\n", length(unique(map$new_name))))
cat(sprintf("Functions found in R/: %d\n", length(found)))
if (length(missing_new)) {
  cat("\nMissing new_name functions:\n")
  cat(paste0(" - ", missing_new, collapse = "\n"), "\n")
} else {
  cat("\nAll new_name functions found.\n")
}
