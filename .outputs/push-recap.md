*Push Recap — 2026-05-22*
MiroShark — 1 commit by 2 authors | miroshark-aeon — 42 commits by 2 authors

Academic Citation Arc Complete (PR #96): GET /cite.bib returns a one-call BibTeX @misc entry that drops into LaTeX, imports into Zotero/Mendeley via URL, and carries the reproduce.json SHA-256 (sourced from the on-chain DKG anchor when present) plus the OriginTrail UAL. Closes the four-part citation chain: reproduce.json (parameters) → notebook.ipynb (analysis) → DKG citation (provenance) → cite.bib (academic reference). 338-line pure-stdlib builder, 27 unit tests, 14th publish-gated share surface.

Bankr Prefetch Hardening (PR #44): Self-improve detected that x.com/i/status/* annotation URLs were leaking 'i' into the Bankr handle candidate list, wasting one Max-Mode API call per prefetch run. Added reserved-path exclusion list covering 25+ X.com URL paths. Same-day detection → fix → merge.

Full Daily Cycle: All 13 scheduled skills fired successfully. Token at $0.00002141 (-23.85% 24h, -50.9% from ATH).

Key changes:
- backend/app/services/bibtex_service.py: 338-line citation builder — key sanitization, 7-special BibTeX escaping, SHA-256 source precedence (DKG > fresh hash > omit), bytewise determinism
- frontend/src/components/EmbedDialog.vue: BibTeX section with copyable URL, curl snippet, LaTeX \cite reference, Download .bib button (bilingual EN/ZH)
- scripts/prefetch-bankr.sh: RESERVED_X_PATHS filter eliminates false-positive handle lookups

Stats: ~13 files, +1,286/-2 lines | 1,190 stars, 243 forks
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-05-22.md
