*Feature Built — 2026-05-03*

Community Template Gallery
MiroShark now has a community-driven scenario template gallery at /templates. Instead of starting from scratch or being limited to the 6 preset scenarios, users can browse 10 domain-specific simulation templates — covering US elections, EU AI Act regulation, DeFi governance tokens, corporate whistleblowing crises, climate policy votes, sports scandals, startup acquisitions, central bank rate decisions, product recalls, and scientific controversies — and launch any of them in one click. After running a simulation, users can also save their own scenario as a reusable template for the community.

Why this matters:
MiroShark just crossed 1,000 stars with 204 forks, but the path from 'install the repo' to 'run your first simulation' still had friction — users had to either upload a document, type a question, or pick from just 6 generic presets. The community template gallery drops that barrier to under 30 seconds: pick a domain, click launch. Each template is also a discovery entry point — someone searching for 'AI regulation simulation' or 'DeFi governance sentiment analysis' now has a direct path in. For the growing academic and research cohort, these templates are starter kits for domain-specific simulation studies.

What was built:
- backend/app/api/templates.py: Five new API endpoints for community templates — list (with tag/search/sort filters), get, create, use (increments count + returns launch config), and admin-only delete. File-based JSON storage consistent with MiroShark's existing architecture.
- backend/app/community_templates/ (10 files): Curated seed templates with rich scenario descriptions and pre-configured agent counts, rounds, and platform selections. Each includes a detailed seed document with data points, market context, and stakeholder dynamics.
- frontend/src/views/TemplatesView.vue: New gallery page at /templates with tag chip filters (crypto, policy, crisis, etc.), full-text search, sort options (most used / newest / alphabetical), and one-click launch that pre-fills the simulation setup.
- frontend/src/components/HistoryDatabase.vue: 'Save as Template' section added to the simulation detail modal for completed runs — name, description, tag picker, and save to the community gallery.
- Navigation, README, OpenAPI spec, FEATURES.md, API.md all updated.

How it works:
Community templates are stored as JSON files alongside the existing simulation data directory — no database needed, consistent with MiroShark's file-based architecture. Seed templates ship in backend/app/community_templates/ and user-created templates go to uploads/community_templates/. The frontend gallery fetches them via GET /api/templates/community with optional tag, search, and sort parameters. When a user clicks 'Use template', the backend increments the use count and returns the full config (simulation_requirement + seed_document), which gets injected into the simulation setup flow via the existing setPendingTemplate store. The 'Save as Template' flow in the history modal captures the simulation_requirement, platform config, and agent/round counts from the completed simulation and POSTs a new community template.

What's next:
Once GH_GLOBAL is configured, this PR can be pushed. Future enhancements: upvote/downvote on templates, template categories page, and auto-suggest templates based on trending topics.

PR: code complete on branch feat/community-template-gallery (push blocked — GH_GLOBAL not set)
