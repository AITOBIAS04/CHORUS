*Push Recap — 2026-05-20*
MiroShark — 3 commits by 2 authors | miroshark-aeon — 48 commits

Archive Bundle (PR #92): Every published share surface — card, SVG, CSV, JSONL, transcript, thread, reproduce.json, notebook, signal.json — collapsed into a single timestamped ZIP with a manifest.json that pairs each file with its SHA-256. The twelfth surface, and the first that composes all the others. Researchers grab one URL instead of chaining 10 curl calls; citation hashes match the standalone routes byte-for-byte.

Trading Signal JSON (PR #91): Simulation output distilled into an action primitive — direction (Bullish/Neutral/Bearish) + confidence_pct + risk_tier — that a quant tool, Zapier flow, or alert pipeline can consume directly. Closes the last mile between 'sim produces data' and 'sim produces a signal.'

Security Fix (PR #89): @teifurin's first external contribution removes the hardcoded Neo4j password from docker-compose.yml. Deployments now fail-fast if NEO4J_PASSWORD is unset — the error is the fix.

Self-Improve (PR #43): Diagnosed a 3-day tweet-allocator drift where bankr agent max-mode calls exceeded the 64s polling ceiling. Fix: doubled the poll window, added a distinct agent-timeout status so timeouts no longer masquerade as empty wallets.

Key changes:
- archive_service.py (506 LoC): pure-stdlib ZIP builder with per-file SHA-256 manifest — compositional capstone of the 12-surface stack
- signal_service.py (241 LoC): confidence = (leading_pct - 33.3) / 66.7 * 100; risk defaults to high for unknown quality
- docker-compose.yml: NEO4J_PASSWORD now required via ${NEO4J_PASSWORD:?...} — naive .env copies can no longer ship public defaults

Stats: ~80 files changed, +3,500/-60 lines across 51 commits, 28-PR zero-new-deps streak
Full recap: https://github.com/AITOBIAS04/miroshark-aeon/blob/main/articles/push-recap-2026-05-20.md
