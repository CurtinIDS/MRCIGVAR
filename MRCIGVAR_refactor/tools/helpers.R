# tools/helpers.R

read_text <- function(path) paste(readLines(path, warn = FALSE), collapse = "\n")

# Find function definitions: name <- function( or name = function(
find_function_starts <- function(txt) {
  pattern <- "(?m)^[ \t]*([A-Za-z][A-Za-z0-9_.]*)[ \t]*(<-|=)[ \t]*function[ \t]*\\("
  m <- gregexpr(pattern, txt, perl = TRUE)
  if (length(m[[1]]) == 1 && m[[1]][1] == -1) return(data.frame())
  starts <- as.integer(m[[1]])
  lens   <- attr(m[[1]], "match.length")
  matches <- regmatches(txt, m)[[1]]
  names <- sub("^[ \t]*([A-Za-z][A-Za-z0-9_.]*)[ \t]*(<-|=).*$", "\\1", matches, perl = TRUE)
  data.frame(name = names, start = starts, len = lens, stringsAsFactors = FALSE)
}

# Include preceding roxygen2 block if present
roxy_start_for <- function(txt, fun_start) {
  if (fun_start <= 1) return(fun_start)
  before <- substr(txt, 1, fun_start - 1)
  blines <- strsplit(before, "\n", fixed = TRUE)[[1]]
  if (length(blines) == 0) return(fun_start)
  i <- length(blines)
  while (i > 0 && grepl("^\\s*$", blines[i])) i <- i - 1
  j <- i
  while (j > 0 && grepl("^\\s*#'", blines[j])) j <- j - 1
  if (j < i) {
    # roxygen block is (j+1) .. i
    return(nchar(paste(blines[1:(j+1)], collapse = "\n")) + 2) # +2 for \n
  }
  fun_start
}

# Brace-match from the first '{' after fun_start to find end position
find_function_end <- function(txt, fun_start) {
  subtxt <- substr(txt, fun_start, nchar(txt))
  brace_rel <- regexpr("\\{", subtxt, perl = TRUE)[1]
  if (brace_rel == -1) return(NA_integer_)
  brace_pos <- fun_start + brace_rel - 1

  depth <- 0L
  in_str <- NA_character_
  esc <- FALSE
  j <- brace_pos
  n <- nchar(txt)

  while (j <= n) {
    ch <- substr(txt, j, j)

    # comments: skip to end of line if not in string
    if (is.na(in_str) && ch == "#") {
      nl <- regexpr("\n", substr(txt, j, n), fixed = TRUE)[1]
      if (nl == -1) return(n)
      j <- j + nl - 1
      next
    }

    if (!is.na(in_str)) {
      if (esc) {
        esc <- FALSE
      } else if (ch == "\\\\") {
        esc <- TRUE
      } else if (ch == in_str) {
        in_str <- NA_character_
      }
      j <- j + 1
      next
    } else {
      if (ch == "'" || ch == "\"") {
        in_str <- ch
        j <- j + 1
        next
      }
      if (ch == "{") depth <- depth + 1L
      if (ch == "}") {
        depth <- depth - 1L
        if (depth == 0L) {
          end <- j
          # include trailing newline
          if (end < n && substr(txt, end + 1, end + 1) == "\n") end <- end + 1
          return(end)
        }
      }
      j <- j + 1
    }
  }
  NA_integer_
}

extract_function_blocks <- function(txt) {
  starts <- find_function_starts(txt)
  if (nrow(starts) == 0) return(list())
  out <- list()
  for (i in seq_len(nrow(starts))) {
    st <- starts$start[i]
    st2 <- roxy_start_for(txt, st)
    en <- find_function_end(txt, st)
    if (is.na(en)) next
    block <- substr(txt, st2, en)
    out[[length(out) + 1L]] <- list(name = starts$name[i], start = st2, end = en, block = block)
  }
  out
}

guess_module <- function(fname) {
  n <- tolower(fname)
  if (grepl("irf", n) || grepl("^girf", n) || grepl("^irf", n)) return("irf.R")
  if (grepl("select", n) || grepl("aic|bic|criteria", n)) return("model_selection.R")
  if (grepl("test|constraint|constrain|lrtest|wald|rzs", n)) return("constraints.R")
  if (grepl("est", n) || grepl("estimate", n)) return("estimation.R")
  if (grepl("data", n)) return("data_input.R")
  if (grepl("sigmanpd", n)) return("diagnostics.R")
  "utils.R"
}

to_snake <- function(x) {
  x <- gsub("\\.", "_", x)
  x <- gsub("([a-z0-9])([A-Z])", "\\1_\\2", x, perl = TRUE)
  x <- gsub("([A-Z]+)([A-Z][a-z])", "\\1_\\2", x, perl = TRUE)
  tolower(x)
}

suggest_new_name <- function(old) {
  util <- list(
    Roots2coef = "roots_to_coef",
    rnormSIGMA = "rnorm_sigma",
    rnormSIGMA_cond = "rnorm_sigma_cond",
    NoutofT = "sample_n_out_of_t",
    IRF_graph = "plot_irf",
    irf_B_sigma = "irf_from_params",
    Embed = "embed_ts",
    Type = "infer_deterministic_type",
    JointX = "bind_exogenous_by_state",
    STAT = "spectral_radius"
  )
  if (!is.null(util[[old]])) return(util[[old]])

  models <- c("MRCIGVAR","MRCIVAR","MRGVAR","CIGVAR","CIVAR","MRVAR","GVAR","VAR")
  for (m in models) {
    if (startsWith(old, m)) {
      prefix <- tolower(m)
      rest <- substr(old, nchar(m) + 1, nchar(old))
      if (rest %in% c("Data","DataR","Datam")) {
        suf <- tolower(substr(rest, 5, nchar(rest)))
        if (nchar(suf) == 0) return(paste0(prefix, "_data"))
        return(paste0(prefix, "_data_", suf))
      }
      if (grepl("^est", tolower(rest))) {
        rr <- gsub("^est", "", to_snake(rest), perl = TRUE)
        return(paste0(prefix, "_estimate", rr))
      }
      if (grepl("select", tolower(rest))) {
        rr <- gsub("select", "", to_snake(rest), perl = TRUE)
        return(paste0(prefix, "_select", rr))
      }
      if (grepl("^test", tolower(rest))) {
        rr <- gsub("^test", "", to_snake(rest), perl = TRUE)
        return(paste0(prefix, "_test", rr))
      }
    }
  }
  to_snake(old)
}

# Apply symbol renames using parse data offsets (avoids strings/comments)
apply_symbol_renames <- function(path, rename_map) {
  lines <- readLines(path, warn = FALSE)
  txt <- paste(lines, collapse = "\n")
  parsed <- try(parse(text = txt, keep.source = TRUE), silent = TRUE)
  if (inherits(parsed, "try-error")) return(FALSE)

  pd <- getParseData(parsed)
  pd <- pd[pd$token %in% c("SYMBOL","SYMBOL_FUNCTION_CALL"), ]
  if (nrow(pd) == 0) return(TRUE)

  # line start offsets
  line_starts <- c(0, cumsum(nchar(lines) + 1))
  # +1 because \n

  edits <- list()
  for (i in seq_len(nrow(pd))) {
    sym <- pd$text[i]
    hit <- rename_map$new_name[match(sym, rename_map$old_name)]
    if (!is.na(hit) && hit != sym) {
      s <- line_starts[pd$line1[i]] + pd$col1[i]
      e <- line_starts[pd$line2[i]] + pd$col2[i]
      edits[[length(edits)+1L]] <- list(start = s, end = e, repl = hit)
    }
  }
  if (length(edits) == 0) return(TRUE)

  # apply from end to start
  edits <- edits[order(vapply(edits, `[[`, numeric(1), "start"), decreasing = TRUE)]
  for (ed in edits) {
    txt <- paste0(substr(txt, 1, ed$start - 1), ed$repl, substr(txt, ed$end + 1, nchar(txt)))
  }
  writeLines(strsplit(txt, "\n", fixed = TRUE)[[1]], path)
  TRUE
}
