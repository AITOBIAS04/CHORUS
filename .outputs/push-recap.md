*Push Recap — 2026-06-25*
aaronjmars/MiroShark — 5 substantive commits by 2 authors (Daniel Andersen, @aaronjmars)
aaronjmars/miroshark-aeon — 3 substantive commits (38 automation filtered)

Interview System Hardening (#214): Comprehensive fix for silent batch-interview hangs with slow thinking models. Engine catches errors and sends None instead of dying, PID liveness verification catches crashed workers, env.step() wrapped in 220s asyncio timeout, interview endpoints return HTTP 400 with the real error. Stop lifecycle fixed so intentional stops no longer trigger spurious "failed" alerts.

Local LLM Infrastructure (#212): Self-hoster tuning — AGENTS_PER_BATCH halved (15→7) to prevent JSON truncation, summary lengths doubled (300→500), twhin-bert pre-warmed during visible setup, Neo4j schema retry with backoff, Docker healthcheck gating + persistent HF model cache + SIMD-accelerated vectors.

i18n Locale Persistence (#213): Non-English sims drifted to English over rounds — fixed with per-round locale directives in agent messages, contextvars propagation for ThreadPoolExecutor workers (Python <3.12), and per-section ReasoningTrace recorders to prevent concurrent clobbering.

CLI stop Subcommand (#216, #217): Completes the automation lifecycle — `wait || stop` pattern for bounded runs. Docs fix corrects --json flag placement.

Aeon Schedule Tuning (#76): Paused 9 build/content skills, stretched docs-sync to every 3 days and repo-pulse to every 2 days. Lean watch-and-report loop.

Key changes:
- platform.running() no longer hangs on unknown/errored actions — sends None back and continues
- Docker Compose uses service_healthy gating for Neo4j across all 3 compose files
- contextvars.copy_context().run() propagates locale into report ThreadPoolExecutor workers

Stats: 24 files changed, +583/-135 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-25.md
