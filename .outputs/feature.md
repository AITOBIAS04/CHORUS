*Feature Built — 2026-05-06*

One-Click Share to X (Tweet Composer)
Every MiroShark simulation now has a one-click "Post to X" button that opens a pre-filled tweet composer. The tweet includes the scenario excerpt, the consensus outcome (bullish/bearish/contested with round count), a share link that auto-unfurls with the OG card, and the #MiroShark hashtag. No copying, no composing — one click from results to tweet.

Why this matters:
MiroShark already has shareable URLs (PR #71) and OG cards that unfurl on Twitter (PR #42), but there was still friction: users had to manually compose a tweet, paste the link, and write something interesting about the simulation. With the founder's Twitter account being the primary organic discovery channel, removing this friction is a direct distribution multiplier. Every simulation result is now one click from becoming a tweet — and with 1,064 stars and growing, the community running simulations daily can now amplify organically without manual effort.

What was built:
- EmbedDialog.vue: New "Post to X" section with dark X-branded styling. Shows a live tweet preview (scenario excerpt truncated to 80 chars + consensus summary + share URL + #MiroShark). Opens twitter.com/intent/tweet in a new tab. Gated on the simulation being public, same as all share surfaces.
- ExploreView.vue: Hover-visible X icon overlay on each gallery card thumbnail. Same tweet template, composed from the gallery item's metadata (scenario, final_consensus, simulation_id). Turns gallery browsing into a distribution surface.
- Both surfaces include full zh-CN localization — Chinese-mode simulations compose the tweet in Chinese.

How it works:
The feature uses Twitter's intent URL API (twitter.com/intent/tweet?text=...&url=...) — pure client-side, no API key, no backend changes, no secrets. The tweet text is composed from the simulation's embed summary data (scenario, belief percentages, round count). Consensus is classified as bullish (≥65%), bearish (≥65%), or contested, and formatted as a human-readable outcome. The share landing URL is passed separately so Twitter auto-appends it and unfurls the OG card (the 1200×630 PNG from PR #42). The gallery surface computes the same template from the public gallery item data without an extra API call.

What's next:
Code complete (250 lines, 2 files), committed locally on feat/share-to-x. Push blocked — GH_GLOBAL secret still not set (6th consecutive block since May 1). Setting the secret would unblock this PR and 5 others.
