# Pandoks Skills

Reusable agent skills installed with the [skills CLI](https://github.com/vercel-labs/skills).

## Install

List the available skills:

```sh
npx skills add Pandoks/skills --list
```

Install interactively:

```sh
npx skills add Pandoks/skills
```

Choose the skills, agents, and installation scope when prompted. For project installations, run the
command from your project directory. Add `--global` to install skills across projects.

## Update

Refresh existing skills from this repo and install any newly added skills:

```sh
npx skills add Pandoks/skills --skill '*'
```

Choose the same agents and installation scope as before. For project installations, run this from
the same project directory; for global installations, add `--global`.

To update only skills that are already installed, including those from other repositories:

```sh
npx skills update
```

This does not install newly added skills. Add `--project` or `--global` to limit updates to that
scope.

## Skills

| Skill                                              | Purpose                                                             |
| -------------------------------------------------- | ------------------------------------------------------------------- |
| [clean-up](skills/clean-up/SKILL.md)               | Review leftover task artifacts and remove them after confirmation.  |
| [create-worktree](skills/create-worktree/SKILL.md) | Place and name Git worktrees consistently next to the project root. |
| [orchestrate](skills/orchestrate/SKILL.md)         | Delegate and coordinate complex workflows across subagents.         |
