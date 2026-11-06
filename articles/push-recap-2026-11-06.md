# Push Recap - 2026-11-06

## Overview
4 substantive commits by 2 authors across both watched repos (8 automation commits filtered). The main thrust: a major upstream sync landed the 85th skill (canister-audit for ICP Rust security), while the scorer/health pipeline got a structural overhaul and MiroShark's CI actions were SHA-pinned against supply-chain attacks.

**Stats:** 74 files changed, +5,327/-298 lines across 4 substantive commits

---

## aaronjmars/MiroShark

### Supply-Chain Hardening: CI Action SHA Pinning
**Summary:** Every GitHub Actions reference in both CI workflows was pinned from floating version tags (e.g., `actions/checkout@v7`) to immutable commit SHAs with version comments (e.g., `actions/checkout@3d3c42e...# v7.0.1`). This closes a known supply-chain attack vector where a compromised maintainer can repoint a tag to inject malicious code.

**Commits:**
- `2d18e8b` - ci: pin actions to commit SHAs (#356)
  - Changed `.github/workflows/docker-image.yml`: Pinned 5 actions (checkout, setup-docker-builder, login-action, metadata-action, build-push-action) to specific SHAs (+5/-5 lines)
  - Changed `.github/workflows/tests.yml`: Pinned 6 action references across backend-tests, frontend-tests, integration-tests, and lint jobs (checkout, setup-python, setup-uv, setup-node, ruff-action) to specific SHAs (+11/-11 lines)

**Impact:** All CI runs now reference immutable code. A compromised action maintainer cannot inject code via tag repointing. This follows the Starsling audit recommendations (OPT46/OPT57) from the earlier CI hardening work in PR #348.

---

## aaronjmars/miroshark-aeon

### Upstream Sync: New Canister Audit Skill + Template Refresh
**Summary:** 10 upstream commits from aeonfun/aeon were synced, adding the 85th skill to the catalog. The headline addition is a full canister-audit pipeline for Internet Computer (ICP) Rust canisters, alongside a significant token-movers rewrite and refreshed skill templates.

**Commits:**
- `421f939` - aeon-update: sync 10 upstream commits (535991c..4d64089) (#249)
  - New `skills/canister-audit/SKILL.md`: 201-line skill definition for deep ICP canister security auditing - Semgrep IC rules, cargo-audit, invariant modelling against 12 canister-security pitfalls, PocketIC reproductions (+201 lines)
  - New `skills/canister-audit/fixtures/token_vault/`: Complete test fixture with a token vault canister source, Cargo manifests, reproduction harness, and test suite (+3,400+ lines across 10 files)
  - New `skills/canister-audit/references/`: IC security checklist (+122 lines) and Semgrep Rust rule definitions (+95 lines)
  - New `.github/workflows/ci-canister-audit-fixture.yml`: CI workflow for the fixture (+95 lines)
  - New `scripts/stage-canister-audit.sh`: Staging script for canister audit runs (+141 lines)
  - New `docs/icp/README.md`: ICP documentation (+105 lines)
  - Changed `skills/token-movers/SKILL.md`: Major rewrite - saves API responses to files and reads only needed fields instead of printing raw JSON bodies, reducing token consumption (+71/-34 lines)
  - Changed 5 skill templates (code-reviewer, community-manager, crypto-tracker, deploy-watcher, social-monitor): Refreshed with updated patterns
  - Changed `eyebrowlock.json`: Integrity manifest regenerated for new/changed files (+100/-47 lines)
  - Minor hardening in heartbeat, skill-article, skill-repair, vuln-scanner SKILLs
  - Updated catalog counts: 84 to 85 skills, dev pack 16 to 17

**Impact:** The canister-audit skill brings ICP security review capability to the framework - the first blockchain-native auditing skill beyond token tracking. The token-movers rewrite reduces API token waste by writing responses to files. Five community skill templates now reflect current best practices.

### Quality Infrastructure: Scorer Strategy Gate + Notification Cleanup
**Summary:** A multi-part PR that restructures how skills are scored, how errors are reported, and how notifications handle typography. The scorer now grades skills against their own SKILL.md job description first, STRATEGY.md only when the skill explicitly reads it. Notifications strip em/en dashes. Health tracking ignores idle skips. Error reporting uses structured envelope parsing.

**Commits:**
- `cc45941` - Scorer strategy gate, notify dash pass, idle skips off health, last_error cleared (#250)
  - Changed `.github/workflows/aeon.yml` (+63/-18 lines):
    - Scorer now extracts `SKILL_JOB` from the skill's own SKILL.md description; STRATEGY.md joins the rubric only when the skill's SKILL.md references it (grep for `read.*STRATEGY.md`). Previously routine reports were penalized for not serving product priorities
    - Health step passes scorer outputs through env vars instead of inline `${{ }}` - FLAGS validated as JSON array of strings only (security: untrusted judge output could break shell quoting in a step with write token)
    - Idle-gated skips (memory-flush, fetch-tweets) now exit 0 before the run_failed override - previously scored as "score 1, run_failed"
    - Gateway error reporting: captures last exit code and provider name on claude-gateway failure, passes to gateway-error.sh instead of raw stderr byte slice
    - Cron state: `last_error` cleared to null on success (previously only set on failure, never cleared)
  - Changed `scripts/gateway-error.sh` (+12/-2 lines): New optional 4th argument for envelope file (non-claude harness path). Reads `.result` of is_error envelopes or `.error.message` before falling back to stderr parsing
  - Changed `scripts/notify.sh` (+7/-0 lines): Em dash (U+2014) and en dash (U+2013) replaced with plain hyphen before dedup and queue
  - Changed `scripts/notify-jsonrender.sh` (+5/-0 lines): Same dash normalization for json-render feed cards
  - Changed `scripts/notify_format.py` (+20/-8 lines): `plain_dashes()` function added, applied in `main()` to both body and title. Docstring dashes also normalized
  - Changed `scripts/state_reduce.py` (+2/-0 lines): Success events now set `last_error = None`, matching the file backend in aeon.yml
  - New test coverage: `test_gateway_failover.sh` (+15 lines, 4 new cases for envelope file), `test_notify.sh` (+11 lines, dash normalization), `test_notify_format.py` (+17 lines, plain_dashes unit + integration), `test_state_reduce.py` (+9 lines, success-clears-error)

**Impact:** Skills are now graded on their actual job, not penalized for topic irrelevance to operator strategy. A correct token-report no longer risks a low score because "token tracking isn't a product priority." The FLAGS validation closes a shell injection vector. Idle skips no longer generate false health regressions. Notifications are typographically consistent across all channels.

### Cost Optimization: Heartbeat Model Downgrade
**Summary:** The heartbeat skill - which reads state files, runs gh list commands, and rewrites the status page - was moved from the default Sonnet model to Haiku. Its two most recent runs cost ~$0.22-0.25 on Sonnet with no quality benefit for this routine check.

**Commits:**
- `cb1eb74` - heartbeat: run on claude-haiku-5-5 instead of the Sonnet default (#248)
  - Changed `aeon.yml`: Added `model: "claude-haiku-5-5"` to the heartbeat skill config (+1/-1 line)

**Impact:** Reduces per-run cost for the daily heartbeat check. Heartbeat's workload (state file reads, gh CLI calls, status page generation) doesn't require Sonnet-tier reasoning.

---

## Developer Notes
- **New dependencies:** Canister-audit brings Rust toolchain dependencies (Cargo.lock files for fixture and repro harness); these only run in the CI fixture workflow, not in the main pipeline
- **Breaking changes:** Scorer strategy gate changes how quality scores are computed - skills that don't reference STRATEGY.md will no longer be graded against it. This could shift score distributions upward for routine skills
- **Architecture shifts:** FLAGS from the scorer judge are now treated as untrusted input (validated as JSON string array before shell interpolation) - first explicit security boundary between the judge and the write-token health step
- **Tech debt:** The aeon-update sync lists 10 files needing manual review; pending_conflicts tracking continues in aeon-update-state.json

## What's Next
- PR #82 ("improve: add Active Targets data refresh to memory-flush") is >48h and UNKNOWN merge state - will be force-merged on next self-improve run
- PR #83 ("improve: add resolve passed deadlines to memory-flush") was just opened today
- The 1,500-star hyperstition deadline is tomorrow (Nov 7) with 1,489-1,490 stars and ~11 needed - the new deadline resolution mechanism from PR #83 will evaluate this
- 10 held files from the aeon-update sync still need manual conflict resolution
