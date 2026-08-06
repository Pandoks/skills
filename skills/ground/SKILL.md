---
name: ground
description: >-
  Use when an answer would contain a factual claim, recommendation, or advice
  that can be checked against current primary sources or the installed or
  runnable system. Especially use for version-sensitive software, API, or
  configuration claims; named facts or numbers; medical, legal, or financial
  guidance; comparisons; safety questions; and recommendations the user might
  act on. Skip only for explicit speculation, user-supplied premises, or
  long-stable built-ins.
---

# Grounding Claims

## Overview

Verify factual claims against a primary source and, when runnable, with a direct exercise. Memory is not a source; documentation alone may miss version skew or runtime behavior.

Grounding is per claim. Verifying one part of a multi-part answer does not cover the others. Hedge only after a reasonable lookup is inconclusive, never instead of checking an accessible source.

## The two checks

| Check     | What it catches                                    | Typical evidence                                                            |
| --------- | -------------------------------------------------- | --------------------------------------------------------------------------- |
| Reference | Stale or invented facts, APIs, flags, and versions | Official docs, actual source, schemas, package metadata, installed version  |
| Empirical | Docs/runtime mismatch and behavioral edge cases    | Minimal reproducer, real command, targeted test, local integration exercise |

Use both when both are possible. If a claim is not runnable, say that only the reference check was applicable. If a check is blocked, name the blocker and narrow the claim.

## Procedure

1. **Identify each verifiable claim.** Separate facts from judgment. “This name is clearer” is judgment; “this API exists in v4” is a fact.
2. **Check a primary source.** Prefer official documentation, installed source, repository code, schemas, or authoritative registries. For version-sensitive claims, establish the relevant version first.
3. **Exercise runnable behavior.** Use the smallest safe environment that proves or disproves the claim. Prefer a temporary directory over polluting the user’s project.
4. **Reconcile conflicts.** When documentation and execution disagree, report the version, exact observation, and uncertainty rather than rationalizing the mismatch.
5. **Report provenance.** Put the source near the claim and briefly state what was executed and observed.

## When to skip

- Explicitly framed speculation.
- A premise supplied by the user, unless the task is to verify it.
- Pure judgment or taste.
- Long-stable built-ins and basic syntax with no meaningful drift.

Quick questions, casual tone, or having verified a different claim are not valid reasons to skip.

## Minimal empirical pattern

```bash
WORK=$(mktemp -d)
cd "$WORK"
# Install or invoke the exact relevant version.
# Run the smallest example that can falsify the claim.
# Record exit status, stdout/stderr, and relevant side effects.
```

Pin versions explicitly. Test realistic behavior, not only `--help`, compilation, or import success. Clean up sensitive artifacts; temporary evidence may remain only when safe and useful for inspection.

## Stop conditions

Stop and verify before you:

- State a current version, requirement, function signature, option, or schema key from memory.
- Describe internal code you have not inspected.
- Present an unrun code block as working behavior.
- Claim something does not exist without checking the authoritative surface.
- Let one grounded claim stand in for an unrelated claim later in the answer.

## Output contract

Distinguish:

- **Verified:** supported by named primary evidence and, when applicable, direct execution.
- **Inferred:** follows from verified parts but was not directly observed.
- **Unverified:** could not be checked; state why and avoid actionable certainty.

Keep receipts proportional to the answer. A concise question usually needs a concise citation and one short execution note, not a methodology recap.
