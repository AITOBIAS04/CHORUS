# Push Recap — 2026-07-01

## Overview
1 substantive commit by 1 author (9 automation commits filtered). Today's sole push was a significant model lineup overhaul — MiroShark's default Cloud preset moved away from Xiaomi's Mimo V2.5 entirely, swapping in Inception's Mercury 2 (a diffusion LLM) for the base slot and DeepSeek V4 Flash for the simulation loop and web search. Smart and NER slots stay on Gemini 3 Flash.

**Stats:** 12 files changed, +57/-52 lines across 1 substantive commit

---

## aaronjmars/MiroShark

### Model Lineup Overhaul: Mimo V2.5 → Mercury 2 + DeepSeek V4 Flash
**Summary:** PR #223 completely replaces the default model stack. The base persona/sim-config slot moves from `xiaomi/mimo-v2.5` to `inception/mercury-2:nitro`, a diffusion LLM chosen for raw speed rather than report quality. The Wonderwall simulation loop (850+ calls per run, the #1 cost driver) and web search slot both move from Mimo V2.5/Gemini 3 Flash to `deepseek/deepseek-v4-flash` (`:nitro` for sim, `:online` for web research). Smart and NER stay on `google/gemini-3-flash-preview`.

**Commits:**
- `2895fb0` — chore(config): switch default model lineup (#223)
  - Changed `backend/app/config.py`: All four model slots now carry explicit defaults instead of empty-string inherit. `LLM_MODEL_NAME` defaults to `inception/mercury-2:nitro`, `WONDERWALL_MODEL_NAME` to `deepseek/deepseek-v4-flash:nitro`, `WEB_SEARCH_MODEL` to `deepseek/deepseek-v4-flash:online`, `SMART_MODEL_NAME` and `NER_MODEL_NAME` to `google/gemini-3-flash-preview`. Comments rewritten to explain the "set empty to inherit" pattern (+17/-14 lines)
  - Changed `backend/app/api/settings.py`: Cloud preset label updated and all four model fields in the `_PRESETS['cheap']` dict swapped to new models (+4/-4 lines)
  - Changed `backend/app/utils/run_summary.py`: Added OpenRouter pricing entries for `inception/mercury-2` ($0.25/$0.75 per M) and `deepseek/deepseek-v4-flash` ($0.098/$0.196 per M); old Mimo V2.5 entry kept under "legacy" section (+4/-2 lines)
  - Changed `backend/app/utils/url_fetcher.py`: Updated fallback error message and docstring from Gemini to DeepSeek model name (+2/-2 lines)
  - Changed `.env.example`: Active Cloud block now shows Mercury 2 + DeepSeek V4 Flash; header updated (+5/-5 lines)
  - Changed `docs/MODELS.md` + `docs/MODELS.zh-CN.md`: Model comparison tables, Cloud-mode lineup, and slot descriptions updated across both English and Chinese versions (+10/-10 lines)
  - Changed `docs/INSTALL.md` + `docs/INSTALL.zh-CN.md`: Quick-start instructions and OpenRouter example configs updated in both languages (+8/-8 lines)
  - Changed `docs/CONFIGURATION.md` + `docs/CONFIGURATION.zh-CN.md`: Commented-out example values updated in both languages (+6/-6 lines)
  - Changed `frontend/src/components/SettingsPanel.vue`: Wonderwall model placeholder text updated to `inception/mercury-2:nitro` (+1/-1 lines)

**Impact:** Every new MiroShark deployment now runs on a three-model stack (Mercury 2 / Gemini 3 Flash / DeepSeek V4 Flash) instead of the previous two-model stack (Mimo V2.5 / Gemini 3 Flash). The config layer also becomes more explicit — each slot carries its own default rather than silently inheriting from the base LLM when left blank, which makes the behavior clearer for operators who only set some slots. Cost estimates stay accurate via new pricing entries in `run_summary.py`. Existing deployments with explicit `.env` values are unaffected.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None for existing deployments (`.env` values override defaults). Fresh installs will use the new models automatically.
- **Architecture shifts:** Config defaults changed from empty-string-means-inherit to explicit-default-means-inherit-only-when-set-empty. This is a subtle semantic shift — operators who relied on blank slots falling through to LLM_MODEL_NAME will now get per-slot defaults instead.
- **Tech debt:** PR notes that `FAST_SMART` and `TRANSLATION` slots from a "target lineup" are intentionally omitted — they don't exist in code yet and need wiring.

## What's Next
- The `FAST_SMART` and `TRANSLATION` model slots mentioned in the PR body suggest a further model specialization pass is planned — new slots need code wiring before values can be swapped in.
- DeepSeek V4 Flash at $0.098/$0.196 per M tokens vs Mimo V2.5 at $0.14/$0.28 should reduce per-run simulation costs — expect updated cost benchmarks.
- PR #21 in CHORUS (reset poisoned cron-state success rates + counter hygiene) remains open.
