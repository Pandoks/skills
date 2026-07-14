#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT
skills_cli_version="1.5.17"
skills_ref_version="0.1.1"

for skill_dir in "$repo_root"/skills/*; do
  test -d "$skill_dir"
  uvx --from "skills-ref==$skills_ref_version" agentskills validate "$skill_dir"
done

if grep -R -n -E '^allowed-tools:.*,' "$repo_root/skills"; then
  echo "allowed-tools must be a space-delimited string." >&2
  exit 1
fi

if grep -R -n -F 'superpowers:' "$repo_root/skills"; then
  echo "Standalone skills must reference installed dependency names without a plugin namespace." >&2
  exit 1
fi

mkdir -p "$scratch/home" "$scratch/npm-cache" "$scratch/project"

(
  cd "$scratch/project"
  HOME="$scratch/home" \
    npm_config_cache="$scratch/npm-cache" \
    npx --yes "skills@$skills_cli_version" add "$repo_root" \
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

bash "$repo_root/scripts/test-diagram-verifier.sh"

echo "Validated ${#expected[@]} skills with skills-ref $skills_ref_version and skills $skills_cli_version."
