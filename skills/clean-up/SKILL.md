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
   commits. Delete unasked only what this thread created that nothing uses and holds no unique work.
3. Keep every open PR and its branch, whoever opened it, unless the user asks for its removal. Leave
   what you did not create untouched; list it under `Needs your call` only if it looks abandoned or
   you cannot tell whose it is.
4. After a merge, fast-forward the default-branch checkout. For dotfiles and skills, do this on each
   in-scope machine or update its installed copy. Preserve local edits and rollout holds.
5. Name any work left for the user (list waiting PRs in merge order), or say the thread can be
   settled. Then give one short table: `Deleted | Kept (why) | Needs your call`.
