*Push Recap — 2026-11-03*
MiroShark + miroshark-aeon — 3 substantive commits by Aaron Elijah Mars (11 automation filtered)

Upstream Canon Sync (PR #238): The big one. 32 upstream commits land in miroshark-aeon — 69 files touched, +2,080/-662 lines. Two new skills arrive: flovia (live crypto data via Flovia MCP — Nansen smart money, CoinGecko, chain reads, Zerion wallets) and github-filing-registry (structured tracker for upstream issues/PRs filed by the agent, prevents duplicates, provides triage). The secretcurl utility is removed from version control (292 lines).

Twitter API Migration: reply-maker, mention-radar, and write-tweet all switch from xAI Grok x_search to twitterapi.io as primary data source. xAI drops to fallback, WebSearch to last resort. All three now require TWITTER_API_KEY. Structured JSON responses replace free-text Grok summaries.

Supply Chain Hardening: vuln-scanner stages TruffleHog (v3.99.7) and osv-scanner (v2.7.0) with pinned SHA256 digests — fail-closed on mismatch. Replaces the old curl-pipe-sh TruffleHog installer.

Key changes:
- New skill: flovia — live Nansen/CoinGecko/chain/Zerion lookups via MCP with spend discipline (≤8 calls/run)
- New skill: github-filing-registry — pure gh CLI tracker with add/status/triage/sync/log subcommands
- Permission denials now surface as WARNING in Langfuse traces (was DEFAULT — 17/day invisible)
- @hono/node-server 2.1.0→2.1.6 security patch in MCP server (PR #239)
- Dead Sparkleware/mnemedb links stripped from MiroShark ECOSYSTEM.md (PR #355)

Stats: 71 files changed, +2,085/-667 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-11-03.md
