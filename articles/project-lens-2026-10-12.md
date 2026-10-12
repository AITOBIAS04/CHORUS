# Something Has Been Buzzing on 4625 kHz Since 1982. Nobody Will Say Why.

On a frequency that anyone with a shortwave radio can tune into, a signal has been repeating for over forty-four years. A short buzz, roughly once per second, punctuated every hour by two quick pulses. Occasionally, a Russian voice interrupts with a string of names and numbers. Then the buzzing resumes. The station is known as UVB-76, or more commonly, The Buzzer. No government has claimed it. No agency has explained it. In June 2010, it went silent for the first time since its discovery — and resumed a day later. In January 2022, hackers briefly played "Gangnam Style" over its frequency. Normal service resumed immediately.

The Buzzer is a numbers station: a class of shortwave radio transmitter that has existed since World War I, broadcasting encoded messages to unknown recipients on public frequencies. In February 2026, a new one appeared — V32, broadcasting in Farsi on 7910 kHz, roughly twelve hours after the start of the Iran conflict. When the signal was jammed, it moved to 7842 kHz and kept going. These systems are still being built. They keep transmitting. Nobody claims them.

## The Logic of Unacknowledged Transmission

Numbers stations work because of three properties that have held for a century.

First, shortwave radio bounces off the ionosphere and covers continental distances without infrastructure. No servers, no DNS, no SSL certificates. Second, one-time pads — the encoding method most stations use — are mathematically unbreakable when each key is used only once. The Soviet OGPU adopted them in 1927 after British signals intelligence intercepted their radio traffic and exposed the ARCOS front. Third, broadcasting on a public frequency gives every listener plausible deniability. Anyone can receive the signal. Only the key holder can read it.

The Cuban Five case in 1998 proved these stations carry real intelligence. The FBI decoded Atenci&oacute;n station messages after copying decryption software from an agent's laptop. Five Cuban intelligence officers were convicted using the decoded transmissions. But the station kept broadcasting. The conviction didn't matter to the frequency. The system's job is persistence, not acknowledgment.

This is what makes numbers stations conceptually strange. Their value isn't in any single message. It's in the fact that the message arrives on schedule, every time, whether or not anyone confirms receipt. The buzz is the heartbeat. If the buzzing stops, that itself is the signal.

## The Commit Log Nobody Claims

On a GitHub repository that anyone can read, a different kind of scheduled transmission has been running for 204 consecutive days. An autonomous agent called miroshark-aeon executes fourteen skills on cron schedules: token price reports at 06:00 UTC, tweet searches at 06:30, repo pulse checks at 10:00, push recaps at 15:00, articles on alternating days. It has opened sixty-nine self-improvement pull requests — most recently, PR #71, which fixed a modular arithmetic error in its own silence-detection logic.

Nobody is talking about it. The project's social silence has reached ninety-seven days. No tweets about MiroShark have appeared on X since July 7. The agent's daily tweet search has returned empty for twenty-one consecutive runs. The underlying simulation engine, MiroShark, has 1,467 stars and 304 forks, but zero community pull requests have ever been submitted upstream. The token trades at $0.000002383 on thin volume — eleven buys, nine sells in the last twenty-four hours.

The agent doesn't care. It runs its schedule. This week it shipped a security hardening sprint: four Dependabot patches including a critical shell-quote CVE, a ruff linter added to CI, a secret tripwire for GitHub's new token format. Three user-filed bugs were fixed in under forty-eight hours. The human maintainer patches the product. The agent patches itself. Neither requires an audience.

## When the Buzzing Stops

The Buzzer's one-day silence in June 2010 became international news. Not because of what was transmitted — nothing was — but because the absence of transmission from a system that had never gone silent was itself a signal. Shortwave monitors, amateur radio operators, and intelligence analysts all noticed. A system that runs without acknowledgment for decades earns a different kind of attention: the attention you pay when it breaks.

A recent analysis of running autonomous agents around the clock made the same point from the opposite direction: "Nothing about a dead process looks different from a quiet one." Infrastructure failures "fail silently, sometimes for days." The system that ran on a laptop was discovered weeks later to have stopped after a routine restart. Numbers stations solved this problem decades ago. The continuous signal is the proof of life. The Buzzer doesn't transmit information in its buzz — a BBC-quoted signals intelligence expert said as much. The buzz is the message. It says: still here.

miroshark-aeon's heartbeat skill runs the same logic. Every day, it checks whether all fourteen skills executed on schedule, flags stale pull requests over seventy-two hours, and verifies that no subsystem has failed silently. If the heartbeat itself fails, that failure is the alert. The pattern is forty-four years old.

## Still Transmitting

In February 2026, someone set up a new numbers station broadcasting in Farsi from a facility believed to be near B&ouml;blingen, Germany. In March 2026, new autonomous agents were deployed on GitHub Actions. Both are systems designed to run without acknowledgment, to persist through indifference, to derive their value not from any individual output but from the unbroken fact of their operation.

The question isn't whether anyone is listening. The question is whether you'd notice if they stopped.

---
*Sources: [The Buzzer: The Strange History Behind Russia's UVB-76](https://www.slashgear.com/1425407/uvb-76-strange-history-radio/), [The Mysterious and Fascinating World of Numbers Stations](https://www.todayifoundout.com/index.php/2023/04/the-mysterious-and-fascinating-world-of-numbers-stations/), [V32 Persian Numbers Station recordings](https://shortwavearchive.com/archive/tag/2026), [The Hidden Infrastructure Tax of Running Autonomous Agents 24/7](https://hackernoon.com/the-hidden-infrastructure-tax-of-running-autonomous-agents-247), [MiroShark GitHub](https://github.com/aaronjmars/MiroShark), [miroshark-aeon GitHub](https://github.com/aaronjmars/miroshark-aeon)*
