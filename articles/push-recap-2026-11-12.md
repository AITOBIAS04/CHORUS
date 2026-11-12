# Push Recap — 2026-11-12

## Overview
1 substantive commit by 2 authors across aaronjmars/miroshark-aeon (9 automation commits filtered). The day's main work was a large upstream sync from aeonfun/aeon that landed three new Internet Computer Protocol skills, a community security pack, and a mass notification formatting fix across the entire skill catalog.

**Stats:** 101 files changed, +1,982/-772 lines across 1 substantive commit

---

## aaronjmars/miroshark-aeon

### Upstream Sync: ICP Skill Pack (3 New Skills)
**Summary:** PR #251 synced 4 upstream commits from aeonfun/aeon, bringing the first Internet Computer Protocol skill pack to the miroshark-aeon instance. Three new skills were added — canister monitoring, deploy safety checks, and governance digest — plus supporting infrastructure (icons, tests, catalog entries).

**Commits:**
- `5ca506c` — aeon-update: sync 4 upstream commits (4d64089..5981e1c) (#251)
  - New file `skills/canister-status/SKILL.md` (+73 lines): Monitors IC canisters for control-plane changes — new controllers, module hash changes, disappearances from the public index. Uses the public IC dashboard API. Fires alerts only on diffs with warn/info severity.
  - New file `skills/canister-status/reconcile.mjs` (+216 lines): Deterministic Node.js reconciler that validates HTTP responses and does atomic state management for canister monitoring.
  - New file `skills/canister-status/README.md` (+35 lines): Pack documentation.
  - New file `skills/icp-deploy-check/SKILL.md` (+97 lines): Pre-deploy safety checklist for Rust IC canisters. Static, read-only, no network. Checks 7 footguns: anonymous-principal rejection, unguarded admin methods, mainnet `fetch_root_key`, controller backup, upgrade safety (bounded vs unbounded serialization), `CallerGuard` drop bug, secrets in state.
  - New file `skills/icp-deploy-check/README.md` (+27 lines): Pack documentation.
  - New file `skills/sns-digest/SKILL.md` (+92 lines): Digests IC governance proposals (NNS + SNS DAOs). Uses two public APIs. Fires only when new proposals appear; deduplicates against prior logs.
  - New file `skills/sns-digest/parse-proposals.mjs` (+142 lines): Node.js parser for governance proposal data.
  - New file `skills/sns-digest/README.md` (+29 lines): Pack documentation.
  - New file `scripts/tests/test_icp_skill_pack.mjs` (+129 lines): Test suite for all three ICP skills.
  - New files `docs/assets/skill-icons/canister-status.svg`, `icp-deploy-check.svg`, `sns-digest.svg` (+3 lines): SVG icons for the new skills.

**Impact:** The miroshark-aeon instance now carries ICP monitoring capabilities. These skills are not enabled (packs are visibility filters, not runtime switches), but they're available for any IC-focused fork to activate. The skill count advances to 89.

### Community Security Pack: YUSA
**Summary:** The upstream sync also introduced a new community skill pack in the catalog — the YUSA Pack from `yusasecurity/yusa`.

**Commits:**
- `5ca506c` (same commit)
  - Changed `catalog/skill-packs.json` (+19, -1 lines): Added YUSA Pack entry — a security pack that detects hidden instructions in installed skills (Unicode TAG smuggling, zero-width splits, look-alike letters, hidden HTML, base64). Read-only, keyless, MIT licensed.
  - Changed `docs/community-skill-packs.md` (+1 line): Referenced the new YUSA pack.
  - Changed `docs/aeon-setup.md` (+3, -1 lines): Updated setup docs to include YUSA.

**Impact:** Fork operators now have access to a third-party security audit tool for their installed skills. Given the growing skill catalog (89 skills), supply-chain integrity tooling is increasingly relevant.

### Notification Formatting Fix
**Summary:** A global find-and-replace across ~60 skill files swapped em dashes (`—`) for hyphens (`-`) in notification template strings. This is a Telegram/Discord rendering compatibility fix — em dashes inside Markdown bold/italic contexts can cause display issues in some chat clients.

**Commits:**
- `5ca506c` (same commit)
  - Modified ~60 `skills/*/SKILL.md` files: Changed notification template patterns like `*Top Tweets — ${ARG}*` to `*Top Tweets - ${ARG}*`. Logic unchanged; output formatting only.
  - Changed `eyebrowlock.json` (+217, -128 lines): Content-integrity lockfile regenerated with updated SHA-256 hashes for all modified skill files, plus entries for the 3 new ICP skills.

**Impact:** Notifications from all skills should now render consistently across Telegram, Discord, and Slack. The eyebrowlock.json update ensures integrity checks pass for the reformatted files.

### Documentation & Catalog Updates
**Summary:** Skill count bumped from 88 to 89 across all reference documents and catalog files.

**Commits:**
- `5ca506c` (same commit)
  - Changed `.claude/skills/aeon/SKILL.md` (+2, -2 lines): `88 skills` → `89 skills`
  - Changed `.claude/skills/aeon/references/layout.md` (+2, -2 lines): Same update
  - Changed `.claude/skills/aeon/references/mcp.md` (+1, -1 line): Same update
  - Changed `.claude/skills/aeon/references/skill-anatomy.md` (+5, -5 lines): Same update
  - Changed `.github/README.md` (+3, -3 lines): Same update
  - Changed `plugin/skills/aeon/SKILL.md`, `plugin/skills/aeon/references/layout.md`, `plugin/skills/aeon/references/mcp.md`, `plugin/skills/aeon/references/skill-anatomy.md`: Mirrored updates in plugin copies
  - Changed `catalog/packs.json` (+1, -1 line), `catalog/skill-icons.json` (+4, -1 lines), `catalog/skills.json` (+1, -1 line): Catalog metadata updates
  - Changed `docs/skill-packs.md` (+4, -4 lines), `docs/examples/README.md` (+1, -1 line), `docs/icp/README.md` (+5, -7 lines): Doc updates

**Impact:** All documentation surfaces now reflect the correct skill count and the ICP scope has been clarified.

---

## Developer Notes
- **New dependencies:** None (all new ICP skills use pure-stdlib Node.js)
- **Breaking changes:** None — notification output format changed (em dash to hyphen) but this is cosmetic
- **Architecture shifts:** First ICP/Web3-governance skill pack — signals upstream Aeon is expanding beyond crypto-price monitoring into on-chain infrastructure monitoring
- **Tech debt:** None introduced

## What's Next
- The 3 ICP skills are landed but not enabled — activation depends on the operator's needs and whether they run IC canisters
- The YUSA security pack is catalogued but needs a fork operator to install and run it
- The em-dash fix should resolve any lingering notification rendering artifacts across chat platforms
- No branches created or left unmerged — PR #251 was fully squash-merged
