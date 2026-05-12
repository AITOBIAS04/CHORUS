*Feature Built — 2026-05-12*

Agent Persona Library
MiroShark simulations now have a reusable persona library. Instead of generating a fresh agent population from scratch every time, researchers can save specific agent configurations — archetype, platform preference, initial belief stance, a 500-character backstory, and behavioral tags — and reuse them across different simulations. Think of it as a casting directory for your simulation agents: save an "ESG Investment Director" once, then drop them into any scenario alongside auto-generated agents.

Why this matters:
Until now, every MiroShark simulation generated its entire agent population procedurally from the scenario text. Two runs of the same scenario with different seeds produced different agent populations — which is stochastic by design but creates a reproducibility problem. A researcher who wants to test "how does this specific agent population respond to five different scenarios?" had no way to save and reuse an agent configuration. The Persona Library closes this gap. Combined with the Reproducibility Config Export (PR #75) which captures what was run, and Per-Agent Trajectory Export which captures individual-level data, the Persona Library captures who was run — the third leg of fully citable, reproducible simulation claims.

What was built:
- backend/app/services/persona_library.py: Pure stdlib CRUD service storing one JSON file per persona under uploads/persona_library/. Atomic writes via tempfile + os.replace. Path traversal protection. Search by keyword across label/archetype/backstory/tags. Filter by archetype, platform, stance. Sort by date or usage count. Fork (copy) any persona into a new entry. Fire-and-forget usage counter that increments each time a persona is included in a simulation.
- backend/app/api/personas.py: 5 REST endpoints — GET /api/personas/list (with filters), GET /api/personas/<id>, POST /api/personas/create, DELETE /api/personas/<id>, POST /api/personas/<id>/fork. Full i18n error messages (EN/ZH). Blueprint registered at /api/personas.
- frontend/src/components/PersonaLibrary.vue: Standalone panel integrated into the Step 2 Configure view. Create form with archetype dropdown (13 options from analyst to policymaker), platform selector, initial stance picker, backstory textarea with character counter, comma-separated tag input. Two-column browsable card grid with selection toggle (click to include in next simulation). Fork and delete actions on hover. Stance badges color-coded (green=YES, red=NO, amber=MIXED). Usage count display. Selection summary bar.
- backend/tests/test_unit_persona_library.py: 22 offline unit tests covering CRUD, filtering, sorting, forking, usage tracking, input validation, backstory length capping, tag limits, stance weight clamping, and path traversal blocking.

How it works:
Each persona is stored as an individual JSON file (one per persona) in the uploads/persona_library/ directory — simple, inspectable, and git-friendly. The service uses atomic writes (tempfile.mkstemp + os.replace) so concurrent requests can't corrupt the file. The frontend PersonaLibrary panel loads inside the Step 2 Configure card, right below the auto-generated agent profiles. Users can create personas from scratch or fork existing ones, then click to select which personas should be pinned in the next simulation run. Selected personas occupy slots in the agent roster, reducing the auto-generated count by one per pinned persona. All 13 archetype options (analyst, influencer, retail, observer, institutional, academic, journalist, activist, trader, developer, executive, policymaker, custom) are bilingual (EN/ZH).

What's next:
When GH_GLOBAL is set, this feature — along with 11 other completed features — will be pushed and PR'd. Future follow-ups: community persona catalog (public personas browsable across instances), persona import/export as JSON, and integration with the Reproducibility Config Export so shared configs include persona library references.

Status: code complete, push blocked (GH_GLOBAL not set — 12th consecutive block)
