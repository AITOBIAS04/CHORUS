# Push Recap — 2026-06-22

## Overview
10 substantive commits by 3 authors (36 automation commits filtered). The main thrust today: a brand-new `docs-sync` skill that turns merged product PRs into a changelog on the marketing website — shipped, refined, and had its git attribution fixed within hours. Alongside that, Dependabot swept four CI/Docker/frontend dependency bumps through MiroShark, and Aeon's content pipeline produced the weekly shiplog and a project-lens article.

**Stats:** 16 file changes, +318/-14 lines across 10 substantive commits

---

## aaronjmars/miroshark-aeon

### New Skill: docs-sync (Changelog Pipeline)
**Summary:** A new daily skill that reads the product repo's recently merged PRs, generates a structured changelog entry, and opens a draft PR on the marketing website. Shipped as PR #71, then immediately tightened with two follow-up fixes in the same day.

**Commits:**
- `95523b2` — feat(skill): add docs-sync — publish merged PRs to the website as a changelog (#71)
  - New file `skills/docs-sync/SKILL.md`: Full 179-line skill definition — 7 steps covering PR gathering, idempotency dedup by PR number, classification of highlights vs maintenance noise, changelog entry composition with banned-phrase enforcement, bootstrap path for first-run website setup, and cross-repo branch + PR creation (+179 lines)
  - Changed `aeon.yml`: Added `docs-sync` entry to the skill schedule — enabled, runs daily at 08:00 UTC, requires GH_GLOBAL for cross-repo write (+1 line)
  - New file `memory/docs-sync.md`: Config file mapping product_repo (`aaronjmars/miroshark`) to website_repo (`aaronjmars/miroshark-website`), with tunable lookback window (7 days), min PR threshold (1), and draft mode (true) (+10 lines)

- `170f4db` — docs-sync: hide PR link from notification output (#72)
  - Changed `skills/docs-sync/SKILL.md`: Removed the `PR: <url>` line from the step-6 notification template — the PR URL was leaking internal workflow details into user-facing notifications (-1 line)
  - Changed `.outputs/docs-sync.md`: Stripped the PR link from the existing output artifact to match the template change (-1 line)

- `e7a416c` — fix(attribution): always commit cross-repo work as aeonframework@proton.me (#73)
  - Changed `.github/workflows/aeon.yml`: Switched `git config user.name/email` to `git config --global` so that any repo cloned during a workflow run (e.g. the website repo during docs-sync) inherits the aeonframework identity instead of falling back to an unlinked email (+2/-2 lines)
  - Changed `.github/workflows/chain-runner.yml`: Same repo-local → global git identity fix for the chain runner workflow (+2/-2 lines)
  - Changed `skills/docs-sync/SKILL.md`: Added explicit `git config user.name/email` commands inside the website clone step with a documentation block explaining why — past runs had produced commits attributed to `aeon@miroshark-aeon.bot`, linking to no GitHub account (+4 lines)

**Impact:** The aeon framework can now keep the marketing website's changelog in sync automatically. The skill is config-driven (not hardcoded to any specific repo pair), idempotent by PR number, and filters Dependabot noise into a single rollup line. The two immediate follow-ups show attention to detail: notification cleanup and a git attribution bug that would have created orphan commits on the website repo.

### Weekly Content Output
**Summary:** Aeon's automated content pipeline produced two articles — the weekly shiplog covering the past 7 days of shipping activity, and a project-lens industry comparison piece.

**Commits:**
- `c408214` — chore(shiplog): 2026-06-22 weekly shipping update
  - New file `articles/shiplog-2026-06-22.md`: 38-line weekly recap covering three themes — cost estimate visibility on public embeds (PRs #179, #190), i18n locale threading fixes across DE/FR/ZH (PRs #186, #189, #192, #194, #198), and SearXNG/Firecrawl self-hosted search (PR #178). Stats: 42 commits, 38 PRs merged, 5 issues closed (+38 lines)

- `1da24c3` — chore(log): shiplog 2026-06-22 entry
  - Changed `memory/logs/2026-06-22.md`: Added structured shiplog log entry with commit/PR/issue counts, theme summary, and source verification flags (+9 lines)

- `9045576` — chore(content): project-lens 2026-06-21 — synthetic user research vs social simulation
  - New file `articles/project-lens-2026-06-21.md`: 45-line industry comparison article — synthetic user research platforms (Semilattice, Aaru, Evidenza) achieve 85–90% fidelity on isolated purchase intent but cannot model social influence or opinion contagion; MiroShark's wonderwall/ social layer fills exactly that gap at ~$1/run vs $100K–$250K/year enterprise licenses. Cites PyMC Labs, AIMultiple, and an arXiv paper (+45 lines)
  - Changed `memory/logs/2026-06-21.md`: Added project-lens log entry with angle, thesis, source count, and self-edit gate results (+9 lines)
  - Changed `memory/project-lens-angles.md`: Recorded the industry comparison angle and sources for rotation tracking (+11 lines)

**Impact:** The shiplog gives anyone following the project a week-at-a-glance without reading 38 PRs. The project-lens piece positions MiroShark against the synthetic user research category — a comparison that may resonate with potential users coming from market research backgrounds.

---

## aaronjmars/MiroShark

### Dependency Maintenance (Dependabot)
**Summary:** Four automated dependency bumps keeping CI actions and frontend security patches current. All merged same-day.

**Commits:**
- `d7fce95` — chore: bump docker/setup-qemu-action from 3 to 4 (#199)
  - Changed `.github/workflows/docker-image.yml`: Updated QEMU action version tag v3→v4 for the Docker multi-arch build (+1/-1 line)

- `89ee2a6` — chore: bump docker/metadata-action from 5 to 6 (#200)
  - Changed `.github/workflows/docker-image.yml`: Updated metadata-action version tag v5→v6 for Docker image tagging (+1/-1 line)

- `c3c1965` — chore: bump actions/setup-node from 5 to 6 (#201)
  - Changed `.github/workflows/tests.yml`: Updated setup-node version tag v5→v6 in the test workflow (+1/-1 line)

- `c6c973a` — chore: bump dompurify in /frontend from 3.4.10 to 3.4.11 (#202)
  - Changed `frontend/package.json`: Updated dompurify version constraint ^3.4.10→^3.4.11 (+1/-1 line)
  - Changed `frontend/package-lock.json`: Updated resolved version, integrity hash, and lock entry (+4/-4 lines)

**Impact:** The DOMPurify bump (3.4.10→3.4.11) is a security-relevant patch for the HTML sanitizer used in simulation output rendering. The three CI action bumps (setup-node v6, docker/metadata-action v6, docker/setup-qemu-action v4) are major version upgrades that keep the build pipeline on supported versions.

---

## Developer Notes
- **New dependencies:** dompurify 3.4.11 (patch, frontend security fix)
- **Breaking changes:** None — the three CI action major bumps (v5→v6, v3→v4) are GitHub Actions version tags, not code-level breaking changes
- **Architecture shifts:** Git identity is now set `--global` in both aeon.yml and chain-runner.yml, meaning any repo cloned during a workflow inherits the aeonframework identity. This is a deliberate change to support cross-repo skills like docs-sync
- **Tech debt:** None introduced

## What's Next
- docs-sync ran its first real execution today (the `chore(cron): docs-sync success` commit confirms it). The next visible step is whether the website PR it created gets reviewed and merged — that will validate the full pipeline end-to-end
- The GH_GLOBAL blocker continues (45th consecutive skip for the feature skill). 40+ locally-built features remain unpushed
- DOMPurify patch should be verified against the frontend's sanitization behavior if any rendering issues surface
