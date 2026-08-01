# Token Report — 2026-08-01

## $MiroShark Performance

| Metric | Value | 24h Change |
|--------|-------|------------|
| Price | $0.000001728 | −6.01% |
| Liquidity (LP) | $203,111 | — |
| 24h Volume | $2,839 | — |
| 24h Buys/Sells | 8 / 28 | — |
| 24h Buyers/Sellers | 7 / 11 | — |
| 24h High/Low | $0.000001838 / $0.000001612 | — |
| FDV | $172,799 | — |

## Trend

- **24h:** Volatile session. Price opened near $0.000001838, sold off to $0.000001612 on concentrated liquidation from 0x749fe188, then recovered to $0.000001728 as that same wallet reversed and accumulated ~$517 across three buys between 06:50 and 07:11 UTC.
- **7-day:** −2.9% (Jul 25 close: $0.000001780)
- **30-day:** −58.1% (Jul 3 close: ~$0.000004129)

## Volume & Liquidity

Volume of $2,839 over 24 hours is lower than yesterday's $12,849 spike. Trade count skews heavily sell-side: 28 sells vs 8 buys, 11 sellers vs 7 buyers. By dollar volume the gap narrows — the three ETH buys from 0x749fe188 in the final hour of the window totaled ~$517, matching nearly all of the selling pressure in magnitude.

The main MiroShark/WETH pool on Uniswap v4 (Base) holds $203,111 in reserves. A USDC pool (Aerodrome Slipstream) adds $368 and a 2.5%-fee USDC pool on Uniswap v4 adds $823 more. Total LP approximately $204,302.

The defining trade sequence today: 0x749fe188 sold ~314M tokens ($526) in two transactions at Jul 31 23:30 UTC and Aug 1 00:12 UTC, compressing price to the session low of $0.000001612 — within 1% of the Jul 18 ATL. Then the same wallet bought back ~300M tokens ($517) in three rapid transactions between 06:50 and 07:11 UTC, lifting price to $0.000001728.

## Social Pulse

XAI_API_KEY not set — live social data unavailable. fetch-tweets on Jul 31 surfaced one tweet from Jul 17 (https://x.com/aaronjmars/status/2078253373459923369), breaking a 24-day search-empty streak. Today's fetch returned empty. Organic social activity remains near-absent: approximately 25 consecutive days of minimal mentions (Jul 7 – Aug 1).

## Context

$MiroShark sits at +5.8% above its all-time low FDV of $163,272 (Jul 18) and −96.0% from the May 18 ATH of $0.0000436. FDV at $172,799. The intraday round-trip by 0x749fe188 — sell to ATL-zone, then buy back within hours — is the dominant price driver today; no new organic buyers appeared to absorb the earlier sell-off. Repo activity continues: community PR #259 (Atlas Cloud provider preset) merged Jul 31; 1,413 stars and 298 forks unchanged.

---
*Data: GeckoTerminal | Chain: Base*
*Pool: MiroShark/WETH (Uniswap v4)*
*Contract: 0xd7bc6a05a56655fb2052f742b012d1dfd66e1ba3*
