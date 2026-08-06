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

| Skill     | Purpose                                                                                        |
| --------- | ---------------------------------------------------------------------------------------------- |
| `defacto` | Research the documented, vendor-recommended, and community-standard ways to use a tool.        |
| `diagram` | Build interactive system diagrams with scenarios and numbered flows.                           |
| `dig`     | Reconstruct answers from primary evidence when no direct source publishes the full comparison. |
| `dive`    | Produce durable, source-backed context for a codebase.                                         |
| `ground`  | Verify factual claims against primary sources and runnable evidence.                           |
| `html`    | Produce self-contained, browser-openable HTML artifacts.                                       |
| `test`    | Exercise code and configuration changes before declaring them complete.                        |
| `try-all` | Implement and compare substantive alternatives instead of debating them abstractly.            |

## Compatibility

These skills are Codex-oriented. Some reference Codex tool names, macOS `open`,
or skills from the `superpowers` collection. Install these dependencies in the
same scope as the Pandoks skills. For the global Codex install above, run:

```sh
npx skills add obra/superpowers \
  --skill dispatching-parallel-agents \
  --skill using-git-worktrees \
  --agent codex \
  --global \
  --yes
```

The `diagram` skill includes its template and verifier. The verifier is a plain
`.js` file that runs directly in CommonJS or ESM projects on Node.js 18+, with
no TypeScript build step or package metadata. Browser rendering additionally
uses Playwright when available.
