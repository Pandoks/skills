#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT

mkdir -p "$scratch/home" "$scratch/npm-cache" "$scratch/project"

(
  cd "$scratch/project"
  HOME="$scratch/home" \
    npm_config_cache="$scratch/npm-cache" \
    npx --yes skills add "$repo_root" \
      --skill '*' \
      --agent codex \
      --copy \
      --yes
)

expected=(defacto diagram dig dive ground html test try-all)
installed="$scratch/project/.agents/skills"

for skill in "${expected[@]}"; do
  test -f "$installed/$skill/SKILL.md"
  diff -qr "$repo_root/skills/$skill" "$installed/$skill"
done

count="$(find "$installed" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
test "$count" = "${#expected[@]}"

echo "Validated ${#expected[@]} skills."
