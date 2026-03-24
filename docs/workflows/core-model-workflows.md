# Core Model Workflows

This page collects the standard workflows for the core single-regime model
families in `MRCIGVAR`:

- `VAR`
- `CIVAR`
- `GVAR`
- `CIGVAR`

The main object flow across these families is:

1. build data with `*_data()`
2. estimate with `*_estimate()`
3. compare specifications with `*_select_*()`
4. inspect responses with `irf_*()`

## VAR

```r
res_d <- var_data(n = 3, p = 2, T = 200, type = "const")
res_e <- var_estimate(res = res_d)

res_e$Summary
irf_cb <- irf_var_cb(res = res_e, nstep = 12, comb = NA, irf = "gen1")
plot_irf(irf_cb)
```

Use the VAR workflow when you want a baseline multivariate benchmark without
cointegration or cross-country weighting.

## CIVAR

```r
res_d <- civar_data(
  n = 4,
  p = 2,
  T = 150,
  Co = matrix(0, 4, 1),
  type = "none",
  crk = 1
)

res_e <- civar_estimate(res = res_d)
res_e$Summary

irf_cb <- irf_civar_cb(
  res = res_e,
  nstep = 12,
  comb = NA,
  irf = "gen1",
  runs = 50,
  conf = c(0.05, 0.95)
)
```

Compared with `VAR`, the CIVAR workflow introduces explicit cointegration rank
handling.

## GVAR

```r
n <- 4
p <- matrix(0, nrow = n, ncol = 3)
p[, 1] <- 2
p[, 2] <- 1

res_d <- gvar_data(m = 2, n = n, p = p, T = 200, type = "const")
res_e <- gvar_estimate(res = res_d)

res_e$Summary
sel <- gvar_select_(res = res_d, L_V = c(3, 3), I = 1)
irf_cb <- irf_gvar_cb(res_e, nstep = 10, comb = NA, irf = "gen1")
```

`GVAR` extends the country-level setup by combining domestic and foreign blocks
through the weighting matrix `W`.

## CIGVAR

```r
n <- 4
p <- matrix(0, nrow = n, ncol = 3)
p[, 1] <- 2
p[, 2] <- 2

res_d <- cigvar_data(
  m = 2,
  n = n,
  p = p,
  T = 200,
  type = "const",
  DFYflag = 0
)

res_e <- cigvar_estimate(res_d)
res_e$Summary

sel <- cigvar_select_(res = res_e, L_V = c(3, 3))
irf_cb <- irf_cigvar_cb(
  res = res_e,
  nstep = 12,
  comb = NA,
  irf = "gen1",
  runs = 50,
  conf = c(0.05, 0.95)
)
```

`CIGVAR` combines the global structure of `GVAR` with the cointegrated
representation used in `CIVAR`.

## Cross-family conventions

Across these model families:

- data constructors return rich model objects rather than raw matrices
- estimation functions usually augment the input object
- summary fields are stored in `res$Summary`
- IRF functions reuse the same core arguments such as `res`, `nstep`, `comb`,
  `irf`, `runs`, and `conf`
