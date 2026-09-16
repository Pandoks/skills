---
name: clean-up
description: >-
  Use this skill whenever you have fully completed a task and the user is ready to move on.
---

# Clean Up

When you are done with a task, take full inventory of all of the residual artifacts that you have
created. These mainly include:

- Worktrees
- Branches
- Temporary files
- Random residual files
- Temporary resources in the cloud
- Temporary resources in Kubernetes clusters
- Docker images
- Running containers
- Installed packages
- Installed applications
- Services
- Dead code

These are the most common sources of residual artifacts, but there may be more. You should scan the
entire system to find all of the residual artifacts that you have created.

# Presentation

Once you have a complete inventory of all of the residual artifacts, you should present them to the
user and confirm that they are all safe to delete. 

Make sure to format your response that's easy to read and skim. The user shouldn't need to heavily
read through the confirmation. Think of short lists, tables, bullet points, etc. depending on the
context and situation.

The user may also give you feedback on artifacts that you haven't considered or veto the deletion
of certain artifacts. Take those into account.

# Clean Up

Once the user has confirmed that the residual artifacts are safe to delete, you should fully delete
them without any further prompts making sure to follow any feedback you received from the user.
