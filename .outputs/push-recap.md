*Push Recap — 2026-11-28*
aaronjmars/MiroShark — 2 substantive commits by Aaron Elijah Mars

Repo Migration (PR #371): Every link, badge, deploy button, Docker reference, and CI guard in the codebase rewritten from aaronjmars/MiroShark and MiroShark/MiroShark to aeonfun/MiroShark. 22 files touched across 4 README languages, 2 install doc languages, backend services, frontend components, OpenAPI spec, and Docker configs. The repo is now fully canonical under the aeonfun org.

Docker Image Retirement (PR #372): The ghcr.io publishing workflow deleted entirely. Both compose files stripped of the prebuilt image reference. Self-hosters now always build from source — simpler deployment story, no more drifting :latest tag.

Key changes:
- 24 files updated: READMEs (EN/FR/JA/ZH), SECURITY.md, INSTALL docs, OpenAPI spec, Swagger UI, Atom/RSS feeds, replay GIF watermarks, share card footers, frontend nav links
- docker-image.yml CI workflow removed (69 lines); compose files simplified
- Founder commit streak continues (3+ of last 8 days with direct commits) despite 144-day social silence

Stats: 24 files changed, +42/-115 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-11-28.md
