*Push Recap — 2026-07-22*
aaronjmars/MiroShark — 2 substantive commits by aaronjmars (9 automation commits filtered)

Security: Same-Day CVE Patching: Two dependency patches shipped within hours of advisory publication, continuing the project's pattern of same-day MTTR against the 40+ MCP-ecosystem CVEs tracked in 2026. Industry average is 74-252 days.

Key changes:
- MCP SDK 1.27.2 → 1.28.1 closing CVE-2026-59950 (CSWSH, CVSS 7.6) — real attack surface for WebSocket deployments (#255)
- shell-quote 1.8.4 → 1.10.0 via scoped npm override clearing CVE-2026-13311 (quadratic DoS, CVSS 7.5) — not reachable in this codebase but defense-in-depth; override self-deactivates when concurrently upstream repins (#256)
- Dependabot alert #66 cleared; #65 (torch, low) intentionally left

Stats: 3 files changed, +10/-7 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-07-22.md
