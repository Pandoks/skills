---
name: orchestrate
description: >-
  Use for complex multi-step work, such as a feature, a PR review, a swarm, reviewing from every
  angle, a review/fix loop, deep research, babysitting a PR, or work where subagents can run in
  parallel or in stages.
---

# Orchestrate

As orchestrator, you hold the goal, context, and plan; subagents do all the work, including tests
and writing. Favor quality over speed and token cost, but add no process the task doesn't need, such
as gates, ledgers, or audit trails, and tell agents the same. Skip this for a quick one-step task.

## Plan

1. Explore until you know the scope, what "done" means, and what must stay in sync, such as docs or
   a PR description; delegate independent exploration.
2. Split the work into tasks and map their dependencies, then run independent ones in parallel,
   isolating shared runtime targets (like local clusters or config reloads) so agents don't collide.
   Start a dependent task as soon as its inputs are ready and pass them in, or run it alongside the
   task it depends on, defining their interface in both briefs.
3. Give each agent one task, root and repo `AGENTS.md` to read first, real data (not placeholders),
   the user's standing instructions (such as which model to use), and what to return; state the
   chosen model and effort when starting it (if a user-named model can't be used, stop and say so),
   and tell it to report only to you when done or blocked. Never let two agents edit one file.
4. Use a single agent for simple lookups, gathering information for later steps, summaries of a
   given source, and other work with no objective check; use a review loop for work with an
   objective check, such as code, tests, configs, data, calculations, or a report's conclusions.

## Review loop

`implementer → reviewer → fixer → reviewer → …` until one round finds nothing. Every step is a new
agent, closed when done. Don't fix anything yourself; every change gets a fresh review. Reuse a
finished agent only if no fresh one can start even after waiting, and never to review work it made,
fixed, or reviewed.

- For code or PR work, run parallel reviewers for separate angles—correctness, simplicity, the
  `pr-ready` checklist + repo conventions, and tests (`test-audit` when tests change)—until clean.
- **Implementers and fixers** get full context, run the checks, add no hardening that repo rules
  exclude, and reject wrong, out-of-scope, or excluded findings with a rule citation. Report
  unrelated findings to the user without opening PRs. Settle disputes in later briefs ("X stays as
  is because Y"), not as history.
- **Reviewers** don't edit, start without your history (in Codex, `fork_turns: "none"`), and get
  only the current artifact and what they need to judge it (requirements, constraints, relevant
  interfaces, how to run the checks), not the fix history or how it changed between rounds. They
  report only in-scope problems: wrong results, unmet requirements, breaches of written repo rules
  or `pr-ready` (comments, docs length, naming — grouped as one item), needless complexity, untested
  new behavior, or unsupported conclusions. They confirm findings themselves where possible and skip
  ungrounded preferences and missing process logs.
- From round 3 onward, reviewers judge fixes and regressions only; if an issue repeats or round 5
  still fails, change the approach or stop and report the recurring blocker to the user.

## Updates

Post a short, plain update as agents report, or at the user's cadence: done, running, waiting, ETA.
In T3 Code, run work as agents or tasks it shows, not bare background jobs, keep the thread title as
`<task> — <state> (<ETA>)`, and schedule status posts for long waits, deleting them after.

## Finish

Wait for every agent and job, and for CI, deploys, and active bot reviews to pass with findings
handled (follow the repo's review triggers and wait policy, by default stopping 30 minutes after the
last push, and name the reviews missing on this head); if anything fails, stalls, or overruns,
investigate and have a fresh agent fix what is in scope. Run the combined result through
`test-audit` (if tests changed), `pr-ready`, and real-entry-point checks on the final revision,
auto-clean temp artifacts created by this thread without asking, and hand off using `pr-ready`.
