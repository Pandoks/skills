---
name: pr-ready
description: >-
  Use before handing the user a diff or calling a PR ready, final, done, or mergeable, for
  self-review, after fix rounds, and when asked to review from every angle or babysit.
---

# PR Ready

From the repo root, inspect the full change, never just the last commit: `git diff -U0 <merge-base>`
for a PR or `git diff -U0 HEAD` locally, plus untracked files. Hand off local diffs on the existing
branch. Create a branch or commit only if asked. Finish after verification and review unless asked
to monitor. For a small, straightforward local change (under ~50 changed lines, any number of files;
the repo's `AGENTS.md` wins if stricter), run steps 1, 2, and 5 plus one fresh correctness review (a
subagent if available, told to change nothing in the repo and test only in its own scratch copy;
else a cold reread; no loop), and give a compact ≤8-line report without tables. A docs typo or
comment-only fix (no code or config) needs no review or report shape: check the diff and reply in a
sentence or two. Always apply `test-audit` when tests change and step 4 when a PR exists.

## Checklist

1. **Comments:** From the repo root, pipe that diff (untracked text files as new-file diffs) to
   `sh <this-skill-dir>/scripts/added-comments.sh`. Its output is advisory: inspect each listed line
   in context and remove only redundant comment text, never executable code, literals, requested
   notes, or tool directives (`# renovate:`, `# shellcheck`, `//nolint`, `# options:`, EmmyLua). A
   comment stays only if it states a non-obvious why (upstream bug with `TODO: <url>`, invariant, or
   constraint), on one line, with no file header, version, history, or restatement. Put chat Q&A
   answers in chat, not new code comments.
2. **Additions, names, layout, and budgets:** For each added file, helper, option, env var, guard,
   retry, or doc section, name what fails without it or delete it. Trace callers/consumers before
   deleting or moving code. Prefer the tool's native feature (with a docs link) over custom code.
   Use full-word names matching neighbors, rename stale identifiers, inline one-off wrappers when
   readable (respecting the repo's helper layout), and separate logical blocks with blank lines.
   Instruction files (`AGENTS.md`, `SKILL.md`) stay net `<= 0` lines for rewordings unless the user
   or the repo's Docs rule requires adding an entry (report before → after).
3. **Review loop:** For a PR, a complex or high-risk change, or ~50+ changed lines, run a fresh
   multi-angle review (`orchestrate` if installed, else subagents or a cold pass) across
   correctness, simplicity, this checklist, repo rules, and tests until one round is clean; one
   already done for this revision counts. Reviewers apply this checklist, write only in their own
   scratch copies, and never start another review loop. Never invent new nits in late rounds.
4. **Bot findings & PR state (when a PR exists):** Fix real bot findings; dismiss asks for hardening
   that the repo's fail-fast rule excludes, citing the rule. Confirm the PR description (with a
   terse `change | why | deleted/moved` table) matches the final diff, head is current with base,
   required CI checks and intended path-filtered jobs passed on the current head SHA, zero
   unresolved threads remain, and no review still requests changes (dismiss a bot's handled review
   yourself, with a note). Follow the repo's review triggers and wait policy (by default, stop
   waiting on missing bots 30 minutes after the last push) and name which reviews missed the head.
5. **Final verification:** Run repo format/lint/type/test checks on the final revision and verify
   through the user's real entry point (CLI, keybinding, screenshot, curl, reload, allowed deploy).

## Handoff

After all reviews finish, use this format once. Omit interim status text and empty optional fields.

- `Ready:` PR link + head SHA (several PRs: one each in merge order, saying why any is a draft), or
  for local work the current branch, uncommitted unless asked. Use `Not ready:` + exact blocker for
  a stale PR head, unverified required checks on the reviewed SHA, or any other unmet requirement.
- `Does:` up to 3 plain bullets on what it does and why, by behavior: no file names, SHAs, or counts
- `Changed:` without a PR only, up to 7 grouped rows (`change | why needed | deleted or moved to`)
- `Dismissed:` rejected bot findings + cited rule and the concrete reason in one clause (if any)
- `Verified:` entry point, input, and observed output (`test-audit` note if tests changed)
- `Not verified:` material untested path and exact blocker (if any)
- `Needs you:` copy-pasteable numbered commands flagging interactive prompts, or `nothing`

After `Needs you:`, finish on a separate line with `**tldr:** <1–2 sentences>`.
