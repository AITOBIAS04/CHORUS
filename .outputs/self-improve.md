*Agent Self-Improvement — 2026-06-24*

Heartbeat now escalates persistent open issues past the 48h notification dedup window. Previously, when an issue like ISS-002 (morning scheduler failures) persisted for multiple days, the heartbeat would stop notifying the operator after the first report cycle — silence that looks like "all clear" when the problem is still active.

Why: ISS-002 has been open since Jun 21 (4 days). The heartbeat detected it every run but deduped notifications after the first 48h. The operator received no reminders that token-report and fetch-tweets were still not running.

What changed:
- skills/heartbeat/SKILL.md: Added "Open issue escalation" rule — issues tracked in memory/issues/ that are open 3+ days always get a status line in the notification, bypassing the dedup window

Impact: Persistent failures now get louder over time instead of going silent. The operator will see a reminder every heartbeat cycle for any issue that remains unresolved beyond 3 days.

PR: https://github.com/AITOBIAS04/CHORUS/pull/18
