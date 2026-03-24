# API Migration Guide

This page explains how to move from legacy function names to the refactored
snake_case API.

The package still provides compatibility wrappers for many older names, but new
code should use the refactored API directly.

## What changed

The refactor standardises public function names around:

- lower snake_case
- model-family prefixes
- predictable workflow suffixes such as `_data`, `_estimate`, `_select_`, and
  `_cb`

This makes the package easier to navigate and keeps related model families
aligned.

## Common renaming patterns

Typical migrations look like this:

| Legacy name | Refactored name |
| --- | --- |
| `CIGVARData()` | `cigvar_data()` |
| `CIGVARest()` | `cigvar_estimate()` |
| `GVARData()` | `gvar_data()` |
| `GVARest()` | `gvar_estimate()` |
| `BoAoW2G()` | `bo_ao_w2_g()` |
| `B2CIB()` | `b2_cib()` |
| `CIA2A()` | `cia2_a()` |
| `CIB3B()` | `cib3_b()` |
| `ABSVAR()` | `absvar()` |

## Recommended migration strategy

When updating older scripts:

1. replace legacy function names with the new snake_case names
2. keep the same workflow order: data, estimate, select, respond
3. re-run examples to verify output shapes and object fields
4. update any user-facing documentation that still uses legacy names

## Example migration

Old style:

```r
res_d <- CIGVARData(m = 2, n = 4, p = p, T = 200, type = "const")
res_e <- CIGVARest(res_d)
IRF   <- IRF_CIGVAR_CB(res = res_e, nstep = 12)
```

Refactored style:

```r
res_d <- cigvar_data(m = 2, n = 4, p = p, T = 200, type = "const")
res_e <- cigvar_estimate(res_d)
irf_cb <- irf_cigvar_cb(res = res_e, nstep = 12, comb = NA, irf = "gen1")
```

## Compatibility wrappers

Legacy compatibility wrappers live in `R/compat-legacy-aliases.R`.

They are auto-generated and should not be edited by hand. Their purpose is to
help older user code transition gradually, not to define the preferred API.

## Contributor guidance

If you rename or reorganise a public function:

- preserve backward compatibility where practical
- keep the new name aligned with the family conventions
- update user-facing examples and vignettes
- avoid adding hand-written deprecated wrappers outside the generated alias file
