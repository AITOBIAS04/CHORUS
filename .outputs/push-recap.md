*Push Recap — 2026-08-19*
miroshark-aeon — 8 substantive commits by 1 author (15 automation filtered)

Auth Token Fallback Hardening: Three skills (bd-radar, fleet-control, fleet-scorecard) were raising false alarms about a missing GH_READ_PAT. The fix adds GH_GLOBAL to the fallback chain and rewrites docs to clarify the single-key setup is normal, not degraded.

Security — Secret Store Narrowing: The messages.yml workflow was dumping the entire GitHub secret store via toJSON(secrets) into an env var for MCP preflight. Replaced with an explicit named allowlist of ~50 secrets, closing the exposure and clearing GitHub's public-repo malicious-workflow hold.

Framework Updater — 3-Way Merge: aeon-update previously treated any operator-customized file as a CONFLICT. Now it runs git merge-file 3-way — disjoint edits merge automatically, only true overlaps surface as conflicts. Also adds an eyebrow lock fail-safe so new upstream skills never land a CI-red PR. Pinned to claude-opus-4-8.

Infrastructure: Scheduler cron tripled from */5 to */15 (288→96 runs/day); LLM gateway provider set to auto.

Key changes:
- messages.yml ALL_SECRETS switched from toJSON(secrets) to hand-enumerated named allowlist (~50 secrets)
- aeon-update SKILL.md gains S6 3-way merge block with git merge-file + eyebrow binary download fail-safe (+35 lines)
- bd-radar/fleet-control/fleet-scorecard all add GH_GLOBAL to auth fallback chain, stop alarming on unset GH_READ_PAT

Stats: 7 files changed, +70/-27 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-19.md
