---
name: fetch-tweets
description: Search X/Twitter for tweets about a token, keyword, username, or topic
var: ""
---
> **${var}** — Search query for X/Twitter. **Required** — set your query in aeon.yml.

Today is ${today}. Search X for tweets matching **${var}**.

## Steps

1. **Build the search prompt for Grok.** The prompt sent to Grok must be specific enough to get relevant results:
   - If the query mentions a token/cashtag/crypto: include "crypto token", the chain name, and the contract address from `memory/MEMORY.md` in the Grok prompt. This eliminates false matches.
   - Example: instead of searching "aeon", search "the $AEON crypto token on Base chain (contract 0xbf8e...) in the last 7 days. Only return tweets about the cryptocurrency."

2. **Load previously-reported tweet URLs** from the last 3 days of `memory/logs/`. Grep each log file for lines that match `https://x.com/` — collect all tweet URLs already reported. You'll use these to filter duplicates in step 4.

3. **Search tweets.** Use whichever path is available:

   **Path A — X.AI API** (preferred, use when `XAI_API_KEY` is set):
   ```bash
   FROM_DATE=$(date -u -d "7 days ago" +%Y-%m-%d 2>/dev/null || date -u -v-7d +%Y-%m-%d)
   TO_DATE=$(date -u +%Y-%m-%d)
   curl -s -X POST "https://api.x.ai/v1/responses" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $XAI_API_KEY" \
     -d '{
       "model": "grok-4-1-fast",
       "input": [{"role": "user", "content": "YOUR_SEARCH_PROMPT_HERE. Date range: '"$FROM_DATE"' to '"$TO_DATE"'. Return 10 tweets — prioritize the most interesting, insightful, or highly-engaged posts. For each tweet include: @handle, the full text, date posted, engagement (likes/retweets if available), and the direct link (https://x.com/handle/status/ID). Return as a numbered list."}],
       "tools": [{"type": "x_search"}]
     }'
   ```
   Parse the response JSON to extract the text from the output array:
   ```bash
   echo "$RESPONSE" | jq -r '.output[] | select(.type == "message") | .content[] | select(.type == "output_text") | .text'
   ```

   **Path B — WebSearch fallback** (use when `XAI_API_KEY` is NOT set):
   Use the built-in WebSearch tool to search for recent tweets. Construct a query like:
   `site:x.com "${query_terms}" after:${FROM_DATE}`
   Note at the top of the log entry: "XAI_API_KEY not available; results compiled via WebSearch". WebSearch rankings favour high-engagement older tweets — **prioritise results that mention a date within the last 48 hours** when possible.

   **Query cap: run at most 3 WebSearch queries per execution.** WebSearch rarely surfaces fresh tweets — more queries just burn compute for the same stale results. Use your 3 queries wisely: one broad match (`site:x.com "${primary_term}"`), one with date constraint (`after:${FROM_DATE}`), and one variant (cashtag, handle, or alternate phrasing). If all 3 return nothing new, stop searching.

4. **Deduplicate against previously-reported tweets** (from step 2):
   - Compare each candidate tweet URL against the collected set of already-reported URLs.
   - Remove any tweet that was already reported in the last 3 days.
   - If ALL tweets found are already in the recent logs: log "FETCH_TWEETS_NO_NEW: all results already reported" to `memory/logs/${today}.md` and **stop here — do NOT send any notification**.

4b. **Freshness gate (WebSearch only).** WebSearch favours high-engagement older content — tweets from months ago routinely pass the dedup filter because they were never reported recently. After dedup, check each remaining tweet's posted date (from the WebSearch snippet date, tweet text, or surrounding context). **Discard any tweet posted more than 14 days before ${today}.** Log discarded stale tweets: "Excluded N stale tweets (older than 14d): [URLs]". If you cannot determine a tweet's date and it looks like older high-engagement content (e.g. status IDs much lower than recent tweets, topics from months ago), discard it. If all remaining tweets are stale, proceed to step 5 (treated as empty).

5. **If no relevant tweets found** (no results, API error, or empty after dedup/freshness filtering): log "FETCH_TWEETS_EMPTY" to `memory/logs/${today}.md`.

   **Prolonged silence escalation.** After logging FETCH_TWEETS_EMPTY, count the number of consecutive days with FETCH_TWEETS_EMPTY in `memory/logs/`. Scan backward from today through recent log files — stop counting when you find a day without FETCH_TWEETS_EMPTY (or a day with actual tweet results). If the consecutive empty count is a **multiple of 7** (7, 14, 21, …), send a single notification via `./notify`:
   ```
   *Social Monitor Dark — ${consecutive_count} consecutive days*

   fetch-tweets has found zero new mentions for ${consecutive_count} straight days.

   Likely cause: XAI_API_KEY not set — WebSearch fallback rarely surfaces fresh tweets.
   Fix: Set XAI_API_KEY in repo secrets to enable direct X/Twitter search via Grok.
   ```
   This ensures the operator learns the monitoring channel is blind without spamming daily. If the count is NOT a multiple of 7, **stop here — do NOT send any notification**.

6. **Save the results** (new tweets only) to `memory/logs/${today}.md`.

7. **Send a notification via `./notify`** with the top NEW tweets. Each tweet MUST include a clickable link. Use Telegram Markdown link format: `[link text](url)`.

   Format the notification like this:
   ```
   *Top Tweets — ${var} (${today})*

   1. x.com/handle — [brief summary of tweet content]
   Likes: X | RTs: Y
   [View tweet](https://x.com/handle/status/ID)

   2. x.com/handle — [brief summary]
   Likes: X | RTs: Y
   [View tweet](https://x.com/handle/status/ID)

   3. x.com/handle — [brief summary]
   Likes: X | RTs: Y
   [View tweet](https://x.com/handle/status/ID)

   ... (up to 5 tweets)
   ```

   IMPORTANT: Do NOT use @handle format — it tags/pings users on Telegram. Use x.com/handle instead (shows the profile URL without tagging anyone). The `[View tweet](URL)` link is required so users can tap to open each tweet.

## Environment Variables Required

- `XAI_API_KEY` — X.AI API key (optional; skill falls back to WebSearch when not set, but quality is lower)
