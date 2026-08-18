# Push Recap — 2026-08-18

## Overview
15 substantive commits by 3 authors across 2 watched repos (9 automation commits filtered). The dominant event: miroshark-aeon rebased onto the latest aeonfun/aeon canon framework — a 300-file, +32.8K/-6.6K delta that brings multi-harness architecture (six AI backends), eyebrow skill-integrity gating, a plugin marketplace, 19 new skills, and a complete dashboard/MCP overhaul. Alongside the sync, four targeted bug fixes hardened the notification script, cron push contention, skill-mode permissions, and harness timeouts.

**Stats:** ~320 files changed, +34,473/-6,639 lines across 15 substantive commits

---

## aaronjmars/miroshark-aeon

### Framework Canon Sync — Multi-Harness Architecture
**Summary:** The miroshark-aeon instance was rebased onto the upstream aeonfun/aeon framework via rsync-overlay, adopting the largest single delta since the instance was created. This brings six harness adapters (Claude, Codex, Grok, Kimi, Pi, Vibe), an eyebrow skill-integrity gate, a plugin marketplace, and 19 new framework skills — all while preserving operator config (memory/, soul/, aeon.yml schedules, custom skills like repo-pulse and holdings).

**Commits:**
- `08f6831` — chore: sync framework to aeonfun/aeon canon (2026-08-17) (#129)
  - 300 files changed, +32,832/-6,630 lines — the largest single commit in miroshark-aeon history
  - New directory `harness-adapter/`: Six shell-based harness adapters (`claude.sh`, `codex.sh`, `grok.sh`, `kimi.sh`, `pi.sh`, `vibe.sh`) with a shared `run-harness` dispatcher (+1,613 lines); enables running aeon skills on non-Claude AI backends via a unified envelope/sandbox/retry layer
  - New file `eyebrow.policy.json` + `eyebrowlock.json` (+2,312 lines): Skill-integrity gate that locks skill file hashes and blocks unauthorized modifications — CI workflow `ci-skill-integrity.yml` validates on every PR
  - New CI workflows: `ci-apps.yml` (monorepo app builds), `ci-readme-catalog.yml`, `ci-skill-integrity.yml`, `ci-skill-packs.yml` — four new quality gates
  - Removed: OKF (Open Knowledge Framework) entirely — `ci-okf.yml`, `docs/OKF.md`, okf-related skills and scripts deleted
  - Major `aeon.yml` overhaul (+618/-162): new skill entries from canon, updated harness-adapter run path, token usage capture restructured
  - Dashboard overhaul: MCP OAuth flow (`mcp-oauth.ts`, `mcp-oauth-server.ts`, +244/+64 lines), harness auth (`harness-auth.ts`, +110 lines), service icon refactor (`service-icons.ts` replaces inline SVGs, +138 lines), new `SkillGlyph` component, `instrumentation.ts` for OpenTelemetry
  - MCP server: Removed OKF module (`okf.ts`, -207 lines), added `tracing.ts` (+54 lines), skill-executor rewrite (+116/-38)
  - New docs: `ADK.md` (Agent Development Kit, +369 lines), `ClawHunter-API.md`, `mcp-oauth.md`, `skill-integrity.md`, `skill-scan-calibration.md`, `aeon-setup.md`
  - Skill icon SVGs: 72 new per-skill icons under `docs/assets/skill-icons/`
  - README refreshed (+118/-238): updated branding assets, community images, pill button SVGs
  - Also seeds `memory/topics/aeon-update-state.json` with baseline SHA so incremental updates work going forward

- `167d741` — chore: add .claude/ operator skill + .claude-plugin/ marketplace from canon (#136)
  - New file `.claude/skills/aeon/SKILL.md` (+450 lines): In-repo operator skill giving Claude Code direct access to aeon's internal structure — CI helpers, layout references, secret catalog, MCP config, history-mining scripts
  - New file `.claude-plugin/marketplace.json` (+15 lines): Plugin manifest for the Claude Code plugin marketplace
  - 6 reference documents under `.claude/skills/aeon/references/`: CI, history-mining, layout, MCP, secrets, skill-anatomy guides
  - New script `.claude/skills/aeon/scripts/mine-history.mjs` (+317 lines): History mining for commit/skill-run archaeology
  - Total: 9 files, +1,535 lines — bridges the gap between the aeon framework and Claude Code's native skill system

- `6ea03f6` — chore(aeon.yml): enable aeon-update weekly (Mon 11:00 UTC) (#135)
  - Changed `aeon.yml`: flipped `aeon-update` from `enabled: false` to `enabled: true` (+1/-1 line)
  - This means miroshark-aeon will now automatically pull upstream canon changes each Monday as a reviewable PR, rather than requiring manual rsync syncs

**Impact:** miroshark-aeon is now architecturally aligned with the multi-harness aeonfun/aeon framework. The instance can theoretically run skills on Codex, Grok, Kimi, Pi, or Vibe backends alongside Claude. The eyebrow integrity gate prevents silent skill tampering. The aeon-update cron means future framework updates arrive incrementally as weekly PRs instead of massive catch-up syncs.

### Reliability & Bug Fixes
**Summary:** Four targeted fixes address real failure modes observed in production: a notification script that broadcast `--help` text to all channels, push contention under concurrent cron writers, a permission gap that caused 30-minute skill-health timeouts, and an undersized harness timeout that killed long-running skills.

**Commits:**
- `47b8f81` — fix(notify): add -h/--help guard so a usage probe never broadcasts
  - Changed `scripts/notify.sh`: Added `-h|--help` case that prints usage to stderr and exits without sending (+12 lines)
  - Also rejects unrecognized `--long` flags instead of silently treating them as the message body
  - Root cause: a skill agent probing `./notify --help` to inspect flags had the string fall through the catch-all and get broadcast as a real notification (self-reported 2026-08-10, recurred)

- `6e30051` — fix(cron-state): jittered backoff + 10 retries for commit-race (#139)
  - Changed `.github/workflows/aeon.yml`: Widened retry loop from 5 to 10 attempts in both auto-commit and cron-state push paths (+4/-4 lines)
  - Replaced deterministic `sleep "$i"` with `sleep "$(( (RANDOM % 4) + i ))"` — jittered backoff desynchronizes lockstep writers under push contention
  - Root cause: on the high-churn vuln instance, two skills finishing simultaneously would both try to push, re-collide on every retry because they slept the same duration, and lose the outcome write

- `ee27c08` — chore(harness): 30m skill-run timeout (harness 1800s, job 50m) (#138)
  - Changed `.github/workflows/aeon.yml`: Doubled harness agent budget from 900s to 1800s, raised job timeout from 30m to 50m (+2/-2 lines)
  - Root cause: vuln-scanner and sc-audit intermittently exceeded the 900s harness guard and failed

- `981bee8` — fix(skill_mode): grant ./scripts/skill-runs in the base tool tier (#137)
  - Changed `scripts/skill_mode.sh`: Added `Bash(./scripts/skill-runs:*)` to the BASE_TOOLS allowlist (+12 lines)
  - Root cause of ISS-001 on aeon-compute: five skills (skill-health, heartbeat, cost-report, retrospective, self-review) document `./scripts/skill-runs` as a primary data source, but no tier granted it — skill-health burned turns working around denials and hit the 30m job timeout on two consecutive runs
  - Safe in base tier: the script only does `gh api` GET reads + jq + date (no repo/network mutation)

**Impact:** Eliminates four distinct failure modes: phantom notification broadcasts, push contention under concurrent writers, long-running skill timeouts, and permission-denied loops in health-monitoring skills. The jittered backoff alone would have prevented ~2 observed incidents per day on the high-churn instance.

### Observability — Cache Economics Trace
**Summary:** A new per-run trace sidecar captures the 5-minute vs 1-hour cache write split that the daily-aggregate CSV loses, enabling accurate cost attribution and cadence analysis.

**Commits:**
- `9f004ad` — feat(usage): emit cacheeconomics trace sidecar alongside token-usage.csv (#128)
  - Changed `.github/workflows/aeon.yml`: Extracts `cache_creation.ephemeral_5m_input_tokens` and `cache_creation.ephemeral_1h_input_tokens` from the Anthropic response (+31 lines)
  - Appends one JSON line per run to `memory/token-trace.jsonl` in the cacheeconomics normalized-trace schema
  - Each trace line carries: full ISO timestamp, model, skill name, run ID as session, and the 5m/1h write split
  - The existing CSV is untouched — this is additive
  - Why: a 1h cache write bills at 2x while a 5m write bills at 1.25x; the aggregate total in the CSV can't distinguish them, making cost reconciliation against Anthropic invoices impossible

**Impact:** Enables three analyses that were previously blocked: per-lifetime write pricing (2x vs 1.25x), intra-day cadence detection (run spacing), and clean model-bump identification (one line per run, not one line per day).

### CI/CD — PR Concurrency Gates
**Summary:** Seven lint/check workflows now cancel superseded in-progress runs when a newer commit is pushed to the same PR, reclaiming wasted runner-minutes.

**Commits:**
- `eb6baad` — ci: add PR-scoped concurrency to lint/check workflows
  - Modified 7 CI workflow files: `ci-agents-md.yml`, `ci-capabilities-parity.yml`, `ci-okf.yml`, `ci-packs-json.yml`, `ci-skill-category.yml`, `ci-skills-json.yml`, `ci-tests.yml`
  - Each gets a `concurrency:` block with `cancel-in-progress: ${{ github.event_name == 'pull_request' }}` — only cancels PR runs, never push/main/tag runs (+42 lines total)

**Impact:** On PRs with rapid iteration (stacked pushes), earlier CI runs are cancelled instead of running to completion. Reduces runner-minute waste on the repo's now 10+ CI workflow suite.

### Dependency Updates
**Summary:** Six Dependabot PRs merged — one on MiroShark (httpx patch) and five on miroshark-aeon (tsx, wrangler, @types/node, eyebrow, and a 5-package dashboard bundle).

**Commits:**
- `e48a8a0` — chore(deps): bump tsx 4.23.1 → 4.23.12 in /apps/cli (#130)
- `80dca69` — chore(deps-dev): bump wrangler 4.115.0 → 4.123.0 in /apps/webhook (#131)
- `4cb7d97` — chore(deps): bump @types/node 26.1.2 → 26.2.0 in /apps/mcp-server (#132)
- `f313f6a` — chore(actions): bump alexverify/eyebrow/action 0.4.1 → 0.4.2 (#133)
- `453a1fe` — chore(deps): bump dashboard group — next 16.2.12→16.3.1, @types/node 26.1.2→26.2.0, @types/react 19.2.17→19.2.18, @types/react-dom 19.2.3→19.2.4, tsx 4.23.1→4.23.12 (#134)

**Impact:** Keeps dependencies current. The Next.js minor bump (16.2→16.3) is the most notable — may include new features or performance improvements in the dashboard. The eyebrow action bump aligns with the newly added skill-integrity CI gate.

---

## aaronjmars/MiroShark

### Dependency Patch — httpx
**Summary:** Dependabot bumped the httpx minimum from 0.28.0 to 0.28.1 in the backend requirements.

**Commits:**
- `733def1` — chore: update httpx requirement in /backend (#289)
  - Changed `backend/requirements.txt`: Tightened lower bound from `httpx>=0.28` to `httpx>=0.28.1` (+1/-1 line)
  - Context: last week's PR #288 fixed the OpenAI SDK 3.0 httpx→httpx2 transitive dependency break; this patch version likely includes bug fixes relevant to that resolution

**Impact:** Ensures the backend pins to a known-good httpx patch, reducing the risk of regression from the httpx2 migration path.

---

## Developer Notes
- **New dependencies:** wrangler 4.123.0, next 16.3.1, tsx 4.23.12, @types/node 26.2.0, eyebrow/action 0.4.2
- **Breaking changes:** OKF (Open Knowledge Framework) fully removed — `ci-okf.yml`, `docs/OKF.md`, and all okf-related skills/scripts deleted from miroshark-aeon. Any downstream tooling referencing OKF endpoints or imports will break.
- **Architecture shifts:** Multi-harness architecture adopted (6 AI backends); eyebrow skill-integrity gating (hash-locked skill files); MCP OAuth flow added to dashboard; operator skill + plugin marketplace introduced; cacheeconomics trace sidecar for per-run cost attribution
- **Tech debt:** None introduced. OKF removal is tech debt reduction.

## What's Next
- The aeon-update skill is now enabled — first automatic canon sync PR expected Monday Aug 24 at 11:00 UTC, testing the incremental delta path
- The canon sync brought 19 new framework skills (all `enabled: false`) — operator can selectively enable aeon-doctor, glim-mcp, robinhood-mcp, executor-mcp, and others as needed
- Multi-harness adapters are present but untested on this instance — would require non-Claude API keys to activate
- The eyebrow skill-integrity gate needs the `ci-skill-integrity.yml` workflow to run on the next PR to validate the lock file
- MiroShark main repo remains quiet — 77th consecutive push block (GH_GLOBAL not set)
