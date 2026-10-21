*Push Recap — 2026-10-21*
miroshark-aeon — 1 substantive commit by aaronjmars (18 automation commits filtered)

Upstream Sync (PR #222): 16 commits from aeonfun/aeon landed in one merge. The biggest change is a full rewrite of the aeon-update sync engine — the skill's shell snippets were being blocked by Claude Code's permission layer, causing runs to exit green with nothing synced. The new Python script (840 lines) handles the entire compare/classify/apply pass as a single allowed command.

Gateway Failover: Each gateway attempt now reports a one-line failure reason instead of a cryptic timeout. Dead fallback keys fail in 2 minutes instead of 1800 seconds. OTEL spans track provider and attempt number.

Dashboard & Config: Half-hour timezones (India, Nepal, Newfoundland) now show correct cron times. validate-config.js catches misspelled skill keys with did-you-mean hints — a typo like "enabld:" can no longer silently disable a skill.

Plugin 0.2.0: Codex plugin connects to the hosted Aeon MCP server. New get-started onboarding skill guides first-run setup.

Key changes:
- scripts/aeon_update.py: 840-line Python rewrite of upstream sync engine (+tests)
- scripts/gateway-error.sh: per-attempt error extraction for the gateway cascade
- apps/dashboard/lib/utils.ts: UTC offset fixed from hours to minutes for half-hour zones
- scripts/validate-config.js: +214 lines adding misspelled-key detection with Levenshtein hints

Stats: 53 files changed, +2504/-516 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-10-21.md
