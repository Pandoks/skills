# Pandoks Skills

Opinionated agent skills for grounded research, implementation discipline, and
interactive artifacts.

## Install

List the available skills:

```sh
npx skills add Pandoks/skills --list
```

Install interactively:

```sh
npx skills add Pandoks/skills
```

Install every skill globally for Codex:

```sh
npx skills add Pandoks/skills --skill '*' --agent codex --global --yes
```

## Skills

| Skill | Purpose |
| --- | --- |
| `defacto` | Research the documented, vendor-recommended, and community-standard ways to use a tool. |
| `diagram` | Build interactive system diagrams with scenarios and numbered flows. |
| `dig` | Reconstruct answers from primary evidence when no direct source publishes the full comparison. |
| `dive` | Produce durable, source-backed context for a codebase. |
| `ground` | Verify factual claims against primary sources and runnable evidence. |
| `html` | Produce self-contained, browser-openable HTML artifacts. |
| `test` | Exercise code and configuration changes before declaring them complete. |
| `try-all` | Implement and compare substantive alternatives instead of debating them abstractly. |

## Compatibility

These skills are Codex-oriented. Some reference Codex tool names, macOS `open`,
or skills from the `superpowers` collection. The `diagram` skill includes its
template and validator; browser rendering in the validator additionally uses
Playwright when available.

## Validate

```sh
bash scripts/validate.sh
```

The validator installs the repository into a temporary Codex project through
the `skills` CLI and checks that all eight skills and their supporting files are
copied exactly.
