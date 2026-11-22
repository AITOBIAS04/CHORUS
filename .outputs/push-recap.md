*Push Recap — 2026-11-22*
aaronjmars/MiroShark — 2 substantive commits by aaronjmars

CI/CD Infrastructure Overhaul: Docker images now publish automatically from main on every relevant push (previously tag-only). All 4 CI jobs switched from paid Blacksmith runners to free GitHub-hosted ubuntu-latest — sub-30s jobs meant queue wait was the bottleneck. Dependabot reconfigured to group ALL updates (majors included) into one weekly PR per ecosystem.

Dependency Updates: Bundled Dependabot PR merges week's bumps — DOMPurify 3.4.18 (XSS patch), Marked 18.2.1, vue-router 5.5.1, setup-uv v10.4.0. Notable transitive: chokidar 5→6 (Node >=22.22 required).

Key changes:
- Docker image reference moved from ghcr.io/aaronjmars/miroshark to ghcr.io/miroshark/miroshark — forks using old path will 404
- docker-compose.yml now has build: . fallback so compose works without a published image
- Blacksmith runners removed across all CI jobs (unit, frontend, camel-smoke, lint)

Stats: 7 files changed, +139/-86 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-11-22.md
