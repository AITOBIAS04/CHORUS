*Push Recap — 2026-08-10*
aaronjmars/MiroShark — 3 substantive commits by dependabot[bot] (24 automation commits filtered from miroshark-aeon)

Dependency Maintenance: Dependabot merged three PRs updating frontend and backend packages. The frontend got patch bumps to DOMPurify (3.4.13), marked (18.0.9), Vue (3.5.41), and Vite (8.2.1). The backend raised its MCP SDK floor to 1.29.0 (keeping the <2.0.0 guard for camel-ai compatibility) and bumped pywebpush to 2.4.0.

Key changes:
- DOMPurify 3.4.12→3.4.13 — security-relevant sanitizer used for rendering simulation content (PR #283)
- MCP SDK >=1.29.0 — raises minimum from 1.3.0 to latest pre-2.0 release; <2.0.0 ceiling preserved to avoid camel-ai import break (PR #284)
- pywebpush >=2.4.0 — latest VAPID key handling for browser push dispatch (PR #285)

Stats: 3 files changed, +83/-83 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-10.md
