# Push Recap — 2026-11-28

## Overview
2 substantive commits by Aaron Elijah Mars (0 automation commits filtered). Both PRs landed within 11 minutes of each other early UTC, completing MiroShark's migration to the `aeonfun` GitHub organization: every link, badge, deploy button, Docker reference, and CI guard in the codebase now points to `aeonfun/MiroShark`, and the prebuilt Docker image has been retired entirely.

**Stats:** 24 files changed, +42/-115 lines across 2 substantive commits

---

## aaronjmars/MiroShark

### Repo Ownership Migration — All Links Rewritten to `aeonfun`
**Summary:** PR #371 performs a comprehensive find-and-replace across the entire codebase, updating every GitHub URL and org reference from the old owners (`aaronjmars/MiroShark`, `MiroShark/MiroShark`) to the new organization `aeonfun/MiroShark`. The old URLs redirect, but this commit makes every internal reference canonical.

**Commits:**
- `714251c` — chore: point links to the new repo owner (#371)
  - Changed `.github/README.md`: Star and fork badge shields now point to `aeonfun/MiroShark`, "Star us" button updated, clone URL in quickstart changed (+4/-4 lines)
  - Changed `.github/README.fr.md`: French README badges and clone URL updated to `aeonfun` (+3/-3 lines)
  - Changed `.github/README.ja.md`: Japanese README badges and clone URL updated to `aeonfun` (+3/-3 lines)
  - Changed `.github/README.zh-CN.md`: Chinese README badges and clone URL updated to `aeonfun` (+3/-3 lines)
  - Changed `.github/SECURITY.md`: Private vulnerability reporting link and supported-versions reference now point to `aeonfun/MiroShark` (+2/-2 lines)
  - Changed `.github/workflows/docker-image.yml`: CI owner guard changed from `'MiroShark'` to `'aeonfun'`; ghcr.io comment updated (+2/-2 lines) — this file was subsequently removed by PR #372
  - Changed `ECOSYSTEM.md`: x402aff repo link updated from `MiroShark/x402aff` to `aeonfun/x402aff` (+1/-1 lines)
  - Changed `backend/app/api/docs.py`: Swagger UI nav links for docs/API.md and GitHub now point to `aeonfun` (+2/-2 lines)
  - Changed `backend/app/api/mcp.py`: MCP status payload `docs_url` updated to `aeonfun` (+1/-1 lines)
  - Changed `backend/app/api/simulation.py`: RSS feed fetcher User-Agent header now references `aeonfun/MiroShark` (+1/-1 lines)
  - Changed `backend/app/services/ecosystem_catalog.py`: x402aff repo URL in hardcoded catalog updated to `aeonfun` (+1/-1 lines)
  - Changed `backend/app/services/feed.py`: Atom `<generator>` URI and RSS generator string both updated to `aeonfun` (+2/-2 lines)
  - Changed `backend/app/services/replay_gif.py`: Footer watermark in both regular and empty replay GIF frames changed to `github.com/aeonfun/MiroShark` (+2/-2 lines)
  - Changed `backend/app/services/share_card.py`: Share card image footer watermark updated to `aeonfun` (+1/-1 lines)
  - Changed `backend/openapi.yaml`: OpenAPI spec contact URL, license URL, and PR number reference all updated to `aeonfun` (+3/-3 lines)
  - Changed `docker-compose.ollama.yml`: Docker image reference updated from `ghcr.io/miroshark/miroshark` to `ghcr.io/aeonfun/miroshark` (+1/-1 lines)
  - Changed `docker-compose.yml`: Same Docker image reference update (+1/-1 lines)
  - Changed `docs/INSTALL.md`: All 4 deploy/clone URLs (Railway button, Render button, manual clone, Docker clone) updated to `aeonfun` (+4/-4 lines)
  - Changed `docs/INSTALL.zh-CN.md`: Same 4 deploy/clone URLs in the Chinese install guide (+4/-4 lines)
  - Changed `frontend/src/components/EmbedDialog.vue`: Webhook verification docs link and notification docs link updated (+2/-2 lines)
  - Changed `frontend/src/components/SettingsPanel.vue`: `.env.example` link and webhook docs link updated (+2/-2 lines)
  - Changed `frontend/src/components/SiteFooter.vue`: GitHub footer link updated (+1/-1 lines)
  - Changed `frontend/src/views/ExploreView.vue`: GitHub link in explore page header updated (+1/-1 lines)
  - Changed `frontend/src/views/Home.vue`: GitHub nav link on home page updated (+1/-1 lines)

**Impact:** The repo is now fully self-consistent under the `aeonfun` organization. Badge counts, deploy buttons, clone instructions, User-Agent strings, GIF/share-card watermarks, and every documentation link all point to the canonical owner. No more mixed references to the old org. Old GitHub redirects still work, but tools and scrapers that parse URLs (rather than following redirects) will now hit the right target.

### Docker Image Retirement
**Summary:** PR #372 removes the Docker image publishing pipeline entirely and strips the prebuilt image reference from both compose files. MiroShark no longer publishes `ghcr.io/aeonfun/miroshark:latest` — users always build from the local Dockerfile.

**Commits:**
- `b4f6c9f` — chore: stop publishing a Docker image (#372)
  - Removed `.github/workflows/docker-image.yml`: The entire 69-line CI workflow deleted — it used Blacksmith runners, GHCR login, Docker metadata, and build-push to publish images on main pushes and tags (+0/-69 lines)
  - Changed `docker-compose.yml`: Removed `image: ghcr.io/aeonfun/miroshark:latest` line and updated comment to "Builds from the local Dockerfile (no prebuilt image is published)" (+1/-3 lines)
  - Changed `docker-compose.ollama.yml`: Same removal of image reference and comment update (+1/-3 lines)

**Impact:** Self-hosters now always build from source when running `docker compose up`. This eliminates the CI cost of Blacksmith runner minutes, removes a moving target (the `:latest` tag could drift from main), and simplifies the deployment story to one path: clone and build. The tradeoff is slightly longer first-start times for Docker users since there's no prebuilt layer cache on GHCR.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** Anyone running `docker compose pull` will no longer get a prebuilt image — they must use `docker compose up --build` or just `docker compose up` (which triggers the build). The `image:` key was removed, so compose falls through to the `build: .` directive automatically.
- **Architecture shifts:** The repo has formally migrated from `aaronjmars` (personal account) and `MiroShark` (org) to `aeonfun` as the canonical GitHub owner. This is a naming/governance change, not a technical one.
- **Tech debt:** None introduced. The link cleanup is thorough — 22 files across 4 README languages, 2 install doc languages, backend services, frontend components, OpenAPI spec, and Docker configs all updated in one pass.

## What's Next
- The `aaronjmars/MiroShark` redirects will continue working, but any external documentation, ecosystem partner links, or bookmarks pointing to the old org should be updated to `aeonfun/MiroShark`.
- With the Docker image gone, the INSTALL docs already reflect build-from-source as the only path. No follow-up needed there.
- The founder's consecutive-day commit streak continues (at least 3 of the last 8 days with direct commits). Combined with the org migration, this signals active project governance — a contrast to the 144-day social silence.
