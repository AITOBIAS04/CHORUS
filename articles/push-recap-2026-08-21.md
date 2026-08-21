# Push Recap — 2026-08-21

## Overview
5 substantive commits by 1 author (aaronjmars) across 1 watched repo (9 automation commits filtered). Today's work was a targeted hardening sprint: three progressive dashboard fixes that stopped the 288px feed panel from shattering stat labels and overflowing card boundaries, a supply-chain security pass that SHA-pinned every GitHub Action and sandboxed the eyebrow binary, and a scorer quality overhaul paired with new Codex plugin + llms.txt distribution manifests ported from the framework canon.

**Stats:** 25 files changed, +278/-76 lines across 5 substantive commits

---

## aaronjmars/MiroShark

No commits in the last 24 hours. 80th consecutive push block (GH_GLOBAL not set).

---

## aaronjmars/miroshark-aeon

### Dashboard Layout Fixes — Feed Panel Overflow & Stat Shattering
**Summary:** A 3-PR series (PRs #142, #143, #144) systematically fixed the dashboard's narrow (~288px) right-panel feed where long unbreakable strings (token prices like $0.000002483, handles, dollar amounts) were overflowing card boundaries and stat labels were shattering into vertical single-character columns. The fixes progress from containment (overflow-wrap, min-w-0) through content-aware grid sizing to flex-wrap with basis constraints on horizontal stat stacks.

**Commits:**
- `f2da314` — fix(dashboard): keep feed card content inside its box (#142)
  - Changed `apps/dashboard/components/SpecNode.tsx`: Added `min-w-0` and `overflow-hidden` to Card, Stack, Grid, Stat, TweetCard, StoryLink, Badge, Alert, and Link components so flex/grid items can shrink below their min-content width. Introduced two CSS helper constants — `hard` (`overflow-wrap:anywhere`) for unbreakable tokens (prices, handles) and `soft` (`break-words`) for prose/labels that should only break at spaces. Grid columns now use `repeat(auto-fit, minmax(min(100%, Npx), 1fr))` so un-fittable cells wrap to the next row instead of being crushed. (+30/-13 lines)
  - Changed `apps/dashboard/components/RightPanel.tsx`: Added `overflow-x-hidden` to the feed scroller and `min-w-0` on feed card rows to prevent horizontal scroll on the panel. (+2/-2 lines)

- `b9ded73` — fix(dashboard): collapse feed stat grid to 1 column for long values (#143)
  - Changed `apps/dashboard/components/SpecNode.tsx`: Made the Grid component's min track width content-aware — it now walks descendant Stat elements, measures the longest value string (at ~13px/char + 24px padding), and sets the CSS `minmax()` accordingly. A row of long-number stats (e.g. $0.000002025) now collapses to a single full-width column where the value fits on one line, instead of three narrow columns each wrapping the number one character per line. Short-value grids keep their columns. (+14/-2 lines)

- `935f435` — fix(dashboard): wrap horizontal stat stacks so labels stop shattering (#144)
  - Changed `apps/dashboard/components/SpecNode.tsx`: Horizontal Stacks of Stats (used in shiplog "The Bytes" and repo-pulse cards) were crushing each stat to a sliver in the 288px panel, shattering labels into vertical letters like "P R I C E". Fix: horizontal stacks now `flex-wrap` with a `7rem` basis on `[data-stat]` children — surplus stats wrap to the next row at a readable width. Grid min track width now also measures the longest label *word* (at ~10px/char) so short-value grids with long labels (like "COMMITS", "REPOS") don't shatter either. Stat elements now emit a `data-stat` attribute so the parent Stack can target them with CSS selectors. Base min for 3+ column grids increased from 92px to 112px. (+23/-6 lines)

**Impact:** The dashboard feed is now usable at its designed width. Token prices, dollar amounts, handles, and multi-stat grids all render correctly in the narrow panel. This was a visible regression — cards were literally unreadable with content spilling outside their boundaries.

### Supply-Chain Security Hardening
**Summary:** A comprehensive supply-chain hardening pass (PR #141) that SHA-pins every GitHub Action reference, blocks npm lifecycle scripts on the codex CLI install, and SHA256-verifies the eyebrow binary before execution in the secret environment — all ported from the framework's canon PRs #917/#918.

**Commits:**
- `80aff61` — security: pin actions to SHA + harden fetch-and-run in secret env (#141)
  - Changed `.github/workflows/aeon.yml`: Replaced mutable tag references (`actions/checkout@v7`, `actions/setup-node@v7`, `actions/cache@v6`, `actions/attest-build-provenance@v4`) with immutable commit SHAs across 6 references. A tag can be re-pointed at malicious code by whoever controls the action repo; a SHA cannot. (+6/-6 lines)
  - Changed `.github/workflows/chain-runner.yml`: SHA-pinned `actions/checkout@v7` (+1/-1 lines)
  - Changed `.github/workflows/ci-agents-md.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/ci-apps.yml`: SHA-pinned 4 checkout/setup-node references across dashboard, CLI, MCP server, and Worker jobs (+8/-8 lines)
  - Changed `.github/workflows/ci-capabilities-parity.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/ci-packs-json.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/ci-readme-catalog.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/ci-skill-category.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/ci-skill-integrity.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/ci-skill-packs.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/ci-skills-json.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/ci-tests.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/messages.yml`: SHA-pinned 3 checkout references, 1 setup-node, and 1 cache reference (+5/-5 lines)
  - Changed `.github/workflows/scheduler.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `.github/workflows/setup-commands.yml`: SHA-pinned checkout (+1/-1 lines)
  - Changed `scripts/install-harness.sh`: Added `--ignore-scripts` to `npm install -g @openai/codex@0.144.6` — codex ships its binary via optional platform packages, not a postinstall, so blocking lifecycle scripts is safe and denies a compromised release an auto-run install hook. (+6/-1 lines)
  - Changed `skills/aeon-update/SKILL.md`: Rewrote eyebrow binary download to SHA256-verify the tarball against a pinned hash before extracting or executing. Added per-architecture hash constants (amd64/arm64). Binary now runs with `env -i PATH="$PATH" HOME="$HOME"` — a scrubbed environment that denies it access to GH_GLOBAL and other run secrets even if the hash verification were somehow bypassed. (+27/-4 lines)

**Impact:** Closes the three main supply-chain attack vectors in the CI/CD pipeline: mutable action tags (re-pointing attack), npm lifecycle scripts (arbitrary code on install), and unverified binary downloads executed with full secret access. All 15 workflow files now use immutable SHA references.

### Scorer Quality Fixes + Codex Plugin + llms.txt
**Summary:** Ports two framework canon PRs (#919/#921) into this instance. The scorer overhaul fixes multiple quality issues — it was only reading the first 3KB of output (missing conclusions of long articles), grading on polish rather than strategic alignment, and silently recording 0 scores when the judge failed. The distribution side adds a Codex plugin manifest and llms.txt doc map.

**Commits:**
- `fef2cfd` — sync: scorer quality fixes + Codex plugin + llms.txt (from canon #919/#921) (#145)
  - Changed `.github/workflows/aeon.yml`: **Scorer overhaul** — (1) head+tail sampling replaces flat 3KB head-truncate: outputs ≤14KB are read whole, larger ones get 10KB head + 4KB tail with `[... middle truncated ...]` marker, using `iconv -c` to avoid partial UTF-8 chars at byte boundaries. (2) STRATEGY.md is now injected into the rubric prompt so the judge grades strategic alignment and correctness, not just surface polish. (3) Meta-skill skip is now frontmatter-driven (`scorable: false`) instead of a hardcoded name regex that had drifted (listed skill-analytics/reflect/self-review/cost-report which no longer exist). (4) Added `unverifiable_claim` flag — outputs that assert invented specifics are capped at score 2. (5) Invalid/missing judge scores are treated as unscored (skip the write) instead of recording a 0 that drags avg_score. (+50/-16 lines)
  - New file `.agents/plugins/marketplace.json`: Codex plugin marketplace manifest — registers the `aeon` plugin as "Operator console for running an Aeon agent instance from your coding agent" (+26 lines)
  - New file `llms.txt`: Doc map for LLM-native discovery — links to AGENTS.md, CLAUDE.md, STRATEGY.md, aeon.yml, setup docs, skills catalog, harness docs, and plugin install instructions. (+40 lines)
  - New file `plugin/.codex-plugin/plugin.json`: Codex plugin definition — name, version, description, interface config, capability declarations (Interactive, Write), and skill directory pointer. (+25 lines)
  - Changed `skills/heartbeat/SKILL.md`: Added `scorable: false` frontmatter flag (+1 line)
  - Changed `skills/memory-flush/SKILL.md`: Added `scorable: false` frontmatter flag (+1 line)
  - Changed `skills/skill-health/SKILL.md`: Added `scorable: false` frontmatter flag (+1 line)

**Impact:** The scorer now reads entire skill outputs (or a representative head+tail sample), grades against the operator's stated strategy rather than generic polish criteria, and can't be dragged down by judge failures. The Codex plugin and llms.txt extend the project's discoverability surface — an agent running Codex can now install the Aeon operator console directly.

### Automation Commits (9 filtered)
| Type | Count | Examples |
|------|-------|---------|
| `chore(cron):` — skill success markers | 3 | token-movers, heartbeat, fetch-tweets |
| `chore(scheduler):` — cron state updates | 3 | scheduler state updates |
| `chore(…): auto-commit` — skill output files | 3 | token-movers, heartbeat, fetch-tweets |

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** The scorer now skips skills with `scorable: false` in their frontmatter instead of matching a hardcoded name regex. Any skill that previously relied on being in the old regex list needs the frontmatter flag added (heartbeat, memory-flush, and skill-health were updated in this commit).
- **Architecture shifts:** GitHub Actions references across all 15 workflow files are now SHA-pinned — future action version bumps require updating both the SHA and the comment tag. The eyebrow binary download is now hash-verified and runs in a scrubbed environment.
- **Tech debt:** The dashboard fix series touched `SpecNode.tsx` three times in the same day (PRs #142→#143→#144), each building on the prior. This is clean progressive refinement, not tech debt — each PR addressed a distinct failure mode.
- **New files:** 3 new distribution files (`.agents/plugins/marketplace.json`, `llms.txt`, `plugin/.codex-plugin/plugin.json`) — no impact on runtime.

## What's Next
- MiroShark main repo remains at 80th consecutive push block (GH_GLOBAL not set) — no feature PRs can land
- The dashboard fixes are complete — the feed panel overflow/shattering regression is resolved
- The scorer quality overhaul should improve score accuracy for long-form skills (articles, digests, research) that were being penalized by the 3KB head-truncate
- PR #56 (fetch-tweets WebSearch query backoff) is the sole open self-improve PR, pending merge
- Token at $0.000002463 (−0.47% 24h) consolidating after yesterday's +26.83% surge
