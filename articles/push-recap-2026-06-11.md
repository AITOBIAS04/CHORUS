# Push Recap — 2026-06-11

## Overview
5 substantive commits by 2 authors (@aaronjmars + aeonframework co-author) across 2 repos. The headline: miroshark-aeon was completely rebuilt on the upstream aeon template — a 300-file structural migration that brings in a full operator dashboard, MCP server, and A2A server while purging 80+ accumulated article files and temp scripts. MiroShark itself shipped a Japanese README, its third root-level language.

**Stats:** 307 files changed, +10,162/-12,640 lines across 5 commits

---

## aaronjmars/miroshark-aeon

### Template Rebuild & Architecture Overhaul
**Summary:** The entire miroshark-aeon deployment was rebuilt on the new aeon template framework in a single massive PR (#57). This migrates from an organically grown directory layout to the template's canonical `apps/` structure, inherits all new upstream features, and strips out accumulated cruft — old articles, temp scripts, stale output files.

**Commits:**
- `6498af1` — Rebuild on the new aeon template (adopt structure + features, re-apply instance config) (#57)
  - **300 files touched:** 79 added, 184 removed, 26 renamed, 11 modified (+10,009/-12,634 lines)
  - New `apps/dashboard/` — full Next.js operator dashboard with 15+ API routes (auth, secrets, skills, runs, memory, outputs, analytics, strategy, sync, import, upload), React components (SkillDetail, McpPanel, SecretsPanel, StrategyPanel, HQOverview, LeftSidebar, TopBar, InstantModeCard, TelegramChatIdHelper), security API gate with tests, auth provider, config system with tests, memory reader, frontmatter parser, GitHub integration
  - New `apps/a2a-server/` — Agent-to-Agent server (+592 lines), relocated from root
  - New `apps/mcp-server/` — MCP server (+231 lines), relocated from root
  - New `apps/webhook/` — Cloudflare Worker webhook handler (+76 lines) with wrangler config
  - New `.github/workflows/ci-capabilities-parity.yml` — CI workflow for testing capabilities alignment (+41 lines)
  - New `.github/workflows/sync-upstream.yml` — automated upstream sync (+90 lines)
  - Modified `aeon.yml` — expanded from 122 to 261 lines of skill config (+261/-122), adopting template structure
  - Modified `.github/workflows/aeon.yml` — updated CI workflow (+309/-77)
  - Modified `.github/workflows/messages.yml` — updated scheduler (+150/-46)
  - Modified `README.md` — complete rewrite with upstream template content (+398/-269)
  - Added `ECOSYSTEM.md` (+102), `SHOWCASE.md` (+73), `STRATEGY.md` (+49), `LICENSE` (+21)
  - Added `.x402books/wallets.json` — x402 wallet config (+20 lines)
  - **Removed 184 files:** All old articles (80+ push-recaps, 50+ project-lenses, operator scorecards, AI framework watches, repo-actions), temp scripts (`.aeon-tmp/`, `.memory_flush_patch.py`, `.parse_trades_tmp.py`, `.check_syntax.py`), stale output files (`.outputs/`), old webhook workflow, build target marker
  - **Renamed 26 files:** Dashboard components and configs from root `dashboard/` to `apps/dashboard/`

**Impact:** This is a structural milestone — miroshark-aeon now inherits the upstream aeon template's full feature set (operator dashboard, MCP tools, A2A protocol, upstream sync) rather than carrying its own ad-hoc versions. The 184 deleted files represent months of accumulated output that was cluttering the repo. Future template improvements flow in via the new `sync-upstream.yml` workflow.

### Skill Intelligence: Hyperstition-Deadline Tiebreaker
**Summary:** Encodes a judgment call from the previous day's feature run into a permanent skill rule: when selecting which feature to build from a batch, prefer candidates that advance a hyperstition target within 10 days of its deadline.

**Commits:**
- `f24aa63` — improve: feature skill — hyperstition-deadline tiebreaker on idea pick (#56)
  - Changed `skills/feature/SKILL.md`: Added new step between idea selection and PR-check — reads Active Targets from MEMORY.md, identifies hyperstitions within 10-day deadline window, prefers matching candidate over higher-impact alternatives (+3/-1 lines)
  - Also fixed stale cross-reference (step 10 → step 11) in the grep-evidence note
  - Cites PR #155 (Chinese README, Jun 10) as the originating judgment — idea #5 was picked over #2/#3/#4 because Jun-15 Chinese-platform hyperstition was 5 days out

**Impact:** The feature skill now has time-pressure awareness. Instead of always picking the highest-impact idea, it can prioritize one that's on a deadline. This is the third "encode a judgment as a prompt step" improvement (after auth-posture PR #53 and push-recap noise filter PR #55).

### Operational Tuning
**Summary:** Two small follow-up PRs tune the rebuilt instance's model and gateway settings, and add a README introduction explaining what this deployment is.

**Commits:**
- `a140cf6` — Add instance intro to README; adopt template defaults (opus-4-8, gateway auto) (#58)
  - Changed `README.md`: Added blockquote explaining this is a live Aeon deployment for $MIROSHARK — what it does daily (token tracking, push recaps, articles, star milestones, feature building, Telegram updates) (+2 lines)
  - Changed `aeon.yml`: Upgraded default model from `claude-opus-4-7` to `claude-opus-4-8`; switched gateway from `direct` to `auto` (resolves provider at runtime from available secrets) (+2/-2 lines)

- `867b5b4` — star-milestone: pin model to claude-sonnet-4-6 (#59)
  - Changed `aeon.yml`: Added explicit `model: "claude-sonnet-4-6"` override to star-milestone skill — previously inherited the default (now opus-4-8), pinned to sonnet for cost efficiency on a simple milestone-check task (+1/-1 line)

**Impact:** The instance now runs on the latest Opus 4.8 model by default while keeping cost-sensitive skills (star-milestone, repo-pulse, repo-actions, star-momentum) on Sonnet 4.6. Gateway set to auto-detect available providers rather than hardcoding direct Anthropic access.

---

## aaronjmars/MiroShark

### Internationalization: Japanese README
**Summary:** MiroShark's third root-level README — a full Japanese translation of the project, mirroring the Chinese README (#155) that shipped the day before. All three READMEs now cross-link via a language switcher.

**Commits:**
- `63cf725` — feat: add Japanese README (README.ja.md) (#156)
  - New file `README.ja.md`: Complete 143-line Japanese translation covering tagline, quickstart, use cases, features table (smart setup, counterfactual branches, director mode, MCP tools, article generation, public gallery), architecture diagrams, and full documentation link table (+143 lines)
  - Changed `README.md`: Added 日本語 link to language switcher (+1/-1 line)
  - Changed `README.zh-CN.md`: Added 日本語 link to language switcher (+1/-1 line)

**Impact:** MiroShark now has first-class documentation in English, Chinese, and Japanese. This directly advances the "featured on a Chinese dev platform by 2026-06-15" hyperstition target (3-language coverage signals international readiness) and positions the project for Japanese developer communities.

---

## Developer Notes
- **New dependencies:** None — all new code is pure-stdlib or uses existing framework packages
- **Breaking changes:** miroshark-aeon's directory structure completely changed (root `dashboard/` → `apps/dashboard/`, root `a2a-server/` → `apps/a2a-server/`, etc.). Old article paths no longer exist.
- **Architecture shifts:** miroshark-aeon adopted the canonical aeon template structure (`apps/` for sub-applications, standardized workflow files, upstream sync). This is a one-time migration, not incremental.
- **Tech debt:** 184 accumulated files removed. The repo went from ~300 tracked articles/outputs to zero — future articles will be generated fresh by the rebuilt instance.
- **Model changes:** Default upgraded to claude-opus-4-8; star-milestone pinned to claude-sonnet-4-6 for cost efficiency.

## What's Next
- The rebuilt miroshark-aeon instance should begin producing output on its new structure — first runs will validate the migrated skill configs and new dashboard
- Japanese README (#156) + Chinese README (#155) from yesterday position MiroShark for the Jun 15 Chinese-dev-platform hyperstition deadline (4 days out)
- GH_GLOBAL secret remains unset — 36 consecutive feature blocks; the Per-Round Confidence Trajectory feature (built locally Jun 11) and 35 prior features still can't push
- The `sync-upstream.yml` workflow creates a channel for future aeon template improvements to flow into miroshark-aeon automatically
