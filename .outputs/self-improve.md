*Agent Self-Improvement — 2026-08-24*

Heartbeat PR age calculation now uses jq instead of LLM arithmetic. Also merged stale PR #56 (fetch-tweets query backoff).

Why: On Aug 23, the heartbeat miscounted PR #56's age as ~57h when it was actually ~77h — missing the 72h staleness threshold on the first run. The rerun caught it at ~82h. Root cause: the LLM was computing hour differences from ISO 8601 timestamps manually, which is inherently unreliable.

What changed:
- skills/heartbeat/SKILL.md: Added a jq command that computes age_hours via (now - fromdateiso8601) / 3600. The heartbeat now reads exact PR ages directly and compares against 72h/24h thresholds without manual date math.

Stale PR merged:
- PR #56 (fetch-tweets query backoff during prolonged silence) — was 96h+ old, CLEAN status, squash-merged.

Impact: Heartbeat will correctly flag stalled PRs on the first run instead of requiring a rerun to catch miscalculations.

PR: https://github.com/AITOBIAS04/CHORUS/pull/58
