---
name: clean-up
description: >-
  Use when the user says cleanup or clean up, when a PR you worked on is merged or closed, or when a
  task is finished and the user is moving on.
---

# Clean Up

1. Inventory what this thread created across every host it touched: worktrees, branches, temp files,
   servers, containers, images, cloud and cluster resources, scheduled jobs, and dead code.
2. Before deleting, check open PRs (drafts included), worktree contents, and unpushed or unmerged
   commits. Delete without asking only what this thread created, nothing still uses, and holds no
   unique work.
3. Keep every open PR and its branch, whoever opened it, unless the user asks for its removal. Leave
   what you did not create untouched; list it under `Needs your call` only if it looks abandoned or
   you cannot tell whose it is.
4. After a merge: fast-forward the default-branch checkout and list what PRs remain for the user to
   review next.
5. Report one short table: `Deleted | Kept (why) | Needs your call`.
