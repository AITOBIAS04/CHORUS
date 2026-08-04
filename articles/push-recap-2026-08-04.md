# Push Recap — 2026-08-04

## Overview
3 substantive commits by 2 authors (@aaronjmars, aeonframework) across both watched repos, with 9 automation commits filtered from miroshark-aeon. Today's work split into two threads: a two-step ecosystem catalog cleanup removing the Noelclaw integration from MiroShark, and a CI security hardening pass on the aeon workflow that eliminated a secrets-context dump flagged by GitHub's malicious-workflow scanner.

**Stats:** 5 files changed, +12/-116 lines across 3 substantive commits

---

## aaronjmars/MiroShark

### Ecosystem Cleanup: Noelclaw Integration Removed
**Summary:** Noelclaw — an MCP server that exposed MiroShark surfaces to MCP-aware assistants — was removed from the ecosystem in two coordinated PRs. PR #266 pulled the row from `ECOSYSTEM.md`, and the follow-up PR #267 cleaned up the matching entry in the backend catalog plus all documentation references, fixing a test failure (`test_catalog_names_match_ecosystem_md`) that the first PR introduced.

**Commits:**
- `b79c42e` — docs: remove Noelclaw from ecosystem (#266)
  - Changed `ECOSYSTEM.md`: Removed the Noelclaw table row (logo, name, links to noelclaw.com, @noelclawfun X handle, and GitHub mcp repo) (-1 line)

- `3e7ee05` — fix(ecosystem): remove Noelclaw from catalog to match ECOSYSTEM.md (#267)
  - Changed `backend/app/services/ecosystem_catalog.py`: Removed the 7-line Noelclaw dict entry from the catalog list and stripped "Noelclaw mcp" from the module docstring's integration category example (+1, -9 lines)
  - Changed `docs/FEATURES.md`: Removed "Noelclaw" from the integration category description in the English feature docs (+1, -1 lines)
  - Changed `docs/FEATURES.zh-CN.md`: Same removal in the Chinese-language feature docs (+1, -1 lines)

**Impact:** The ecosystem drops from 12 to 11 active integrations. The drift-guard test between `ECOSYSTEM.md` and `ecosystem_catalog.py` was the forcing function — PR #266 removed the Markdown row but left the Python entry, breaking CI on main. PR #267 restored the invariant. This two-PR pattern shows the drift-guard test doing exactly what it was designed to do.

---

## aaronjmars/miroshark-aeon

### CI Security: Workflow Secret-Exfil Signature Reduction
**Summary:** A significant hardening change to `aeon.yml` that replaced a blanket `toJSON(secrets)` dump with an explicit named-secret JSON object, and removed the entire Fleet Watcher preflight/postflight subsystem. This was done to clear a hold that GitHub's public-repo malicious-workflow scanner had placed on every workflow dispatch.

**Commits:**
- `5c6f05b` — fix(ci): reduce workflow secret-exfil signature to clear GitHub malicious-workflow hold
  - Changed `.github/workflows/aeon.yml`:
    - **Removed** `FLEET_ENDPOINT` and `FLEET_TOKEN` from workflow-level env vars (these secrets were never set on this instance)
    - **Removed** the entire Fleet Watcher preflight step (~48 lines) — a curl-based pre-run gate that asked a control plane to ALLOW or BLOCK skills before execution
    - **Changed** `ALL_SECRETS` from `${{ toJSON(secrets) }}` (dumps the entire secrets context as a single JSON blob) to an explicit JSON object naming exactly 7 secrets: `CLAUDE_CODE_OAUTH_TOKEN`, `GH_GLOBAL`, `XAI_API_KEY`, `LANGFUSE_PUBLIC_KEY`, `LANGFUSE_SECRET_KEY`, `TELEGRAM_BOT_TOKEN`, `TELEGRAM_CHAT_ID`
    - **Removed** the entire Fleet Watcher postflight step (~46 lines) — a curl-based post-run audit reporter with taint-chain detection
    - Net: +9, -104 lines — the workflow is nearly 100 lines shorter

**Impact:** The `toJSON(secrets)` pattern is a known trigger for GitHub's automated malicious-workflow scanner on public repos — it looks like secret exfiltration even when the value is only consumed locally. By switching to an explicit named-secret list, the workflow now declares exactly which secrets it reads, eliminating the scanner hold. The Fleet Watcher removal is a dead-code cleanup — `FLEET_ENDPOINT` and `FLEET_TOKEN` were never configured on this instance, so the preflight/postflight blocks were always no-ops. This is a defense-in-depth improvement: fewer secrets in memory, a smaller attack surface, and no more GitHub action_required blocks on dispatches.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** Any fork that had `FLEET_ENDPOINT` + `FLEET_TOKEN` configured will lose preflight/postflight gating after pulling this change. However, no known forks used this feature.
- **Architecture shifts:** The ALL_SECRETS pattern shifted from implicit (dump everything) to explicit (name each secret). Any new secret added to the repo must also be added to the ALL_SECRETS JSON line in `aeon.yml` to be available to MCP config and skill `requires:` injection.
- **Tech debt:** None introduced. Net reduction of ~100 lines of dead code.

## What's Next
- The Noelclaw removal suggests ongoing ecosystem curation — projects that go inactive get pruned rather than accumulating indefinitely
- The ALL_SECRETS explicit-list pattern means future secret additions require a one-line workflow edit — a minor maintenance cost for a significant security posture improvement
- GH_GLOBAL remains unset (67th consecutive block) — feature skill and 40+ built PRs still cannot push
- Watch for any workflow dispatch issues if the scanner hold takes time to clear after the fix merges
