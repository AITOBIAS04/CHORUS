# Push Recap — 2026-11-14

## Overview
1 substantive commit by Dependabot across 2 watched repos (1 automation commit filtered from miroshark-aeon). Today's sole change was a major-version dependency bump in MiroShark's backend — `soupsieve` jumped from 2.9 to 4.0, rippling through the lock file's resolution markers and transitive dependency tree.

**Stats:** 1 file changed, +68/-36 lines across 1 substantive commit

---

## aaronjmars/MiroShark

### Dependency Update: soupsieve 2.9 → 4.0 (Major Version Bump)
**Summary:** Dependabot merged PR #358, bumping the `soupsieve` CSS selector library from 2.9 to 4.0 in the backend's `uv.lock`. This is a major version jump — soupsieve 4.0 was released November 3, 2026 — and it triggered a cascade of lock file resolution changes affecting Python version markers and transitive dependencies.

**Commits:**
- `96001a9` — chore: bump soupsieve in /backend in the uv group across 1 directory (#358)
  - Changed `backend/uv.lock`: Lock file revision 3 → 5; soupsieve source updated to 4.0 tarball/wheel from PyPI (+68, -36 lines)
  - **Resolution marker refinement**: Python `< 3.12` markers split into `>= 3.11.5` and `< 3.11.5` buckets — soupsieve 4.0 apparently requires Python ≥ 3.11.5, so the resolver now pins beautifulsoup4 4.6.3 for older Pythons and 4.14.3 for ≥ 3.11.5
  - **New beautifulsoup4 4.6.3 entry**: Added as a fallback for `python_full_version < 3.11.5` environments (the previous lock only had bs4 4.14.3)
  - **NVIDIA CUDA dependency markers simplified**: Across ~20 entries (cuda-bindings, nvidia-cublas, nvidia-cudnn-cu13, nvidia-cufft, nvidia-cusolver, nvidia-cusparse), removed verbose `sys_platform != 'emscripten' and sys_platform != 'win32'` guards — markers now use simpler unconditional or architecture-only checks
  - **Other marker simplifications**: pexpect's ptyprocess dependency and uvicorn's click/h11 dependencies also had platform guards stripped
  - **nbconvert**: beautifulsoup4 dependency split into version-conditional entries matching the new resolution markers

**Impact:** The soupsieve major version bump is routine dependency maintenance, but the 2.9→4.0 jump is notable — it's a two-major-version leap. The lock file resolution became more precise around the Python 3.11.5 boundary, which matters for environments running older Python 3.11.x point releases. The NVIDIA marker simplifications are cosmetic (uv resolver cleanup) but reduce lock file complexity. No source code changes — this is pure dependency graph maintenance.

---

## aaronjmars/miroshark-aeon (automation only)

1 automation commit filtered:
- `673c186` — chore(deps): bump hono from 4.13.13 to 4.13.18 in /apps/mcp-server (#253) — Dependabot patch bump for the Hono web framework

---

## Developer Notes
- **New dependencies:** soupsieve 4.0 (major bump from 2.9); beautifulsoup4 4.6.3 added as Python < 3.11.5 fallback
- **Breaking changes:** None expected — soupsieve 4.0's CSS selector API is consumed by beautifulsoup4, not called directly
- **Architecture shifts:** None
- **Tech debt:** The beautifulsoup4 version split (4.6.3 vs 4.14.3 by Python version) adds resolution complexity — worth monitoring if Python ≥ 3.11.5 becomes the enforced minimum

## What's Next
- Both repos remain in maintenance mode — no feature work, just dependency bumps and automated commits
- The Dependabot cadence continues; hono 4.13.18 in miroshark-aeon may trigger downstream lock updates
- GH_GLOBAL secret remains unset, blocking 40+ feature PRs from landing
