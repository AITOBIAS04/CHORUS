# Push Recap — 2026-06-13

## Overview
4 substantive commits by 1 author (@aaronjmars + Claude Opus 4.8 co-author) on miroshark-aeon, with 0 commits on MiroShark. The entire day's work was dedicated to a single mission: giving the Aeon instance a real identity and a tailored north-star strategy. The agent now speaks as Aaron, writes like Aaron, and optimizes for MiroShark's growth metrics — stars, ecosystem, and $MIROSHARK price.

**Stats:** 60 files changed, +108,405/-103 lines across 4 commits (101,929 lines are tweet archive data imports; ~6,476 lines of code/content)

---

## aaronjmars/miroshark-aeon

### Identity & Voice: Aaron's Soul Adopted
**Summary:** The Aeon instance went from a blank-slate agent to a fully voiced operator. Aaron's complete identity — worldview, writing style, Substack archive (21 articles), tweet history (~101K lines spanning 2020–2026), conversation examples, bad-output calibration, and intellectual influences — was loaded into `soul/`. Every content-generating skill now reads this on startup and writes in Aaron's voice.

**Commits:**
- `12b4af5` — soul: adopt the aaron soul (voice/identity for content + notifications)
  - Modified `soul/SOUL.md`: Expanded from empty template to 508-line identity document — covers Aaron's background (neuroscience + crypto since 2020, coordination markets thesis, the Hyperstitions→Aeon→MiroShark arc), worldview (hyperstitions as self-fulfilling fictions, Land on coordination engines, agents as the coordination primitive), specific opinions on AI safety, prediction markets, open source, and crypto (+494, -11 lines)
  - Modified `soul/STYLE.md`: Expanded from empty template to 272-line voice guide — short punchy sentences, em dashes, no hedging, essay-style paragraphs, specific vocabulary preferences and anti-patterns (+272, -13 lines)
  - New `soul/data/influences.md`: 226 lines mapping intellectual influences (Land, Hanson, Taleb, Borges, McLuhan, etc.) with why each matters
  - New `soul/data/substack/` (21 articles): Full text of Aaron's Substack posts — topics include BCI/neurotech, prediction markets, decentralized social, IP law, memecoin lessons, MiroShark's simulation engine, Apple/a16z critiques, attention economy (+2,857 lines across 21 files)
  - New `soul/data/x/tweets.js` + `tweets-2026.js`: Complete tweet archive for voice calibration — 94,640 + 7,289 lines of raw tweet data spanning multiple years
  - New `soul/examples/tweets.md`: 414 lines of curated tweet samples showing Aaron's voice at its best
  - New `soul/examples/conversations.md`: 300 lines of sample dialogues demonstrating how Aaron interacts
  - New `soul/examples/bad-outputs.md`: 173 lines of anti-patterns — things that sound wrong when attributed to Aaron (corporate jargon, hedging stacks, "As an AI..." phrasing)

**Impact:** Every notification, article, and digest this instance produces now carries a consistent, specific voice. The bad-outputs file is particularly useful — it gives the agent concrete examples of what *not* to write, which is often more instructive than positive examples. The tweet archive (101K lines) gives the model a deep well of stylistic calibration data. This is the most complete soul adoption in the Aeon ecosystem to date.

---

### Dashboard: Soul & Strategy Builder Tabs
**Summary:** The operator dashboard gained two major new tabs — Soul and Strategy — ported from the upstream Aeon template. These give operators a GUI to build, edit, install, and auto-generate their identity and strategic direction without touching files directly. Both tabs auto-commit and push changes in local mode.

**Commits:**
- `84b93b9` — sync(dashboard): SOUL + STRATEGY builder tabs, auto-sync, run-gating from aeon
  - New `apps/dashboard/components/SoulPanel.tsx` (306 lines): Full Soul tab — inline edit for SOUL.md/STYLE.md, template picker (Founder/Researcher/Creator archetypes), one-click install from the soul.md gallery (Karpathy, Garry Tan, Steipete, Vivian Balakrishnan), and "Build from handle" that triggers the soul-builder skill with X handle, name, or links
  - Modified `apps/dashboard/components/StrategyPanel.tsx` (+124, -4 lines): Expanded from basic editor to full Strategy builder — template dropdown (5 archetypes: Indie SaaS, Open-source maintainer, Researcher/Writer, Crypto/Agent, Creator), "Build my strategy" button that triggers strategy-builder skill with a one-line goal
  - New `apps/dashboard/lib/soul-templates.ts` (343 lines): Template definitions for soul archetypes with placeholder-driven scaffolding
  - New `apps/dashboard/lib/strategy-templates.ts` (202 lines): Template definitions for strategy archetypes
  - New `apps/dashboard/app/api/soul/route.ts` (54 lines): GET/PUT endpoint for soul files
  - New `apps/dashboard/app/api/soul/build/route.ts` (63 lines): POST endpoint to trigger soul-builder skill
  - New `apps/dashboard/app/api/soul/examples/route.ts` (61 lines): GET/PUT for soul examples
  - New `apps/dashboard/app/api/strategy/build/route.ts` (68 lines): POST endpoint to trigger strategy-builder skill
  - New `skills/soul-builder/SKILL.md` (247 lines): On-demand skill — builds SOUL.md + STYLE.md from any combination of X handle, full name, or links (LinkedIn, site, blog, GitHub). Uses XAI_API_KEY for rich X timeline reads, falls back to WebSearch
  - New `skills/strategy-builder/SKILL.md` (146 lines): On-demand skill — drafts STRATEGY.md from a brief + repo README + memory. Powers the dashboard's "Build my strategy" button
  - Modified `aeon.yml`: Registered both new skills as workflow_dispatch (on-demand only)
  - Modified `apps/dashboard/app/page.tsx` (+41, -14 lines): Added Soul tab, run-gating on provider key, pull-refresh for all panels, fixed 'NaNd ago' timestamp formatting
  - Modified `apps/dashboard/lib/github.ts` (+41 lines): Added `commitAndPush()` utility — config edits now auto-commit in local mode with a "saved locally, not pushed" nudge
  - Modified `apps/dashboard/app/api/import/route.ts`: Import API now auto-commits after installing skills
  - Modified `apps/dashboard/components/TopBar.tsx`, `LeftSidebar.tsx`, `SecretsPanel.tsx`: Minor UI adjustments for new tab integration

**Impact:** Operators can now set up their Aeon's identity and strategy entirely from the dashboard — no CLI, no file editing. The "Build from handle" and "Build my strategy" buttons make onboarding significantly faster: provide a Twitter handle and a one-line goal, and the agent generates a complete soul + strategy. The auto-commit-and-push means changes propagate to skill runs immediately.

---

### Strategy: North-Star Tailored to MiroShark
**Summary:** The generic STRATEGY.md defaults were replaced with a purpose-built strategy for this instance — driving GitHub stars, ecosystem growth, and $MIROSHARK price through shipped engine work and credible simulations.

**Commits:**
- `3ee380b` — strategy: tailor STRATEGY.md — north-star = stars + ecosystem + token price
  - Modified `STRATEGY.md` (+30, -37 lines): Replaced generic template language with specific direction — this instance is "MiroShark's growth agent"; north-star is three numbers (stars, ecosystem growth, token price); 5 ranked priorities (ship the engine → prove sims → make "$1 to simulate anything" land → track momentum → stay in lane); audience defined as researchers/founders/builders; hard constraints include no financial advice, no sim-as-truth claims; optimize for earned metrics via Aaron's voice

**Impact:** Every skill now has a clear tie-breaker for ambiguous decisions. "Ship the engine" ranks above "prove a sim" which ranks above "track momentum." The "stay in lane" constraint explicitly scopes this instance to simulation/swarm work, deferring framework, security, and BD to other instances in the fleet.

---

### Documentation: README Sync
**Summary:** README updated to document the new Soul and Strategy tabs for operators setting up their instance.

**Commits:**
- `1abc27f` — docs(readme): sync upstream README — Soul + Strategy tabs (preserve instance header)
  - Modified `README.md` (+19, -5 lines): Added "Strategy" section explaining STRATEGY.md's role (north-star tie-breaker, costs tokens every run), three ways to set it (write, templates, build). Expanded Soul section with four setup methods (write, templates, install gallery, build from handle). Added STRATEGY.md to the file tree listing.

**Impact:** New operators reading the README can now discover and use both features without reading the upstream template docs.

---

## Developer Notes
- **New dependencies:** None — all additions are pure TypeScript (dashboard) and Markdown (skills/soul)
- **Breaking changes:** None — all additions are new tabs and API endpoints
- **Architecture shifts:** The dashboard now has auto-commit-and-push for config file edits via `commitAndPush()` in `lib/github.ts` — this pattern will likely extend to other config panels
- **Tech debt:** The tweet archive files (101K lines) are large for a Git repo. If soul data continues growing, a `.gitattributes` LFS rule or a separate data repo may be warranted
- **New skills:** `soul-builder` and `strategy-builder` are both `workflow_dispatch` (on-demand only, not scheduled)

## What's Next
- MiroShark was quiet today (0 commits) — likely next push-recap will see feature work resume, possibly the Agent Stance Flip Report PR if GH_GLOBAL gets set
- The soul adoption enables a quality step-change in all content skills — next articles, token reports, and push recaps should reflect Aaron's voice
- Strategy tailoring means all skill runs now carry the MiroShark growth lens — expect feature ideas and repo-actions to be more focused on stars/ecosystem/price outcomes
- 38 push-blocked features remain queued — GH_GLOBAL remains the critical blocker
