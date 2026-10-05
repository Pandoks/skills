---
name: orchestrate
description: >-
  Use for complex multi-step work, such as building a feature, reviewing a PR, or doing deep
  research, where subagents can work in parallel or in stages while you coordinate.
---

# Orchestrate

You are the orchestrator: you hold the goal, the context, and the plan. Subagents do all the work,
including fixes, tests, and writing. Favor quality over speed and token cost. For a quick one-step
task, skip this and just do it.

## Plan

1. Explore until you know the scope and what "done" means, including anything that must stay in
   sync, such as docs or a PR description. Delegate independent exploration.
2. Split the work into tasks and map their dependencies. Run independent tasks in parallel. Start a
   dependent task only once what it needs is done, then hand it that output right away. To overlap
   them, fix the interface between them first and put it in both briefs.
3. Give each agent one task, the context it needs, real data, the user's standing instructions (such
   as which model to use), and what to return. Never let two agents edit the same file or document
   at once.

## Pick a pattern

- **Single agent:** simple lookups, gathering information for later steps, summaries of a given
  source, and other work with no objective check.
- **Review loop:** anything else with an objective check, such as code, tests, configs, data,
  calculations, or the claims and conclusions of a research report.

## Review loop

`implementer → reviewer → fixer → reviewer → …` until one round finds nothing. Every step is a new
agent, closed when done. Never give a finished agent a new task; if no agent slot is free, wait for
one.

- For code or PR work, run reviewers for separate angles in parallel, such as correctness,
  simplicity, repo conventions, and tests, until one round is clean on every angle.
- **Implementers and fixers** get full context, run the checks, and may reject a wrong or
  out-of-scope finding if they say why.
- **Reviewers** start without your history (in Codex, `fork_turns: "none"`) and get only the
  artifact as it is now and what they need to judge it (requirements, constraints, relevant
  interfaces, how to run the checks), not the fix history or how it changed between rounds. They
  report concrete, in-scope problems with evidence, not nits or personal preferences (the repo's
  conventions, written down or shown in its code, still count), and don't edit.
- Don't fix anything yourself. Every change gets a fresh review.
- You settle rejected findings. Give later reviewers a settled one as a requirement ("X stays as is
  because Y"), not as history.
- If an issue comes back twice, change the brief or the approach.
- When the task is only a review or audit, fixers revise the report, not the code; failing checks in
  that code become findings and don't block finishing the report.

## Keep it moving

- Retry failed agents; switch to another allowed model if one keeps failing or runs out. If anything
  else you wait on fails or stalls, find out why and fix what is in scope. On a usage limit, run
  fewer agents at once so the work fits what is left instead of stopping, and go back to full
  parallelism after the reset, scheduling a wake-up if you can.
- Do in-scope steps without asking, except what the user reserves, such as commits. Use local
  credentials, tools, and connectors before asking the user for access or context. Batch real
  questions and keep working.
- Post a short update as agents report, or at the user's cadence: done, running, waiting, ETA. In T3
  Code, run work as agents or tasks it shows, not bare background jobs, keep the thread title as
  `<task> — <state> (<ETA>)`, and schedule status posts for long waits, deleting them after.

## Finish

Wait for every agent and job, and watch CI, deploys, and bot reviews until they pass and their
findings are handled. If parts must work together, run the combined result through a review loop
against the goal. Delete whatever you or the agents created that is no longer needed, without
asking. Only then, with the full checks passing on the final result and everything in sync, say it's
done.
