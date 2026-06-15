*Push Recap — 2026-06-15*
MiroShark — 4 commits | miroshark-aeon — 1 commit | 3 authors

Code Quality Paydown: Two back-to-back PRs (#163, #164) ran an 8-pass cleanup across 47 files and then consolidated 12 duplicate helper functions into 3 shared utility modules (timeutils, belief, base_url). Bare except blocks narrowed to specific types, dead imports purged, AI-generated comment noise removed. Net: the codebase has one place to fix timestamps, one place to compute belief averages, and one place to resolve public URLs — not 7-11 copies each.

Community Infra — Same-Origin API: Daniel Andersen's PR #159 landed, replacing the hardcoded localhost:5001 API base with same-origin /api. MiroShark now works behind LAN hostnames and reverse proxies out of the box. Neo4j bumped 5.15→5.26 for indexing reliability. First community code contribution from dan-and.

Test & CI Hardening: Demographic-grounding tests no longer crash without LLM_API_KEY (mocked the eager client constructor). miroshark-aeon's sync-upstream workflow fixed — was failing every run because GITHUB_TOKEN can't create PRs and the unrelated-history merge pushed dead branches.

Key changes:
- 3 new shared utils (timeutils.py, belief.py, base_url.py) replace 12 copy-pasted helpers across 19 service files
- Vite config rewrite: dynamic env loading, Traefik DNS auto-parsing, configurable proxy target
- 1,372 tests passing in any env (no API key required)

Stats: 77 files changed, +1,580/-571 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-15.md
