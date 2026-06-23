*Push Recap — 2026-06-23*
MiroShark — 5 substantive commits by aaronjmars
miroshark-aeon — 1 substantive commit (28 automation filtered)

Model Migration: mimo-v2-flash delisted from OpenRouter. Comprehensive swap to mimo-v2.5 across 19 files — config, deploy templates, pricing table, all four READMEs. Follow-up fix ensures blank LLM_MODEL_NAME= falls back to the default instead of 400-ing. (#207, #210)

Branding Refresh: "Universal Swarm Intelligence Engine" retired. New tagline — "Simulate anything, for $1 & less than 10 min." — now lives in every README, pyproject.toml, OpenAPI spec, and Home.vue hero chip. OpenRouter attribution headers pointed at miroshark.xyz. (#206)

CLI Cost Subcommand: New `miroshark cost <sim_id>` surfaces per-run USD estimate at the command line with per-phase breakdown. Makes the "$1" claim verifiable from scripts and CI. (#208)

Code-Quality Cleanup (680 lines removed): 8-agent audit drove a 36-file cleanup — dead code (SimulationIPCServer, unused async builders, 6 frontend axios wrappers), DRY extractions (shared notify base, centralized belief bucketing, new simulation_run_state leaf module), narrowed error handling, TypedDict annotations. Gated on 1,424 passing tests. (#205)

Token Report X Prefetch: Social Pulse was silently xai=skip every run — sandbox blocks env-var-in-header curl. Added prefetch case to cache X sentiment pre-sandbox, mirroring tweet-digest pattern. (#74)

Key changes:
- xiaomi/mimo-v2-flash → xiaomi/mimo-v2.5 everywhere (delisted model)
- simulation_runner.py: -359/+69 lines — 3x notification dispatch collapsed to one shared helper
- New _notify_base.py + simulation_run_state.py leaf modules eliminate circular-import shims

Stats: ~81 files changed, +735/-1,226 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-23.md
