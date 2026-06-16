*Push Recap — 2026-06-16*
MiroShark — 10 commits by 3 authors | miroshark-aeon — 3 commits (~20 cron noise filtered)

Self-Hosted Search & Scraping (PR #178): Community contributor dan-and landed SearXNG + Firecrawl integration. Any model — including local Ollama — can now ground persona research with live web results. SearXNG searches, the default LLM synthesizes. Firecrawl scrapes JS-heavy pages for URL imports. Both opt-in, both fallback-safe. Settings UI has a "Test search" button. New docker-compose.ollama.yml for one-command local deployment.

40th Surface — Per-Sim Cost Breakdown (PR #179): GET /api/simulation/<id>/cost.json makes the "$1 to simulate anything" claim queryable. Headline estimated_cost_usd + token/latency totals + per-model and per-phase breakdowns. Honest by construction: is_estimate=true, untracked models price at $0 (lower bound). Refactored run_summary.py to share event reading between the markdown report and the JSON surface.

CI/CD & Dependency Management: Dependabot configured from scratch (#166) — covers all 5 ecosystems (pip, npm ×2, Actions, Docker). First sweep landed same day: 6 version-bump PRs (#169–174). New frontend build gate (#180) catches broken UIs at PR time.

Key changes:
- SearXNG client + Firecrawl scraper + 3 new test files (+1,167/-55 across 19 files)
- cost_service.py + run_summary refactor + 191-line test file (+699/-25 across 9 files)
- repo-pulse now profiles every stargazer/forker with bio/location — hides <10 follower noise
- Feature skill corrected: pytest is sandbox-blocked regardless of clone path

Stats: 47 files changed, +2,254/-235 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-16.md
