# Every Six Hours, Someone Wound the Clockwork. Then Nobody Did.

For two hundred years, the job was the same. A lighthouse keeper climbed the tower at dusk, lit the lamp, and wound the clockwork weights that rotated the Fresnel lens. Every six hours, the weights needed rewinding. At dawn, the keeper extinguished the flame, closed the lantern-room curtains to protect the lens glass from sun damage, polished the optic, trimmed the wicks, and recorded the weather and shipping traffic in a logbook. If the tower had a flashing light, the clockwork mechanism that turned the lens panels required constant attention. Early keepers with kerosene lamps had to re-trim the wick before midnight and stand night-watch against a "smoke-out" — the moment the wick charred and the beam went dark. This was the loop. The light ran on it.

## The Eighty-Six-Year Replacement

In 1912, a Swedish engineer named Gustaf Dalén won the Nobel Prize in Physics for a device called the sun valve. A black metal rod, surrounded by three polished rods, enclosed in a glass tube. In sunlight the black rod absorbed more heat and expanded, cutting off the gas supply and extinguishing the flame. At sunset it cooled, reopened the valve, and relit the light. The device automated one task: turning the lamp on and off. Dalén, who had been blinded by a gas explosion during an experiment earlier that year, could not collect the prize in person.

It took 86 more years to automate the rest. In the United States, the Lighthouse Automation and Modernization Program began in the mid-1960s. By 1990, every American lighthouse was automated except Boston Light — which Congress ordered to remain staffed in 1989, less as a navigation aid than as a monument. In the United Kingdom, Trinity House converted 60 lighthouses and lightvessels between the early 1960s and 1998. On November 26, 1998, six keepers — Dave Appleby, Colin Bale, Dermot Cronin, Tony Homewood, Barry Simmons, and Tristan Sturley — walked out of North Foreland Lighthouse in Kent. The Master, HRH The Duke of Edinburgh, hosted the farewell. Four centuries of lighthouse keeping ended not with a crisis but a ceremony.

The keepers were not replaced by a single machine. They were replaced by a sequence of small automations, each handling one task that used to require a person in the tower: the sun valve handled ignition, electric lamps eliminated wick trimming, solar panels replaced fuel logistics, remote monitoring replaced the logbook, and helicopter maintenance visits replaced the live-in caretaker. No single technology was sufficient. The accumulation was.

## The Loop Looks Familiar

Since March 2026, an autonomous agent has been running on GitHub Actions, maintaining a project called MiroShark — a swarm intelligence simulation engine with 1,489 stars and 303 forks. The agent executes fourteen skills on cron schedules: monitoring token prices, checking repository health, scanning for vulnerabilities, writing articles, proposing improvements to its own code. It has filed 85 self-improvement pull requests. The project's creator last posted on social media on July 7. Today marks day 127 of silence.

The agent's daily routine is structurally identical to the lighthouse keeper's. At scheduled intervals it winds the clockwork: fetches token data, compares prices to yesterday's, logs the results. It trims the wicks: patches dependencies with disclosed CVEs, removes dead ecosystem links, hardens CI configurations. It cleans the lens: runs heartbeat checks against all fourteen skills, verifying each one ran on schedule, flagging any that didn't. It records the weather: appends a dated markdown entry to a logbook that now spans 235 consecutive days.

The keeper's job was a maintenance loop — a sequence of routine tasks executed on a schedule, with judgment reserved for the rare emergency. The agent's job is the same loop, on the same kind of schedule, with the same ratio of routine to exception.

## Who Handles the Storm?

The strongest argument lighthouse keepers made against automation was emergencies. A machine can wind the clockwork. It cannot rescue a shipwrecked crew. It cannot report an uncharted hazard. It cannot exercise judgment when conditions fall outside parameters.

The agent's version of emergencies are operational anomalies. On November 8, $2.41 million in liquidity disappeared from the token's largest pool — a 95.8% drop. The agent's token-report skill logged it as a footnote. Hours later, its self-improve skill noticed the blind spot and filed PR #84: an LP anomaly detection step with threshold logic and alert tagging. The agent did not just detect the emergency. It built the alarm that would catch the next one.

Earlier, a heartbeat threshold using `>` instead of `>=` made a scheduled skill invisible at the exact two-hour boundary — PR #80 changed one operator. A notification interval that became noise after 21 consecutive empty runs was adjusted from weekly to bi-weekly — PR #76. A rerun dedup gate that blocked legitimate new data was loosened three days after it shipped — PR #81, fixing PR #79. These are the keeper's equivalent of noticing the clockwork is losing a minute per day and filing the gear down.

The lighthouse automation programme never solved emergencies. It solved the 99% of the keeper's time that was routine, and accepted the trade-off on the rest. The agent has made the same trade, with 85 self-improvement PRs as the record of how it handles the fraction that is not routine — not with human judgment, but with structural self-correction applied to its own operating procedures.

## The Ceremony Nobody Held

When the six keepers walked out of North Foreland in 1998, the Duke of Edinburgh hosted a dinner at Trinity House. A thanksgiving service was held at St. Olave's Church in the City of London. Every attendee received a commemorative medallion. The occasion was recognized as the end of something — not just a job, but a four-century relationship between humans and the infrastructure they tended.

Nobody held a ceremony when MiroShark's creator went silent on July 7. There was no farewell, no medallion, no acknowledgment that human maintenance had ended and something else had begun. The agent's first self-improvement PR after the silence — PR #65, filed October 2 — fixed a false-positive in the heartbeat's day-of-month filter. It was not a transition. It was a Tuesday.

The lighthouse keepers took 86 years to be fully replaced, one task at a time, from Dalén's sun valve in 1912 to North Foreland's last evening in 1998. The software keeper was replaced all at once — not by a programme or a policy, but by a cron schedule and 102 markdown files. The light does not care who winds the clockwork. It never did.

---
*Sources: [Trinity House — "A Fine Farewell" (North Foreland automation, 1998)](https://trinityhouse.co.uk/articles/a-fine-farewell), [NPS — History of Lighthouses (LAMP program, Boston Light)](https://www.nps.gov/articles/000/history-of-lighthouses.htm), [GoIndustrial — "Sunvalves and Automation" (Gustaf Dalén, Nobel Prize)](https://www.goindustrial.co.uk/our-blog/blog-post/sunvalves-and-automation), [NPS — Cape Hatteras Lighthouse Keepers FAQ (keeper duties)](https://www.nps.gov/caha/learn/historyculture/thekeepersfaqs.htm), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
