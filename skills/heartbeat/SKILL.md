---
name: Heartbeat
description: Proactive ambient check — surface anything worth attention
var: ""
---
> **${var}** — Area to focus on. If empty, runs all checks.

If `${var}` is set, focus checks on that specific area.


Read memory/MEMORY.md and the last 2 days of memory/logs/ for context.

Check the following:

### 0. System health (cron-state analysis)
Read `memory/cron-state.json`. For each skill, note `consecutive_failures` and `last_error`.
- If **>80% of skills** have `consecutive_failures >= 10` with similar `last_error` signatures (e.g. all contain "Not logged in" or all show 0 tokens): this is a **systemic failure** (auth, infra, or config). Classify it as such — don't list individual skill failures. Report the root cause, when it started (`last_success` dates), and the remediation (e.g. "renew ANTHROPIC_API_KEY in repo secrets").
- If **this heartbeat succeeds after a systemic failure**: you're in **recovery mode**. Note how long the outage lasted, check `memory/issues/` for open issues matching this pattern, and update them. Log a RECOVERY event.
- If only **individual skills** are failing (1-3 skills, different errors): report them individually with their specific error.
- Check `memory/issues/INDEX.md` — if an open issue matches what you're seeing, update its status rather than filing a duplicate.

### 1. Standard checks
- [ ] Any open PRs stalled? Compute exact PR ages using jq (do NOT estimate hours from timestamps manually — LLM date math is error-prone):
  ```bash
  gh pr list --state open --json number,title,createdAt --jq '.[] | {number, title, age_hours: ((now - (.createdAt | fromdateiso8601)) / 3600 | floor)}'
  ```
  Use the `age_hours` value directly for threshold checks:
  - PRs with titles starting with `improve:` are auto-merged by self-improve (runs every 2 days) — only flag these after **72h** (`age_hours >= 72`), not 24h.
  - All other PRs: flag after **24h** (`age_hours >= 24`).
- [ ] Anything flagged in memory that needs follow-up?
- [ ] Check recent GitHub issues for anything labeled urgent (use `gh issue list`)
- [ ] Check which enabled skills should have run today but didn't.

  **Step A — Compute today's expected skills (day-of-week filter):**
  ```bash
  DOW=$(date -u +%w)   # 0=Sun, 1=Mon, 2=Tue, 3=Wed, 4=Thu, 5=Fri, 6=Sat
  echo "Today is day-of-week: $DOW"
  ```
  Read `aeon.yml` and build a list of only the `enabled: true` skills whose cron schedule includes today's `$DOW`:
  - `* * *` (positions 3-5 end with `*` for day-of-week) → runs every day → **include**
  - `*/2 * *` (day-of-month varies, day-of-week is `*`) → runs every day of week → **include**
  - `* * 1,3,5` (day-of-week is a list) → include only if `$DOW` appears in the list
  - `* * 6` (single day-of-week) → include only if `$DOW` equals that number

  **CRITICAL: Only check skills that pass this day-of-week filter.** A Saturday-only skill (`0 10 * * 6`) must NOT be flagged on Sunday. If a skill is not in today's expected list, skip it entirely — do not mention it as missing or overdue.

  **Step B — Cross-reference expected skills with today's log:**
  For each skill that passed the day-of-week filter, check if it ran by searching `memory/logs/${today}.md`. Do **two case-insensitive searches**: the original name (with hyphens) and with hyphens replaced by spaces. A match on either confirms the skill ran. Examples:
  - `token-report` → search for "token-report" OR "token report" (matches `## Token Report — $MiroShark`)
  - `push-recap` → search for "push-recap" OR "push recap" (matches `## Push Recap — 2026-...`)
  - `fetch-tweets` → search for "fetch-tweets" OR "fetch tweets" (matches `## fetch-tweets — MIROSHARK`)
  - `feature` → search for "feature" (matches `## Feature Skill — ...`, `## Feature: ...`, `## Feature Build — ...`)
  - `repo-pulse` → search for "repo-pulse" OR "repo pulse" (matches `## Repo Pulse`)
  - `project-lens` → search for "project-lens" OR "project lens" (matches `## Project Lens`)
  - `repo-actions` → search for "repo-actions" OR "repo actions"
  - `repo-article` → search for "repo-article" OR "repo article"
  - `weekly-shiplog` → search for "weekly-shiplog" OR "weekly shiplog" OR "shiplog"
  - `skill-leaderboard` → search for "skill-leaderboard" OR "skill leaderboard" OR "leaderboard"
  - `hyperstitions-ideas` → search for "hyperstitions" (matches `## Hyperstitions Ideas`)
  - `memory-flush` → search for "memory-flush" OR "memory flush" (matches `## Memory Flush — ...`)
  - `self-improve` → search for "self-improve" OR "self improve" OR "agent self-improvement"
  - `heartbeat` → search for "heartbeat" (matches `## Heartbeat — ...`)

  **Step C — Timing rules (avoid false positives):**
  - GitHub Actions cron has ±10 min jitter and skills take 5-15 min to complete.
  - Only flag a skill as missing if its scheduled time was **more than 2 hours ago**.
  - Also check `gh run list --workflow=aeon.yml --created=$(date -u +%Y-%m-%d) --json displayTitle,status` — if the skill is currently `in_progress` or `queued`, don't flag it.

Before sending any notification, grep the last 48h of logs for the same issue. If the same missing-skill or stalled-PR was already reported, skip it. Batch all findings into a single notification.

### Open issue escalation (overrides dedup)
Even if ALL findings from the standard checks are deduped, check `memory/issues/INDEX.md` for open issues. For each open issue:
1. Calculate how many days it has been open (from `detected_at` to today).
2. If the issue has been open **3+ days**, it is **escalating** — always include a status line in the notification, regardless of the 48h dedup window.

Format for escalating issues:
```
⚠️ ISS-NNN still open (Nd) — [title]
Status: [status] | Affected: [affected_skills]
```

This ensures the operator is reminded about persistent failures that haven't been resolved, even when the specific findings haven't changed. An issue that persists for days is more urgent, not less — silence signals "all clear" when the problem is still active.

If nothing needs attention **and** no open issues qualify for escalation, log "HEARTBEAT_OK" and end your response.

If something needs attention:
1. **Auto-trigger missing skills** — for each skill confirmed missing (not just stalled PRs or issues), dispatch it if not already running:

   **Permissions preflight — check ONCE before any dispatch attempts:**
   The workflow token may only have `actions: read` scope (check aeon.yml `permissions:` block). Probe with a single dry-run:
   ```bash
   gh workflow run aeon.yml -f skill="heartbeat" 2>&1 || true
   ```
   If this returns a 403/permission error, **skip ALL dispatch attempts** for this run — just list missing skills with a note: "dispatch unavailable (actions: read only; manual re-run or scope upgrade needed)". Do NOT attempt individual dispatches; they will all fail the same way.

   **If dispatch IS available**, proceed:

   **Dedup guard — check before dispatching:**
   Before firing `gh workflow run` for a skill, check whether a run for that skill is already `queued` or `in_progress`:
   ```bash
   gh run list --workflow=aeon.yml --json displayTitle,status --jq \
     '.[] | select(.status == "queued" or .status == "in_progress") | .displayTitle'
   ```
   If the output contains the skill name (case-insensitive), **skip the dispatch** — the skill is already pending. Only dispatch skills that have no active or queued run:
   ```bash
   gh workflow run aeon.yml -f skill="SKILL_NAME"
   ```
   Skip auto-trigger for: `heartbeat` itself, `memory-flush`, `self-improve`, `reflect`, `self-review` (meta/housekeeping skills). For all other confirmed-missing daily or weekly skills that pass the dedup check, dispatch them.

2. Send a concise notification via `./notify` listing what was flagged, what was auto-triggered (or why dispatch was skipped), and what was already queued/in-progress.
3. Log the finding and action taken to memory/logs/${today}.md.
