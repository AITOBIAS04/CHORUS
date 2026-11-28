# Token Report — 2026-11-28

## ⚠ LP ALERT — $MiroShark

**mmETH pool completely absent from GeckoTerminal API.** Total visible liquidity dropped 97.4% overnight — from $2,473,957 (Nov 27) to $63,218. The mmETH pool, which had been stable at ~$2.41M with zero trades since at least November 20, is no longer returning data from the API. This may indicate pool migration, LP withdrawal, or a GeckoTerminal data failure. The WETH active trading pool remains intact at $63,197.

---

## $MiroShark Performance

| Metric | Value | 24h Change |
|--------|-------|------------|
| Price | $0.000000986032 | +2.29% |
| Active Pool LP (WETH) | $63,197 | — |
| Total Visible LP | ~$63,218 | −97.4% (LP ALERT) |
| 24h Volume | $12,477.06 | — |
| 24h Buys/Sells | 42 / 14 | — |
| 24h High/Low | $0.000001028 / $0.000000875 | — |
| FDV | $98,603 | — |

## Trend

- **24h:** Recovered from an intraday low of $0.000000875 to close the day at $0.000000986. Net buy pressure (42 buys vs 14 sells) drove the +2.29% move. 0x796eff wallet placed two buys ($623 and $820) during the recovery window.
- **7-day:** −8.0% (from $0.000001072 open Nov 21)
- **30-day:** −47.0% (from $0.000001860 Oct 29 close)

## Volume & Liquidity

24h volume of $12,477 is comparable to yesterday's $10,527 — elevated relative to the quiet $234–$948 range seen Nov 23–25. Buy/sell ratio strongly favors buyers (42/14, 75% buys). Notable trades:
- 0x796effe3: two buys totaling ~$1,443 (cycling wallet pattern seen prior days)
- 0x4b5c33c3: buy $36.99
- 0x331d9a: buy $313.93
- 0xd840dbe7: sell $566.67
- 0x63256d: sell $329.27

**LP situation:** The active WETH pool ($63,197) is functioning normally and driving all 24h volume. The mmETH pool (consistently ~$2.41M, zero trades Nov 20–27) has disappeared from GeckoTerminal's pool list entirely. It did not appear in the top-pools relationship of the token endpoint or in the first page of pools. This is the same type of event flagged in the LP anomaly detection system (self-improve PR #84). The mmETH pool's absence reduces total visible LP by 97.4%.

## Social Pulse

XAI_API_KEY not set — social data unavailable. Social silence: 144 consecutive days (Jul 7 – Nov 28). No change in silence status.

## Context

FDV at $98,603 is the closest to $100K recovery since the token broke below that threshold on Nov 21 (day 8 sub-$100K). It needs +1.4% from current price to reclaim $100K FDV. The Nov 30 external PR hyperstition closes in 2 days (304 forks, 0 external PRs). Stars at 1,494 — 6 needed to reach 1,500 by Dec 7 (9 days). The 2× price hyperstition target remains $0.0000018120, requiring +83.6% from current price.

---
*Data: GeckoTerminal | Chain: Base*
*Contract: 0xd7bc6a05a56655fb2052f742b012d1dfd66e1ba3*
