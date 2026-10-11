---
name: orchestrate
description: >-
  Use for complex multi-step work, such as a feature, a PR review, or deep research, where subagents
  can work in parallel or in stages.
---

# Orchestrate

As orchestrator, you hold the goal, context, and plan; subagents do all the work, including tests
and writing. Favor quality over speed and token cost, but add no process the task doesn't need, such
as gates, ledgers, or audit trails, and tell agents the same. Skip this for a quick one-step task.

## Plan

1. Explore until you know the scope, what "done" means, and what must stay in sync, such as docs or
   a PR description; delegate independent exploration.
2. Split the work into tasks and map their dependencies, then run independent ones in parallel.
   Start a dependent task as soon as its inputs are ready and pass them in, or run it alongside the
   task it depends on, defining their interface in both briefs.
3. Give each agent one task, the context it needs, real data (not placeholders), the user's standing
   instructions (such as which model to use), and what to return; tell it to report only to you,
   when it finishes or gets blocked. Never let two agents edit the same file or document at once.
4. Use a single agent for simple lookups, gathering information for later steps, summaries of a
   given source, and other work with no objective check; use a review loop for work with an
   objective check, such as code, tests, configs, data, calculations, or the claims and conclusions
   of a research report.

## Review loop

`implementer → reviewer → fixer → reviewer → …` until one round finds nothing. Every step is a new
agent, closed when done. Don't fix anything yourself; every change gets a fresh review. Reuse a
finished agent only if no fresh one can start even after waiting, and never to review work it made,
fixed, or reviewed.

- For code or PR work, run parallel reviewers for separate angles, such as correctness, simplicity,
  repo conventions, and tests, until one round is clean on every angle.
- **Implementers and fixers** get full context, run the checks, and may reject a wrong or
  out-of-scope finding if they say why; you settle it, tell later fixers the ruling and why ("an
  earlier fixer rejected X; overruled because Y"), and give later reviewers the outcome as a
  requirement ("X stays as is because Y"), not as history.
- **Reviewers** don't edit, start without your history (in Codex, `fork_turns: "none"`), and get
  only the current artifact and what they need to judge it (requirements, constraints, relevant
  interfaces, how to run the checks), not the fix history or how it changed between rounds. They
  report only in-scope problems that change the outcome, such as a wrong result, an unmet
  requirement or repo convention (documented or evident in existing code), needless complexity,
  untested new behavior, or a conclusion its sources or results don't support. They give evidence
  for each, confirm it themselves where they can (rerun, recompute, read the source), drop any that
  don't hold up, and skip nits, preferences, and missing records of how the work was done.
- If an issue comes back twice, change the brief or the approach.
- When the task is only to review or audit, fixers revise the report, not the code, and failing
  checks in that code are findings, not blockers.

## Keep it moving

- Retry failed agents; switch to another allowed model if a model keeps failing or hits its limit.
  If anything you wait on fails, stalls, or overruns, find out why and have a fresh agent fix what
  is in scope. On a usage limit, cap concurrent agents instead of stopping, retry held-back ones
  periodically, not just at the stated reset, and raise the cap as they start.
- Do in-scope steps without asking; ask first only before destructive, irreversible, or unrequested
  externally visible steps, real scope changes, or user-reserved actions, such as commits. Use local
  credentials, tools, and connectors before asking for access or context. Batch real questions and
  keep working on whatever they don't block.
- Never end a turn while a needed step could start, even if it needs a reversible assumption (state
  it); watching a PR or CI is not a step. If only waiting is left (on agents, jobs, CI, or held-back
  agents), set a wake-up for the soonest expected finish or next retry, since nothing wakes you when
  work runs late; if you can't (often in Codex), keep waiting in the turn. Whenever you end a turn
  with a question open or the work finished, say so plainly; in T3 Code, unwatch the PR first.
- Post a short, plain update as agents report, or at the user's cadence: done, running, waiting,
  ETA. In T3 Code, run work as agents or tasks it shows, not bare background jobs, keep the thread
  title as `<task> — <state> (<ETA>)`, and schedule status posts for long waits, deleting them
  after.

## Finish

Wait for every agent and job, and for CI, deploys, and bot reviews to pass with their findings
handled. If parts must work together, run the combined result through a review loop against the
goal. Delete what you or the agents created and no longer need, without asking. Only then, with the
full checks passing on the final result and everything in sync (a PR description describes the
current diff, not how it got there), say it's done.
