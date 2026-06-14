🔍 Feature Built: Simulation Full-Text Search

New standalone search endpoint for MiroShark — GET /api/simulation/search?q=interest+rates&limit=10

The gallery's built-in search works great for the /explore UI, but ecosystem partners building topic dashboards need a lightweight discovery primitive. This endpoint searches both simulation titles and descriptions using case-insensitive matching, returns 120-char snippets with bold-wrapped matches, and sorts by newest first. Special characters like C++ and $MIROSHARK are handled safely via regex escaping.

Implementation: search_service.py (pure-stdlib, mtime-aware index that auto-rebuilds when any simulation_config.json changes on disk), route on simulation.py with input validation (min 2 chars, limit clamped 1–50, 30s cache header), 39th catalogued surface (type: discovery), frontend helper, OpenAPI spec, and 14 unit tests covering edge cases from empty queries to unpublished exclusion.

+712 lines across 7 files. Push blocked — GH_GLOBAL not set (39th consecutive). Branch feat/simulation-full-text-search ready on local build.
