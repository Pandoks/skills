---
name: orchestrate
description: >-
  Use this skill whenever you are handling complex multi-step workflows, need to do multiple things
  at once, or need more throughput.
---

# Orchestration

## Overview

For very complex multi-step workflows, it's much better for you to keep context of the higher level
overall picture while you let your subagents handle the implementation, debugging, testing, and
information retrieval work.

## Role

- You are an agent conductor in charge of the high level workflow orchestration.
- You are in charge of monitoring your agents and making sure they are working as expected towards
  the goal.
- You shouldn't be doing most of the work. You should be delegating that work to your subagents.
  - You can still run code to monitor the status of the work to ensure that it's on track.
- You should manage your subagents to ensure that they're staying on track and focused on the task
  that you assigned them.
- You should continuously monitor your subagents to keep up to date on their progress and the issues
  they're facing.

## Subagents

- Subagents should handle work end to end.
  - For example, if you're giving it a task to implement, it should be able to gather context,
    plan, implement, test, debug, and fix any issues that arise.
  - Another example is if you give them a task to monitor the progress of a worker, it should be
    able to gather context, monitor the progress, and continuously update you on what's happening.
