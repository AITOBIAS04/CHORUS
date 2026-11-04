# Push Recap — 2026-11-04

## Overview
7 substantive commits by 1 author (Aaron Elijah Mars) across aaronjmars/miroshark-aeon, with 11 automation commits filtered. The main thrust: a cost-saving idle-gate system that skips paid model calls when skills have nothing to do, three targeted bug fixes, and two large upstream canon syncs that bring the instance in line with aeonfun/aeon HEAD.

**Stats:** ~65 files changed, +1,746/-303 lines across 7 substantive commits

---

## aaronjmars/miroshark-aeon

### Cost Optimization: Pre-Model Idle Gates
**Summary:** Two new features that prevent the workflow from paying for a model run when there's nothing for the skill to process. fetch-tweets gets a Python gate that checks twitterapi.io before the model starts; memory-flush gets a gate that checks whether any log changed since the last flush. Both fail open — any error or doubt runs the skill normally.

**Commits:**
- `72e63c4` — feat(fetch-tweets): free pre-model idle gate when no tracked account posted (#244)
  - New file `scripts/fetch_tweets_idle.py` (+345 lines): Queries twitterapi.io for each tracked handle's latest tweets. Exits 0 (skip) only when no handle has a tweet inside the skill's window (3-day for tracked accounts, 2-day for single handle) that isn't already in recent logs. Parses Twitter-native `createdAt` dates (not ISO), extracts status IDs from URLs, cross-references against the last 2 days of `memory/logs/` fetch-tweets entries.
  - New file `scripts/tests/test_fetch_tweets_idle.py` (+342 lines): 30+ unit tests covering var parsing, tracked-accounts YAML parsing, Twitter date parsing, the string-compare gotcha (native dates > ISO dates as strings), seen-ID extraction, verdict logic, full gate integration, and a CLI end-to-end test using a local fake HTTP server.
  - Changed `.github/workflows/aeon.yml` (+23/-3 lines): Added the `Idle gate (fetch-tweets)` step before the Run step, conditioned on `steps.skill.outputs.name == 'fetch-tweets'`. The Run step now checks `steps.idle.outputs.skip != 'true'`. Cron-state postflight treats idle skips as successes.
  - Changed `.github/workflows/ci-tests.yml` (+2 lines): Added the new test to CI.
  - Changed `docs/CONFIGURATION.md` (+2 lines): Documented the fetch-tweets idle gate behavior.

- `0e5caed` — feat(aeon.yml): memory-flush pre-model idle gate, step matches canon (#246)
  - Changed `.github/workflows/aeon.yml` (+17/-9 lines): Merged the fetch-tweets idle gate into a combined `Idle gate (memory-flush, fetch-tweets)` step. memory-flush now runs `python3 scripts/memory_prep.py idle` before the model — skips when no daily log changed since the last flush and the flush is under 7 days old. TWITTER_API_KEY is only injected when the skill is fetch-tweets. The step condition broadened to trigger for either skill.

**Impact:** Direct cost reduction. fetch-tweets was spending ~$1.67/10 runs saying "nothing found" during the 120-day social silence. memory-flush similarly burned a model run on days with no new log activity. Both gates cost effectively nothing (one lightweight API call or a local file check) and eliminate the model cost entirely on quiet days.

### Bug Fixes & Hardening
**Summary:** Three fixes addressing distinct failure modes: transient GitHub server errors during push, sandbox-incompatible shell patterns in repo-pulse, and the scorer only seeing the notification card instead of the full article.

**Commits:**
- `d8e61ef` — fix(git-push-retry): retry transient GitHub server push failures (canon aeonfun/aeon#1332) (#247)
  - Changed `scripts/git-push-retry.sh` (+24/-1 lines): Added `transient_server_failure()` function that matches `[remote rejected] (failure)` or `[remote rejected] (Internal Server Error)` in `git push --porcelain` output. These are GitHub-side errors (e.g. "remote: fatal error in commit_refs") that sometimes occur after the ref was already updated. Bounded to `MAX_SERVER_RETRIES=2` with randomized sleep, separate from the existing 10-iteration stale-ref retry loop. The next `git pull` drops a commit that already landed, and the push succeeds.
  - Changed `scripts/tests/test_git_push_retry.sh` (+28/-1 lines): Two new test cases: `server-failure` (transient error retried after one pull, succeeds on attempt 2) and `server-down` (persistent failure stops after 2 retries, exits 1).

- `c676b55` — fix(repo-pulse): shell snippets the read-only sandbox accepts (#243)
  - Changed `skills/repo-pulse/SKILL.md` (+16/-14 lines): Rewrote all shell snippets to avoid patterns the read-only sandbox refuses: no `CUTOFF=$(date ...)` variable capture, no `export`, no `STARS=$(gh api ...)` subshell capture, no `for`/`while` loops, no `;`/`&&`/`||` joining. Each bash call is now a single command with literal values (date printed first, then written into later commands). Added a "Shell shape" section to the Sandbox note documenting which patterns are refused and why.

- `628ec33` — fix(scorer): grade the article a run wrote next to its short card (canon #1319) (#241)
  - Changed `.github/workflows/aeon.yml` (+58/-13 lines): Replaced the flat 3KB head-truncate of `/tmp/skill-result.txt` with a `score_output_sample()` function that does head+tail sampling within a 14KB content budget. The scorer now finds the article a skill wrote this run (checking `output/articles/*.md` for uncommitted or today's files matching the skill name) and sends it alongside the notification card to the judge. changelog skill gets special handling (repository change result + notification). This fixes a bias where the scorer only saw the short notification card and never the substantive article, underscoring skills that write long-form content.

**Impact:** git-push-retry now handles a real-world GitHub failure mode (observed: "fatal error in commit_refs") instead of exiting immediately. repo-pulse stops burning model turns on refused shell commands. The scorer's quality grades now reflect the actual article output rather than just the 420-byte notification summary.

### Upstream Canon Sync
**Summary:** Two bulk synchronizations bringing the miroshark-aeon instance up to date with aeonfun/aeon HEAD. Together they resolve 19 held upstream changes, reducing the pending-conflicts count from 40 to 27.

**Commits:**
- `cb98e48` — aeon-update: sync 6 upstream commits (25575a6..501e21c) (#240)
  - 37 files changed, +694/-125 lines
  - `scripts/aeon_update.py` (+76/-2): Enhanced the update script itself — likely the stale-copy detection rule that enables PR #242's bulk landing.
  - `harness-adapter/lib/otel-span.sh` (+23/-5): Canon version with cancelled error class, 1h/5m cache-write split in usage_details, zero-length rollup rows.
  - `scripts/langfuse-otel.sh` (+14/-2): Canon version with cron/chain/manual trigger labels.
  - `scripts/cron-due.sh` (+4/-1): Updated cron scheduling logic.
  - `.github/workflows/scheduler.yml` (+7/-3): Scheduler workflow updates.
  - Multiple test files updated: `test_aeon_update.py` (+53), `test_community_skill_install.sh` (+47/-2), `test_cron_due.sh` (+20), `test_score_output.sh` (+61), `test_langfuse_otel.sh` (+23/-1), `test_otel_span.sh` (+18/-2), `test_validate_readme_catalog.sh` (+28).
  - Skill catalog references: SKILL.md and layout.md updated to 88 skills, Crypto pack to 20 skills.
  - `docs/langfuse.md` (+38/-4): Updated Langfuse documentation.

- `c3974d9` — aeon-update: land 13 held stale canon copies + token-movers (501e21c..dd4887b) (#242)
  - 18 files changed, +195/-137 lines
  - 10 CI workflow files (ci-aeon-skill-sync, ci-agents-md, ci-capabilities-parity, ci-gate, ci-harnesses-json, ci-packs-json, ci-readme-catalog, ci-skill-category, ci-skill-integrity, ci-skills-json): All received `timeout-minutes: 5` and changed from `${{ vars.AEON_RUNNER || 'ubuntu-24.04' }}` to fixed `runs-on: ubuntu-24.04` — these are lightweight ~10s checks where a bigger runner adds no value.
  - `catalog/skill-packs.json` (+65/-3): Updated pack catalog with token-movers and canon changes.
  - `skills/token-movers/SKILL.md` (+24/-4): New `--wallet` flag for holdings queries.
  - `eyebrowlock.json` (+34/-3): Regenerated integrity hashes.
  - `memory/topics/aeon-update-state.json` (+4/-106): Cleared resolved entries, advanced baseline to dd4887b.

**Impact:** The instance is now 13 fewer files behind canon. CI workflows are faster and cheaper on fixed free-tier runners. The aeon-update script's stale-copy detection rule means future syncs can land trivially-diverged files automatically. pending_conflicts dropped from 40 to 27.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None — the idle gates fail open and the scorer change only affects quality scoring, not skill execution
- **Architecture shifts:** The "idle gate" pattern is now a first-class workflow concept. Two skills use it; the pattern is extensible to any skill that can cheaply determine it has nothing to do before burning a model call.
- **Tech debt:** pending_conflicts still at 27 (down from 40). The combined idle gate step in aeon.yml handles two skills with an if/elif; a third would benefit from a dispatcher.

## What's Next
- The idle gate pattern could extend to other skills that frequently no-op (e.g. repo-pulse on quiet days, push-recap on no-commit days)
- 27 pending_conflicts remain between the instance and canon — continued aeon-update syncs will chip away at these
- The scorer fix means quality grades will shift (likely upward) for article-writing skills — worth watching the next few days of scorer output
- PR #82 (memory-flush Active Targets data refresh) is open and pending merge
