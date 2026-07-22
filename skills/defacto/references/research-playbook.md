# Research Playbook

## Contents

- [Vendor-official sources](#vendor-official-sources)
- [Vendor-dogfooded sources](#vendor-dogfooded-sources)
- [Community sources](#community-sources)
- [Operational fallbacks](#operational-fallbacks)
- [Gap patterns](#gap-patterns)
- [Review checklist](#review-checklist)

## Vendor-official sources

Select sources for the kind of tool under review:

| Tool type | Primary sources |
|---|---|
| GitHub Action | Current README, `action.yml` or `action.yaml`, and official examples |
| CLI tool | Official docs plus the installed binary’s `--help` output |
| Library | Official docs, changelog, tests, and examples for the pinned major version |
| Framework or platform | Canonical documentation site and current migration guidance |
| Container image | Image repository README and its examples directory |

Fetch independent pages in parallel. For competing vendors, inspect both vendors’ positioning and configuration guidance. Vendor silence about the competitor is a `Vendor-silent` finding.

Record version applicability, such as `Vendor-official (current, since v9.5)`. If the README, companion action, tutorial, or other official surface disagrees, report each source separately; the intra-vendor inconsistency is itself a gap.

## Vendor-dogfooded sources

Choose dogfood that exercises the user’s scenario:

- CI, build, or development tools: maintainer workflows that use the tool for a real user-facing task.
- Runtime tools: reference deployments or flagship applications, not merely the project’s own build pipeline.
- Libraries: official examples or a maintainer-owned application built with the library.

Dogfood demonstrates mechanics, but the maintainer’s scale, threat model, release semantics, or repository needs may differ from the user’s. State that mismatch rather than elevating dogfood above documented guidance or adopter convention.

Framework-author repository structure is not automatically app-author convention.

## Community sources

Look for independent adopter convergence appropriate to the domain:

| Question domain | Useful adopter sources |
|---|---|
| CI or GitHub Actions | Starter workflows and two or three independent production workflows |
| Runtime, install, or deploy | Reference deployments, GitOps repositories, Terraform modules, and production writeups |
| Architecture or workload shape | Canonical charts, operators, and mature project manifests |
| Library API usage | Official examples plus two or three major dependents on the same major version |
| Configuration structure | Two or three independent, production-oriented configurations |
| Young SDK ecosystem | Vendor demos plus a ranked adopter search; expect possible vendor saturation |

A dominant publisher may be a distinct signal when it ships many artifacts under one documented style guide. Name it as publisher house style rather than independent ambient convergence.

`Community-de-facto` requires either:

1. At least two unrelated adopters showing the same pattern; or
2. One canonical generator or template, such as a vendor-supported project initializer.

Flag whether convergence is traceable to an origin copied by others or ambient across independent projects. Demo forks do not count as independent adopters. One non-template adopter is `Inferred (low)` with the single-source limitation stated in the finding.

## Operational fallbacks

- List directories before guessing filenames, branches, or extensions.
- For GitHub repository content, prefer the GitHub API or a local checkout over scraping `github.com` HTML.
- When a file lookup returns 404, list the parent directory and search the repository before concluding absence.
- Batch code searches when rate limits are tight. If code search is unavailable, use recent primary project pages and disclose the smaller sample.
- Use parallel tool calls for independent single-file or single-page fetches.
- Use reasoning agents only when each source requires traversal, interpretation, or synthesis across many files.
- If no source is accessible, use the degraded-mode contract in the main skill and downgrade every claim to `Inferred`.

## Gap patterns

Name every applicable gap as bullets:

- **Vendor vs community:** Vendor recommends one pattern while adopters converge on another.
- **Intra-vendor:** Official surfaces disagree.
- **Temporal or deprecation drift:** Current guidance replaced a legacy pattern that remains visible in old tutorials.
- **Vendor silent, community converged:** The vendor does not address the question but independent adopters agree.
- **Multi-modal community:** Different user segments converge on different patterns. Preserve the split.
- **Scope vs vendor constraint:** The user’s requested topology or configuration conflicts with an explicit vendor constraint.
- **Vendor-saturated:** The ecosystem is too young or demo-driven to establish independent convention.
- **Coexistence:** Multiple tools divide responsibility without explicit vendor endorsement. Label the supporting evidence `Community-de-facto` when two or more independent adopters converge; otherwise use `Inferred` with confidence.

For multi-modal populations, anchor quantities to repository counts, a stated sample such as “three of four projects,” or documented search ranking. Otherwise use ordinal language.

## Review checklist

Before answering, confirm:

- The version or API generation was pinned before research.
- Current, legacy, dogfood, saturated, silent, community, common anti-pattern, and inferred evidence were not conflated.
- Every factual claim has a source and controlled label.
- Every compound sub-question has its own findings.
- Community convergence meets the two-adopter or canonical-template threshold.
- Missing coverage was reconstructed only for the affected sub-question.
- Population language has a quantitative or sampled anchor.
- Each audited configuration key has a distinct finding unless grouped by one shared citation.
- No recommendation was added unless requested.
- Explicit chat, length, and style constraints were honored.
