*Push Recap — 2026-09-01*
miroshark-aeon — 3 substantive commits by 2 authors

10th-Gen Harness Fleet (upstream sync #161): The big one. 34 upstream commits synced, bringing the harness count from 7 to 10 — Cursor, Hermes, and GLM now join Claude, Grok, Codex, Pi, Vibe, Kimi, and fx. The MCP server's blocking spawnSync was replaced with async spawn + a single-flight queue, so skill runs no longer freeze the event loop. Telegram notifications from the same skill now thread under each other via reply_to_message_id. The HTML chunker was rewritten to split rendered HTML at tag boundaries. Two new skills: cortx-reliability (x402 endpoint checker) and rightstack (Web3 stack advisor), catalog now at 77.

GLM Reasoning Effort: Reasoning depth pinned to high by default for the GLM gateway, with a GLM_REASONING_EFFORT var override. Verified: low ~2.4k think chars, high ~15.3k, max ~32.7k.

Holdings Snapshot: Fifth consecutive accumulating snapshot — 11.78B tokens (11.78%), +507.7M in 7d (+4.50%), +1.06B in ~30d (+9.90%).

Key changes:
- MCP server async rewrite — skill runs no longer block the Node event loop for up to 10 minutes
- wrap_raw_output now rejects (exit 3) instead of wrapping broken output as SUCCESS — silent-failure path closed
- Chain runner uses unique dispatch IDs — no more mismatched run lookups on concurrent dispatches
- deploy-uni-hook: Labs routing rules + fleet audit defect catalog codified in skill spec
- skill-health/skill-repair: new fix-pending lifecycle — repair PRs tracked through merge/close
- secretcurl: built-in 3-attempt retry for x.ai Responses endpoint
- Dashboard GitHub auth API + aeon auth --github — one-command GH_GLOBAL setup

Stats: ~100 files changed, +2,519/-487 lines (44 automation commits filtered)
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-09-01.md
