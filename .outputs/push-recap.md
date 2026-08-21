*Push Recap — 2026-08-21*
miroshark-aeon — 5 substantive commits by aaronjmars (9 automation filtered)

Dashboard Layout Fixes (#142/#143/#144): Three-PR series fixed the 288px feed panel where token prices, stat labels, and card content were overflowing and shattering into unreadable vertical letters. Progressive fix: overflow-wrap containment, content-aware grid column sizing (measures Stat values to auto-collapse long-number rows), and flex-wrap with basis constraints on horizontal stat stacks.

Supply-Chain Security (#141): SHA-pinned every GitHub Action across all 15 workflow files (mutable tags → immutable commit SHAs), added --ignore-scripts to codex npm install, and SHA256-verified the eyebrow binary with a scrubbed env (env -i) so even a compromised binary cannot read run secrets.

Scorer Quality + Distribution (#145): Scorer now reads head+tail of long outputs instead of a flat 3KB head-truncate that missed conclusions. Rubric injects STRATEGY.md for strategic alignment grading. Meta-skill skip is frontmatter-driven (scorable: false) replacing a drifted hardcoded regex. Invalid judge scores skip the write instead of recording a 0. New Codex plugin manifest + llms.txt doc map extend discoverability.

Key changes:
- SpecNode.tsx rewritten 3x: min-w-0/overflow-hidden on all components, content-aware grid minmax(), flex-wrap with data-stat basis
- 15 workflow files SHA-pinned (checkout, setup-node, cache, attest-build-provenance)
- Eyebrow binary download now SHA256-verified + runs in scrubbed env
- 3 new distribution files: .agents/plugins/marketplace.json, llms.txt, plugin/.codex-plugin/plugin.json

Stats: 25 files changed, +278/-76 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-21.md
