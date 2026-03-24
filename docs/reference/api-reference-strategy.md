# API Reference Strategy

`MkDocs` is a good fit for narrative documentation, package guides, workflows,
and contributor-facing explanations. It is not, by itself, a native R package
reference generator.

## What this means for MRCIGVAR

This site should be treated as the primary human-facing documentation layer for:

- package overview
- conceptual explanations
- workflow guides
- migration notes
- curated examples

Function-by-function API reference still needs a source strategy.

## Recommended options

### Option 1: Keep MkDocs for guides and add generated reference pages

Generate Markdown from roxygen or `man/*.Rd` outputs and publish those pages
inside `docs/reference/`.

This keeps one site, but requires a generation step and consistent formatting.

### Option 2: Use MkDocs for guides and pkgdown for API reference

Use `MkDocs` as the front door for documentation and keep `pkgdown` for
function-level reference pages generated from the package source.

This is the lowest-risk path if complete R API reference becomes a priority.

### Option 3: Curate only the most important API pages

Document the major exported workflows manually instead of reproducing every
function page.

This is the lightest maintenance path, but it does not replace full reference
documentation.

## Suggested near-term path

For this repository, the pragmatic next step is:

1. use `MkDocs` as the main documentation site
2. migrate and expand the current vignette content
3. add curated reference pages for the main workflows first
4. decide later whether to generate full API reference or adopt `pkgdown`

That gives you a usable documentation site now without blocking on a full R
documentation publishing pipeline.
