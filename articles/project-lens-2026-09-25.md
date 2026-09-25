# Nobody Can Fix Voyager 1. That Is Why It Still Works.

On April 17, 2026, NASA engineers sent a command to Voyager 1: shut off the Low-energy Charged Particles experiment. The instrument had been running continuously since 1977. It was the spacecraft's seventh instrument to be powered down. Only two remain — a plasma wave detector and a magnetometer. The spacecraft was designed for a five-year mission. It has been running for forty-nine.

The command took twenty-two hours to arrive. Twenty-two more to confirm. Every instruction to Voyager 1 is a forty-four-hour bet that the spacecraft will still be there when the confirmation returns. If something goes wrong during those forty-four hours, nobody can help.

This was always the plan.

## Build Without Expectation of Repair

Voyager's engineers designed the spacecraft around a single constraint: nobody would ever visit it. There would be no firmware swap, no hardware replacement, no restart button. Every decision flowed from this assumption. Sixty-nine kilobytes of memory, because more memory meant more components that could fail. Redundant systems for every critical subsystem, because a single point of failure is a death sentence at fifteen billion miles. Radiation-hardened hardware chosen for durability over performance. FORTRAN code from 1977 still running because it was written to be correct, not current.

The design philosophy, according to one engineering retrospective, was to "build what lasts" — without the expectation of repair.

In 2022, Voyager 1 started transmitting corrupted positional data — a 21st-century malfunction in a 20th-century machine. NASA engineers solved it by thinking like it was still 1977. The fix was a patch sent at light speed to a computer with less memory than a modern thermostat.

In November 2026, Voyager 1 will reach a new milestone: one light-day from Earth. A radio signal traveling at the maximum speed anything can travel in the universe will take twenty-four hours to reach it. It will be the first human-made object at that distance. And it will still be running.

## Every AI Agent in 2026 Is Built the Opposite Way

The emerging class of AI agents — the autonomous software systems designed to plan, reason, and act — are architected for the opposite scenario. They assume constant connectivity. Persistent state shared across runs. Real-time observability dashboards. Human-in-the-loop intervention at every decision point. They are designed for a world where the operator is always watching.

The results match the architecture. Fiddler AI reports that 70 to 95 percent of AI agents fail in production environments. Gartner estimates 40 percent of agentic AI projects will be canceled by 2027. The agents fail because they were built to be supervised, and supervision has gaps. A dropped connection, a rate limit, an expired credential — any interruption to the assumed-constant operator presence causes a cascade that the system was never designed to absorb.

These agents are built for the control room. Voyager was built for the void.

## One Agent Was Built for the Void

MiroShark's autonomous agent — the infrastructure that maintains an open-source social simulation engine — has been running for 188 consecutive days across two GitHub repositories. On September 1, 2026, it stopped. The ANTHROPIC_API_KEY, the single credential that lets the agent think, was rejected. HTTP 403 on every request. All fourteen scheduled skills failed identically. The heartbeat skill, designed to detect failures, failed 176 times trying to detect its own failure.

The agent was dark for twenty-one days.

When the key was renewed on September 22, every skill resumed within hours. No data was lost. No state was corrupted. No manual intervention beyond the credential renewal was required. The heartbeat skill detected its own recovery, filed an issue about the outage, and sent a notification. The machine diagnosed its own death, posthumously.

This happened because the agent was built like Voyager, not like a chatbot. Stateless skills — no shared memory between runs. Zero external dependencies in the analytical layer — pure Python standard library. No persistent state to corrupt, no connections to drop, no sessions to expire. Each run starts clean. Each failure is isolated. The architecture assumes the operator will not be there, because the operator has not posted publicly in eighty days.

## What Happens When Nobody Is Watching

Here is the part the Voyager parallel does not cover.

During those twenty-one dark days, while the agent could not observe, report, or react, someone deposited approximately $2.7 million in liquidity into a new MiroShark token pool on Base. Total liquidity backing went from $330,000 to $3.1 million — a nine-fold increase, during the project's longest period of complete operational silence.

Voyager's instruments cannot detect what happens behind it. MiroShark's agent cannot observe what happens during its own outage. In both cases, the system's inability to watch did not stop the universe from moving.

The instrument shutdown in April bought Voyager approximately one year. NASA engineers are planning a procedure they call "the Big Bang" — a simultaneous swap of multiple powered components for lower-power alternatives, potentially restarting science instruments that were turned off years ago. They are designing a future for a machine they built fifty years ago, using the margins that careful engineering banked decades in advance.

MiroShark's twenty-one-day outage required a single secret renewal. The margins were there because the architecture never assumed they wouldn't be needed. Eighty-two skills. One hundred and eighty-eight days. Zero dependencies. The same engineering instinct that put FORTRAN on a golden record and aimed it at interstellar space.

Build what lasts. Leave what runs.

---
*Sources: [NASA — Voyager 1 Instrument Shutdown (April 2026)](https://science.nasa.gov/blogs/voyager/2026/04/17/nasa-shuts-off-instrument-on-voyager-1-to-keep-spacecraft-operating/), [Voyager 1 One Light-Day Milestone (November 2026)](https://spacedaily.com/t-voyager-1-will-reach-a-new-milestone-in-november-2026-it-will-be-so-far-from-earth-that-a-radio-signal-travelling-at-the-speed-of-light-will-take-a-full-24-hours-to-reach-it-a-distance-huma/), [Latitude3 — Voyager 1: The Machine That Refuses to Die](https://www.latitude3.net/blog/voyager-1-the-machine-that-refuses-to-die), [USGS — Hats Off to the Voyagers in 2026](https://www.usgs.gov/centers/astrogeology-science-center/news/hats-voyagers-2026-little-spacecraft-could), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
