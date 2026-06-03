*Feature Built — 2026-06-03*

Ecosystem Registry API
ECOSYSTEM.md is no longer just a Markdown file for humans — it's now a live, machine-readable API. A new GET /api/ecosystem endpoint parses the Markdown table into structured JSON: every project that builds on MiroShark gets exposed as a clean object with name, website, X handle, and GitHub link. A companion GET /api/ecosystem/count returns just the project total, ready for badge rendering or status widgets.

Why this matters:
Four ecosystem projects (HivemindOS, Echo Oracle, Capacitr, SyntheticsAI) submitted PRs in the same week. The ECOSYSTEM.md table is growing, but it's invisible to machines — no downstream tool can query it, render a widget from it, or subscribe to changes. The Ecosystem Registry API turns a PR-based append log into a composable surface. Any project building on MiroShark can now pull the live registry, render an 'ecosystem' widget, or count the network size without scraping Markdown. For the Chinese dev platform hyperstition, this is the asset worth linking to.

What was built:
- backend/app/services/ecosystem_service.py: Regex-based ECOSYSTEM.md table parser. Extracts project name, classifies links (website vs X handle vs GitHub) from the Links column, and caches results for 60 minutes with mtime-based invalidation so merged PRs that update the table are picked up quickly.
- backend/app/api/ecosystem.py: Flask blueprint with two public endpoints — GET /api/ecosystem (full registry with ETag for conditional requests) and GET /api/ecosystem/count (badge-ready total + timestamp).
- frontend/src/views/EcosystemView.vue: New /ecosystem page with responsive card grid. Each project gets a numbered card with clickable link pills for Website, X, and GitHub. Dark-themed with the deep-space-violet design system, bilingual (EN/ZH).
- frontend/src/views/ExploreView.vue: Added an 'Ecosystem' navigation chip to the /explore gallery toolbar, alongside RSS and Verified.
- backend/tests/test_unit_ecosystem.py: 10 unit tests covering parsing, cache behavior, mtime invalidation, missing file handling, and link classification.

How it works:
The service reads ECOSYSTEM.md from the repo root using a line-by-line parser that identifies the GFM table by its | Logo | Project | Links | header. Each data row is split on pipes, the Project column gives the name, and the Links column is scanned with a regex for Markdown links — URLs containing github.com route to the github field, @handle labels route to x_handle, everything else becomes the website. Results cache in a module-level dict keyed on file path, with a 60-minute TTL that invalidates early if the file's mtime changes. Pure stdlib — re, os, time, threading. Zero new dependencies.

What's next:
Could add an ecosystem count to the platform stats badge, or a /api/ecosystem/search endpoint for filtering by name. When ECOSYSTEM.md grows past 30+ projects, pagination would be valuable.

Branch: feat/ecosystem-registry-api (push blocked — GH_GLOBAL not set)
