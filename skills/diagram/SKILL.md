---
name: diagram
description: >-
  Use when the user asks to map or visualize an interactive system,
  architecture, topology, or flow whose value comes from showing connected
  parts across multiple scenarios or step sequences. When the sibling html
  skill is installed, prefer this for multi-scenario node-and-flow
  visualizations. Skip a single static image, simple chart or table, or
  non-visual explanation.
compatibility: Requires Node.js 18+ and a graphical browser; Playwright is optional for automated rendering.
---

# Interactive System Diagrams

## Overview

Create one self-contained HTML file with a pannable, zoomable node canvas, numbered flows, scenario tabs, and a step panel. Reuse [assets/template.html](assets/template.html) unchanged; customize only the diagram data and four documented placeholders.

Use this skill when the explanation is fundamentally a system of connected parts viewed across two or more scenarios. When the sibling `html` skill is installed, use it for prose explainers, comparison grids, single static SVGs, and editors; otherwise create the simpler artifact directly.

## Output handling

1. Write to `./.agents/artifacts/YYYY-MM-DD-<kebab-slug>.html` in a repository, or the platform temporary directory otherwise.
2. Ensure `.agents/artifacts/` is ignored by Git on first use. Do not commit the artifact unless asked.
3. Keep the output self-contained; do not add CDN assets.
4. Open the completed file with the platform’s normal browser opener.
5. Reply with the path and must-see warnings only; the artifact is the explanation.

## Workflow

1. **Design the data.** Read [data-contract.md](references/data-contract.md), then choose:
   - Nodes: distinct system parts.
   - Zones: optional logical groupings.
   - Scenarios: two to six flows worth showing.
   - Per scenario: grid positions, numbered arrows, and matching steps.

2. **Fill the template.** Copy [assets/template.html](assets/template.html) verbatim and replace only:
   - `/*__NODES__*/` with `const NODES = { … };` and `const ZONE_LABELS = { … };`
   - `/*__SCENARIOS__*/` with `const SC = { … };`
   - `__TITLE__` with the document title.
   - `__BRAND__` with the top-left brand line.

3. **Verify.** Run:

   ```bash
   node <absolute-skill-directory>/scripts/verify.js <output.html>
   ```

   Resolve every reported overlap, crossing, collision, malformed arrow, orphan node, and step mismatch. Rerun until it prints `ALL CHECKS PASSED`. If Playwright is unavailable, static validation still runs; visually inspect the opened file more carefully.

4. **Open and inspect.** Click every scenario, confirm the content is correct, and check that arrows describe the real sequence. Structural validation cannot prove domain accuracy.

## Quality bar

- Use two to six scenarios. Use a static artifact when there is only one view.
- Keep `flow` and `steps` arrays one-to-one and in the same order.
- Ensure every visible node participates in a flow.
- Keep node IDs stable across scenarios and channel vocabulary consistent.
- Prefer adjacent grid hops and sparse layouts over crossings.
- Represent work performed on one node with `net: 'compute'` and the same source/destination node.
- Never edit or retype the rendering engine.

## Common mistakes

| Mistake                                    | Fix                                                                       |
| ------------------------------------------ | ------------------------------------------------------------------------- |
| Arrow crosses a third node                 | Move a node to another row or adjust `bow`.                               |
| Return overlaps the forward path           | Use a larger opposite bow for the return.                                 |
| `flow` and `steps` differ                  | Make them one-to-one; numbering follows array order.                      |
| A scenario contains an orphan node         | Remove it from the grid or connect it to the real flow.                   |
| A local action becomes a zero-length arrow | Use the same node at both ends with `net: 'compute'`.                     |
| Verification passes but content is wrong   | Inspect every tab and compare the sequence with grounded source behavior. |

## Chat reply

Reply with one line, for example:

```text
Wrote and opened ./.agents/artifacts/2026-06-15-bill-to-law.html — 4 scenarios.
```
