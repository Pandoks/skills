---
name: dream
description: >-
  Use when the user says dream, or asks to audit past agent sessions and improve AGENTS.md, skills,
  or CI checks from them: mines session history since the last instruction change, runs a blind
  multi-model council and A/B simulations, and opens PRs without merging.
---

# Dream

Turn past sessions into the smallest verified PRs for instruction files, skills, and CI checks. Keep
all live checkouts, configs, installed skills, and session databases read-only throughout. Do all
work in a private, uniquely named run directory (`RUN=$(mktemp -d /var/tmp/dream-XXXXXX)`); the only
outputs are PRs and a final report.

## 1. Scope and cutoffs

1. Ask once for anything unspecified: hosts in scope, project exclusions, target repos and files,
   line budgets (`AGENTS.md` net `<= 0` unless requested), and allowed council/eval models. Discover
   all configured providers and frontier models dynamically from the harness (overriding any
   single-provider default) so the run spans every available provider unless the user restricts it;
   if a named model or provider is unavailable, stop instead of substituting.
2. In fresh clones under `$RUN/repos/`, run `git log --follow --format='%H %cI %s' -- <path>` for
   each target `AGENTS.md`, skill, and review/CI config. Record each substantive rule's cutoff (a
   cosmetic edit does not reset unrelated rules) plus the last `git log --grep='^Dream:' -1` commit
   in `cutoffs.tsv`.
3. Enumerate every open PR with a paginated query
   (`gh api --paginate 'repos/<owner>/<repo>/pulls?state=open&per_page=100'`; `gh pr list` stops at
   30), and save `git diff -U0 <base>...<head> -- <path>` for each target path. Protect the lines
   changed by the PR and the insertion points it uses. Read old-side coordinates from zero-context
   hunks. For a supplied diff with context, count old-file lines from each hunk start and exclude
   unchanged context. Recheck against the current base before publishing.

## 2. Read-only corpus

4. Locate each host's session store (for example `~/.t3/userdata/statev2.sqlite` or harness session
   logs). Obtain a consistent SQLite backup with the source database and its directory protected
   from writes by the OS, or copy the database and its present sidecars from one atomic filesystem
   snapshot. Query and integrity-check the resulting copy under `$RUN`. If a host is unreachable or
   neither method is available, report that coverage gap and continue. Export normalized JSONL per
   top-level thread under `$RUN/corpus/`: host, project, workspace, provider, timestamps, each human
   message, preceding assistant text, and inline review anchor, dropping excluded projects (with
   their aliases and worktrees) and subagent threads at query time.
5. Write `manifest.json` with counts per host and per side of each cutoff, verified by an
   independent count. Weight post-cutoff recurrences over pre-cutoff history whose `git log` diff
   shows a later commit already addressed the failure. Keep raw transcripts and secrets out of repos
   and PRs.

## 3. Multi-model council

6. **Round 1 (blind):** Spawn 3–4 councilors across every available provider (top reasoning model
   per provider, plus a second distinct model where a provider offers different model families) at
   high/xhigh effort, each with a distinct lens (code taste, prompt adherence, verification/CI,
   workflow/UX), given the same corpus, cutoffs, open-PR ranges, budgets, and read-only rules, with
   zero cross-reading. Each writes `$RUN/council/r1-<lens>.md` with quantified drivers, root causes,
   net-`<=0` diffs, and honest limits.
7. **Round 2 (cross-examination):** Share all R1 reports and constraints. Each member red-teams peer
   reports, reproduces key counts/diffs/open-PR merges (`git merge-file`), and votes on disputed
   decisions and 5 paired eval cases. Keep edits supported by reproduced evidence and write `v1`.

## 4. Isolated A/B simulation and loop (max 3 candidates)

8. Materialize baseline (`A`) and candidate (`B`) in per-run sandboxes under `$RUN/eval/`. Confine
   every agent, judge, and process that runs agent-written files, with their children, by OS
   enforcement (`sandbox-exec`, a container, or a throwaway account) to its own fixture: no live
   instruction files or skills, no connectors or MCP servers, no apps, no other runs. Give each
   agent only its own provider's login, and run fixture checks with no login or network. Give each
   sandbox a temp directory that `mktemp` and shell here-documents resolve to. Shim CLIs that reach
   live apps or services, and say in each prompt that the repo is a scratch copy.
9. **Mandatory canary, per launch configuration:** Plant a unique token only in `B` and another only
   in `A`. Each arm must report its own token and neither the other's nor a phrase from the live
   config, fail to read a decoy outside its sandbox, fail to write outside it, and list no tool that
   can message a person or drive the desktop. Save the results; fix isolation before scoring if any
   check fails or a live `shasum` changes.
10. Run paired real post-cutoff corpus fixtures across models from `>=2` distinct providers
    (including a subagent-tier model when available), scoring observable state (files, diffs,
    recorder logs, parsed fields) + explicit guardrails (zero unintended edits, zero unrequested
    sends, preserved required annotations) and blind randomized-order judging for qualitative tasks.
    Count timeouts as failures, record seconds per run, and read raw replies before trusting a
    metric: a scorer that passes on a negation, or a case where baseline is already at its floor or
    ceiling, proves nothing.
11. Give each council member the exact diff, raw trials, guardrail evidence, and blind judgments.
    SHIP only when every member votes SHIP, `B` passes every required guardrail (two equally failing
    arms do not pass), and valid evidence supports the targeted gains. Otherwise revise the concrete
    blockers, recheck line budgets and open-PR overlaps, and rerun. After three candidates, hold
    unresolved edits and report them as `Not verified:`.

## 5. Ship PRs and clean up

12. Clone each target repo fresh in `$RUN/ship/<repo>`, branch off default, apply SHIP edits, verify
    exact line budgets, run repo format/lint/checks, and run 3-way `git merge-file` against open PRs
    (`0` added conflicts). Commit with `Dream: <YYYY-MM-DD>` trailer and open PRs (never merge).
13. Remove `$RUN` and any temporary remote artifacts on completion, and report PR links/SHAs, line
    deltas, A/B scorecard, dropped items, `Verified:`, and `Not verified:`.
