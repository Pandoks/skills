---
name: orchestrate
description: >-
  Use for complex multi-step work, such as building a feature, reviewing a PR, or doing deep
  research, where subagents can work in parallel or in stages while you coordinate.
---

# Orchestrate

You are the orchestrator: you hold the goal, the context, and the plan. Subagents do all the work,
including fixes, tests, and writing. For a quick one-step task, skip this and just do it.

## Plan

1. Explore until you know the scope and what "done" means, including anything that must stay in
   sync, such as docs or a PR description. Delegate independent exploration.
2. Split the work into tasks. Run independent tasks in parallel. When a task finishes, hand its
   output to the tasks it unblocks and start them right away.
3. Give each agent one task, the context it needs, real data, the user's standing instructions (such
   as which model to use), and what to return. Never let two agents edit the same file or document
   at once.

## Pick a pattern

- **Single agent:** simple lookups and retrieval, summaries, judgment calls, and other work with no
  objective check.
- **Review loop:** anything else with an objective check: code, tests, configs, data, calculations,
  or research findings.

## Review loop

`implementer → reviewer → fixer → reviewer → …` until one round finds nothing. Every step is a new
agent, closed when done.

- For code or PR work, run reviewers for separate angles in parallel, such as correctness,
  simplicity, repo conventions, and tests, until one round is clean on every angle.
- **Implementers and fixers** get full context, run the checks, and may reject a wrong or
  out-of-scope finding if they say why.
- **Reviewers** start without your history (in Codex, `fork_turns: "none"`) and get only the
  artifact and what they need to judge it (requirements, constraints, relevant interfaces, how to
  run the checks), not the fix history. They report concrete, in-scope problems with evidence and
  don't edit.
- Don't fix anything yourself. Every change gets a fresh review.
- You settle rejected findings and tell later reviewers which ones are settled.
- If an issue comes back twice, change the brief or the approach.
- When the task is only a review or audit, fixers revise the report, not the code.

## Keep it moving

- Retry failed agents; switch to another allowed model if one keeps failing or runs out. On a usage
  limit, run fewer agents instead of stopping, and go back to full parallelism after the reset,
  scheduling a wake-up if you can.
- Do in-scope steps without asking, except what the user reserves, such as commits. Find local
  credentials, tools, and connectors before asking for access. Batch real questions and keep
  working.
- Post a short update as agents report, or at the user's cadence: done, running, waiting, ETA. In T3
  Code, run work as agents or tasks it shows, not bare background jobs, keep the thread title as
  `<task> — <state> (<ETA>)`, and schedule status posts for long waits, deleting them after.

## Finish

Wait for every agent and job, and watch CI, deploys, and bot reviews until they pass and their
findings are handled. If parts must work together, run the combined result through a review loop
against the goal. Delete whatever you or the agents created that is no longer needed, without
asking. Only then, with everything verified and in sync, say it's done.
