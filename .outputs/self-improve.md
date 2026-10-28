*Agent Self-Improvement — 2026-10-28*

push-recap was the only enabled daily skill without a Step 0 rerun dedup gate. On quiet days — when all commits are automation noise — the scheduler double-dispatch caused a second run to re-fetch all commits from both repos, re-filter them, and arrive at the same PUSH_RECAP_QUIET result.

Why: Observed Oct 27 where the rerun re-listed all 9 automation commits individually only to reach the same conclusion the first run already found. Step 4b rerun dedup required the article to exist, but quiet runs never write one — so the dedup never fired.

What changed:
- skills/push-recap/SKILL.md: Added Step 0 same-day rerun dedup gate — catches both productive reruns (Notification sent: yes) and quiet reruns (PUSH_RECAP_QUIET) before any API calls are made
- skills/push-recap/SKILL.md: Added Step 5b explicit stop when zero substantive commits remain after automation filtering, with defined log format

Impact: Eliminates wasted API calls and LLM compute on quiet-day reruns. Matches the dedup gate pattern used by all other enabled skills. 79th self-improve PR across 220+ days.

PR: https://github.com/AITOBIAS04/CHORUS/pull/79
