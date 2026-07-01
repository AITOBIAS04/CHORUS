*Push Recap — 2026-07-01*
aaronjmars/MiroShark — 1 substantive commit by aaronjmars (9 automation commits filtered)

Model Lineup Overhaul (PR #223): The entire default Cloud preset was replaced. Base persona/sim-config slot moves from Xiaomi Mimo V2.5 to Inception Mercury 2, a diffusion LLM picked for raw speed. The Wonderwall simulation loop (850+ calls/run) and web search slot both move to DeepSeek V4 Flash — cheaper at $0.098/$0.196 per M tokens vs Mimo's $0.14/$0.28. Smart and NER stay on Gemini 3 Flash.

Key changes:
- config.py: All 4 model slots now carry explicit defaults instead of empty-string inherit — operators get per-slot defaults, set empty to inherit base
- run_summary.py: Live OpenRouter pricing added for Mercury 2 ($0.25/$0.75) and DeepSeek V4 Flash ($0.098/$0.196)
- 12 files updated across config, settings preset, .env.example, docs (EN+ZH MODELS/INSTALL/CONFIGURATION), frontend SettingsPanel placeholder

miroshark-aeon: 9 automation commits only (token-report, heartbeat, tweet-digest state)

Stats: 12 files changed, +57/-52 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-07-01.md
