# Push Recap — 2026-10-04

## Overview
2 substantive commits by 2 authors (Aaron Elijah Mars, aeonframework) across miroshark-aeon, plus 9 automation commits filtered. The headline is PR #193 — a documentation overhaul that reframes miroshark-aeon as a live Aeon instance and redirects new users to Aeon Connect (www.aeon.fun/connect) instead of cloning this repo. The README, quickstart flow, and llms.txt were all rewritten to reflect the new three-path onboarding model: browser (recommended), coding agent, or terminal.

**Stats:** 6 files changed, +51/-17 lines across 2 substantive commits

---

## aaronjmars/MiroShark

No commits in the last 24 hours.

---

## aaronjmars/miroshark-aeon

### Documentation Overhaul: Aeon Connect Onboarding
**Summary:** PR #193 is a comprehensive rewrite of the repo's public-facing documentation. The README now opens with a banner declaring this is a live Aeon instance — the growth agent for MiroShark — and redirects anyone who wants their own agent to Aeon Connect rather than cloning this instance. The quickstart flow was rewritten from a clone-and-run model to three paths: browser-first via Aeon Connect (recommended), a one-liner for coding agents, or the traditional terminal setup pointing at the upstream aeonfun/aeon template.

**Commits:**
- `ed472e0` — docs: mark as a live instance and point to Aeon Connect (#193)
  - Changed `.github/README.md`: Added a blockquote banner near the top identifying this as a live instance with a link to Aeon Connect; rewrote the quickstart section from "clone this repo and run `./aeon`" to three onboarding paths (browser at www.aeon.fun/connect, coding agent one-liner, terminal `./aeon init`); updated hero image alt text from "60+ skills across 7 harnesses" to "85 skills across 9 harnesses" reflecting current counts; replaced quickstart image alt text with the new four-step Aeon Connect flow (Sign in → Connect a model → Pick skills → Runs itself); removed the `gh` CLI troubleshooting `<details>` block; added link to full docs at www.aeon.fun/docs (+13, -13 lines)
  - Changed `docs/assets/quickstart-aeon.jpg`: Replaced quickstart image with a new screenshot showing the Aeon Connect browser flow (binary file, no line diff)
  - Changed `llms.txt`: Updated the opening description from "six coding-agent CLIs" to "nine" (added fx, Cursor, Hermes); noted GLM Coding Plan is a gateway provider, not a harness; changed site URL from `aeon.fun` to `www.aeon.fun`; added "Get your own agent" line pointing to www.aeon.fun/connect; updated harnesses reference from "six" to "nine" (+4, -3 lines)

**Impact:** This is a positioning shift. miroshark-aeon is no longer presenting itself as a starting point for new Aeon users — it's explicitly a live instance, the growth agent for MiroShark, and newcomers are redirected to the upstream framework. The three-path quickstart (browser/agent/terminal) with browser as the recommended option signals that Aeon Connect has matured to the point where cloning a repo is no longer the expected onboarding flow. The `llms.txt` update also reflects the framework's growth from 7 to 9 harnesses (adding fx, Cursor, and Hermes) and 60+ to 85 skills.

### Automated Skill Output: Token Report
**Summary:** The token-movers skill ran its daily single-token report for MIROSHARK, writing results to memory and output files. This commit doesn't follow the `chore(scope):` naming convention but is automated skill output.

**Commits:**
- `31995c4` — token-movers: single-token report for MIROSHARK (2026-10-04, QUIET)
  - Changed `memory/MEMORY.md`: Updated token price data (+1, -1 lines)
  - New file `memory/logs/2026-10-04.md`: Created daily log with token-movers entry (+7 lines)
  - New file `output/articles/token-report-2026-10-04.md`: Full token report article (+26 lines)

**Impact:** Standard daily token tracking. The "QUIET" suffix indicates no significant price movement warranting a notification.

### Automation Commits (9 filtered)
Scheduler state updates (3: `9e8d25d`, `3bb1830`, `f56b198`), cron success markers for token-movers/heartbeat/fetch-tweets (3: `ee35438`, `9ce47df`, `dca07f8`), auto-commits for token-movers/heartbeat/fetch-tweets (3: `a047c39`, `60718fa`, `a0b4110`). Standard skill execution cycle.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None
- **Architecture shifts:** The README now treats Aeon Connect (www.aeon.fun/connect) as the primary onboarding path, not `git clone`. This is a documentation-level shift, not a code change, but it signals the framework's maturity trajectory.
- **Tech debt:** None introduced

## What's Next
- The llms.txt update to 9 harnesses and 85 skills suggests the upstream aeonfun/aeon framework has added Cursor and Hermes harnesses since the last sync — watch for these appearing in miroshark-aeon's harness-adapter
- PR #193 replaced the quickstart image — verify the new screenshot renders correctly on GitHub
- GH_GLOBAL secret still blocks all feature work; 90+ consecutive blocks
- 2 improve PRs open: PR #62 (stale, DIRTY/CONFLICTING) and PR #66 (new, skill-leaderboard dedup)
- Hacktoberfest Day 4 — still 302 forks at 0% upstream PR conversion
