# Push Recap — 2026-07-22

## Overview
2 substantive commits by 1 author across aaronjmars/MiroShark (9 automation commits filtered from miroshark-aeon). Today's work was entirely security-focused: same-day patches for two CVEs — a Cross-Site WebSocket Hijacking flaw in the MCP Python SDK and a quadratic-complexity DoS in shell-quote. Both were merged within hours of advisory publication.

**Stats:** 3 files changed, +10/-7 lines across 2 substantive commits

---

## aaronjmars/MiroShark

### Security: Same-Day CVE Patching
**Summary:** Two dependency-level security patches shipped back-to-back, addressing vulnerabilities in the MCP protocol SDK (backend) and shell-quote (frontend toolchain). Both follow the project's pattern of same-day MTTR against advisories — well under the industry average of 74-252 days.

**Commits:**
- `6a5a12a` — chore(deps): bump mcp 1.27.2 -> 1.28.1 (GHSA-vj7q-gjh5-988w / CVE-2026-59950) (#255)
  - Changed `backend/uv.lock`: MCP Python SDK version bumped from 1.27.2 to 1.28.1 (+3/-3 lines)
  - The vulnerability is a Cross-Site WebSocket Hijacking (CSWSH) flaw rated CVSS 7.6 — allows an attacker to hijack authenticated WebSocket sessions if origin validation is missing
  - Straightforward lockfile bump; the SDK's API surface is unchanged between these versions

- `9646181` — chore(deps): scoped override for shell-quote to clear GHSA-395f-4hp3-45gv (#256)
  - Changed `package.json`: Added `overrides` section with scoped selector `shell-quote@<1.9.0` -> `^1.9.0` (+3 lines)
  - Changed `package-lock.json`: shell-quote resolved version updated from 1.8.4 to 1.10.0; incidental engines.node mirror resynced from >=18.0.0 to >=22.0.0 (+4/-4 lines)
  - Addresses CVE-2026-13311 (CVSS 7.5) — quadratic-complexity DoS in shell-quote's `parse()` function
  - Required a scoped npm override rather than a standard `npm audit fix` because concurrently@10.0.3 pins shell-quote to exact version 1.8.4; no upstream fix exists yet
  - **Not reachable in this codebase** — concurrently only imports `quote()` from shell-quote, never the vulnerable `parse()`. The only strings reaching the parser are static command literals in package.json's `dev` script. However, shell-quote is present in the Docker image since concurrently runs in `npm run dev`
  - Override self-deactivates once concurrently repins to a version that doesn't pin shell-quote <1.9.0
  - Clears Dependabot alert #66; alert #65 (torch, low, backend/uv.lock) intentionally left as-is

**Impact:** Both CVEs are now cleared from audit reports. The MCP CSWSH patch closes a real attack surface for any deployment accepting WebSocket connections. The shell-quote patch is defense-in-depth — the vulnerable code path is unreachable in this project, but the override prevents future code from accidentally calling `parse()` on the vulnerable version. Dependabot alert count drops by 1.

---

## aaronjmars/miroshark-aeon
9 automation commits filtered (4x `chore(cron):`, 3x `chore(scheduler):`, 2x `chore(*): auto-commit`). No substantive changes.

---

## Developer Notes
- **New dependencies:** None added; shell-quote bumped 1.8.4 -> 1.10.0, mcp bumped 1.27.2 -> 1.28.1
- **Breaking changes:** None — both are patch/minor bumps with no API changes
- **Architecture shifts:** None
- **Tech debt:** Dependabot alert #65 (torch, low severity) remains open in backend/uv.lock by design. The shell-quote override is temporary scaffolding that self-removes when concurrently updates upstream.

## What's Next
- Concurrently upstream may release a version that unpins shell-quote, at which point the npm override can be removed
- No open PRs or incomplete work visible in today's diffs
- The project continues its pattern of rapid CVE response — 40+ MCP CVEs have appeared in 2026, and this project has maintained same-day patching for those affecting its dependencies
