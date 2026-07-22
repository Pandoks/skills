# Worked Examples

## Contents

- [Divergent signals: cosign signing](#divergent-signals-cosign-signing)
- [Multi-modal community: k3s installation](#multi-modal-community-k3s-installation)
- [Vendor saturation and deprecation drift: Zero permissions](#vendor-saturation-and-deprecation-drift-zero-permissions)

These examples demonstrate the reporting method. Re-fetch all sources and re-pin versions before using their factual content in a current answer.

## Divergent signals: cosign signing

**Question:** “What is the de facto way to sign container images with cosign: keyless OIDC or keyed?”

Research the current cosign generation, multiple official surfaces, Sigstore’s own release workflow, and at least two independent adopters. A valid report distinguishes documented defaults, companion-tool examples, maintainer release semantics, and adopter convergence:

```text
Vendor-official (current, README): Keyless OIDC is the documented default
(source: current cosign README).

Vendor-official (current, companion tool): The flagship installer example
shows a keyed path (source: current companion-tool README).

Vendor-dogfooded: The maintainer’s canonical release workflow uses a managed
key (source: current release workflow).

Community-de-facto: Two named independent release workflows use keyless
signing (sources: adopter A, adopter B).

Gap:
- Intra-vendor: Official surfaces lead with different paths.
- Vendor dogfood vs documentation: Canonical releases use a different threat
  model from ordinary build provenance.
```

Do not recommend one path unless asked. If asked, connect the recommendation to the user’s release and threat-model constraints.

## Multi-modal community: k3s installation

**Question:** “What is the de facto way to install k3s for a small production cluster?”

Pin current k3s guidance and separate install mechanics from high-availability constraints. Sample multiple adopter segments instead of forcing one convention:

```text
Vendor-official (current): The documented bootstrap path is the install script;
the current datastore and HA requirements depend on server count
(sources: current quick-start and HA documentation).

Vendor-silent: The vendor documentation does not prescribe every community
automation wrapper.

Community-de-facto (multi-modal):
- Bare metal and homelab samples favor the install script or an SSH wrapper.
- Cloud-IaaS samples favor Terraform modules.
- GitOps reference stacks add Argo CD or Flux after bootstrap.

Gap:
- Vendor vs community: Community automation layers sit above the official
  bootstrap path.
- Multi-modal community: The dominant wrapper depends on deployment segment.
```

Use explicit sample counts or ordinal wording. Do not invent percentages for the segments.

## Vendor saturation and deprecation drift: Zero permissions

**Question:** “What is the de facto way to define permissions in Rocicorp Zero?”

First determine whether a permissions API was renamed, deprecated, or replaced. Then compare current documentation, legacy documentation, the maintainer’s flagship app, and independent adopters:

```text
Vendor-official (current): Permissions are implemented through the current
authenticated query and mutation model (source: current permissions docs).

Vendor-official (legacy): The former first-class permissions API is deprecated
or scheduled for removal (source: current deprecation page).

Vendor-dogfooded: The flagship app separates authentication, queries, and
mutations into named files (source: current app tree). This demonstrates
maintainer layout, not a prescribed public convention.

Vendor-saturated: The sampled third-party material is composed of vendor demos,
forks, or tutorials derived from them, with too few independent production
layouts to establish community convergence.

Gap:
- Temporal: Older tutorials still teach the deprecated generation.
- Vendor-saturated: No independent layout convention can yet be claimed.
```

Never promote the flagship app’s file split to `Community-de-facto` without independent adopters.
