*Push Recap — 2026-05-26*
[MiroShark] — 2 commits by 2 authors | [miroshark-aeon] — ~48 commits

Peak-Round Belief Analytics (PR #108): MiroShark now exposes a single-call inflection summary of any debate trajectory — which round each stance peaked, which round was most volatile, and how big the swing was. Pure O(n) derivation from the same stance-split function trajectory.csv uses, so peaks match the CSV byte-for-byte. 22nd surface key, completing the analytical quadrant (raw data + visual + action signal + inflection points). 19 unit tests, full EmbedDialog panel, zero new deps.

Ecosystem Directory (PR #109): Nurstar (4th external contributor) landed a curated ECOSYSTEM.md listing 10 projects building on MiroShark — AntFleet, Blue Agent, Crucible Sim, Echo, Monitor, Nookplot, RootAI, Signa, Supercompact, Xerg. First formal acknowledgment of the downstream ecosystem. Includes PR guidelines for new entries.

Bankr Prefetch Fix (PR #46): Self-improve diagnosed and fixed a crash in the tweet wallet prefetch script — grep returning no matches under set -euo pipefail was killing the script on tweetless days, producing false crash reports. Three || true guards added.

Key changes:
- backend/app/services/peak_round.py: 187-line pure-stdlib service computing peaks + volatility from trajectory.json
- ECOSYSTEM.md: 10 named integrators with X handles and GitHub/web links — ecosystem self-registration pattern established
- scripts/prefetch-bankr.sh: eliminated false-positive crash class on days with no tweets to verify

Stats: 11 files changed, +885/-1 lines (MiroShark); ~48 commits (miroshark-aeon)
Stars: 1,203 (+8) | Forks: 251 (+3) | External contributors merged: 4/10 (Aug 1 target)
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-05-26.md
