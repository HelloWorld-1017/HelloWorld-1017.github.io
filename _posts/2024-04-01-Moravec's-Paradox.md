---
layout: single
title: "Moravec's Paradox in AI and Robotics"
categories:
 - Machine Learning
 - Biology
drafted_at: 2024-03-27 10:39:13 +0800
date: 2024-04-01 04:37:17 +0800
last_modified_at0: 2024-04-01 04:37:17 +0800
last_modified_at1: 2024-04-02 09:57:51 +0800
last_modified_at: 2024-04-02 09:57:51 +0800
---

# Moravec's paradox

As described in Wikipedia[^1], **Moravec's paradox** is the observation in <u>artificial intelligence</u> and <u>robotics</u> that, contrary to traditional assumptions, **reasoning requires very little computation, but sensorimotor and perception skills require enormous computational resources**. The principle was articulated by Hans Moravec, Rodney Brooks, Marvin Minsky and others in the *1980s*. Moravec wrote in 1988, "*it is comparatively easy to make computers exhibit adult level performance on intelligence tests or playing checkers, and difficult or **impossible** to give them the skills of a one-year-old when it comes to perception and mobility*".

There are two major AI winters approximately 1974-1980 (six years) and 1987-2000 (thirteen years)[^2][^3][^10][^11], and Moravec's expressed this viewpoint about in the second winter.
{: .notice--primary}

One possible explanation of the paradox, offered by Moravec, is based on **evolution**. All human skills are implemented biologically, using machinery designed by the process of **natural selection**. In the course of their evolution, natural selection has tended to preserve design improvements and optimizations. **The older a skill is, the more time natural selection has had to improve the design**. Abstract thought developed only very recently, and consequently, we should not expect its implementation to be particularly efficient.

As Moravec writes:

*"Encoded in the large, highly evolved sensory and motor portions of the human brain is a billion years of experience about the nature of the world and how to survive in it. The deliberate process we call reasoning is, I believe, the thinnest veneer of human thought, effective only because it is supported by this much older and much more powerful, though usually unconscious, sensorimotor knowledge. We are all prodigious olympians in perceptual and motor areas, so good that we make the difficult look easy. Abstract thought, though, is a new trick, perhaps less than 100 thousand years old. We have not yet mastered it. It is not all that intrinsically difficult; it just seems so when we do it."*

A compact way to express this argument would be:

- We should expect **the difficulty of reverse engineering[^9] any human skill to be roughly proportional to the amount of time that skill has been evolving in animals**.

  - Some examples of skills that have been evolving for millions of years: recognize a face, move around in space[^8], judge people's motivations, catch a ball, recognize a voice, set appropriate goals, paying attention to things that are interesting, anything to do with perception, attention, visualization, motor skills, and social skills.

  - Some examples of skills that have appeared more recently: engineering, games, and logic and scientific reasoning. **These are hard for us because they are not what our bodies and brains were primarily evolved to do.** These are skills and techniques that were acquired recently, in historical time, and have had at most a few thousand years to be refined, mostly by cultural evolution.
  
- The oldest human skills are largely **unconscious** and so appear to us to be effortless.
- Therefore, we should expect skills that appear effortless to be difficult to reverse engineering, but skills that require effort may not necessarily be difficult to engineer at all.

<br>

# Other similar viewpoints

Marvin Minsky emphasized that **the most difficult human skills to reverse engineer are those that are below the level of conscious awareness**. "In general, we're least aware of what our minds do best", he wrote, and added "we're more aware of simple processes that don't work well than of complex ones that work flawlessly".

Steven Pinker wrote in 1994 book *The Language Instinct* that[^1]:

"*The main lesson of thirty-five years of AI research is that the hard problems are easy and the easy problems are hard. The mental abilities of a four-year-old that we take for granted – recognizing a face, lifting a pencil, walking across a room, answering a question – in fact solve some of the hardest engineering problems ever conceived... As the new generation of intelligent devices appears, it will be the stock analysts and petrochemical engineers and parole board members who are in danger of being replaced by machines. The gardeners, receptionists, and cooks are secure in their jobs for decades to come.*"

<br>

# Against optimism for AI

In the early days of artificial intelligence research, leading researchers often predicted that they would be able to create thinking machines in just a few decades[^4]. Their optimism stemmed in part from the fact that they had been successful at writing programs that used logic, solved algebra and geometry problems and played games like checkers and chess. Logic and algebra are difficult for people and are considered a sign of intelligence. Many prominent researchers assumed that, having (almost) solved the "hard" problems, the "easy" problems of vision and commonsense reasoning would soon fall into place. They were wrong[^2], and one reason is that these problems are not easy at all, but incredibly difficult. The fact that they had solved problems like logic and algebra was irrelevant, because these problems are extremely easy for machines to solve.

Rodney Brooks[^6][^7] explains that, according to early AI research, intelligence was "best characterized as the things that highly educated male scientists found challenging", such as chess, symbolic integration, proving mathematical theorems and solving complicated word algebra problems. "The things that children of four or five years could do effortlessly, such as visually distinguishing between a coffee cup and a chair, or walking around on two legs, or finding their way from their bedroom to the living room were not thought of as activities requiring intelligence."

In the 1980s, this would lead Brooks to pursue a new direction in artificial intelligence and robotics research. He decided to build intelligent machines that had "No cognition. Just sensing and action. That is all I would build and completely leave out what traditionally was thought of as the *intelligence* of artificial intelligence."He called this new direction "Nouvelle AI"[^5].

"Nouvelle AI differs from classical AI by aiming to produce robots with intelligence levels similar to insects. Researchers believe that intelligence can emerge organically from simple behaviors as these intelligences interacted with the "real world", instead of using the constructed worlds which symbolic AIs typically needed to have programmed into them."[^5]
{: .notice--primary}

<br>

**References**

[^1]: [Moravec's paradox - Wikipedia](https://en.wikipedia.org/wiki/Moravec%27s_paradox).
[^2]: [AI winter - Wikipedia](https://en.wikipedia.org/wiki/AI_winter).
[^3]: [AI Winter: The Highs and Lows of Artificial Intelligence - History of Data Science](https://www.historyofdatascience.com/ai-winter-the-highs-and-lows-of-artificial-intelligence/).
[^4]: [History of artificial intelligence: Optimism - Wikipedia](https://en.wikipedia.org/wiki/History_of_artificial_intelligence#Optimism).
[^5]: [Nouvelle AI - Wikipedia](https://en.wikipedia.org/wiki/Nouvelle_AI).
[^6]: [Rodney Brooks – Robots, AI, and other stuff](https://rodneybrooks.com/).
[^7]: [Rodney Brooks - Wikipedia](https://en.wikipedia.org/wiki/Rodney_Brooks).
[^8]: [Why we don't have robot butlers yet - Ken Goldberg - TEDxMarin - YouTube](https://www.youtube.com/watch?v=6OUfOzCabXs).
[^9]: [Reverse engineering - Wikipedia](https://en.wikipedia.org/wiki/Reverse_engineering).
[^10]: [脑洞乌托邦 - YouTube](https://www.youtube.com/watch?v=ojnO6hrz1FE).
[^11]: [Part I Artificial Intelligence: A general survey by Sir James Lighthill FRS Lucasian Professor of Applied Mathematics, Cambridge University](https://www.aiai.ed.ac.uk/events/lighthill1973/lighthill.pdf).
