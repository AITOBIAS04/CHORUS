# Push Recap — 2026-07-12

## Overview
2 substantive commits by 2 authors (15 automation commits filtered). A quiet Saturday — one dependency bump on MiroShark and one scorer accuracy fix on miroshark-aeon. Both changes are maintenance/hardening, no new features.

**Stats:** 2 files changed, +8/-4 lines across 2 substantive commits

---

## aaronjmars/MiroShark

### Dependency Maintenance: soupsieve Bump
**Summary:** Dependabot bumped the soupsieve CSS selector library from 2.8 to 2.8.4 in the backend lockfile. This is an indirect dependency — likely pulled in by BeautifulSoup4 — covering 10 months of upstream patches (Aug 2025 to May 2026).

**Commits:**
- `220ef40` — chore: bump soupsieve in /backend in the uv group across 1 directory (#244)
  - Changed `backend/uv.lock`: Updated soupsieve version 2.8 → 2.8.4, updated sdist and wheel URLs/hashes, incremented lock revision 2 → 3 (+4/-4 lines)

**Impact:** Keeps the dependency tree current. soupsieve 2.8.4 includes bug fixes for CSS selector edge cases — low risk, routine maintenance.

---

## aaronjmars/miroshark-aeon

### Scorer Accuracy Fix: Eliminate False Positives on No-Op Skill Runs
**Summary:** The skill scorer was reading a run's entire log rather than just its final output, which caused it to flag legitimate no-op runs (empty inbox, clean scan, nothing met threshold) as `empty_output` failures. This fix tightens the flag definitions in the scorer prompt so they evaluate only the final output.

**Commits:**
- `a8cae40` — fix(scorer): flag empty_output only on empty FINAL output, not legitimate no-ops (#112)
  - Changed `.github/workflows/aeon.yml`: Added 4 lines to the scorer prompt clarifying flag semantics (+4 lines):
    - `empty_output` now only fires when a skill produced no usable result — not when a skill completed successfully but its upstream source was empty (e.g., fetch-tweets finding no tweets, heartbeat finding no issues)
    - `api_error` / `rate_limited` now only fire when the error actually blocked the skill's output — not for sub-calls that were retried or fell back cleanly
  - Co-authored-by: Claude

**Impact:** Directly addresses a scoring accuracy problem. Skills like fetch-tweets (which legitimately return "no new tweets") and heartbeat (which legitimately return "all healthy") were being penalized with `empty_output` flags despite completing their task. This fix should reduce false-positive failure flags and give more accurate health metrics across the ~200-skill catalog.

---

## Developer Notes
- **New dependencies:** soupsieve 2.8.4 (indirect, backend)
- **Breaking changes:** None
- **Architecture shifts:** None — both changes are surgical fixes to existing systems
- **Tech debt:** None introduced

## What's Next
- The scorer fix (#112) should improve skill health metrics on the next scoring cycle — worth monitoring whether false-positive rates drop
- MiroShark main repo continues quiet (4th low-activity day in a row) — all feature work remains blocked on GH_GLOBAL secret
- 15 automation commits show the aeon framework running normally across 6 skills (repo-pulse, changelog, token-movers, heartbeat, fetch-tweets, scheduler)
