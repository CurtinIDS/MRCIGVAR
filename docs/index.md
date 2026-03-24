# MRCIGVAR

`MRCIGVAR` provides data-generation, estimation, model-selection, testing, and
impulse-response tools for a family of global and regime-switching multivariate
time-series models.

The package covers:

- `VAR`
- `CIVAR`
- `MRVAR`
- `MRCIVAR`
- `GVAR`
- `CIGVAR`
- `MRGVAR`
- `MRCIGVAR`

## What this site is for

This documentation site is intended to be the most navigable entry point for
the project. It focuses on:

- model-family overviews
- end-to-end workflows
- response-analysis guidance
- migration notes for the refactored API

The package is currently under active refactoring toward a consistent public API
based on lower snake_case function names.

## Documentation map

Start with the sections that match your use case:

- **Getting Started** for package scope and installation
- **Workflows** for model-family examples and practical usage patterns
- **Reference** for API migration guidance and documentation strategy

## Refactored API

The refactor standardises naming around predictable suffixes:

- `*_data()` for data generators and constructors
- `*_estimate()` for estimation routines
- `*_select_*()` for model-selection helpers
- `irf_*()` and `girf_*()` for response analysis

Examples:

- `cigvar_data()`, `cigvar_estimate()`
- `mrcigvar_data()`, `mrcigvar_estimate()`
- `irf_cigvar_cb()`, `irf_mrcigvar_cb()`

Legacy aliases remain available where needed, but new code should prefer the
refactored lowercase names.

## Current direction

The current documentation rollout uses existing package materials as the source
for the site structure:

- `README.md` for package positioning
- `vignettes/*.Rmd` for long-form workflows
- `man/*.Rd` and roxygen comments for function-level reference

This means the site can evolve incrementally without forcing a full
documentation rewrite first.
