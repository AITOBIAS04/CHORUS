*Push Recap — 2026-06-12*
MiroShark + miroshark-aeon — 3 commits by @aaronjmars

Server-Side Surface Catalog Filtering (MiroShark PR #157): The /api/surfaces.json endpoint now accepts an optional ?type=<category> query param, letting integrators fetch just one of the 7 surface categories server-side instead of pulling the full 37-surface catalog. Per-category ETags prevent cache collisions. Unknown types return 400 with the valid set. 8 new tests, OpenAPI spec and docs updated. Fully backward-compatible.

Pre-Ship Validation for Feature Skill (miroshark-aeon PR #60): The autonomous feature skill was cloning repos into /tmp where the sandbox blocks code execution — every feature PR shipped without running its test suite. Now clones into workspace-relative .feature-build/ where exec is permitted, and adds an explicit "validate before shipping" step. Triggered by today's MiroShark #157 shipping 8 unrun tests.

Inbound Message Handling Disabled (miroshark-aeon): TG/Discord/Slack message collection and dispatch turned off at operator request. Cron scheduler unaffected — all scheduled skills keep running. Reversible via two inline comments.

Key changes:
- /api/surfaces.json ?type= filter with per-category ETags and 400 validation (+236/-30 lines, 6 files)
- Feature skill clone path /tmp → .feature-build/ + test suite validation step (+28/-10 in SKILL.md)
- messages.yml inbound pipeline early-exit + run job disabled (+9/-1 lines)

Stats: 14 files changed, +341/-41 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-12.md
