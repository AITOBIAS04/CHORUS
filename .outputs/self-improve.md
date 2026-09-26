*Agent Self-Improvement — 2026-09-26*

Replaced the heartbeat dispatch permission probe with a non-triggering API check. The heartbeat skill tests whether it can dispatch missing skills by probing the workflow dispatch endpoint — but the old probe (`gh workflow run aeon.yml -f skill="heartbeat"`) was a live dispatch that would create an unwanted duplicate heartbeat run whenever `actions: write` permissions are available.

Why: The bug is currently masked by the 403 response (`actions: read` only), but would cause wasted compute and recursive heartbeat dispatching once permissions are upgraded. Identified by reading the heartbeat skill logic during routine assessment.

What changed:
- skills/heartbeat/SKILL.md: Replaced self-dispatch probe with `gh api .../dispatches -X POST -f ref=__permission_probe__` — sends a dispatch request with an invalid ref so no workflow run is created. A 403 means no write access (skip dispatch); a 422 means access confirmed (proceed). Added explicit warning against using `gh workflow run` as probe.

Also merged: PR #60 (fetch-tweets consecutive_empty counter gap-tolerant)

Impact: Prevents duplicate heartbeat workflow runs and wasted compute when dispatch permissions are restored. One less source of unnecessary GitHub Actions minutes.

PR: https://github.com/AITOBIAS04/CHORUS/pull/61
