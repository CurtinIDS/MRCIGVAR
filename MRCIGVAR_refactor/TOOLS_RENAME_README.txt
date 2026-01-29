Renaming tools for MRCIGVAR (starter pack)

What you get
- tools/rename_map.csv: edit this to define OldName -> NewName mappings.
- tools/rename_api.py: rewrites definitions + calls across the repo using whole-symbol matching.
- tools/generate_aliases.R: creates R/compat-legacy-aliases.R wrappers for any rows with keep_alias=TRUE.

Recommended workflow
1) Create a git branch
   git checkout -b refactor/rename-api

2) Review and edit tools/rename_map.csv
   - Start with public API only.
   - Keep keep_alias=TRUE at first so nothing breaks.

3) Run the renamer from repo root
   python3 tools/rename_api.py

4) Generate legacy wrappers (optional but recommended)
   Rscript tools/generate_aliases.R

5) Rebuild docs + run checks
   R -q -e 'devtools::document(); devtools::test(); devtools::check()'

Notes
- Whole-symbol matching avoids renaming substrings.
- This will also update README/vignettes if they include the old function names.
- If you later want to retire old names, keep the wrappers but remove them in a major version bump.
