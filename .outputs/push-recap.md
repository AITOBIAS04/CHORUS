*Push Recap — 2026-08-04*
MiroShark — 2 substantive commits by @aaronjmars
miroshark-aeon — 1 substantive commit by aeonframework
(9 automation commits filtered)

Ecosystem Cleanup — Noelclaw Removed: Two coordinated PRs (#266 + #267) pulled the Noelclaw MCP integration from the ecosystem table, backend catalog, and both EN/ZH feature docs. The drift-guard test caught the incomplete first PR and forced the follow-up — exactly the safety net it was designed to be.

CI Security — Workflow Hardening: Replaced a blanket toJSON(secrets) dump with an explicit 7-secret named list and removed ~100 lines of dead Fleet Watcher preflight/postflight code. This clears the GitHub malicious-workflow scanner hold that was blocking every workflow dispatch on the public repo.

Key changes:
- ALL_SECRETS switched from implicit secrets-context dump to explicit named JSON — declares exactly which secrets the workflow reads
- Noelclaw removed from ECOSYSTEM.md, ecosystem_catalog.py, FEATURES.md, and FEATURES.zh-CN.md — ecosystem drops to 11 active integrations
- Fleet Watcher preflight + postflight steps deleted (-~95 lines) — never configured on this instance, pure dead code

Stats: 5 files changed, +12/-116 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-04.md
