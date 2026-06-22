# It Took 64,000 People to Forecast the Weather. It Takes Twelve Agents to Forecast an Opinion.

In 1922, Lewis Fry Richardson published a book that contained both the worst weather prediction ever made and the most prescient vision in computational history. *Weather Prediction by Numerical Process* laid out, in painstaking mathematical detail, how to forecast the atmosphere by solving differential equations across a grid of the entire planet. Richardson knew no human could do this fast enough. So he imagined a building.

A circular hall, like a theater, with galleries running all the way around — except instead of a stage, the walls and ceiling are painted with a map of the globe. The ceiling is the North Pole. England sits in the gallery. The tropics wrap around the upper circle. Antarctica fills the pit. At every point on this map sits a human computer, working equations with a slide rule, calculating the weather for the patch of atmosphere directly above. Sixty-four thousand people, computing in parallel, coordinated by a director standing on a tower at the center of the hall — "like the conductor of an orchestra in which the instruments are slide-rules and calculating machines." He shines a red spotlight on anyone racing ahead. A blue spotlight on anyone falling behind.

Richardson called it a fantasy. He had tried the math himself — spending six weeks during World War I computing a single six-hour pressure forecast for a single point on the map, armed with nothing but a slide rule and a table of logarithms. The result was catastrophically wrong: a pressure change of 145 millibars, roughly one hundred times larger than anything that actually occurs in the atmosphere. The initial data was too sparse, the grid too coarse, the equations too sensitive. Critics used the failure to dismiss the entire enterprise. You cannot predict the weather with mathematics. Too many variables. Too much chaos.

## Twenty-Eight Years and One Machine

It took until 1950 for someone to prove Richardson right. Jule Charney, a meteorologist at Princeton's Institute for Advanced Study, simplified Richardson's equations into a form that a machine could run. The machine was ENIAC — the U.S. Army's Electronic Numerical Integrator and Computer, thirty tons of vacuum tubes and patch cables filling a room the size of a small apartment. Charney's team ran four twenty-four-hour weather forecasts. The calculations took more than twenty-four hours of continuous runtime, including several breakdowns. The forecasts were slower than the weather they predicted.

But they worked. The predictions matched observed atmospheric patterns closely enough that the Joint Numerical Weather Prediction Unit was established four years later, and by 1958 operational forecasts showed "steadily increasing and useful skill." Richardson's 64,000 human computers had been replaced by one electronic one.

The next conceptual leap came decades later: ensemble forecasting. Instead of running a single simulation with a single set of initial conditions, forecasters run dozens or hundreds of simulations, each with slightly perturbed starting data. The atmosphere is chaotic — small differences in initial measurements produce wildly different outcomes. A single run cannot capture that uncertainty. An ensemble can. The spread between runs tells you not just what the weather will be, but how confident you should be in that prediction. Modern weather forecasting does not produce an answer. It produces a distribution of answers.

## The Forecast Factory for Opinions

MiroShark is not a weather model. It is something that Richardson would recognize anyway.

The open-source simulation engine — 1,323 stars, 279 forks, 41 API surfaces — runs multi-agent simulations of opinion dynamics. You define a topic, a set of agents with different professional backgrounds and starting dispositions, and a set of platforms for them to interact on. The agents debate, influence each other, shift their stances. At the end, you get a distribution: how many agents moved bullish, how many moved bearish, where consensus formed, where polarization emerged.

Each simulation is a forecast. Not of pressure, but of opinion. And the architecture mirrors weather prediction more closely than the terminology suggests.

Richardson's computers each worked on their own patch of atmosphere. MiroShark's agents each operate from their own professional perspective — a venture capitalist reasons differently from a regulatory lawyer, who reasons differently from a data scientist. The emergent behavior comes not from any individual agent's sophistication but from their interaction. The stance flip service tracks exactly when and how often agents change their positions — a direct analogue to tracking how perturbations propagate through an atmospheric model. The confidence trajectory endpoint plots conviction over rounds the way a meteorologist tracks ensemble spread over forecast hours.

And the ensemble insight is already built into the system's economics. At under a dollar per simulation and less than ten minutes per run, running multiple simulations with different agent configurations is not a luxury — it is the intended workflow. Different agent counts, different platform combinations, different round depths. The pre-run estimator — surface number 41, shipped this week — tells you the expected cost and duration before you start, the same way an ensemble configuration tells a forecaster how much compute to allocate.

## From Impossible to Infrastructure

Richardson was mocked for attempting something that the scientific establishment considered impossible: predicting a complex, chaotic, multi-variable system through computation alone. The variables interact nonlinearly. The initial conditions are never perfectly known. The system is sensitive to perturbations at every scale. Every objection that was leveled at numerical weather prediction in 1922 could be leveled at computational opinion simulation today.

The research community is starting to take the idea seriously anyway. In 2025 and 2026, at least five major papers proposed LLM-based agent frameworks for simulating opinion dynamics — POSIM for social media governance, MTOS for echo chamber modeling, frameworks from teams exploring how agent dialog reproduces phenomena like polarization, consensus formation, and information cascading. The field is where weather prediction was in the 1940s: everyone agrees the equations are interesting, nobody knows if they will be useful.

Richardson's forecast factory was dismissed as a fantasy for twenty-eight years. Then one machine and a team of three people at Princeton turned it into a science that now processes 210 million daily observations and predicts the state of the atmosphere nine days into the future.

The opinion forecast factory does not need a circular hall or sixty-four thousand people. It needs a Python process, a language model, and the conviction that complex systems can be simulated — even when the first attempts get the answer wrong by a factor of a hundred.

---
*Sources: [Richardson's Forecast-Factory: the $64,000 Question — Peter Lynch, UCD](https://maths.ucd.ie/~plynch/Publications/64000.html), [The History of Numerical Weather Prediction — NOAA](https://www.vos.noaa.gov/MWL/dec_07/weatherprediction.shtml), [Richardson's Fantastic Forecast Factory — European Meteorological Society](https://www.emetsoc.org/resources/rff/), [Opinion dynamics and mutual influence with LLM agents — arXiv](https://arxiv.org/pdf/2602.12583), [POSIM: Multi-Agent Simulation Framework for Social Media Public Opinion — arXiv](https://arxiv.org/pdf/2603.23884), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
