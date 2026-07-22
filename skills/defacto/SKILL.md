---
name: defacto
description: >-
  Use when the user asks for the standard, idiomatic, canonical, de facto, or
  best-practice way to use a tool, library, framework, or workflow; asks how
  most teams do it; or asks to audit a setup against current convention. Also
  use before making an industry-standard claim that could vary by version or
  community. Skip subjective preferences, long-stable built-ins, and questions
  about runtime behavior rather than convention.
---

# Researching De Facto Conventions

## Overview

Determine what a vendor prescribes, what maintainers actually do, and what independent adopters converge on. Never flatten those signals into one “standard.” The gap between them is often the answer.

Label every factual finding with exactly one of these categories:

- `Vendor-official (current):` Current, version-pinned vendor guidance.
- `Vendor-official (legacy):` Former guidance that is now deprecated or replaced.
- `Vendor-dogfooded:` What maintainers do in their own production code.
- `Vendor-saturated:` Findable adopters are vendor demos or forks, so no independent convention exists yet.
- `Vendor-silent:` Vendor material does not address the question.
- `Community-de-facto:` At least two independent adopters converge, or one canonical generator/template establishes the pattern.
- `Anti-pattern-but-common:` Widespread practice contradicts a naive reading of vendor guidance.
- `Inferred (high/medium/low):` A reconstruction from separately grounded parts.

Do not invent additional labels. `Community-de-facto` from one non-template adopter is invalid; label it `Inferred (low)` and state that it has single-source support.

## Skill composition

- **Grounding.** Ground every claim in a primary source. Use the sibling `ground` skill when installed; otherwise apply that discipline directly. Memory, analogy, Stack Overflow, and hedging are not vendor evidence.
- **Conditional parallelism.** Use agents when each source requires reasoning across many files or pages. Use parallel tool calls for simple independent fetches. Continue serially when the host has no agent delegation.
- **Reconstruction.** Use the sibling `dig` skill when installed, or the same decomposition method directly, only for uncovered sub-questions.
- **Execution.** After an implementation change, use the sibling `test` skill when installed or directly exercise “does this work?” claims before completion. For runtime questions without a change, perform a direct check.
- **Scope.** This skill researches conventions; it does not implement competing branches.

## When to use

- The user invokes `/defacto`.
- The user asks for the standard, idiomatic, canonical, conventional, or best-practice approach.
- The user asks how most teams handle something.
- The user asks to audit a workflow, Dockerfile, configuration, or setup against current convention.
- You are about to make an industry-standard claim that could vary by version, ecosystem, or community.
- The question combines multiple tools and asks how they are conventionally used together.

## When to skip

- The user wants a specifically nominated source followed, not compared with broader convention.
- The user asks for subjective taste rather than industry practice.
- The surface is universally stable and has no meaningful convention drift.
- The question is purely whether something functions; use `ground` and a direct check, plus `test` after an implementation change.

## Procedure

### 1. Pin the version or API generation

Do this before fetching documentation or adopter examples whenever a recent major release, rename, replacement, or deprecation can change the answer.

1. Prefer the user’s manifest or lockfile.
2. In monorepos with version skew, pin and report per package.
3. Without a codebase, check current release notes and state the generation being evaluated.
4. Ask one clarifying question only when the version materially changes the result and cannot be discovered.

If source access is impossible, the first line of the answer must be:

```text
⚠️ DEGRADED MODE — no fetches performed this turn. All claims below are best-effort recall, downgraded to `Inferred:`. Verify before acting.
```

In degraded mode, label every finding `Inferred`; never imply that unfetched memory is vendor-grounded.

### 2. Decompose the question

Split compound questions before research and report each sub-question separately. For example, “Tailscale in GitHub Actions” may contain authentication, tagging, and trigger questions.

For a bare tool name, choose the most common scope, state it explicitly, or ask one narrowing question.

### 3. Gather independent evidence tiers

Research these independently:

1. Current and legacy vendor documentation.
2. Maintainer dogfood or flagship examples.
3. Independent adopter usage.
4. Both vendors for competing-tool or coexistence questions.

Use [research-playbook.md](references/research-playbook.md) for source selection, community thresholds, operational fallbacks, and gap classification.

Attach version applicability to version-gated findings. When vendor surfaces contradict one another, report each surface separately. Dogfood is strong evidence for invocation mechanics, but it is not automatically user-facing convention because maintainers may have a different threat model or use case.

### 4. Reconstruct only missing sub-questions

If the evidence tiers leave a sub-question unanswered, use `dig` when installed or apply its decomposition method directly for that sub-question only. Name the parts used and label the result `Inferred` with confidence:

- High: three or more independent corroborators.
- Medium: one or two corroborators.
- Low: analogy only.

The stricter community rule still applies: one non-template adopter cannot establish community convergence.

### 5. Label findings and name every gap

Apply one controlled label to every factual claim. Then list each divergence explicitly rather than hiding it in prose.

Use counts, sampled ratios, or search-ranking evidence for population claims. Without an anchor, use ordinal wording such as “more visible” or “predominant in the sampled projects”; never invent quantities.

### 6. Apply findings neutrally

When auditing the user’s setup, compare each key or step against the labeled baselines. Produce one finding per key; group keys only when they share the same source.

Do not recommend a choice unless the user asks which path to follow. When asked, ground the recommendation in the user’s stated constraints.

## Output

Lead with the labeled findings. Do not add a second summary or conclusion after them.

For one question:

```text
Vendor-official (current): <finding> (source: <path or URL>).
Vendor-dogfooded: <finding> (source: <repo/path>).
Community-de-facto: <finding> (sources: <adopter 1>, <adopter 2>).
Gap:
- <named divergence>
```

For compound questions, use one section per sub-question plus `### Cross-cutting gaps`. Do not fuse multiple questions into one labeled paragraph.

Explicit length and format requirements override artifact preferences. If the user requests chat or a word limit, stay in chat. Otherwise, use the sibling `html` skill when installed and the findings genuinely need a long, shareable, or side-by-side artifact; without it, use the host’s normal rich-artifact capability.

Under a strict budget, compact labels such as `[V-cur]`, `[V-leg]`, `[V-dog]`, `[V-sat]`, `[V-sil]`, `[C]`, `[A]`, and `[I-hi/med/lo]` are acceptable.

## Stop conditions

Stop and correct course when you are about to:

- Claim a standard without checking current vendor material.
- Claim “everyone” or “most teams” without named adopter evidence.
- Attribute community practice to the vendor.
- Treat dogfood as universal convention without comparing documentation and use case.
- Fetch drift-prone guidance before pinning the version or generation.
- Fuse compound questions or flatten a multi-modal community split.
- Infer community convergence from demo forks or a single adopter.
- Recommend a winner when the user only asked for a neutral audit.
- Use a GitHub file URL when the GitHub API or repository checkout is available.

## References

- [research-playbook.md](references/research-playbook.md): detailed source-selection, adopter research, fallbacks, and gap patterns.
- [examples.md](references/examples.md): complete worked examples for divergent, multi-modal, and vendor-saturated ecosystems.
