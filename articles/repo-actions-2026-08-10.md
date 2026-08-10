# Repo Action Ideas — 2026-08-10

**Repo:** [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)
**Snapshot:** 1,429 stars · 298 forks · 1 open issue (#240 air-gapped HF — Jul 6, 35 days stale) · 0 open PRs
**Recent changes:** Frontend minor-patch group bumped (4 updates, #283); mcp dependency updated (#284); pywebpush 2.4.0 (#285); "Remove good first issues link from README" (bd0ffb5, Aug 8)

---

## Context

Day 34 of social silence. Token at $0.000002706 (+7.13% 24h) — a V-shaped bounce off the $0.00000251 consolidation floor. One wallet (0x73d31c03) bought 293.6M tokens ($804) at 03:35 UTC, the largest single trade since the Aug 2–3 rally. Today's partial-day volume is already $5,537 — 3.7× all of yesterday's $1,488, breaking the 8-session post-rally volume collapse. LP rose to $259K from $248K. Buy/sell count even (14/14) but seller wallet count exceeds buyer count (14 vs 10): pressure balanced but position closing continues.

The tutorial hyperstition (Aug 15, **5 days**, 0/5) is the single most time-compressed active target. Tutorial Seed Kit (#1, Aug 8) and Demo Simulation Library (#1, Aug 6) address the creation side — but neither solves the "structured output I can paste into my post" problem that data-oriented tutorial writers face. The language hyperstition (Sep 1, **22 days**, 4/5) has Korean proposed (Aug 8) and Dutch (Aug 6) — both unbuilt due to GH_GLOBAL block — but Portuguese is a completely fresh locale that lands a different market (Brazil's 1.3M+ GitHub users). The 3-community-PRs-by-Sep-15 hyperstition is at 1/3 with 36 days left; 298 forks are dormant at 1.7% contribution rate (CMU STRUDEL research baseline: 14%); the bottleneck isn't motivation, it's "what do I build?"

GH_GLOBAL remains unset (72nd consecutive block). Ideas below build as local commits and ship when access restores.

Off-limits from the past 7 days (Aug 4, 6, 8): Tutorial Seed Kit, MiroFish Comparison Page, Korean (KO) Locale, Social Preview Card SVG, Simulation Short URL Service, Demo Simulation Library, CLI Shell Completion Scripts, Dutch (NL) Locale, X/Twitter Content Kit, Operator Metrics Endpoint, GraphML/GEXF Agent Mention Export, CITATION.cff + docs/CITING.md, Per-Round Webhook Events, Ecosystem Project Health API, Feature Spec Issue Publisher.

---

### 1. Portuguese (PT-BR) UI Locale

**Type:** Community
**Effort:** Small (hours)
**Impact:** The "5 languages by September 1" hyperstition is at **4/5** with 22 days remaining. Korean (off-limits, Aug 8) and Dutch (off-limits, Aug 6) are both proposed but unbuilt; Portuguese targets an entirely different market. Brazil has 1.3M+ GitHub users — the fourth-largest developer community globally (GitHub Octoverse 2025), with active AI research centers at USP, UNICAMP, UFMG, and FGV EAESP (which runs the most-cited Latin American computational social science program). Portugal's Instituto Superior Técnico and Universidade do Porto both have NLP and multi-agent systems labs. The combined PT-BR + PT-PT audience spans ~250M native speakers, a larger addressable pool than Korean (80M) or Dutch (25M). Brazil passed the "Marco Legal de IA" framework in 2025 — AI policy simulation in Portuguese-language documentation directly serves that regulatory compliance market. Portuguese has zero encoding edge cases: standard Latin alphabet, BMP-only, no combining sequences beyond cedilla and tilde (both in standard NFC form). The dictionary-only locale pattern is proven at 3 languages (ZH-CN, JA, FR). One PR moves the hyperstition from 4/5 to **5/5** and clears it 22 days early.

**How:**
1. Create `frontend/src/locales/pt.js` (~1,984 entries). Use `locales/en.js` as the authoritative key source. Register: formal `você` throughout for all instructional UI text (button labels, tooltips, error messages, form placeholders, onboarding steps) and `vocês` for plural second person — this is standard Brazilian enterprise software convention (Nubank, iFood, Mercado Livre all use `você` in their UIs). Avoid European `tu`/`vós` which would alienate the larger BR user base. Key term decisions: `simulation` → `simulação`, `agent` → `agente`, `round` → `rodada` (preferred over `round` loanword — natural in Brazilian tech), `consensus` → `consenso`, `bullish` → `altista` (Brazilian finance term; preferred over English loanword; `alta` as the noun), `bearish` → `baixista` (standard Brazilian finance), `confidence` → `confiança` (general; `taxa de confiança` for "confidence percentage"), `platform` → `plataforma`, `stance` → `posição` (position; `posicionamento` for the act of taking a stance), `publish` → `publicar`, `topic` → `tópico`, `influence` → `influência`, `belief` → `opinião` (opinion; natural in social simulation; not `crença` which implies strong conviction), `wallet` → `carteira` (native Portuguese word; preferred over `wallet` loanword). Technical loanwords kept in English: `webhook`, `embed`, `endpoint`, `fork`, `API`, `token`, `DEX`, `CLI` — these are standard in Brazilian tech writing. File structure mirrors `locales/fr.js` exactly. Header comment: locale (pt-BR, formal `você` register), key term decisions, creation date 2026-08-10.

2. Update `frontend/src/i18n.js`: add `import ptDict from './locales/pt.js'`; add `'pt'` to the supported locales array; add `const isPt = computed(() => locale.value === 'pt')`; add `ptDict` to the `t()` fallback chain; update `toggleLocale()` cycle to include `'pt'`; add `'pt': 'PT'` to the locale label map. Update `LocaleToggle.vue`: add `'pt'` to the cycle array with label `'PT'`. Create `README.pt.md` (~120 lines) with hook (`Simule a reação da opinião pública sobre qualquer cenário em menos de 10 minutos por menos de $1`), quickstart CLI block in Portuguese context, use cases (teste de comunicação de crise, previsão de reação de mercado, simulação de conformidade com o Marco Legal de IA, análise de sentimento de lançamento de produto), and a Brazil-specific hook: "Simulações de cenários de conformidade com o Marco Legal de IA por menos de $1 — análise de opinião pública em escala." Update the language switcher row in the main `README.md` to add `· <a href="README.pt.md">Português</a>`.

3. Add 4 unit tests: `t('simulate', 'pt')` returns the correct Portuguese string, PT cycles correctly in `toggleLocale()`, all keys present in `locales/pt.js`, no key in `locales/en.js` missing from `locales/pt.js`. PR format: `feat(i18n): add Portuguese (pt-BR) locale`. PR body: key count (1,984 entries), formal `você` register decision, Marco Legal de IA hook in `README.pt.md`, and tracking note: **this PR clears the 5-language hyperstition (5/5)** — EN · ZH-CN · JA · FR · PT — with 22 days to spare before the Sep 1 deadline. Include a rationale note for why PT was chosen over remaining unbuilt locales (largest addressable market, Brazil's AI legislation hook, no encoding complexity).

---

### 2. Fork Activation Guide

**Type:** Community
**Effort:** Small (hours)
**Impact:** 298 forks with a 1.7% contribution rate (5 community PRs from 298 forks). CMU STRUDEL research (arXiv 2502.11067) finds the industry baseline for "active contributing forks" is ~14% — MiroShark is at 12% of that baseline. The 3-community-PRs-by-Sep-15 hyperstition is at 1/3 with 36 days left; the 10-PRs-by-Aug-1 hyperstition expired at 5/10. The bottleneck is not motivation or discovery (1,429 stars says people see the project) — it's the blank-page problem for contributors: "I forked it, now what do I build?" The repo has 40+ agent-designed feature specifications in repo-actions articles, a rich API surface (41+ endpoints), and locale files as a proven low-barrier entry point — but none of this is surfaced for contributors who land on the repo without reading the articles. A `docs/FORK_GUIDE.md` answers "what do I build with my fork?" with 5 concrete project ideas at three difficulty tiers, an extension-point map of the most hackable code paths, and a step-by-step PR submission template. This converts passive fork holders into contributors at exactly the moment when the Sep 15 hyperstition deadline provides urgency.

**How:**
1. Create `docs/FORK_GUIDE.md` (~200 lines). Structure:
   - **Why fork MiroShark?** (3 bullets): "You want to self-host opinion simulation with full data control," "You want to extend the simulation engine for your research domain," "You want to contribute features that go live in the main repo." These frame the guide's three audiences.
   - **Project ideas by difficulty tier** (~100 lines):
     - *Quick wins (hours):* Add a new UI locale (follow the `locales/en.js` → `locales/xx.js` pattern — Korean, Portuguese, Arabic, or any untranslated language; see `frontend/src/locales/`). Update the `ECOSYSTEM.md` if you built something that uses MiroShark. Add a `docs/TUTORIAL_SEED_KIT.md` outline for a tutorial platform or use case not yet covered.
     - *Medium builds (1–3 days):* Build a new export format for `GET /api/simulation/{id}/export` — CSV, Parquet, LaTeX table, or DOCX. Add a new frontend visualization overlay (example: `StanceFlipsPanel.vue` and `MentionsPanel.vue` show the pattern). Implement a new API surface (any of the 40+ feature specifications in `articles/repo-actions-*.md` in the CHORUS repo — [link to CHORUS]). Add `README.xx.md` + locale file for a language not yet in the switcher.
     - *Larger builds (3–5 days):* A domain-specific simulation pack (AI safety scenarios, financial events, political campaigns) — 10 pre-run published simulations + a docs page. A `miro verify` CLI command that verifies a `reproduce.json` against the original signal. A plugin system for custom agent personas (`agents.json` extension hooks).
   - **Extension point map** (~40 lines): 6 key files/directories for contributors, each with 1-sentence explanation of what it does and how to modify it: `frontend/src/locales/` (add translations), `backend/app/api/` (add new endpoints), `backend/app/data/surfaces_catalog.py` (register new surfaces), `frontend/src/components/` (add new UI panels), `docs/ECOSYSTEM.md` (add ecosystem projects), `agents.json` (add new agent archetypes). For each: "Find this at: `<path>`" + "Safe to modify: yes/no without touching core simulation".
   - **PR submission checklist** (~20 lines): 8-item checklist a contributor verifies before opening a PR: tests added for new code, no new dependencies without justification, locale files contain all keys from `locales/en.js`, new endpoints registered in `surfaces_catalog.py`, FEATURES.md updated if new user-visible feature, PR title follows `feat/fix/chore/docs(scope): description` format, no secrets or API keys in committed files, PR body describes the "why" not just the "what".
   - **How to get a PR merged fast** (~15 lines): "Small is faster — one focused change beats a multi-feature branch." "Reference an existing repo-actions article if your idea came from there — it shows alignment with the project direction." "Add tests that would catch a regression if the feature were removed." "Ping @aaronjmars in the PR body for a review within 48h."

2. Update `CONTRIBUTING.md`: add a "What to build" section near the top (before the detailed setup instructions) that links directly to `docs/FORK_GUIDE.md` with one paragraph: "Not sure what to work on? The [Fork Activation Guide](docs/FORK_GUIDE.md) has 10+ concrete project ideas at three difficulty levels, an extension-point map, and a PR checklist. Start there." Remove the "good first issues" link (already removed from README per bd0ffb5) and replace it with: "Browse the [Fork Activation Guide](docs/FORK_GUIDE.md) for self-directed contribution ideas." This ensures the guide is discoverable from the primary contributor entrypoint.

3. Link `docs/FORK_GUIDE.md` from `README.md` in the documentation pill buttons section ("Fork Guide — 10+ contribution ideas") and add a "Contributing" tile to the README community section if one exists. Add a GitHub issue template `.github/ISSUE_TEMPLATE/contribution_idea.yml` (~25 lines) with fields: title, which tier (Quick win / Medium build / Larger build), description of what you plan to build, relevant API surfaces or files, estimated time. This creates a structured intake channel for contributors who want feedback before building — reducing wasted effort and increasing PR success rate.

---

### 3. CSV + Markdown Simulation Export

**Type:** Feature
**Effort:** Small (hours)
**Impact:** The tutorial hyperstition (Aug 15, **5 days**, 0/5) has a structural problem: the most data-oriented tutorial format for MiroShark — "I ran an opinion simulation and here's what the numbers show" — requires exporting structured output. The existing `signal.json` is JSON (readable by developers) and the share page is visual (shareable but not quotable). Tutorial writers who want to paste a table into their Dev.to post, embed agent results in their academic blog, or copy-paste a Markdown table into their LinkedIn post have no path to do this. `GET /api/simulation/{id}/export?format=csv` returns all agent rounds as a flat CSV (agent name, round, stance, confidence, platform — one row per agent per round). `GET /api/simulation/{id}/export?format=markdown` returns a Markdown table of the final aggregate results — direction, confidence, per-platform breakdown — ready to paste into any Markdown-supporting platform. Both formats are directly usable in tutorial creation without any further processing. This is also the correct primitive for the Academic Citation Helper pattern (off-limits but distinct: that helps researchers cite the repo; this helps researchers include the data) and for the TypeScript SDK (off-limits: that wraps the API; this is the API endpoint itself). The GraphML/GEXF export (off-limits, Aug 4) exports agent mention network graphs — this exports general simulation results, a distinct scope.

**How:**
1. Create `backend/app/api/export.py` (~130 LoC, pure stdlib). `GET /api/simulation/{id}/export?format=csv|markdown|json-table`. Publish-gated (unpublished simulations return 404 `{"error": "Simulation not published"}`). Invalid format returns 400 `{"error": "Unsupported format", "supported": ["csv", "markdown", "json-table"]}`. **CSV logic** (~40 LoC): reads `trajectory.json` for per-round agent data. For each round, for each agent: row = `[round_number, agent_name, platform, stance (bullish/bearish/neutral), confidence_pct, initial_stance, flip_count_cumulative]`. Generates CSV with `csv.writer` (stdlib). Header row: `round,agent,platform,stance,confidence_pct,initial_stance,total_flips`. Response: `Content-Type: text/csv`, `Content-Disposition: attachment; filename="miroshark-{id[:8]}-{topic_slug}.csv"`. `Cache-Control: public, max-age=3600`. **Markdown logic** (~40 LoC): reads `signal.json` for aggregate results. Generates a 3-section Markdown document: (1) summary table (Direction, Confidence, Rounds, Agents, Topic — a single-row table with those 5 fields), (2) per-platform results table (Platform | Direction | Confidence — one row per platform from `platform_sentiment.json` if available, else blank), (3) top-3 agent flips table from `stance_flips.json` if available. Response: `Content-Type: text/markdown; charset=utf-8`, `Content-Disposition: attachment; filename="miroshark-{id[:8]}-{topic_slug}.md"`. **json-table format** (~15 LoC): same data as CSV but as a JSON array of objects (one per row) — useful for JavaScript consumers. Register the route in the main app router as `GET /api/simulation/<id>/export`. Add to `surfaces_catalog.py` (type: export; next available surface number).

2. Add export buttons to the simulation share page (`Step3Simulation.vue` or the share template). Three buttons in a row: "Export CSV", "Export Markdown", "Export JSON". Each button links to `GET /api/simulation/{id}/export?format=csv|markdown|json-table` with `download` attribute on the link element so the browser triggers a file download rather than navigation. Add a short label below the button row: "Use the CSV for spreadsheet analysis · the Markdown table for blog posts and reports · the JSON for programmatic processing." Update `docs/API.md` with a "Export Formats" section: route, query parameter, response format, example content for each format, and a "Tutorial writers" note: "Paste the Markdown table directly into your Dev.to, HN, or GitHub post — it renders as a formatted results table without any additional processing." Add `GET /api/simulation/{id}/export` to the embed page alongside the existing `reproduce.json` and `signal.json` links.

3. Add 6 unit tests: `?format=csv` returns 200 with `Content-Type: text/csv` and a valid CSV string with header row, `?format=markdown` returns 200 with content containing a Markdown table header (`| Direction |`), `?format=json-table` returns 200 with a JSON array where every item has `round` and `agent` keys, `?format=invalid` returns 400 with the supported formats list, unpublished simulation returns 404 for all formats, simulation with no `trajectory.json` returns 200 with a CSV containing only the header row (graceful empty). Add a mention in `docs/TUTORIAL_SEED_KIT.md` (once built): "Export the simulation data table via `GET /api/simulation/{id}/export?format=markdown` and paste it directly into your post — no screenshots needed." PR body should note: "Closes the data-export gap for tutorial writers — CSV for spreadsheets, Markdown for direct paste into blog posts."

---

### 4. GitHub Actions Integration Example

**Type:** DX improvement / Content
**Effort:** Small (hours)
**Impact:** The 298 fork holders are developers — nearly all of them use GitHub Actions. MiroShark has a `miro` CLI, a REST API, and a Docker-friendly self-hosted model. The missing piece is a reference workflow file that shows developers how to integrate MiroShark into their CI/CD pipeline. Use cases that map directly to the 298 fork holders' work: run an opinion simulation before a product launch to see how your announcement will be received, run a policy compliance simulation in a PR check when documentation changes, run a crisis communication simulation before publishing a press release, run a competitor sentiment simulation before a pricing change. A `examples/github-actions-simulate.yml` + `docs/CI_INTEGRATION.md` positions MiroShark as a CI/CD opinion simulation layer — a distinct value proposition from "AI agent tool you run manually." It's also the most compelling technical tutorial topic for the Aug 15 deadline: "I added public opinion simulation to my GitHub Actions deployment pipeline" is a Strong Show HN opener and a developer-audience-specific Dev.to post. This is distinct from the Demo Simulation Library (off-limits, Aug 6) which provides pre-run simulations; this shows how to run simulations programmatically in automated pipelines.

**How:**
1. Create `examples/github-actions-simulate.yml` (~80 lines). A fully functional workflow that:
   ```yaml
   name: Pre-Launch Opinion Check
   on:
     push:
       branches: [main]
     workflow_dispatch:
       inputs:
         topic:
           description: 'Topic to simulate public opinion on'
           required: true
           default: 'our product launch'
   jobs:
     opinion-check:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - name: Install miro CLI
           run: pip install miroshark
         - name: Run opinion simulation
           id: simulate
           env:
             MIROSHARK_API_KEY: ${{ secrets.MIROSHARK_API_KEY }}
             MIROSHARK_HOST: ${{ vars.MIROSHARK_HOST || 'https://miroshark.xyz' }}
           run: |
             TOPIC="${{ github.event.inputs.topic || 'our product launch' }}"
             RESULT=$(miro simulate --topic "$TOPIC" --agents 50 --rounds 5 --output json --quiet)
             echo "direction=$(echo $RESULT | jq -r '.direction')" >> $GITHUB_OUTPUT
             echo "confidence=$(echo $RESULT | jq -r '.confidence_pct')" >> $GITHUB_OUTPUT
             echo "share_url=$(echo $RESULT | jq -r '.share_url')" >> $GITHUB_OUTPUT
         - name: Comment simulation result on PR
           if: github.event_name == 'pull_request'
           uses: actions/github-script@v7
           with:
             script: |
               github.rest.issues.createComment({
                 issue_number: context.issue.number,
                 owner: context.repo.owner,
                 repo: context.repo.repo,
                 body: `## 🦈 Opinion Simulation Result\n**Direction:** ${{ steps.simulate.outputs.direction }}\n**Confidence:** ${{ steps.simulate.outputs.confidence }}%\n[View full simulation](${{ steps.simulate.outputs.share_url }})`
               })
         - name: Fail if consensus is bearish with high confidence
           if: steps.simulate.outputs.direction == 'bearish' && steps.simulate.outputs.confidence >= 80
           run: |
             echo "High-confidence bearish signal (${{ steps.simulate.outputs.confidence }}%) — review messaging before merging."
             exit 1
   ```
   Include a second variant in the same file (commented, ~15 lines): a weekly scheduled simulation that monitors long-term opinion drift on a configured topic and posts the result as a GitHub Discussion comment.

2. Create `docs/CI_INTEGRATION.md` (~100 lines). Sections:
   - **Why run opinion simulation in CI?** — 3 use cases: "Catch messaging misalignment before a public launch," "Monitor community sentiment weekly," "Gate on strong bearish signals before major releases."
   - **Prerequisites** — `pip install miroshark` (or `docker pull aaronjmars/miroshark`), `MIROSHARK_API_KEY` secret (for hosted), or `MIROSHARK_HOST` var (for self-hosted at `http://localhost:8000`).
   - **Quick start** — copy the example file from `examples/github-actions-simulate.yml`, add the secret, push.
   - **Configuration reference** — `miro simulate` flags (topic, agents, rounds, output format), GitHub Actions variable/secret names, the 3 output variables (`direction`, `confidence`, `share_url`).
   - **Self-hosted variant** — run `docker compose up -d` as a prior step and set `MIROSHARK_HOST=http://localhost:8000`. Full `docker-compose.yml` snippet. Note: self-hosted requires no API key.
   - **Examples**: PR comment bot, weekly scheduled digest, bearish-signal gate.
   - **Cost note**: each workflow run at 50 agents × 5 rounds costs approximately $0.05–$0.15 (note this is a rough estimate; actual cost depends on LLM pricing at run time).
   Link `docs/CI_INTEGRATION.md` from `README.md` ("GitHub Actions — run simulations in CI/CD pipelines") and from `docs/DEMO_SIMULATIONS.md` (once built). Add `examples/` to `.gitignore` exclusion list (currently it's a created directory, not a tracked one — verify before PR).

3. Log to memory: "CI/CD integration example created 2026-08-10: `examples/github-actions-simulate.yml` + `docs/CI_INTEGRATION.md`. Enables 3 patterns: PR comment bot, weekly digest, bearish-signal gate. Requires `MIROSHARK_API_KEY` (hosted) or `MIROSHARK_HOST` var (self-hosted). This is distinct from the `miro` CLI quickstart — it's a persistent automated pipeline pattern." No unit tests (documentation + workflow example — workflow correctness is validated by GitHub Actions on PR). Add the CI integration to `README.md` use cases: "Run opinion simulation as a CI check before any public-facing launch — `examples/github-actions-simulate.yml` is a drop-in template."

---

### 5. Simulation Quality Score Endpoint

**Type:** Feature
**Effort:** Small (hours)
**Impact:** The 40+ published simulations in the Demo Simulation Library (proposed, Aug 6) and the Tutorial Seed Kit (proposed, Aug 8) both depend on identifying high-quality simulations worth showcasing. "High quality" currently has no formal definition — tutorial writers pick simulations by browsing share pages manually, and ecosystem integrators have no signal for filtering. A `GET /api/simulation/{id}/quality` endpoint that returns a scored quality assessment solves three distinct problems: (1) the Demo Library needs an automated way to rank which simulations belong in the curated 10-entry table, (2) tutorial writers need a fast "is this simulation compelling enough to write about?" signal, (3) ecosystem integrations (AntFleet bench, Capacitr) need to filter high-signal simulations from low-signal ones before surfacing to their users. The scoring model is deterministic and pure-Python (no ML, no external API): four dimensions scored 0–100, averaged to a final grade. The "reproducibility" dimension directly rewards simulations that have `reproduce.json` + signed results — which incentivizes all operators to run with provenance enabled, compounding the network effect of MiroShark's unique provenance layer.

**How:**
1. Create `backend/app/api/quality.py` (~100 LoC, pure stdlib). `GET /api/simulation/{id}/quality`. Publish-gated (unpublished simulations return 404). Computation: reads `signal.json` and checks for the presence of `trajectory.json`, `reproduce.json`, `platform_sentiment.json`, and `stance_flips.json`. Four scoring dimensions:
   - **Completion** (0 or 100): did all rounds complete? Check `signal.json`'s `rounds_completed` vs `rounds_requested` (or derive from `trajectory.json` round count). 100 if complete; 0 if partial.
   - **Consensus strength** (0–100): maps `confidence_pct` from `signal.json` directly. A 90% confidence simulation scores 90 on this dimension.
   - **Diversity** (0–100): `min(100, platform_count × 15 + agent_count × 0.5)` — rewards simulations that used multiple platforms and more agents. A 4-platform, 100-agent simulation: `min(100, 60 + 50) = 100`. A 1-platform, 20-agent simulation: `min(100, 15 + 10) = 25`. Capped at 100.
   - **Reproducibility** (0, 50, or 100): 0 if no `reproduce.json`; 50 if `reproduce.json` present; 100 if `reproduce.json` present AND `signal.json` contains a `signed_result` field (HMAC signature from the Signed Result JSON skill). This directly rewards provenance-enabled simulations.
   - **Final score**: `(completion × 0.25 + consensus × 0.30 + diversity × 0.20 + reproducibility × 0.25)` — weighted average. Map to letter grade: A (85–100), B (70–84), C (55–69), D (40–54), F (<40).
   Response: `{"score": 87, "grade": "A", "factors": {"completion": 100, "consensus": 85, "diversity": 80, "reproducibility": 100}, "simulation_id": "{id}", "published": true}`. `Cache-Control: public, max-age=1800` (30-minute cache; quality factors are stable for published simulations). Add to `surfaces_catalog.py` (type: metadata).

2. Integrate the quality score into the share page (`Step3Simulation.vue` or share template): below the direction/confidence display, add a small quality badge. Format: `Quality: A (87/100)` with tooltip on hover explaining the four factors. Color: A/B = green, C = yellow, D/F = red. The badge is informational — it tells the viewer "this is a high-confidence, multi-platform, provenance-enabled simulation" without requiring them to understand the internals. Add a `GET /api/simulation/{id}` or `list` endpoint integration: add a `quality_score` field to any endpoint that already returns simulation summaries (if the search service or activity feed return simulation metadata, add `quality_score` as an optional field populated by a call to the quality service). Add to `docs/API.md` under a new "Quality & Curation" section: endpoint reference, field descriptions, scoring formula, grade thresholds. Note: "Use `?quality_min=B` filter on search endpoint to surface high-quality simulations only" — plan this as the follow-up PR once search has a filter mechanism.

3. Add 6 unit tests: simulation with all 4 files present and 95% confidence scores ≥85 (grade A), simulation with no `reproduce.json` and 60% confidence scores ≤75 (grade B or C), simulation with partial rounds (completion=0) scores ≤75, `{"grade": "A"}` is in response when score ≥ 85, unpublished simulation returns 404, response JSON contains all required top-level keys (`score`, `grade`, `factors`, `simulation_id`, `published`). Log to memory: "Quality Score endpoint created 2026-08-10. Four dimensions: completion (25%), consensus_strength (30%), diversity (20%), reproducibility (25%). Grade thresholds: A≥85, B≥70, C≥55, D≥40, F<40. Use for Demo Library curation and tutorial showcase selection." Add a note in the Demo Library spec (when built): "Use `GET /api/simulation/{id}/quality` to verify each entry scores ≥ B before including in the curated table."

---

## Selection Rationale

Five ideas targeting the five most active constraints on today's board, in priority order.

- **Portuguese (PT-BR) Locale (#1)** — Language hyperstition (Sep 1, 22 days, 4/5). With Korean and Dutch both proposed but unbuilt (GH_GLOBAL block), Portuguese targets the largest untouched market: Brazil's 1.3M+ GitHub developer base + the Marco Legal de IA regulatory hook. One PR clears the hyperstition entirely — 22 days early — and opens a market with no existing MiroShark presence. Highest-return locale per effort hour.

- **Fork Activation Guide (#2)** — Community PRs hyperstition (Sep 15, 36 days, 1/3). 298 forks at 1.7% contribution rate (industry baseline: 14%). The bottleneck is not motivation — it's the blank page. A `docs/FORK_GUIDE.md` with 10+ concrete project ideas at three difficulty tiers, an extension-point map, and a PR checklist converts dormant fork holders into contributors. Directly targets the 3-PRs-by-Sep-15 metric with 36 days remaining.

- **CSV + Markdown Export (#3)** — Tutorial hyperstition (Aug 15, **5 days**, 0/5). The most urgent deadline on the board. Tutorial writers need structured output they can paste — the existing share page is visual-only, signal.json is developer-only. A CSV + Markdown export adds zero dependencies, serves three tutorial formats (tabular data post, academic paper, LinkedIn report), and is directly referenced in the Tutorial Seed Kit's "use a pre-run simulation without running your own" pattern.

- **GitHub Actions Integration Example (#4)** — Developer activation + tutorial content (Aug 15 deadline and beyond). The 298 fork holders are developers; most run GitHub Actions. A drop-in `examples/github-actions-simulate.yml` makes MiroShark a native CI/CD opinion simulation layer — a distinct value prop that generates a naturally compelling tutorial topic: "I added public opinion simulation to my deployment pipeline." This tutorial angle lands with the Dev.to and HN developer audiences the Aug 8 Tutorial Seed Kit targeted.

- **Simulation Quality Score (#5)** — Feature enabling curation and incentive alignment. The Demo Library, Tutorial Seed Kit, and every future showcase surface need a programmatic way to identify "compelling" simulations. The quality score is a 4-dimension deterministic formula (completion, consensus, diversity, reproducibility) with a letter grade output. It incentivizes operators to run simulations with provenance enabled (boosting reproducibility score) and gives tutorial writers a single number that answers "is this simulation worth writing about?"
