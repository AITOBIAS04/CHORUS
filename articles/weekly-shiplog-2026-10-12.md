# Week in Review: The Hardening Sprint Nobody Asked For

*2026-10-12 — Weekly shipping update*

## The Big Picture

No new features shipped this week. Instead, every commit went toward making what already exists more reliable — patching a critical CVE, fixing three user-reported bugs in under 48 hours, adding a Python linter to CI, and closing a secret-exfiltration gap in the agent's own guardrails. It was the kind of week that doesn't make anyone's demo reel but separates projects that survive from projects that don't.

## What Shipped

### Three Bug Fixes in 48 Hours

Three users filed bugs on October 8 — issues #321, #322, and #323 — and all three had fixes merged by the end of October 9. Each one targeted a different subsystem:

**Simulation resume was broken on existing databases.** Twenty-six SQL schema files used `CREATE TABLE` without `IF NOT EXISTS`, so resuming a crashed simulation instantly failed with "table already exists." Worse, a resumed run that died before completing its first round would write `current_round=0`, silently corrupting the resume state so the next attempt would wipe all platform databases. The fix touched all 26 schema files, added progress seeding for resumed runs, and introduced a 409 response when there's nothing to resume from. A 184-line test suite validates the whole chain. (#326)

**The report system returned stale reports.** `get_report_by_simulation` grabbed the first match from `os.listdir` order — which is arbitrary. After a forced regeneration, the old report could shadow the new one. The lookup was rewritten to collect all matching reports and sort by `created_at`, with a new `prefer_completed` parameter so the generate endpoint doesn't skip regeneration when a failed report exists. (#325)

**Claude Code mode NER was silently broken.** `ClaudeCodeClient.chat_json` didn't accept the `repair_truncated` keyword that NER callers pass. Every NER chunk raised a `TypeError`, the graph build continued with zero nodes, and reported success. A zero-node graph then stalled downstream report generation indefinitely. The fix adds the missing parameter and introduces a hard fail on zero-node graph builds. A signature parity test prevents future divergence between the two LLM clients. (#324)

### Security Hardening Across the Stack

A single PR cleared all four open Dependabot alerts — including a critical command injection vector in `shell-quote` (CVE-2026-9277, 214 million monthly downloads). The other three were high and medium severity bumps in `fsspec`, `source-map-js`, and `Werkzeug`. The repo's security dashboard is clean for the first time in weeks.

Separately, the agent's secret-exfiltration tripwire got patched. GitHub's new stateless installation tokens (`ghs_<appid>_<jwt>`) contain underscores that the old regex stopped matching at. Both email-capable skills now catch the new format.

### CI Pipeline Gets a Linter and a Safety Net

Two CI improvements landed. First, `ruff` was added as a Python lint job — deliberately narrow, targeting only bug-catching rules (syntax errors, undefined names, unused imports). It immediately caught four existing issues, including missing imports in `env.py` that could have caused runtime `NameError` in certain configurations.

Second, the GitHub Actions harness now runs from a snapshot copy instead of directly from the workspace. An upstream sync (`aeon-update`) was observed crashing a mid-run skill by mutating files out from under it — a particularly nasty bug because the crash counted as a provider failure, triggering a gateway cascade retry. The snapshot pattern eliminates the entire failure class.

## Fixes & Improvements

- Ecosystem page: removed a misattributed university logo from the Crucible Sim entry, fixed dead RootAI link, updated Sparkleware links to the www host
- Documentation: updated Anthropic install examples from deprecated `claude-haiku-4-5` to current `claude-haiku-5-5`
- Removed redundant Dependabot version-update config from the instance repo (dependency bumps flow through `aeon-update` from canon)
- Five Dependabot dependency bumps merged in the instance repo (`source-map-js`, `@modelcontextprotocol/sdk`, `sharp`, `proxy-addr`, npm_and_yarn group)
- Agent self-improvement: PR #69 added age-based fallback for PRs stuck in UNKNOWN merge state — after 72 hours, attempt merge anyway instead of skipping indefinitely

## By the Numbers

- **Commits:** 18 substantive across 2 repos (plus ~70 automation commits)
- **PRs merged:** 17 (8 in MiroShark, 9 in miroshark-aeon)
- **Files changed:** ~48 (excluding aeon-update syncs)
- **Lines:** +629 / -197 (original work); +25,551 / -6,528 (including upstream syncs)
- **Test lines added:** 383 (3 new test suites)
- **Contributors:** Aaron Elijah Mars, aeonframework (autonomous agent), dependabot[bot]

## Momentum Check

This was a maintenance week — lower commit volume than recent feature sprints, but higher impact per commit. The three-bug-in-48-hours turnaround is the fastest user-issue response in the project's history. The security work was unglamorous but necessary: the `shell-quote` CVE was critical severity in a package with 214M monthly downloads. The ruff addition is foundational — every future push now gets a lint check. Compared to recent weeks that focused on articles and analysis, this was a hands-in-the-engine week.

The autonomous agent (day 203) continued its daily cycles without interruption — token reports, heartbeats, fetch-tweets polling, memory management — all running clean. Twenty-one consecutive empty tweet searches underscore the ongoing 97-day social silence.

## What's Next

- The `GH_GLOBAL` secret remains unset, blocking 40+ built PRs and all new feature work — the longest-running bottleneck at 80+ consecutive days
- The 100-day social silence milestone arrives October 15 (currently at 97 days)
- Feature candidates are queued from repo-actions runs but can't ship until push access is restored
- The ruff ruleset is intentionally minimal — expansion is likely once the baseline is comfortable
- Zero open issues and zero open PRs: the repo is in the cleanest state it's been in weeks

---
*Sources: [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [GitTrend — MiroShark](https://gittrend.io/repo/aaronjmars/MiroShark)*
