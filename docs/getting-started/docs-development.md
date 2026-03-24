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
mkdocs serve
```

By default, the site is available at `http://127.0.0.1:8000/`.

## Build the static site

To validate the site and generate static output:

```bash
conda activate mrcigvar-docs
mkdocs build --strict
```

The built site is written to `site/`, which is intentionally ignored by Git.

## Source of truth

The site is currently assembled from:

- `docs/` for MkDocs-native pages
- `README.Rmd` and `README.md` for package overview material
- `vignettes/*.Rmd` for long-form workflows and migration guidance

When updating user-facing package workflows, keep the corresponding MkDocs page
and vignette aligned.

## Deployment

GitHub Pages deployment is configured in `.github/workflows/mkdocs.yml`.

The workflow installs dependencies from `environment-docs.yml` and runs:

```bash
mkdocs build --strict
```

If the site fails to deploy, verify local build success first.
