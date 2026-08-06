---
name: dive
description: >-
  Use when the user explicitly asks to deep-dive or comprehensively inspect the
  current project for durable onboarding or future-session context. Do not use
  for a one-off codebase question, ordinary repository exploration, or a
  read-only explanation that should not create files.
compatibility: Requires project file read/write access; parallel agents are optional for large repositories.
---

# Build Durable Project Context

## Goal

Inspect the current project comprehensively and write grounded context to `<project>/.agents/context/`. Do not edit project or global instruction files. If the host supports `@path` imports, offer this opt-in line at completion:

```text
@.agents/context/index.md
```

Otherwise explain how to include `.agents/context/index.md` from the host’s project-instruction file without editing it automatically. If `.agents/context/` already contains files, ask before overwriting them.

## Output files

For a non-trivial project, write:

| Path              | Contents                                                              |
| ----------------- | --------------------------------------------------------------------- |
| `index.md`        | Project summary and links to the other context files                  |
| `architecture.md` | Layers, data flow, key abstractions, state, and external integrations |
| `conventions.md`  | Enforced rules plus observed, non-trivial code style with evidence    |
| `gotchas.md`      | Footguns, surprising invariants, workarounds, and recent regressions  |
| `workflows.md`    | Exact install, build, dev, test, lint, typecheck, and deploy commands |
| `entry-points.md` | Executable entry points, routes, jobs, workers, and scheduled tasks   |

For a genuinely tiny or config-only project, write only `index.md` and `workflows.md`; do not pad empty files.

## Procedure

### 1. Survey the repository

Confirm the project root and inspect:

- Top-level directories and files.
- Recent Git history and current branch state.
- Language and package manifests.
- Build, formatter, linter, typechecker, and task-runner configuration.
- CI workflows.
- Existing README, contribution, architecture, style, and agent-instruction documents.

This establishes project type, major boundaries, authoritative commands, and prescribed conventions.

### 2. Inspect major areas

Divide the repository by meaningful area: frontend, backend, database, tests, infrastructure, tooling, and documentation as applicable.

For a large repository, use independent agents when available, one area per agent. Each report must include:

- Purpose of each owned directory.
- Five to ten important files with `path:line` evidence.
- Recurring patterns and local conventions.
- Surprises or likely footguns.
- Three to five files read in full and concrete code-style observations.

Use concise reports and synthesize them; do not paste agent reports into the final context. Inspect small repositories serially.

### 3. Trace a critical path

Follow at least one important user-facing flow end to end, such as:

- HTTP route → handler → domain logic → database → response.
- CLI arguments → command → business logic → output.
- Public library API → core implementation → side effects.

Record boundaries, state changes, error handling, transactions or locks, and logging.

### 4. Establish workflows from CI

Treat CI as authoritative for what must pass. Reconcile CI commands with manifests and documentation. Record exact commands, required environment variables, external services, and credentials without exposing secret values.

### 5. Mine for gotchas

Search source and history for `TODO`, `FIXME`, `HACK`, `XXX`, `WORKAROUND`, `NOTE`, bug fixes, hotfixes, and reverts. Use `rg` when available and fall back to an equivalent search tool otherwise.

Only record gotchas supported by inspected code, comments, tests, or history.

### 6. Audit code style

Read [code-style-audit.md](references/code-style-audit.md). Inspect six to ten representative source files across the project’s languages and document observed patterns with `path:line` evidence. Distinguish prescribed style from actual practice and note drift.

### 7. Write the context

- Use technical, compact prose.
- Cite code claims as `path:line`.
- Prefer tables and short bullets.
- Keep most files about 300–800 words; `conventions.md` may be longer when evidence requires it.
- Add a one-line description for every linked file in `index.md`.
- Add `Last generated: <date>` to `index.md`.
- Write `(none observed)` instead of fabricating content for sparse sections.

### 8. Report

Return:

- A five-line senior-engineer summary of the project.
- Absolute paths to files written.
- The host-appropriate optional import instruction for `.agents/context/index.md`.
- Unresolved questions and the evidence that was missing.

## Constraints

- Do not edit any `AGENTS.md`, `CLAUDE.md`, or global agent configuration.
- Do not commit the generated context files.
- Ground every project claim in a file or command actually inspected.
- For repositories over roughly 5,000 files, prioritize top-level source areas and state what was skipped.
