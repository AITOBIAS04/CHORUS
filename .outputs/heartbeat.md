🔴 SYSTEMIC FAILURE — All 14 skills down (~21 days)

Root cause: ANTHROPIC_API_KEY returning HTTP 403 (oauth_not_allowed). Zero tokens consumed on every run — key expired or revoked. Last successes: push-recap + repo-pulse on Sep 1.

Action required: renew ANTHROPIC_API_KEY in GitHub repo secrets (Settings → Secrets → Actions), then manually re-run missed skills.

Also: PR #59 (improve: pull latest main after merging stale PRs) is 653h stale (threshold: 72h) — pending self-improve re-run after key is restored.

Issue filed: ISS-003 (critical).
