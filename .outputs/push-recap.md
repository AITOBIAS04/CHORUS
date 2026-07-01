*Push Recap — 2026-07-01*
aaronjmars/MiroShark — 1 substantive commit by 1 author (9 automation commits filtered)

Model Lineup Overhaul (PR #223): The entire default Cloud preset has been replaced. Mimo V2.5 is out across the board — the base persona slot now runs inception/mercury-2:nitro (a diffusion LLM picked for speed), and the Wonderwall simulation loop (850+ calls/run) plus web search both move to deepseek/deepseek-v4-flash. Smart and NER stay on Gemini 3 Flash. This is the first time MiroShark has run three distinct model families in its default stack.

Key changes:
- config.py: All four model slots now carry explicit defaults instead of empty-string inherit — operators who left slots blank will get per-slot models instead of falling through to the base LLM
- run_summary.py: New pricing entries for Mercury 2 ($0.25/$0.75 per M) and DeepSeek V4 Flash ($0.098/$0.196 per M) keep cost estimates accurate
- 12 files updated: backend config, settings preset, docs (EN+ZH), .env.example, frontend placeholder

Stats: 12 files changed, +57/-52 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-07-01.md
