# Week in Review: The CLI Learned to Wait, Stop, and Tell You What It Cost

*2026-06-29 — Weekly shipping update*

## The Big Picture

This was the week MiroShark stopped being a tool you run and started being a tool you script. Three new CLI subcommands — `cost`, `wait`, `stop` — landed in four days, completing a full automation lifecycle that lets pipelines run a simulation, block until it finishes, check the bill, and bail if something goes wrong. Underneath that, community contributor Daniel Andersen shipped three PRs that eliminated an entire class of silent failures: interview hangs with local LLMs, locale drift in non-English simulations, and JSON truncation from oversized agent batches. A surgical 680-line cleanup made room for all of it. The one-line summary: MiroShark can now be automated end-to-end, in any language, on any model, without surprises.

## What Shipped

### CLI Automation Lifecycle

Before this week, MiroShark's CLI could start a simulation and pull a report. Everything in between — waiting for completion, checking cost, cancelling a stuck run — required hand-rolling HTTP calls against the API. Three subcommands changed that in rapid succession.

`cost` (PR #208, Jun 23) surfaces the per-run USD estimate at the command line. It calls the existing `/api/simulation/<id>/cost.json` endpoint and formats it as `~$0.9213 (1,284,902 tokens, 871 LLM calls)` with a per-phase breakdown. The tilde prefix mirrors the embed view, marking it as a lower-bound estimate. The "$1 to simulate anything" tagline is now a `--json`-parseable assertion.

`wait` (PR #215, Jun 24) blocks until a simulation reaches a terminal state, with configurable `--interval` and `--timeout` flags. Progress lines print to stderr so stdout stays clean for piping. Transient 5xx errors are retried with a warning rather than treated as failures — a network blip during a 30-minute simulation won't fake a crash.

`stop` (PR #216, Jun 25) completes the loop. A hung or timed-out run can now be cancelled from the CLI instead of raw-curling the stop endpoint. The canonical pattern becomes `wait "$SIM" --timeout 600 || stop "$SIM"` — bound the run, clean up on timeout, move on.

Together these three commands turn MiroShark into something a CI pipeline, a cron job, or a Jupyter notebook can drive without human babysitting.

### Thinking Model Robustness and Local LLM Hardening

Daniel Andersen's PR #209 was the week's densest change: an 8-file sweep that makes MiroShark's LLM pipeline resilient to reasoning models like deepseek-v4-flash, Qwen3, and MiniMax M2.5. These models emit `<think>` blocks that were exhausting token budgets before producing usable output, returning empty responses after thinking, and generating malformed JSON that broke downstream parsing.

The fix adds a `THINKING_BUDGET_TOKENS` env var that pads `max_tokens` with headroom for reasoning, strips unclosed `<think>` blocks (not just matched pairs), returns `None` on empty post-think content so retry logic engages, and repairs invalid backslash escapes in JSON output. A plain-text fallback in the sub-query generator gracefully degrades when the model returns a numbered list instead of JSON.

PR #212 followed with infrastructure tuning for self-hosters: agent batch size dropped from 15 to 7 (preventing JSON truncation with smaller local models), the recommendation model pre-warms during setup instead of blocking Round 1, and Docker Compose gained health-check-gated Neo4j dependencies with exponential backoff for the startup race condition that tripped every fresh deployment.

PR #214 tackled interview hangs specifically — IPC poll timeouts raised for slow thinking models, stale RUNNING state detection, PID liveness checks beyond status files, and a SIGTERM grace period increase from 10 to 30 seconds. The frontend now shows a visible error box on interview failure instead of silently swallowing it.

### i18n: Non-English Simulations That Stay Non-English

A three-fix series across the week closed a persistent regression where Chinese, German, and French simulations drifted back to English output over multiple rounds. The root cause: one-time system-prompt language instructions got diluted by accumulated English environment observations.

PR #213 reinforces the language directive in every per-round user message, not just the system prompt. The report agent fix (building on Jun 20's PR #194) uses `contextvars.copy_context().run()` to propagate locale into `ThreadPoolExecutor` workers — critical for Python versions before 3.12 where context variables don't inherit across threads. Each worker also gets its own `ReasoningTraceRecorder` to prevent concurrent `finalize_section()` calls from clobbering shared state.

### 680 Lines of Dead Code, Gone

PR #205 was the week's largest single change: an 8-agent audit across 36 files that removed dead async code paths, unused API wrappers, orphaned CSS, stray `pdb.set_trace()` breakpoints, and five circular-import shims. The notification pipeline collapsed from three copy-pasted dispatch blocks into one shared helper. New leaf modules (`simulation_run_state.py`, `_notify_base.py`) clean up the dependency graph. Net result: 680 fewer lines, zero behavior change, validated by pytest (1,424 passing), ruff, and the Vite build.

## Fixes & Improvements

- **Model migration:** Default model switched from delisted mimo-v2-flash to mimo-v2.5 across all surfaces, docs, and deploy templates (PR #207)
- **Branding refresh:** New tagline "Simulate anything, for $1 & less than 10 min" replaces "Universal Swarm Intelligence Engine" (PR #206)
- **Blank model fallback:** `LLM_MODEL_NAME=""` now resolves to the default instead of sending an empty string that 400s (PR #210)
- **Semantic fan-out restored:** Sub-query fallback narrowed to a single bare query by the thinking model fix; restored the 4-way semantic exploration (PR #211)
- **DOMPurify 3.4.11:** Security patch for the HTML sanitizer (PR #202)
- **CI action bumps:** setup-node v6, docker/metadata-action v6, docker/setup-qemu-action v4 (PRs #199-201)
- **Aeon token-report:** X sentiment prefetch added; xai status split into `quiet` vs `skip` for observability (PRs #74, #75)
- **Aeon schedule:** Shifted from full autonomous operation to lean monitoring loop — 9 skills paused, cadences stretched (PR #76)

## By the Numbers

- **Commits:** ~24 substantive across 2 repos (+ ~200 automation)
- **PRs merged:** 22 (17 MiroShark + 5 miroshark-aeon)
- **Files changed:** ~140
- **Lines:** +1,968 / -1,410 (net -558 — the codebase got smaller)
- **Contributors:** @aaronjmars, Daniel Andersen (@dan-and), dependabot[bot]
- **Stars:** 1,350 (up ~28 from last week's 1,322)

## Momentum Check

This was a dense four-day burst (Jun 22-25) followed by four quiet days. The pattern is familiar: a concentrated shipping sprint, then a cooldown while the dust settles. Compared to recent weeks, the volume is similar but the character shifted — fewer new surfaces (zero new API endpoints this week, versus 2-3 per week in early June) and more hardening, DX, and cleanup. The 680-line net reduction is the first week the codebase got measurably smaller. That's a sign of maturity, not stagnation.

Daniel Andersen continues to be the only sustained external contributor, now at 12+ merged PRs. The 281 forks haven't produced a second one.

## What's Next

- The GH_GLOBAL secret remains unset — 49 consecutive feature-skill blocks, 40+ features stuck as local commits. This is the single biggest bottleneck.
- The CLI is now feature-complete for the core simulation lifecycle (`simulate`, `cost`, `wait`, `stop`, `report`). A `list` subcommand is the obvious next addition.
- The aeon schedule tuning (PR #76) paused push-recap and most content skills — this shiplog may be the last automated content piece for a while unless the schedule re-enables.
- MiroShark needs 150 more stars to hit 1,500 by July 15, requiring ~9.4/day against a current pace of ~4/day. The gap is widening.
- XAI_API_KEY still not set — token reports lack social sentiment data.

---

*Sources: [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [ToolHunter listing](https://toolhunter.cc/tools/miroshark), [HackerNoon feature](https://hackernoon.com/meet-the-agents-that-pay-for-their-own-compute-inside-aeon-miroshark-and-agentic-commerce)*
