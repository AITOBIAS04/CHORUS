# Push Recap — 2026-10-07

## Overview
2 substantive commits by Aaron Elijah Mars across aaronjmars/miroshark-aeon, plus 8 automation commits filtered. Today's work hardened the CI pipeline against two distinct failure modes — a stale npm cache that breaks version bumps and a mid-run file mutation that crashes the harness — while also closing a gap in the secret-exfiltration tripwire that missed GitHub's new stateless token format.

**Stats:** 5 files changed, +38/-11 lines across 2 substantive commits

---

## aaronjmars/MiroShark

No commits in the last 24 hours.

---

## aaronjmars/miroshark-aeon

### CI/CD Pipeline Hardening
**Summary:** Two fixes targeting distinct reliability issues in the GitHub Actions pipeline. The first removes a `restore-keys` fallback from the npm cache that was silently poisoning version bumps — when Claude Code is pinned to a new version, an older cache's stale packument makes `--prefer-offline` trust the old index, and the install fails with ETARGET indefinitely because the failed install never saves a new cache key. The second moves harness execution to a snapshot copy so that mid-run upstream syncs (aeon-update) can't corrupt the running script.

**Commits:**
- `ea24129` — fix(ci): port #1169 npm cache fix and run the harness from a snapshot (#197)
  - Changed `.github/workflows/aeon.yml`: Removed `restore-keys` prefix from the Claude Code npm cache step — the old fallback degraded "gracefully" on version bumps but actually caused permanent ETARGET failures because `--prefer-offline` trusts a stale packument and the failed install never writes a new cache key. Also replaced the inline `RH="${GITHUB_WORKSPACE}/harness-adapter/run-harness"` path with a call to a new snapshot script (+5, -6 lines)
  - Changed `.github/workflows/messages.yml`: Same `restore-keys` removal applied to the messages workflow's npm cache step, with a cross-reference comment back to aeon.yml (+2, -3 lines)
  - New file `scripts/harness-adapter-snapshot.sh`: Copies `harness-adapter/` to `$HOME/.aeon-run/harness-adapter` before the skill runs and prints the path to the copy's `run-harness`. This prevents "unexpected EOF" crashes when aeon-update syncs upstream changes into the workspace while a skill is mid-execution (the bug was observed in aeon-agent run 37300267512). The copy lives under `$HOME` rather than `$RUNNER_TEMP` because the read-only sandbox allows writes to temp dirs but the unsandboxed scorer also needs this path (+29 lines)

**Impact:** Eliminates two classes of intermittent CI failures. The npm cache fix prevents version-bump lockouts that would require manual cache eviction. The harness snapshot prevents mid-run crashes during upstream syncs — a particularly insidious bug because the crash counted as a provider failure, triggering the gateway cascade to re-run the entire skill.

### Security: Secret Tripwire Expansion
**Summary:** GitHub App installation tokens (including `GITHUB_TOKEN` in Actions) switched to a stateless format `ghs_<appid>_<jwt>` that contains underscores after the app ID prefix. The existing secret tripwire regex `gh[pousr]_[A-Za-z0-9]{20}` stopped matching at the first underscore in the JWT portion, allowing these tokens to slip past the exfiltration guard in email-sending skills.

**Commits:**
- `7ea13f6` — fix(skills): catch stateless ghs_ tokens in the secret tripwire
  - Changed `skills/send-email/SKILL.md`: Added `_` to the character class in the GitHub token regex pattern — `gh[pousr]_[A-Za-z0-9_]{20}` instead of `gh[pousr]_[A-Za-z0-9]{20}` (+1, -1 line)
  - Changed `skills/vuln-scanner/SKILL.md`: Identical regex fix in the vuln-scanner's secret tripwire check (+1, -1 line)

**Impact:** Closes a gap in the secret-exfiltration guard. Both email-capable skills (send-email and vuln-scanner) now correctly detect and block GitHub's new stateless installation tokens in outbound email content.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None — the `restore-keys` removal is a correctness fix, not a behavior change (the cache key is still version-pinned)
- **Architecture shifts:** Harness execution now runs from a snapshot copy under `$HOME/.aeon-run/` instead of directly from the workspace. This is a new pattern for protecting long-running scripts from workspace mutations
- **Tech debt:** The secret tripwire regex is duplicated across two skill files (send-email and vuln-scanner). A shared include or validation script could DRY this up

## What's Next
- The harness snapshot pattern may need adoption in other workflows if additional scripts are vulnerable to mid-run workspace changes
- The secret tripwire regex duplication across skills is a candidate for a future self-improve PR (centralize into a shared validation script)
- PR #67 (fetch-tweets log condensation) is still open — likely to be merged in the next self-improve cycle
