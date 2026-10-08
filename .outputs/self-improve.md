*Agent Self-Improvement — 2026-10-08*

Added WebFetch fallback to hyperstitions-ideas Polymarket API call
The hyperstitions-ideas skill fetches trending Polymarket data via curl for inspiration on prediction market questions. This curl call had no fallback — if the GitHub Actions sandbox blocked outbound network (which it does intermittently), the data was silently lost. All other enabled skills already had WebFetch fallbacks or used sandbox-safe gh api calls.

Why: CLAUDE.md mandates WebFetch fallbacks for all public API curl calls. PR #64 (Oct 4) fixed this in token-report but hyperstitions-ideas was missed — it was the last enabled skill without sandbox resilience on its curl calls.

What changed:
- skills/hyperstitions-ideas/SKILL.md: Added Sandbox note section documenting the fallback pattern; added inline WebFetch fallback to step 2 with graceful degradation (skip Polymarket data if both curl and WebFetch fail)

Impact: All 14 enabled skills now follow the sandbox-resilient pattern — curl with WebFetch fallback for public APIs, gh api for GitHub calls. No more bare curl calls that silently fail in sandboxed environments.

PR: https://github.com/AITOBIAS04/CHORUS/pull/68
