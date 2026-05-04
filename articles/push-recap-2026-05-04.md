# Push Recap — 2026-05-04

## Overview
One merged PR on MiroShark ships shareable scenario links — the missing distribution primitive that lets any tweet or blog post drop a reader directly into a pre-configured simulation. Meanwhile, the Aeon self-improve skill opened a PR to fix an impossible rotation rule that had been silently violated for two weeks. A full cycle of 13 automated skill runs executed on miroshark-aeon with no failures.

**Stats:** 6 files changed, +613/-12 lines across 1 meaningful commit (+ 25 automated skill commits on miroshark-aeon)

---

## aaronjmars/MiroShark

### New Feature: Shareable Scenario Links (PR #71)
**Summary:** Every prior share surface (`/share/<id>`, `/watch/<id>`, replay GIF, transcript, RSS feed, trajectory CSV, gallery search) pointed readers at a *finished* simulation. This PR adds the other half — the *un-run* scenario. Drop a `?scenario=...&url=...` URL into a tweet and the reader lands on the New Sim form already pre-filled, one click from launching their own run with the exact same setup.

**Commits:**
- `4256f85` — feat: shareable scenario links — pre-fill New Sim form from URL params (#71)
  - New file `frontend/src/utils/urlParams.js`: 116-line DOMPurify-backed sanitization module. Four URL params parsed independently: `scenario` (≤500 chars, pre-fills Simulation Prompt), `url` (≤2000 chars, http(s)-only, auto-fetches into URL import list), `ask` (≤300 chars, pre-fills Just Ask field but does NOT auto-run — avoids surprise LLM cost), `template` (slug-only `[a-z0-9_-]+`, auto-launches a preset template). HTML/`javascript:` URIs/control characters stripped via `DOMPurify.sanitize(raw, {ALLOWED_TAGS:[], ALLOWED_ATTR:[]})`. Builder functions (`buildScenarioShareUrl`, `buildTemplateShareUrl`) produce the inverse direction (+385, -2 lines)
  - Changed `frontend/src/views/Home.vue`: `onMounted` hook calls `applyPrefilledParams()` — handles `?template=<slug>` via existing `getTemplate()` + `setPendingTemplate()` + router redirect to `/process/new`; handles text/url/ask params by populating corresponding form fields without overwriting user-typed content. Strips URL params via `router.replace` so refresh shows edited state, not original link. Dismissible orange-edged banner above the console signals which fields were populated by the shared link. New "Share as link" button beneath the Simulation Prompt textarea constructs a share URL from live form state and copies to clipboard with 2.2s toast (+385, -2 lines)
  - Changed `frontend/src/components/TemplateGallery.vue`: Each preset template card gains a small link icon next to Launch that copies a `?template=<slug>` URL. New `card-actions` flex container wraps both buttons. Clipboard copy with brief checkmark flash (+68, -10 lines)
  - Changed `README.md`: Shareable Scenario Links row added to Features table (en + zh-CN) (+2 lines)
  - Changed `docs/FEATURES.md`: Full section with four-param reference table, sanitization details, UX description (+21 lines)
  - Changed `docs/FEATURES.zh-CN.md`: Complete Chinese translation of the feature documentation (+21 lines)

**Impact:** Completes the distribution stack. The prior eight share surfaces all serialized *finished* simulations — this adds the *un-run scenario* direction. Aaron's "try this sim" tweets now have a one-click CTA that drops readers directly into a pre-configured form. Pure frontend, zero new dependencies (DOMPurify already pinned for the markdown renderer), no backend changes. Build green, 27 parser assertions pass.

---

## aaronjmars/miroshark-aeon

### Self-Improvement: Project-Lens Angle Rotation Rule (PR #29 — open)
**Summary:** The self-improve skill identified that the project-lens angle rotation rule ("Never repeat an angle used in the last 14 days") was mathematically unsatisfiable — with 8 angle categories on a daily cadence, day 9 onward forces a repeat into any 14-day window. Every project-lens entry from Apr 22 to May 2 violated the rule and wrote a rationalization instead of rotating cleanly.

**Changes (not yet merged):**
- `skills/project-lens/SKILL.md`: Replaced impossible 14-day rule with "least recently used" selection + 30-day count tie-break + 6-day soft floor + two explicit override paths (must be stated in the log under `**Override:**` with reason)
- Added math-aware preface explaining why strict-no-repeat is only satisfiable for N ≤ 8 days
- Added `**Last used:**` log line so future runs see rotation health at a glance
- 1 file, +14/-3 lines — PR #29

**Impact:** Stops two weeks of quality drift where the skill rationalized its way around an impossible constraint. Future project-lens entries will rotate on least-recently-used and only override when explicitly justified.

### Automated Skill Cycle
**Summary:** Full daily cycle of 13 skill runs executed nominally — token-report, fetch-tweets, tweet-allocator, weekly-shiplog, repo-pulse, feature, self-improve, repo-actions, plus scheduler state updates. 25 automated commits total.

**Notable outputs:**
- `articles/repo-actions-2026-05-04.md`: New feature ideas analysis for MiroShark
- `articles/weekly-shiplog-2026-05-04.md`: Weekly shiplog covering Apr 27 – May 4
- `dashboard/outputs/`: Self-improve and repo-actions dashboard renders
- Memory logs and MEMORY.md updates

**Impact:** Infrastructure running cleanly. No skill failures, no missed runs detected in this cycle (repo-article missing from yesterday's Sunday schedule was flagged by heartbeat but auto-dispatch was blocked by read-only GITHUB_TOKEN).

---

## Developer Notes
- **New dependencies:** None — zero-new-deps streak now spans 10 consecutive PRs on MiroShark
- **Breaking changes:** None
- **Architecture shifts:** Shareable Scenario Links establishes a URL-params-as-API pattern for the home page — `urlParams.js` is the centralized sanitization point that both the read path (mount-time parsing) and write path (share button construction) route through
- **Tech debt:** None introduced. PR #29 *reduces* tech debt by fixing the unsatisfiable rotation rule

## What's Next
- PR #29 (project-lens rotation rule) awaiting merge on miroshark-aeon
- GH_GLOBAL secret still unset — 5 consecutive feature builds blocked from pushing to MiroShark (Pre-Run Cost Estimator, Jupyter Notebook Export, Community Template Gallery, Agent Interrogation API, and now Shareable Scenario Links was built by the repo owner directly as PR #71 instead)
- MiroShark at 1,063 stars (+41 since yesterday's 1,022), 212 forks — growth accelerating post-1K milestone
- Likely next: the remaining repo-actions feature candidates (Fork/Counterfactual Diff View, Mid-Run Belief Threshold Alert Webhooks, Simulation Series/Longitudinal Study Tracker)
