*Push Recap — 2026-08-31*
miroshark-aeon — 3 substantive commits by Aaron Elijah Mars
MiroShark — 2 substantive commits by dependabot
(46 automation commits filtered)

GLM Gateway Integration: Claude subscription exhausted. The founder ported a GLM gateway from canonical PRs, pinned it as the primary provider, and added tiered model mapping. The agent now routes through Z.AI's Anthropic-compatible API instead of Anthropic directly. Per-tier vars (GLM_MODEL_OPUS/SONNET/HAIKU) let different skill tiers use appropriately-sized models.

Dependency Maintenance: Two routine Dependabot merges — MCP SDK patch in the backend, and a 4-package frontend batch (axios, marked, vue, vue-router). vue-router 5.3.0 dropped 3 deps, trimming the tree.

Key changes:
- scripts/llm-gateway.sh: full glm provider arm + tiered model case/esac (+30/-4 lines)
- aeon.yml: gateway.provider pinned from auto → glm
- .github/workflows/aeon.yml: GLM secrets + model vars wired into all 3 job envs
- High skill failure rate today (token-movers, holdings, changelog, shiplog, repo-pulse, aeon-update) — likely GLM secrets not yet configured

Stats: 6 files changed, +124/-190 lines (52 meaningful, rest lockfile)
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-31.md
