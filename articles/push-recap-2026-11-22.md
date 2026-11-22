# Push Recap — 2026-11-22

## Overview
2 substantive commits by aaronjmars (0 automation commits filtered). The founder returned for a second consecutive day with a CI/CD infrastructure sprint — publishing Docker images from main, switching to GitHub-hosted runners, overhauling Dependabot grouping strategy, and bundling the week's dependency bumps into a single PR.

**Stats:** 7 files changed, +139/-86 lines across 2 substantive commits

---

## aaronjmars/MiroShark

### CI/CD Infrastructure Overhaul
**Summary:** A comprehensive cleanup of the project's build and deployment pipeline. Docker images are now published automatically from main (previously only on tags), CI jobs run on free GitHub-hosted runners instead of paid Blacksmith instances, and Dependabot is reconfigured to group all updates (majors included) into one PR per ecosystem per week — eliminating the manual close-and-rebatch workflow.

**Commits:**
- `5dc8679` — ci: publish the Docker image from main, fix compose image, GitHub runners for tests (#364)
  - Changed `.github/workflows/docker-image.yml`: Added `push: branches: [main]` trigger with path filters (Dockerfile, backend/**, frontend/**, package.json, etc.) so a `latest` image is published on every relevant main push; added concurrency group to cancel superseded builds (+15 lines)
  - Changed `.github/workflows/tests.yml`: Switched all 4 CI jobs (unit, frontend, camel-smoke, lint) from Blacksmith runners (`blacksmith-2vcpu-ubuntu-2404`) to `ubuntu-latest` — public repo with sub-30s jobs means Blacksmith's queue wait was the biggest overhead (+6, -4 lines)
  - Changed `.github/dependabot.yml`: Renamed all dependency groups from `*-minor-patch` (which excluded majors) to `*-weekly` with `patterns: ["*"]` (catches everything); added new `docker-weekly` group for the Docker base image (+21, -20 lines)
  - Changed `docker-compose.yml`: Updated image reference from `ghcr.io/aaronjmars/miroshark:latest` to `ghcr.io/miroshark/miroshark:latest` (org-level package); added `build: .` fallback so compose works with no published image; removed the nju.edu.cn mirror line (+4, -3 lines)
  - Changed `docker-compose.ollama.yml`: Same image/build changes as docker-compose.yml (+4, -3 lines)

**Impact:** Docker Hub consumers now get a fresh `latest` image on every main push instead of waiting for a tag. Blacksmith removal eliminates runner queue overhead for jobs that complete in under 30 seconds. The Dependabot change means major version bumps no longer require manual batching — they roll into the weekly group automatically.

### Dependency Updates
**Summary:** A single bundled PR merges the week's Dependabot bumps across frontend packages and CI tooling — the first PR to exercise the new "majors included" grouping strategy from the CI overhaul commit.

**Commits:**
- `6caf74b` — chore(deps): bundle dependabot bumps 2026-11-21 (#365, #366) (#367)
  - Changed `.github/workflows/tests.yml`: Bumped `astral-sh/setup-uv` from v10.3.3 to v10.4.0 (+2, -2 lines)
  - Changed `frontend/package.json`: Updated `dompurify` 3.4.17→3.4.18, `marked` 18.2.0→18.2.1, `vue-router` 5.5.0→5.5.1 (+3, -3 lines)
  - Changed `frontend/package-lock.json`: Lock file updates for the above + transitive dependency bumps: `chokidar` 5.0.0→6.0.0 (Node >=22.22), `@vue/devtools-api` 8.1.5→8.2.1, `unplugin` 3.4.0→3.7.0, `local-pkg` 1.x→2.0.0, `magic-string` 1.4.3→1.4.5, `confbox` 0.3.1→0.3.2, `readdirp` 5.0.0→5.1.1 (+84, -51 lines)

**Impact:** Security and stability patches for DOMPurify (XSS sanitizer) and Marked (Markdown renderer). The chokidar 6.0 bump raises the minimum Node requirement for the vue-router plugin to Node 22.22 — worth noting for self-hosters on older Node versions.

---

## Developer Notes
- **New dependencies:** None added; several bumped to new major versions (`chokidar` 5→6, `local-pkg` 1→2)
- **Breaking changes:** `chokidar` 6.0.0 requires Node >= 22.22 (up from >= 20.19.0); Docker image reference changed from `ghcr.io/aaronjmars/miroshark` to `ghcr.io/miroshark/miroshark` — forks pulling the old path will get 404s
- **Architecture shifts:** CI moved from paid Blacksmith runners to free GitHub-hosted runners; Docker publishing now continuous from main instead of tag-only
- **Tech debt:** The old nju.edu.cn mirror line is removed — anyone who was using it will need to update

## What's Next
- The Docker image should now be live at `ghcr.io/miroshark/miroshark:latest` — first build from the new main-push trigger
- The new Dependabot grouping strategy will be tested with next week's bumps — expect one PR per ecosystem instead of the previous minor/patch + individual major split
- Two days of consecutive founder activity (Nov 21–22) after 138 days of social silence — the CI sprint suggests preparation for broader changes or a release
