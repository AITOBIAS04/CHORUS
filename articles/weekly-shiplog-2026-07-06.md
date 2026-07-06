# Week in Review: The Week MiroShark Got Its Papers in Order

*2026-07-06 — Weekly shipping update*

## The Big Picture

This was the week MiroShark stopped moving fast and started moving carefully. The headline numbers — 20+ CVEs patched, three governance documents shipped, a full model stack replacement, and a community contributor delivering 1,700+ French translations — tell a story of a project crossing from "build everything" into "make everything trustworthy." The one-line summary: MiroShark patched more vulnerabilities in one day than most projects patch in a year, swapped its entire AI brain, and became a French-speaking citizen of the internet — all without breaking a single test.

## What Shipped

### Model Lineup Overhaul: A New Brain in Twelve Files

On July 1, PR #223 replaced MiroShark's entire default model stack. Xiaomi's Mimo V2.5 — the workhorse behind every simulation since launch — gave way to a three-model architecture: Inception's Mercury 2 (a diffusion LLM optimized for raw speed) handles base persona and configuration, DeepSeek V4 Flash takes over the Wonderwall simulation loop (850+ LLM calls per run, the single biggest cost driver) and web search, while Google's Gemini 3 Flash stays on Smart and NER duties.

The swap touched 12 files across config, documentation in both English and Chinese, and the frontend — but zero application logic. Mercury 2 at $0.25/$0.75 per million tokens and DeepSeek V4 Flash at $0.098/$0.196 per million are both cheaper than the outgoing Mimo V2.5. For operators, existing `.env` values override everything, so running deployments are unaffected. For new users, the first simulation now runs on faster, cheaper models out of the box.

### French Internationalization: From Zero to Eighty-Seven Percent

Community contributor Zarbel974 (Abel) delivered the week's largest change by lines touched: full French language support across the entire MiroShark frontend. PR #222 (merged July 3) added `fr:` translations to ~1,627 `tr()` calls across 32 Vue components — every button, label, tooltip, and error message. A follow-up PR #239 (merged July 6) pushed coverage to 86.9%, hitting 1,723 of 1,984 translatable strings.

This wasn't just a translation dump. The PR introduced `scripts/scan_i18n.py`, a CI scanner that catches five bug classes — copy-paste errors, length anomalies, encoding issues — with three blocking categories that gate every future PR. It also fixed a real production bug: 320 `ReferenceError` crashes caused by using Vue's template-only `\` alias in `<script setup>` scope, where only `tr()` works. That bug affected all users, not just French speakers, and would have crashed 24 components including the language switcher itself.

MiroShark now speaks four languages: English, Chinese, German, and French. The dictionary-only architecture — add translations to existing `tr()` calls without touching component logic — means the fifth language needs zero code changes, just a dictionary file.

### Twenty CVEs Patched in a Day

July 3 was security day. Three coordinated commits swept through the entire dependency tree, clearing every active Dependabot alert in one pass.

The safe tier (PR #229) bumped 14 packages — werkzeug patching two CVEs, Pillow patching five, form-data fixing a CRLF injection vector. The risky tier (PR #230) tackled four major-version transitive dependencies behind camel-ai's MCP toolkit: starlette jumped from 0.50 to 1.3.1 (four CVEs), cryptography from 46 to 49 (four CVEs), PyJWT from 2.10 to 2.13 (six CVEs), and python-multipart cleared seven CVEs. These are all indirect dependencies — MiroShark uses Flask, not Starlette; static key auth, not JWT — but they still appeared in the dependency tree and still needed patching. The third commit (PR #231) bumped pytest from 8 to 9, fixing CVE-2025-71176.

All 1,423 tests passed after the sweep. The repo went from dozens of active security alerts to zero in a single afternoon.

### Community Governance Stack

Alongside the security work, three commits professionalized MiroShark's community-facing surface. SECURITY.md (PR #235) establishes a vulnerability disclosure policy with private reporting via GitHub's built-in PVR, response time targets, and a per-repo threat model. CONTRIBUTING.md ships in both English and Chinese with real dev setup instructions, test commands, and a new-endpoint checklist. FUNDING.yml (PR #237) wires up the GitHub Sponsor button, linking to miroshark.xyz, the bankr terminal, DexScreener, and BaseScan.

For a 1,357-star project chasing 1,500, these are table stakes. They signal that contributions are welcome, vulnerabilities will be handled responsibly, and the project has a real governance surface — not just a README.

## Fixes & Improvements

- **Docker data persistence:** Nemotron demographic datasets (hundreds of MB per country) now survive container recreation via bind-mount (PR #238)
- **Cross-provider LLM compatibility:** Daniel Andersen's 9th merged PR (#232) extracts message filtering into a standalone utility that satisfies both Gemini (rejects empty messages) and Azure (requires tool_calls to precede tool results)
- **Vite 8.1.3:** Frontend build tool patch update (PR #225)
- **CI and dependency bumps:** actions/checkout v6→v7, docker/login-action v4, docker/setup-buildx-action v4, frontend deps (axios, vue, vite) via Dependabot
- **miroshark-aeon fleet overhaul:** Skill catalog synced to canonical aeon source — 9 skills added, 8 pruned, TypeScript 5.9→6.0, @types/node v22→v26, 13 npm packages updated (React 19.2.7, Next 16.2.10, Tailwind 4.3, Wrangler 4.107)
- **Shiplog redesign:** Rewired from fixed 7-day window to cadence-agnostic "since last run" state machine with products.md config, X prefetch integration, and ecosystem scout scanning
- **Aeon self-improve:** Cron-state counter hygiene (PR #25) — auto-detects and resets success rates poisoned by historical outages

## By the Numbers

- **Commits:** ~38 substantive across 2 repos (+ ~130 automation filtered)
- **PRs merged:** 13 (MiroShark)
- **Files changed:** ~140+
- **Lines:** ~+6,000 / -4,750
- **Contributors:** @aaronjmars, Zarbel974 (Abel), Daniel Andersen (@dan-and), dependabot[bot]
- **Stars:** 1,357 (up 7 from last week's 1,350)
- **Forks:** 286 (up 5 from 281)

## Momentum Check

Last week was about velocity — 22 PRs, three new CLI commands, the codebase shrinking by 680 lines. This week was about maturity. Fewer PRs (13 vs 22) but heavier ones: the French i18n PR alone touched 3,300+ lines, and the security sweep cleared a backlog that had been accumulating for months.

The contributor picture is brightening. Zarbel974's French PRs represent the first sustained community language contribution, and Daniel Andersen hit his 9th merged PR. Two active external contributors is still a thin bench for 286 forks, but the new CONTRIBUTING.md and CI scanner lower the barrier for number three.

Star growth slowed to +7 this week (vs +28 last week). The 1,500-star target by July 15 now needs ~143 stars in 9 days (~16/day) against a pace of 1/day. That gap isn't closing organically — it would take a viral moment or a HN front page to bridge it.

The token ($MIROSHARK) had a volatile week: a -20% plunge on July 1 to its lowest price since launch ($0.00000296), followed by a +17% surge on July 4, then a steady bleed back to $0.0000034. LP sits at $270K, down from $280K a week ago and well below the June peak of $407K. Price action and development are moving independently.

## What's Next

- **GH_GLOBAL still unset** — the single biggest bottleneck. 50+ consecutive feature-skill blocks, 40+ features sitting as local commits since June 3.
- **Fifth language?** The dictionary-only pattern is proven. The new CONTRIBUTING.md and i18n scanner lower the barrier. The hyperstition (5 languages by September 1) is at 4/5 but needs a new contributor.
- **Open PRs:** Zero on MiroShark — a clean slate for the first time in weeks.
- **miroshark-aeon infrastructure** is wired for email delivery (Resend) and private-repo monitoring (GH_READ_PAT) — both awaiting secrets to activate.
- **Model slots** mentioned in PR #223 (`FAST_SMART`, `TRANSLATION`) suggest further model specialization is planned but not yet wired.

---

*Sources: [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [TrendShift stats](https://trendshift.io/repositories/24822), [ToolHunter listing](https://toolhunter.cc/tools/miroshark)*
