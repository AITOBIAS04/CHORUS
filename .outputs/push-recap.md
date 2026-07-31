*Push Recap — 2026-07-31*
MiroShark — 2 substantive commits by 2 authors
miroshark-aeon — 10 substantive commits (14 automation filtered)

Atlas Cloud Provider Preset: Community contributor nb213 landed the first feature PR (#259) — Atlas Cloud joins OpenRouter and Ollama as a one-click provider. The PR also fixed a key-leak bug where switching providers with a blank key carried the old provider's credentials to the new endpoint.

Holdings Skill: New weekly skill tracks MiroShark wallet balances on-chain via keyless public RPC — reports amount held, % of total supply, and 7d/30d token-amount growth from its own snapshot history. No dollar values, no API keys required.

Telegram Security Fix: Closed an access-control gap where any group member could command the bot via posted notification buttons. Added owner-user gate (TELEGRAM_ALLOWED_USER_ID) and auto-suppresses interactive buttons when Messages workflow is disabled.

Claude 5 Migration: Default model bumped from Sonnet 4.6 to Sonnet 5 across all execution paths — aeon.yml, gateway script, and both workflow fallbacks.

Key changes:
- settings.py _apply_preset now clears stale API keys when switching providers (security fix)
- skills/holdings/holdings.py — 218-line Python stdlib-only balance checker with ERC-20 balanceOf + GeckoTerminal supply
- notify.sh resolves Messages workflow state via GitHub API to gate interactive buttons
- mcp>=1.3.0,<2.0.0 pinned in requirements.txt to fix CI break from mcp 2.0.0

Stats: 26 files changed, +1,040/-174 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-07-31.md
