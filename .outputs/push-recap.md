*Push Recap — 2026-08-24*
miroshark-aeon — 3 substantive commits by 2 authors (30 automation commits filtered)

Security — Egress Audit Hardening (PR #147): Full egress control pipeline ported from canon. P1 blocks cloud metadata via iptables. P2-P3 route all skill HTTP through iron-proxy with per-skill allowlists from eyebrowlock.json. P4 feeds rejected hosts into the health system as egress_blocked flags. Opt-in (EGRESS_AUDIT=1), fail-open, warn-only by default.

Framework — Upstream Canon Sync (#146): 43 upstream commits synced — new fx.sh harness adapter, machine-readable harnesses.json registry with CI validation, dashboard workflow-secrets module, webhook replay-guard tests, 4 new operational scripts (audit, dry-run, chain_when, reactive_when), and plugin packaging (LICENSE/README/SECURITY).

Maintenance — Memory Consolidation: First run of the deterministic memory_prep.py pipeline (shipped yesterday). Promoted repo rename, token rally, holdings skill, and tweet-digest into MEMORY.md. Archived July logs automatically.

Key changes:
- New .github/actions/egress-audit/ composite action: iron-proxy MITM audit proxy with cached binary, ephemeral CA, and fail-open health checks
- New .github/scripts/iron-config.mjs: allowlist generator from baseline + gateway + eyebrowlock sources
- 85 files synced from aeonfun/aeon including fx harness, harnesses.json, and webhook hardening

Stats: ~90 files changed, +3,700/-200 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-24.md
