---
name: dig
description: >-
  Use when the user asks for deep or exhaustive research, or when a question
  has no direct published answer but could be reconstructed from sources,
  source code, tests, measurements, or separately findable facts. Also use when
  initial results are thin and the next response would otherwise say "it
  depends", "not reported", or ask the user for information that can be
  independently obtained. Skip for explicitly quick, off-the-cuff requests or
  genuinely non-decomposable questions.
---

# Leaving No Stone Unturned

## Overview

The absence of a prepackaged answer is not the absence of an answer. Decompose a niche or cross-cut question into findable parts, gather each part, and reconstruct the result with assumptions and per-figure confidence. Treat the missing literal join as a limitation, not a reason to stop.

Ground every part in primary sources. Exercise runnable code claims. When many strands are independent, investigate them in parallel using the agent or concurrency capabilities available in the host.

## When to use

- The requested number, comparison, or fact is not directly reported.
- Reachable source code, documentation, data, or a runnable test could resolve “it depends.”
- A hand-wavy estimate can be improved by modeling findable factors.
- The question spans regions, products, timeframes, sources, or subsystems that are individually researchable.
- Multiple plausible explanations or interpretations can be investigated independently.

Skip when the answer is genuinely non-decomposable, the needed proprietary information is inaccessible and cannot be derived, or the user explicitly requests a quick take.

## Procedure

1. **Decompose.** Turn the desired answer into independently findable facts, measurements, or estimable factors.
2. **Gather.** Use the right primary source for each part: authoritative web sources for facts, actual files for code behavior, package metadata for versions, and execution for runtime behavior.
3. **Parallelize when useful.** Assign independent, reasoning-heavy strands to separate agents when available; use parallel tool calls for simple fetches. Keep a local checklist when the host has no persistent task mechanism.
4. **Pursue competing explanations.** Investigate each plausible branch far enough to discriminate among them. Competing code implementations belong in `try-all`.
5. **Synthesize.** Answer the original question, cite every important figure, distinguish measured from estimated, state assumptions, and give confidence for reconstructed values.

## Stop conditions

Do not stop merely because:

- No publication contains the exact joined comparison.
- The value varies; derive a range from the variables that drive it.
- Available studies are imperfect; combine them transparently and preserve their limitations.
- The source is one file, search, test, or repository inspection away.
- The investigation is large; split it into independent strands.

Stop only when the remaining input is inaccessible, non-derivable, or would require authority outside the task. Report exactly what remains unknown and why.

## Output contract

- Lead with the reconstructed answer.
- Put sources beside the claims they support.
- Mark each important value as measured, modeled, estimated, or unknown.
- State assumptions and confidence without using caveats as a substitute for the answer.
- Identify the literal unavailable join briefly, then explain what the reconstructed evidence supports.
