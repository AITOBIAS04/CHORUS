# Push Recap — 2026-07-14

## Overview
4 substantive commits by 2 authors (12 automation commits filtered). The main thrust today was organizational housekeeping: the MiroShark repo was transferred to a dedicated GitHub org and all in-repo links were canonicalized across both the main project and its aeon agent. A minor dependency bump and a skill toggle round out a quiet maintenance day.

**Stats:** 28 files changed, +44/-44 lines across 4 substantive commits

---

## aaronjmars/MiroShark

### Org Migration: Links Canonicalized to MiroShark/MiroShark
**Summary:** The MiroShark repo was transferred from `aaronjmars/MiroShark` to the new `MiroShark/MiroShark` org. All 25 in-repo references across 14 files were updated to point at the canonical slug. Two stale ecosystem repo slugs were also corrected: `AntFleet/miroshark-bench` → `AntFleet/bench-miroshark` and `OriginTrail/dkg-v9` → `OriginTrail/dkg`.

**Commits:**
- `66759b0` — chore: migrate GitHub links to MiroShark org, fix stale ecosystem slugs (#247)
  - Changed `backend/openapi.yaml`: Updated contact URL, license URL, and PR reference comment — 3 refs to new org (+3, -3 lines)
  - Changed `backend/app/api/docs.py`: Swagger UI nav links now point to `MiroShark/MiroShark` (+2, -2 lines)
  - Changed `backend/app/api/mcp.py`: MCP status payload `docs_url` updated (+1, -1 lines)
  - Changed `backend/app/api/simulation.py`: RSS feed fetcher User-Agent string updated (+1, -1 lines)
  - Changed `backend/app/services/ecosystem_catalog.py`: AntFleet catalog entry URL corrected to `bench-miroshark` (+2, -2 lines)
  - Changed `backend/app/services/feed.py`: Atom and RSS generator URIs updated (+2, -2 lines)
  - Changed `backend/app/services/replay_gif.py`: Footer watermark in replay GIF frames updated (+2, -2 lines)
  - Changed `backend/app/services/share_card.py`: Share card footer text updated (+1, -1 lines)
  - Changed `docs/DKG.md`: OriginTrail repo link corrected to `dkg` from `dkg-v9` (+1, -1 lines)
  - Changed `docs/FEATURES.md`: Ecosystem catalog example JSON updated (+2, -2 lines)
  - Changed `docs/INSTALL.md`: Clone URLs and deploy button links updated across Railway, Render, and Docker sections (+4, -4 lines)
  - Changed `docs/INSTALL.zh-CN.md`: Same install doc changes for Chinese locale (+4, -4 lines)
  - Changed `frontend/src/components/EmbedDialog.vue`: Webhook and notification doc links updated (+2, -2 lines)
  - Changed `frontend/src/components/SettingsPanel.vue`: `.env.example` link and webhook docs link updated (+2, -2 lines)
  - Changed `frontend/src/components/SiteFooter.vue`: Footer GitHub nav link updated (+1, -1 lines)
  - Changed `frontend/src/views/ExploreView.vue`: GitHub link in explore page header updated (+1, -1 lines)
  - Changed `frontend/src/views/Home.vue`: Home page GitHub nav link updated (+1, -1 lines)
  - Changed `ECOSYSTEM.md`: AntFleet entry corrected to `bench-miroshark` (+1, -1 lines)

**Impact:** All GitHub links across backend, frontend, and docs now resolve without relying on GitHub's redirect. Deploy buttons (Railway, Render) and clone instructions will work correctly for the new org URL. The ecosystem catalog no longer has stale repo slugs.

### Dependency Bump: transformers 5.3.0 → 5.5.0
**Summary:** Dependabot bumped the HuggingFace `transformers` library from 5.3.0 to 5.5.0 in the backend lockfile. This is an indirect dependency update — the wheel actually shrunk slightly (10.6 MB → 10.2 MB).

**Commits:**
- `8782703` — chore: bump transformers in /backend in the uv group (#246)
  - Changed `backend/uv.lock`: Version, sdist URL/hash, and wheel URL/hash updated (+3, -3 lines)

**Impact:** Keeps the ML dependency stack current. No behavioral change expected — `transformers` is an indirect dependency in the backend.

---

## aaronjmars/miroshark-aeon

### Org Migration: Template Refs → aeonfun/aeon
**Summary:** The aeon framework repo was moved to a new org location. All functional references across the agent's tooling, catalog, and apps were updated from `aaronjmars/aeon` to `aeonfun/aeon` so they no longer depend on GitHub's rename redirect.

**Commits:**
- `cd0d158` — chore: point template refs to the new aeonfun/aeon location (#113)
  - Changed `apps/dashboard/components/InstantModeCard.tsx`: Deploy URL default repo updated (+1, -1 lines)
  - Changed `apps/webhook/README.md`: Cloudflare deploy button URL and fork instructions updated (+3, -3 lines)
  - Changed `bin/export-skill`: Install registry URL updated (+2, -2 lines)
  - Changed `bin/generate-packs-json`: Repo field updated (+1, -1 lines)
  - Changed `bin/generate-skills-json`: Repo field and install commands updated (+3, -3 lines)
  - Changed `bin/install-skill-pack`: Registry URL updated (+1, -1 lines)
  - Changed `bin/onboard`: Upstream command URL updated (+1, -1 lines)
  - Changed `catalog/packs.json`: Catalog repo reference updated (+1, -1 lines)
  - Changed `catalog/skills.json`: Catalog repo reference updated (+1, -1 lines)
  - Changed `skills/security/trusted-sources.txt`: Trusted source URL updated (+1, -1 lines)

**Impact:** All tooling commands (`install-skill-pack`, `export-skill`, `onboard`, deploy buttons) now point at the canonical org location. No behavioral change — the old redirect still works but canonical URLs are more robust.

### Skill Configuration: repo-pulse Disabled
**Summary:** The repo-pulse skill was toggled from `enabled: true` to `enabled: false` in the aeon configuration.

**Commits:**
- `9dce9c0` — chore: disable repo-pulse skill
  - Changed `aeon.yml`: `repo-pulse` enabled flag flipped to `false` (+1, -1 lines)

**Impact:** The repo-pulse skill (star/fork/release tracking for watched repos) will no longer run on its scheduled cron. This may be a temporary disable while the MiroShark org transfer settles, or a permanent removal. The CHORUS instance still runs its own repo-pulse independently.

---

## Developer Notes
- **New dependencies:** transformers 5.3.0 → 5.5.0 (indirect, backend only)
- **Breaking changes:** None — all changes are link-only or config toggles
- **Architecture shifts:** MiroShark is now under its own GitHub org (`MiroShark/MiroShark`); aeon framework is now at `aeonfun/aeon`. Old URLs redirect but are no longer canonical.
- **Tech debt:** None introduced

## What's Next
- The org migration is complete for in-repo references. External references (README badges on other repos, social links, blog posts) may still point at `aaronjmars/MiroShark` and need updating.
- The repo-pulse disable on miroshark-aeon suggests either a consolidation of monitoring to CHORUS or a pause during the org transition.
- With the org transfer done, the project may be preparing for a broader public push (new org signals institutional intent beyond a personal repo).
