# Push Recap — 2026-08-19

## Overview
8 substantive commits by 1 author (aaronjmars) across 1 watched repo (15 automation commits filtered). Today's work was all operational hardening on miroshark-aeon: eliminating false alarms from a missing optional secret, closing a security hole that dumped the entire secret store into a workflow env var, and upgrading the framework updater with real 3-way merge support so operator customizations survive upstream syncs without manual conflict resolution.

**Stats:** 7 files changed, +70/-27 lines across 8 substantive commits

---

## aaronjmars/miroshark-aeon

### Auth Token Fallback — Silencing False GH_READ_PAT Alarms
**Summary:** Three skills (bd-radar, fleet-control, fleet-scorecard) treated an unset `GH_READ_PAT` as a degraded state and raised source-miss alarms or warned about missing tokens. In reality, the run's `GH_TOKEN` (backed by `GH_GLOBAL`) reads the same private repos — it's the normal single-key setup, not a failure. This triple-commit fix adds `GH_GLOBAL` to the fallback chain and rewrites the docs to stop alarming on a perfectly healthy configuration.

**Commits:**
- `296f905` — fix(bd-radar,fleet-control): GH_GLOBAL fallback for private reads + silence false unset-GH_READ_PAT alarms
  - Changed `scripts/fleet-scorecard.mjs`: Inserted `GH_GLOBAL` into the token fallback chain between `GH_READ_PAT` and `GH_TOKEN`; updated the comment block to describe the single-key setup as normal, not degraded; updated the warning message to mention `GH_GLOBAL` (+7/-6 lines)

- `4f4c155` — fix(bd-radar,fleet-control): GH_GLOBAL fallback for private reads + silence false unset-GH_READ_PAT alarms
  - Changed `skills/fleet-control/SKILL.md`: Rewrote the scorecard view auth documentation — `GH_TOKEN` (= `GH_GLOBAL`) now described as the standard single-key setup that reads private members, not a reduced-scope fallback; removed the "self + public only" qualifier (+2/-2 lines)

- `e5c10ed` — fix(bd-radar,fleet-control): GH_GLOBAL fallback for private reads + silence false unset-GH_READ_PAT alarms
  - Changed `skills/bd-radar/SKILL.md`: Rewrote the GitHub forks+issues fetch block — when `GH_READ_PAT` is unset, the skill now falls back to `gh api` (authenticated by `GH_TOKEN`/`GH_GLOBAL`) instead of logging `BD_RADAR_SOURCE_MISS`. Added explicit instruction to **never report an unset `GH_READ_PAT` as a 401, source miss, or rotation request**. Only a per-repo 404 from `gh api` itself is a real miss (+13/-9 lines)

**Impact:** Eliminates a class of false-positive alarms across bd-radar, fleet-control, and fleet-scorecard. Instances running the standard single-key `GH_GLOBAL` setup (which is most of them) will no longer see noise about missing tokens or degraded paths in their logs.

### Security — Secret Store Narrowing
**Summary:** The `messages.yml` inbound-message workflow was using `${{ toJSON(secrets) }}` to dump the *entire* GitHub secret store into an environment variable for MCP preflight. This fix replaces it with an explicit named allowlist of ~50 specific secrets, preventing the full store from being serialized and avoiding GitHub's public-repo malicious-workflow security hold.

**Commits:**
- `74c1efc` — fix(security): narrow messages.yml ALL_SECRETS to named allowlist (#140)
  - Changed `.github/workflows/messages.yml`: Replaced the `ALL_SECRETS: ${{ toJSON(secrets) }}` line with a hand-enumerated JSON object listing each secret by name (ANTHROPIC_API_KEY, GH_GLOBAL, TELEGRAM_BOT_TOKEN, etc.). The comment now reads "Explicit named secrets (public-repo malicious-workflow-hold safe)" (+3/-2 lines, but the replacement line is a single ~2.5KB JSON string)

**Impact:** Closes a real security surface. The `toJSON(secrets)` pattern serialized every secret in the repository — including any that weren't intended for the MCP preflight — into a single env var. The named allowlist ensures only declared secrets are passed, and satisfies GitHub's public-repo malicious-workflow checks.

### Framework Updater — 3-Way Merge + Eyebrow Fail-Safe
**Summary:** The `aeon-update` skill previously treated any operator-customized file as a CONFLICT, requiring manual review even when the upstream and local edits touched completely different parts of the file. This upgrade adds real `git merge-file` 3-way merging for OWNED files — disjoint edits merge automatically, and only true overlapping changes surface as conflicts. It also adds an eyebrow lock fail-safe: if the `eyebrow` binary isn't available to scan newly-added skills, those skills are reverted to CONFLICT rather than shipping a CI-red PR.

**Commits:**
- `f5defab` — chore(aeon-update): sync 3-way-merge OWNED conflicts + eyebrow-lock fail-safe from canon (#903)
  - Changed `skills/aeon-update/SKILL.md`: Added S6 3-way content merge section — fetches base (upstream@BASELINE), head (upstream@HEAD), and local (operator's copy), runs `git merge-file --diff3`, classifies as CLEAN-MERGE on exit 0 or CONFLICT on exit >0. Updated S7 to write CLEAN-MERGE results alongside CLEAN-ADD/CLEAN-UPDATE. Updated S8 pending-conflict tracking to correctly handle merged files (a 3-way-merged file is resolved, not perpetually pending). Added eyebrow binary download + scan for newly-added skills, with a fail-safe that reverts to CONFLICT if the binary is unavailable. Added "Auto-merged (3-way)" section to PR body template (+35/-5 lines)

- `39d2144` — chore(config): pin aeon-update to claude-opus-4-8
  - Changed `aeon.yml`: Added `model: "claude-opus-4-8"` to the `aeon-update` skill entry — pins this skill to Opus 4.8 regardless of the instance's default model (+1/-1 line)

**Impact:** Dramatically reduces manual merge friction on framework updates. The most common case — operator narrowed a workflow's secrets block while upstream bumped timeouts elsewhere in the same file — now auto-merges instead of requiring a human to review the entire diff. The eyebrow fail-safe ensures new upstream skills never land a CI-red PR. The Opus pin ensures the complex 3-way merge logic runs on the most capable model.

### Infrastructure Tuning
**Summary:** Two config adjustments: the scheduler cron interval was tripled from every 5 minutes to every 15, and the LLM gateway provider was set to auto with minor YAML reformatting.

**Commits:**
- `470e3d6` — chore(scheduler): move Scheduler cron to */15 (from */5)
  - Changed `.github/workflows/scheduler.yml`: Updated cron schedule from `*/5 * * * *` to `*/15 * * * *` (+1/-1 line)
  - Reduces GitHub Actions runner-minute consumption by 3x for the scheduler workflow while keeping dispatch latency under the 15-minute skill scheduling window

- `db49c76` — chore: set LLM gateway provider to auto
  - Changed `aeon.yml`: Reformatted the `deploy-uni-hook` entry from a single-line to multi-line YAML block (+8/-1 lines)

**Impact:** The scheduler cron change cuts runner overhead — 288 runs/day → 96 runs/day — without affecting skill dispatch timing (skills scheduled at fixed hours will fire within the same 15-minute window). The gateway provider change sets up automatic LLM routing.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None
- **Architecture shifts:** The aeon-update skill now performs real 3-way merges for operator-customized files using `git merge-file`, which is a significant upgrade from the previous all-or-nothing CONFLICT disposition. The eyebrow lock fail-safe adds a new binary-download step that fetches from `alexverify/eyebrow` releases.
- **Tech debt:** None introduced. The `toJSON(secrets)` cleanup is tech debt reduction.

## What's Next
- First automatic aeon-update PR with 3-way merge support expected Monday Aug 25 at 11:00 UTC — this will be the first real test of the CLEAN-MERGE path on an operator-customized file
- The GH_READ_PAT/GH_GLOBAL fallback fix should eliminate false alarms from bd-radar and fleet-control on the next run
- MiroShark main repo remains quiet — 78th consecutive push block (GH_GLOBAL not set)
- The secret-store narrowing in messages.yml may need updating if new secrets are added to the repo — the allowlist is hand-enumerated, not dynamic
