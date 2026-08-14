*Push Recap — 2026-08-14*
MiroShark — 2 substantive commits by 2 authors
miroshark-aeon — 1 substantive commit (+ 9 automation filtered)

OrcaRouter Cloud Gateway: Marc-oss-hub landed PR #287, making OrcaRouter the 4th officially supported cloud provider. One API key covers all slots — operators can mix vendors per slot (Anthropic for reports, OpenAI for the sim loop). Full English and Chinese docs across .env.example, INSTALL, MODELS, and CONFIGURATION. First merged community contribution in weeks, from a fork created yesterday.

CI Fix (openai 3.0): openai 3.0.0 swapped its transitive dep from httpx to httpx2, breaking oracle_seed.py which imports httpx directly. Unit tests failed silently — httpx resolved to None, so resolve_oracle_tools() returned empty string. PR #288 pins httpx>=0.28,<1.0 as an explicit dependency in both requirements.txt and the CI workflow.

Token Analysis: Agent repo shipped the daily CONSOLIDATING verdict — $MIROSHARK at $0.000002015 (−17.1% 24h). Volume hit 1.98x average, just under the 2.0x BREAKDOWN threshold. $0.0000025 floor broken for the 2nd consecutive day.

Key changes:
- 8 docs/config files touched for OrcaRouter — .env.example, INSTALL, MODELS, CONFIGURATION (EN + ZH)
- httpx now an explicit dep — guards against openai SDK migration breaking direct importers
- NER reasoning caveat clarified: OrcaRouter does not inject reasoning:{enabled:false}, LLMClient strips <think> blocks client-side

Stats: 12 files changed, +189/−9 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-08-14.md
