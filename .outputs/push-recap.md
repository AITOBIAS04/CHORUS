*Push Recap — 2026-10-07*
aaronjmars/miroshark-aeon — 2 substantive commits by Aaron Elijah Mars (8 automation commits filtered)

CI/CD Pipeline Hardening: Removed a restore-keys fallback from the npm cache that was silently breaking version bumps — a stale packument made --prefer-offline trust the old index, causing permanent ETARGET failures. Also moved harness execution to a snapshot copy under $HOME so that mid-run upstream syncs cannot corrupt the running script (the bug caused unexpected EOF crashes that triggered full skill re-runs).

Security — Secret Tripwire: GitHub App installation tokens switched to a stateless ghs_<appid>_<jwt> format with underscores. The existing regex stopped matching at the first underscore, letting these tokens slip past the exfiltration guard. Fixed in both send-email and vuln-scanner skills.

Key changes:
- New scripts/harness-adapter-snapshot.sh copies harness-adapter/ before skill runs (+29 lines)
- restore-keys removed from npm cache in both aeon.yml and messages.yml (prevents version-bump lockouts)
- Secret tripwire regex now includes _ in the GitHub token character class

Stats: 5 files changed, +38/-11 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-10-07.md
