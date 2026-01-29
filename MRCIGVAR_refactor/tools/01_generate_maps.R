#!/usr/bin/env Rscript
# tools/01_generate_maps.R
# Scan ./legacy for functions and (re)generate tools/rename_map.csv and tools/function_inventory.csv

source("tools/helpers.R")

stopifnot(dir.exists("legacy"))

legacy_files <- list.files("legacy", pattern = "\\.[Rr]$", full.names = TRUE)
if (length(legacy_files) == 0) stop("No .R files found in ./legacy")

inv <- data.frame(
  old_name = character(),
  new_name = character(),
  module = character(),
  source_file = character(),
  keep_old_alias = logical(),
  status = character(),
  stringsAsFactors = FALSE
)

for (f in legacy_files) {
  txt <- read_text(f)
  blocks <- extract_function_blocks(txt)
  if (length(blocks) == 0) next
  for (b in blocks) {
    inv[nrow(inv) + 1, ] <- list(
      old_name = b$name,
      new_name = suggest_new_name(b$name),
      module = guess_module(b$name),
      source_file = basename(f),
      keep_old_alias = TRUE,
      status = "proposed"
    )
  }
}

inv <- inv[!duplicated(inv$old_name), ]
inv <- inv[order(inv$old_name), ]

write.csv(inv, file = "tools/rename_map.csv", row.names = FALSE)
write.csv(inv[, c("old_name","module","source_file","new_name")], file = "tools/function_inventory.csv", row.names = FALSE)

cat(sprintf("Wrote %d functions to tools/rename_map.csv\n", nrow(inv)))
