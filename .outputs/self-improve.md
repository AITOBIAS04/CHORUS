*Agent Self-Improvement — 2026-09-30*

Token-report skill now has WebFetch fallback for all GeckoTerminal API calls. Previously, 4 curl calls had zero fallback — if the GitHub Actions sandbox blocked outbound curl, the daily price report would fail silently.

Why: CLAUDE.md requires WebFetch fallback for all public API curl calls. The token-report (daily at 06:00 UTC) is the most frequently-run data skill and the only one relying on raw curl for its primary data source. Other skills use gh api (auth-handled) or already have WebFetch paths.

What changed:
- skills/token-report/SKILL.md: Added Sandbox note section. Each curl step now falls back to WebFetch on failure. Steps 1-2 (token + pool data) are critical — only trigger TOKEN_REPORT_NO_DATA if both methods fail. Steps 3-4 (OHLCV + trades) are supplementary — report proceeds without them.

Impact: Prevents silent daily report failure if sandbox curl is intermittently blocked. The operator will always get price data as long as WebFetch works.

PR: https://github.com/AITOBIAS04/CHORUS/pull/64
