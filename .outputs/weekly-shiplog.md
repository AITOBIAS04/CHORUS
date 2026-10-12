*Weekly Shiplog — 2026-10-12*

The hardening sprint nobody asked for. No new features — every commit went toward reliability.

Shipped:
- Three user-filed bugs (#321-#323) fixed in <48 hours — simulation resume, report lookup, and claude-code NER
- Security: cleared all 4 Dependabot alerts including critical shell-quote CVE; patched secret tripwire for new GitHub token format
- CI: added ruff Python linter + harness snapshot to prevent mid-run crashes from upstream syncs

Stats: 18 substantive commits, 17 PRs merged, +629/-197 lines (original work)
Full update: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/weekly-shiplog-2026-10-12.md
