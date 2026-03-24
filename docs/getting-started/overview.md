# Overview

`MRCIGVAR` is an econometrics package for data generation, estimation, model
selection, diagnostics, and impulse response analysis across several related
time-series model classes.

## Supported model families

The package currently supports workflows for:

- `VAR`
- `CIVAR`
- `MRVAR`
- `MRCIVAR`
- `GVAR`
- `CIGVAR`
- `MRGVAR`
- `MRCIGVAR`

## Design conventions

The refactored public API follows a family-based naming convention:

- `*_data()` for data generators and constructors
- `*_estimate()` for estimation routines
- `*_select_*()` for model-selection helpers
- `irf_*()` for impulse response functions
- `girf_*()` for generalized impulse response functions

Examples:

- `cigvar_data()`, `cigvar_estimate()`, `cigvar_select_()`
- `mrcigvar_data()`, `mrcigvar_estimate()`, `mrcigvar_select_()`
- `irf_cigvar_cb()`, `irf_mrcigvar_cb()`

## Typical package workflow

For most model families, the high-level workflow is:

1. Generate or prepare a model object with `*_data()`.
2. Estimate the model with `*_estimate()`.
3. Compare alternative lag or threshold specifications with `*_select_*()`.
4. Compute IRFs or GIRFs with `irf_*()` or `girf_*()`.
5. Plot responses with `plot_irf()` where applicable.

The exact arguments differ by model family, but the object flow is designed to
remain consistent.

## Recommended reading order

- Start with the core workflows if you are new to the package.
- Move to the MRCIGVAR workflow for regime-switching global models.
- Use the IRF and GIRF guide when response analysis becomes the main task.
- Use the migration guide when updating older scripts to the refactored API.
