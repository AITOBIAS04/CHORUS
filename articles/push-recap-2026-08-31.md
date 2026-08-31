# Push Recap — 2026-08-31

## Overview
5 substantive commits by 2 authors (46 automation commits filtered). The main event: Aaron Elijah Mars ported a GLM gateway into miroshark-aeon, routing the agent through Z.AI's Anthropic-compatible API after exhausting the Claude subscription. Dependabot handled routine dependency bumps on MiroShark. A quiet but pivotal infrastructure day — the agent's LLM backbone just switched providers.

**Stats:** 6 files changed, +124/-190 lines across 5 substantive commits (excluding lockfile churn: +52/-8 meaningful lines)

---

## aaronjmars/miroshark-aeon

### GLM Gateway Integration
**Summary:** The Claude subscription is exhausted. The founder ported the GLM gateway from canonical PR #990/#998, pinned it as the primary provider, and added tiered model mapping so different skill tiers can use appropriately-sized GLM models. This is a full provider switchover — the agent now routes through Z.AI instead of Anthropic directly.

**Commits:**
- `9479fa2` — feat: pin Claude harness to GLM gateway
  - Modified `aeon.yml`: Changed `gateway.provider` from `auto` to `glm`, added `glm` to the provider documentation and ordered-list comments (+3/-3 lines)
  - Modified `scripts/llm-gateway.sh`: Added full `glm` provider arm — `aeon_present()` detection for `GLM_API_KEY` or `ZAI_API_KEY`, auto-discovery candidate slot, and a 17-line routing block that sets `ANTHROPIC_BASE_URL` to `api.z.ai/api/anthropic`, pins all model slots to `glm-5.2`, and disables non-essential traffic (+21/-3 lines)
  - Modified `.github/workflows/aeon.yml`: Wired `GLM_API_KEY` and `ZAI_API_KEY` secrets plus `GLM_MODEL` var into all 3 job environment blocks (skill-runner, scorer, chain-runner) (+9/-0 lines)

- `cce86a1` — Add tiered GLM model mapping (port of canon PR #998)
  - Modified `scripts/llm-gateway.sh`: Replaced the single `glm_model="${GLM_MODEL:-glm-5.2}"` line with a `case/esac` block that maps the run's `$MODEL` to tier-specific GLM vars — `*opus*` resolves `GLM_MODEL_OPUS`, `*haiku*` resolves `GLM_MODEL_HAIKU`, everything else resolves `GLM_MODEL_SONNET`, each falling back to `GLM_MODEL` then `glm-5.2` (+9/-1 lines)
  - This enables sonnet-tier skills to run a fast/cheap flash model while opus-pinned skills get the full model — same cost-optimization pattern already used by the OpenRouter arm

- `d20774f` — Pass GLM tier model vars through gateway env blocks (canon PR #998)
  - Modified `.github/workflows/aeon.yml`: Wired `GLM_MODEL_SONNET`, `GLM_MODEL_OPUS`, and `GLM_MODEL_HAIKU` vars into all 3 job environment blocks so the tiered mapping can actually resolve at runtime (+9/-0 lines)

**Impact:** The agent's LLM provider has been switched from Anthropic/auto to Z.AI's GLM gateway. All skills, scorers, and chain runners now route through `api.z.ai`. The tiered model mapping means this isn't a blunt switchover — the system can still differentiate between heavy-reasoning tasks (opus tier) and fast-turnaround tasks (sonnet/haiku tier) by setting per-tier GLM model vars. The `auto` fallback chain also now includes `glm` as the lowest-priority native provider, so future auto-resolution will discover it when the key is set.

---

## aaronjmars/MiroShark

### Dependency Maintenance
**Summary:** Two routine Dependabot PRs merged — a backend MCP SDK patch and a batch of 4 frontend package updates. No breaking changes, no new features. Standard supply-chain hygiene.

**Commits:**
- `e82e5db` — chore: update mcp requirement in /backend (#294)
  - Modified `backend/requirements.txt`: Bumped `mcp` pin from `>=1.29.0,<2.0.0` to `>=1.29.1,<2.0.0` (+1/-1 lines)
  - Patch release of the Model Context Protocol Python SDK — the `<2.0.0` ceiling stays in place to guard against camel-ai's FastMCP import break

- `6a193c0` — chore: bump the frontend-minor-patch group in /frontend with 4 updates (#293)
  - Modified `frontend/package.json`: Updated 4 dependencies — `axios` 1.19.0→1.20.0 (minor), `marked` 18.0.10→18.0.11 (patch), `vue` 3.5.41→3.5.42 (patch), `vue-router` 5.2.0→5.3.0 (minor) (+4/-4 lines)
  - Modified `frontend/package-lock.json`: Lockfile regeneration — net reduction of 110 lines as `vue-router` 5.3.0 dropped 3 dependencies (`@babel/generator`, `json5`, `yaml`) in favor of `confbox` (+68/-178 lines)

**Impact:** vue-router 5.3.0 is the notable update — it dropped `@babel/generator`, `json5`, and `yaml` as dependencies, replaced by the lighter `confbox`. This trims the frontend dependency tree. The axios minor and vue patch are maintenance-only. No API-surface or behavior changes expected.

---

## Automation Summary
46 automation commits filtered from miroshark-aeon:
- 13x `chore(scheduler): update cron state`
- 8x `chore(cron): *` failed markers (aeon-update ×3, repo-pulse ×3, token-movers ×3, shiplog ×3, holdings ×3, changelog ×3 — many skills failing, likely related to the gateway transition)
- 2x `chore(cron): heartbeat success`
- 1x `chore(cron): memory-flush success`
- 1x `chore(cron): fetch-tweets success`
- 3x `chore(*): auto-commit` output files (heartbeat, memory-flush, fetch-tweets)
- Notable: high failure rate across skills today (token-movers, holdings, changelog, shiplog, repo-pulse, aeon-update all failing) — likely the GLM gateway is not yet fully configured or the API key secrets haven't been set in the repo

---

## Developer Notes
- **New dependencies:** `confbox` added to vue-router 5.3.0 (replaces json5 + yaml); `@babel/generator`, `json5`, `yaml`, `jsesc`, `@types/jsesc` removed
- **Breaking changes:** Gateway provider pinned from `auto` to `glm` — all skills now require GLM_API_KEY or ZAI_API_KEY to function. If neither secret is set, skills will fail (and many appear to be failing today)
- **Architecture shifts:** LLM backbone switched from Anthropic direct to Z.AI GLM gateway. This is the first time the agent has been pinned to a non-Anthropic provider. The tiered model mapping (GLM_MODEL_OPUS/SONNET/HAIKU) preserves the cost-optimization structure
- **Tech debt:** Multiple skills failing post-switchover — secrets may need to be configured in the repo settings. The `auto` fallback was intentionally overridden with a hard pin to `glm`, so there's no graceful degradation to other providers

## What's Next
- The immediate priority is getting GLM_API_KEY / ZAI_API_KEY configured as repo secrets and setting GLM_MODEL / GLM_MODEL_* vars — the high skill failure rate today suggests this is incomplete
- Setting per-tier model vars (GLM_MODEL_OPUS, GLM_MODEL_SONNET, GLM_MODEL_HAIKU) will unlock cost optimization across skill tiers
- The `auto` provider resolution now has `glm` in its fallback chain, so switching back to `provider: auto` later would still pick up GLM when the key is set
- MiroShark remains blocked on GH_GLOBAL for 40+ queued feature PRs — the gateway change doesn't affect this
