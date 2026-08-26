*Push Recap — 2026-08-26*
miroshark-aeon — 3 substantive commits by aaronjmars (16 automation commits filtered)

Security Hardening — Notify Credential Boundary: The notification system was architecturally split. notify.sh is now a pure queue-writer; a new post-run notify-deliver.sh is the only place channel tokens are consumed. 11 credential env vars removed from the skill runtime, ALL_SECRETS shrank 51→40 keys. A failed skill now still delivers its queued notifications (!cancelled() gate). Shellcheck CI lint gate added.

Upstream Canon Sync — 25 Commits: Fork synced to 8b8d719. Two new skills (skill-article: publish-ready launch articles from any skill; rightstack: Web3 stack advisor). fx (Vercel) added as 7th agent harness. Dashboard aeon.yml edits now serialized via withFileLock() — fixes a race where concurrent config changes silently clobbered each other. cron-due.sh works on macOS without workarounds.

Key changes:
- scripts/notify.sh rewritten to queue-writer only (+58/-210); scripts/notify-deliver.sh delivers post-run (+205 new)
- withFileLock() mutex on dashboard aeon.yml editing — 5 call sites were racing
- skill-article + rightstack skills added (catalog now 76)
- AI_GATEWAY_API_KEY + VERCEL_OIDC_TOKEN added to secrets allowlist for fx harness

Stats: 80 files changed, +1,602/-705 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-26.md
