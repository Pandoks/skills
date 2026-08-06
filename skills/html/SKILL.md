---
name: html
description: >-
  Use when the user asks for a self-contained HTML artifact, interactive
  explainer, playground, prototype, shareable report or spec, or a visual
  document with richer layout than chat; or when the requested deliverable
  would otherwise exceed about 50 lines or is clearly meant to be shared.
  When the sibling diagram skill is installed, prefer it for multi-scenario
  node-and-flow systems. Skip ordinary plans, brief comparisons,
  conversational explanations, code edits, commit messages, and PR bodies.
compatibility: Requires a graphical browser and a platform command capable of opening local HTML files.
---

# HTML Artifacts

## Overview

Create one self-contained HTML file and open it in the browser. The artifact carries the explanation; the chat response contains only its path and must-see warnings.

When the sibling `diagram` skill is installed, use it instead for a multi-scenario node-and-flow visualization; otherwise build the visualization directly. Combine this workflow with any available design or playground guidance when specialized interaction or visual polish is needed; do not assume optional skills are installed.

## When to use

- The user explicitly requests HTML, an interactive explainer, prototype, playground, or shareable visual document.
- A report, spec, research synthesis, or incident writeup needs richer layout than chat.
- The deliverable requires interactive controls, inline SVG, annotated code, or a custom editor.
- The result is long enough to benefit materially from navigation and a standalone file.

Skip ordinary plans, short comparisons, conversational answers, source-code edits, commit messages, and PR bodies. Respect an explicit request for Markdown or chat output.

## File handling

1. Write `./.agents/artifacts/YYYY-MM-DD-<kebab-slug>.html` in a repository; otherwise use a platform temporary directory.
2. Ensure `.agents/artifacts/` is ignored by Git on first use. Do not commit artifacts unless asked.
3. Keep everything inline: CSS, SVG, JavaScript, fonts, and data. Do not use CDNs or remote runtime dependencies.
4. Open the file with the platform’s normal browser opener.
5. Use a descriptive content slug, not `output.html` or `report.html`.

## Quality bar

Every artifact includes:

- `<!doctype html>`, UTF-8 charset, viewport metadata, and a meaningful title.
- Semantic headings, keyboard-accessible controls, visible focus states, and sufficient contrast.
- A system font stack, readable prose width, responsive layout, and dark-mode support.
- A table of contents and anchors when there are three or more major sections.
- Inline SVG for diagrams and proper HTML tables for tabular data.
- `<pre><code>` blocks for code, without external syntax-highlighter dependencies.

For common formats:

- **Comparisons:** Use a responsive grid or table and label each option’s core trade-off.
- **Interactive editors:** Provide an export or copy button and visible success feedback.
- **Code or PR explainers:** Show actual code or diffs with annotations and severity labels.
- **Research and incidents:** Lead with the key finding and place source links beside the claims.

## Verification

Before opening the artifact:

1. Confirm there are no remote `<script>`, stylesheet, font, image, or module dependencies unless the user explicitly requested them.
2. Parse or open the file in a browser and check the console for errors.
3. Exercise every interactive control and export action.
4. Check the layout at narrow and wide viewport sizes.
5. Confirm keyboard navigation and dark mode remain readable.

## Chat contract

After opening, reply with:

1. One line containing the path and that it opened.
2. Only warnings the user must see before opening the artifact.

Do not duplicate the artifact with a summary, section list, excerpts, or a trailing offer in chat.

## Common mistakes

| Mistake                                        | Fix                                                                                                 |
| ---------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| External CDN or font                           | Inline it or use system assets.                                                                     |
| ASCII diagram                                  | Use inline SVG.                                                                                     |
| Artifact saved at repo root                    | Use `.agents/artifacts/` and ignore it.                                                             |
| Interactive control without export             | Add a copy/download action and feedback.                                                            |
| Long chat recap beside the file                | Keep chat to the path and critical warnings.                                                        |
| Multi-scenario system forced into generic HTML | Use the sibling `diagram` skill when installed; otherwise build a dedicated node-and-flow artifact. |

Artifacts live in `./.agents/artifacts/`; check that directory when the user refers to a previous artifact.
