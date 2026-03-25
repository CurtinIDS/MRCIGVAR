# Docs Development

The documentation site is built with `MkDocs` and the Material theme.

## Install the docs toolchain

Create the docs environment with conda:

```bash
conda env create -f environment-docs.yml
conda activate mrcigvar-docs
```

If the environment already exists, update it with:

```bash
conda env update -f environment-docs.yml --prune
```

## Run the site locally

To start a local preview server:

```bash
conda activate mrcigvar-docs
Rscript scripts/render-docs.R
mkdocs serve
```

By default, the site is available at `http://127.0.0.1:8000/`.

## Build the static site

To validate the site and generate static output:

```bash
conda activate mrcigvar-docs
Rscript scripts/render-docs.R
mkdocs build --strict
```

The built site is written to `site/`, which is intentionally ignored by Git.

## Source of truth

The site is assembled from two source types:

- `README.Rmd` and selected files in `vignettes/*.Rmd` for generated MkDocs pages
- `docs/` for MkDocs-native pages that do not come from R Markdown sources

`README.md` is also generated from `README.Rmd`. Do not edit `README.md` by
hand. Update `README.Rmd`, then rebuild the repository README with:

```bash
Rscript -e "rmarkdown::render('README.Rmd', output_format = 'github_document', quiet = TRUE)"
```

Run `Rscript scripts/render-docs.R` whenever you change `README.Rmd` or a
vignette that feeds the site. The script regenerates:

- `docs/index.md`
- `docs/getting-started/overview.md`
- `docs/workflows/core-model-workflows.md`
- `docs/workflows/mrcigvar-workflow.md`
- `docs/workflows/irf-and-girf.md`
- `docs/reference/migration-guide.md`

Do not edit those generated files by hand.

## Deployment

GitHub Pages deployment is configured in `.github/workflows/mkdocs.yml`.

The workflow installs dependencies from `environment-docs.yml` and runs:

```bash
Rscript scripts/render-docs.R
mkdocs build --strict
```

If the site fails to deploy, verify local build success first.
