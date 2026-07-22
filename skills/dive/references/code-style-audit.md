# Code Style Audit

Read six to ten representative source files in full across the languages and major areas of the repository. Document what reviewers enforce beyond formatter and linter rules. Give at least one `path:line` citation per claim and note meaningful counterexamples.

## Naming

- Variable, function, type, constant, and file naming by language.
- Boolean prefixes and module-scope singleton conventions.
- Handler, route, service, hook, and public-export naming.
- String discriminants and enum value casing.

## Function shape

- Named declarations versus arrow functions and whether export status changes the preference.
- Explicit return types on public functions.
- Typical function length and responsibility.
- Guard clauses, early returns, and branching shape.

## Module layout

- Section order inside files.
- Import grouping and ordering.
- Type placement: inline, co-located, or dedicated modules.
- Public export patterns and barrel-file usage.

## Comments

- Approximate comment density in representative files.
- JSDoc, docstrings, inline notes, and prefixes such as `NOTE` or `WARNING`.
- The kinds of invariants, historical context, workarounds, or footguns worth documenting.
- Comment styles notably absent from the project.

## Repetition and reuse

- When repeated shapes become helpers and when near-duplicates remain explicit.
- Whether clarity is preferred over aggressive DRY abstractions.
- Placement of single-use constants and shared utilities.

## Error handling

- Exception types, result objects, status responses, and generic catches.
- Throw-to-retry versus local recovery.
- Logging library, structure, and expected context.
- User-facing error formatting and boundary behavior.

## Domain-specific patterns

Cover only relevant areas:

- UI: variant systems, prop composition, state placement, accessibility patterns.
- Infrastructure: stage gating, secret naming, conditional resources, provider boundaries.
- CLI: dispatch, help behavior, validation, status output, colors, destructive confirmations.
- Libraries: factories, builders, plugin contracts, public API stability.

## Unenforced taste

Look for cleanup or convention commits, comments explaining stylistic invariants, and wrappers whose purpose is consistency rather than functionality. These reveal what a senior reviewer would flag even when lint passes.

## Output

Create a `Code style — <language>` section per language in `conventions.md`. Separate:

1. Prescribed rules from configuration or style guides.
2. Observed patterns supported by multiple files.
3. Exceptions or drift.

Avoid merely paraphrasing formatter settings. Focus on patterns future contributors need to produce code that feels native to the repository.
