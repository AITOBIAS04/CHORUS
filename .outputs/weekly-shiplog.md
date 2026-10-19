*Weekly Shiplog — 2026-10-19*

Both repos got eyes. Coordinated observability upgrades landed across MiroShark and miroshark-aeon — Langfuse tracing for the agent pipeline, OpenRouter Broadcast for simulation LLM calls, Blacksmith bare-metal CI runners.

Shipped:
- Dual-layer observability — Langfuse agent tracing (PRs #205-207, #212) + OpenRouter Broadcast simulation traces (#335, #337)
- CI on bare metal — Blacksmith runners (#334, #211), uv + ruff-action (#332), job consolidation (#336)
- Infrastructure hardening — 42-commit upstream sync (#216), Git auth fix (#217), repo org move (#210), security contact (#333), shell-quote CVE fix (#331)

Stats: ~19 commits, 18 PRs merged, +4,900/-1,000 lines
Full update: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/weekly-shiplog-2026-10-19.md
