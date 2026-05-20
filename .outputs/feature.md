*Feature Built — 2026-05-20*

Curator Collections
MiroShark now has a curation layer above the gallery. Anyone can create a named, ordered collection of simulations — a "playlist" of runs arranged to make an argument, tell a story, or bundle citations. Each collection lives at its own shareable URL (/collections/<id>) and preserves the curator's chosen order, not the algorithmic default.

Why this matters:
The gallery at /explore is comprehensive and the trending sort surfaces engagement leaders, but neither lets a researcher say "here are the 6 governance simulations that informed this paper, in this order." Until now, linking to MiroShark meant linking to individual simulations — there was no way to present a curated set as a single artifact. Curator Collections fills this gap with the lightest possible implementation. For academic users, a collection is a citation bundle; for community curators, it's the difference between "browse the gallery" and "walk through my argument."

What was built:
- backend/app/services/collections.py: Pure-stdlib CRUD service with atomic JSON persistence. Create, read, update, delete, and list collections. Path-traversal validation on sim IDs, title/description length caps, deduplication, max 50 sims per collection. Automatic removal propagation when a simulation is deleted.
- backend/app/api/collections.py: 5 REST endpoints at /api/collections — list public, get detail (with full simulation summaries including consensus data), create, update, delete. Mutation endpoints gated on the same MIROSHARK_ADMIN_TOKEN as publish/resolve/outcome.
- GET /api/simulation/:id/collections: Cross-link endpoint that returns which public collections contain a given simulation, enabling "Appears in N collection(s)" badges on simulation detail pages.
- frontend/src/views/CollectionsView.vue: Gallery page for browsing public collections. Each card shows the collection title, description, sim count, and up to 3 scenario previews from the ordered list. Dark-theme design matching ExploreView.
- frontend/src/views/CollectionDetailView.vue: Single-collection page with simulations displayed in the curator's chosen order. Each sim shows a rank badge (1, 2, 3...), scenario excerpt, agent/round metadata, and a consensus bar (bullish/neutral/bearish). Share button copies the collection URL.

How it works:
Collections are stored as JSON files at <uploads>/collections/<id>/meta.json — one directory per collection, atomic writes via tempfile + os.replace to prevent corruption under concurrent access. The service layer validates all inputs (title max 60 chars, description max 200, sim_ids checked for path traversal, duplicates removed) and caps total collections at 500. The API blueprint mounts at /api/collections with admin-token auth on mutations. The detail endpoint enriches each sim_id with scenario text, consensus data, agent count, and model name by reading the simulation's on-disk config and trajectory files. Frontend routes /collections and /collections/:id are added to Vue Router, and a Collections chip on the /explore gallery provides the discovery path. 22 unit tests cover CRUD, validation, cross-references, and persistence. OpenAPI spec updated with 6 new schemas under a Collections tag. Bilingual docs (English + Chinese) in FEATURES.md.

What's next:
Push blocked (GH_GLOBAL not set — 19th consecutive feature stuck as local commit). Once the secret is configured, this and 18 other built features can be pushed and opened as PRs. Next feature candidate from the May 16 repo-actions batch: Scenario Pre-flight Analyzer.
