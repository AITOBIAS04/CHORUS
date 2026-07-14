*Push Recap — 2026-07-14*
MiroShark + miroshark-aeon — 4 substantive commits by 2 authors (12 automation filtered)

Org Migration & Link Canonicalization: MiroShark transferred to the MiroShark/ GitHub org. All 25 in-repo references (backend, frontend, docs, deploy buttons) updated from aaronjmars/MiroShark → MiroShark/MiroShark. Same treatment for the aeon framework — 10 files updated from aaronjmars/aeon → aeonfun/aeon. Two stale ecosystem slugs also corrected (AntFleet/miroshark-bench → bench-miroshark, OriginTrail/dkg-v9 → dkg).

Infrastructure Housekeeping: Dependabot bumped transformers 5.3.0 → 5.5.0 (indirect backend dep). repo-pulse skill disabled on miroshark-aeon — monitoring may be consolidating to CHORUS.

Key changes:
- 16 files across backend/frontend/docs canonicalized to MiroShark/MiroShark org URL
- 10 files in miroshark-aeon tooling/catalog updated to aeonfun/aeon
- Deploy buttons (Railway, Render, Cloudflare) now point at correct org URLs
- repo-pulse toggled off in miroshark-aeon aeon.yml

Stats: 28 files changed, +44/-44 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-07-14.md
