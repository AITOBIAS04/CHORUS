# Push Recap — 2026-07-24

## Overview
2 substantive commits by 1 author (@aaronjmars) across 1 watched repo (12 automation commits filtered from miroshark-aeon). Today's work was entirely security-focused: two lockfile-only patches resolving active vulnerability advisories in the Python backend's dependency chain.

**Stats:** 1 file changed, +55/-44 lines across 2 substantive commits

---

## aaronjmars/MiroShark

### Security: Dependency Vulnerability Patches
**Summary:** Two back-to-back PRs patched high/medium severity vulnerabilities in `backend/uv.lock` — a setuptools upgrade resolving an open Dependabot alert and a PyTorch upgrade fixing a memory corruption advisory. Both are lockfile-only changes with no manifest modifications required.

**Commits:**

- `ab5bee6` — security: bump torch 2.12.1 -> 2.13.0 (GHSA-rrmf-rvhw-rf47) (#257)
  - Changed `backend/uv.lock`: Upgraded torch from 2.12.1 to 2.13.0. The advisory GHSA-rrmf-rvhw-rf47 covers a memory corruption vulnerability in PyTorch versions ≤2.12.1. Since `pyproject.toml` already declares `torch>=2.12.1`, the existing constraint permits 2.13.0 — no manifest change needed.
  - Transitive dependency updates pulled in by the torch upgrade:
    - `cuda-toolkit` 13.0.2 → 13.0.3.0 (added `cublas` optional dependency group, tightened platform markers from `sys_platform == 'linux'` to explicit `platform_machine` checks for `aarch64` and `x86_64`)
    - `nvidia-cublas` 13.1.0.3 → 13.1.1.3 (added `nvidia-cuda-nvrtc` as a new dependency)
  - Lockfile revision changed from 3 → 2 (uv lockfile internal versioning)
  - +52/-41 lines

- `2c11057` — security: bump setuptools to 83.0.0 in backend/uv.lock (#258)
  - Changed `backend/uv.lock`: Upgraded setuptools from 81.0.0 to 83.0.0, resolving an open Dependabot alert flagged at high/medium severity. Regenerated via `uv lock --upgrade-package setuptools`.
  - +3/-3 lines (version, sdist hash/URL, wheel hash/URL)

**Impact:** Both patches close known vulnerability windows. The torch upgrade is particularly significant — GHSA-rrmf-rvhw-rf47 is a memory corruption issue that could affect any backend process running PyTorch inference. The cuda-toolkit and nvidia-cublas transitive updates also tighten platform markers, reducing the risk of incorrect dependency resolution on non-x86/non-aarch64 platforms.

---

## Developer Notes
- **New dependencies:** nvidia-cuda-nvrtc added as a transitive dependency of nvidia-cublas (new in 13.1.1.3)
- **Breaking changes:** None. Both changes are lockfile-only; pyproject.toml constraints already permitted the new versions.
- **Architecture shifts:** cuda-toolkit platform markers shifted from broad `sys_platform == 'linux'` to specific `platform_machine` checks — a positive narrowing that prevents misresolution on unsupported architectures.
- **Tech debt:** None introduced.

## What's Next
- Both PRs (#257, #258) are merged — no open threads from today's work.
- MiroShark has been in a maintenance/security-only phase for the past week (dead code purge Jul 21, dep sweeps Jul 20, CVE patches Jul 22, security bumps today). No feature commits since the v0.1.0 migration completed Jul 11.
- 61 consecutive feature-skill blocks (GH_GLOBAL not set) continue to prevent new feature PRs from being pushed.
