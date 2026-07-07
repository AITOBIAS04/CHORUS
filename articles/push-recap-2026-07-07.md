# Push Recap — 2026-07-07

## Overview
1 substantive commit by 1 author across the watched repos today (9 automation commits filtered). The sole change is a targeted bug fix from Daniel Andersen: repairing malformed tool_call arguments that DeepSeek-V4-Flash has been silently corrupting, which caused 10–20% of agent actions to drop per simulation round.

**Stats:** 3 files changed, +128/-5 lines across 1 substantive commit

---

## aaronjmars/MiroShark

### Bug Fix: DeepSeek-V4-Flash Tool Call Argument Repair
**Summary:** DeepSeek-V4-Flash reliably appends stray trailing data after otherwise-valid JSON in tool_call arguments (e.g. `'{}""'` for zero-arg calls like `do_nothing`, `trend`, `refresh`). CAMEL's `json.loads()` rejects these outright, silently dropping the agent's action for that round. This showed up as ~10–20% "errors" in run_summary with no indication of what the model actually returned. PR #241 adds a recovery layer that intercepts and repairs these before CAMEL ever sees them.

**Commits:**
- `3518a80` — Fix/social agent tool messages (#241)
  - Modified `backend/app/utils/llm_message_filter.py`: Added new `repair_tool_call_arguments()` function — uses `json.JSONDecoder().raw_decode()` to extract the first valid JSON value and discard trailing garbage. Returns the repaired JSON and the dropped suffix, or `None` if arguments are already valid or unrecoverable. Module docstring updated to reflect broader scope ("Message and tool-call sanitation"). (+29/-3 lines)
  - Modified `backend/wonderwall/social_agent/agent.py`: Added two new methods to `SocialAgent` — `_repair_tool_call_arguments()` iterates each tool_call in the model response and repairs recoverable arguments with a warning log; `_handle_batch_response()` wraps CAMEL's response parsing with the repair step first, and when a `json.JSONDecodeError` still occurs, surfaces the raw `tool_calls`, `content`, and `reasoning_content` in the error log instead of just the decode error message. (+64/-1 lines)
  - Modified `backend/tests/test_unit_social_agent_messages.py`: Added 4 new unit tests covering the repair helper — valid arguments left untouched, trailing garbage dropped (the `'{}""'` DeepSeek regression case), first-value-kept-and-reserialized, and unrecoverable arguments returning `None`. Tests exercise the dep-free helper directly so the offline unit-test job (no camel-ai/numpy) can run them. (+35/-1 lines)

**Impact:** Simulations using DeepSeek-V4-Flash (the Wonderwall and web search model since PR #223's model overhaul on Jul 1) should see a meaningful reduction in dropped agent actions. The repair is surgical — only activates when trailing garbage follows valid JSON — and the improved error logging means any remaining parse failures now show what the model actually returned rather than an opaque decode error. This directly improves simulation reliability and debuggability for the Mercury 2 + DeepSeek V4 Flash model stack.

---

## aaronjmars/miroshark-aeon
0 substantive commits. 9 automation commits filtered (cron state updates, auto-commits for token-report/heartbeat/tweet-digest).

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None — `repair_tool_call_arguments` is a new export from `llm_message_filter`, and `_handle_batch_response` is an override of CAMEL's base method
- **Architecture shifts:** The `llm_message_filter` module is now the canonical home for both message filtering and tool-call sanitation, kept dependency-free for the offline test suite
- **Tech debt:** None introduced; this fix addresses tech debt from the model switch to DeepSeek-V4-Flash

## What's Next
- Monitor simulation error rates to confirm the 10–20% error drop materializes in production runs
- The `raw_decode()` approach is robust to trailing garbage but won't catch malformed JSON at the start of the string — if other providers exhibit different corruption patterns, the repair function may need extending
- Daniel Andersen continues as the most active community contributor (10+ merged PRs)
