#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
verifier="$repo_root/skills/diagram/scripts/verify.js"
template="$repo_root/skills/diagram/assets/template.html"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT

if [[ ! -f "$verifier" ]]; then
  echo "Expected the diagram verifier at $verifier." >&2
  exit 1
fi
if git -C "$repo_root" ls-files '*.mjs' | grep -q .; then
  echo "Expected the repository to contain no .mjs files." >&2
  exit 1
fi
test -f "$template"

node "$verifier" --help >"$scratch/help.out" 2>"$scratch/help.err"
grep -Fq "Usage: node verify.js <diagram.html>" "$scratch/help.out"
test ! -s "$scratch/help.err"

mkdir -p "$scratch/esm-project"
printf '%s\n' '{"type":"module"}' >"$scratch/esm-project/package.json"
cp "$verifier" "$scratch/esm-project/verify.js"
if ! node "$scratch/esm-project/verify.js" --help >"$scratch/esm-help.out" 2>"$scratch/esm-help.err"; then
  echo "Expected verify.js to run inside a type=module project." >&2
  cat "$scratch/esm-help.err" >&2
  exit 1
fi
grep -Fq "Usage: node verify.js <diagram.html>" "$scratch/esm-help.out"
test ! -s "$scratch/esm-help.err"

if node "$verifier" "$scratch/missing.html" >"$scratch/missing.out" 2>"$scratch/missing.err"; then
  echo "Expected a missing input file to fail." >&2
  exit 1
fi
grep -Fq "diagram file not found:" "$scratch/missing.err"

if node "$verifier" "$template" >"$scratch/template.out" 2>"$scratch/template.err"; then
  echo "Expected the unfilled template to fail validation." >&2
  exit 1
fi
grep -Fq "unfilled placeholder:" "$scratch/template.out"

TEMPLATE="$template" OUTPUT="$scratch/valid.html" node --eval '
  const fs = require("node:fs");
  const nodes = `const NODES = {
    source:{w:480,h:160,zone:"",kind:"actor",icon:"S",title:"Source",sub:"start",lines:[["role","producer"]]},
    sink:{w:480,h:160,zone:"",kind:"store",icon:"D",title:"Sink",sub:"finish",lines:[["role","consumer"]]}
  };
  const ZONE_LABELS = {};`;
  const scenarios = `const SC = {
    transfer:{btn:"Transfer",title:"Transfer",desc:"A minimal valid flow.",
      grid:{source:[0,0],sink:[1,0]},
      flow:[["source:r:0.5","sink:l:0.5",1,{net:"HTTP",ep:"GET /"}]],
      steps:[["Source to sink",0]],note:["",""]}
  };`;
  const html = fs.readFileSync(process.env.TEMPLATE, "utf8")
    .replace("/*__NODES__*/", nodes)
    .replace("/*__SCENARIOS__*/", scenarios)
    .replace("__TITLE__", "Verifier fixture")
    .replace("__BRAND__", "Test");
  fs.writeFileSync(process.env.OUTPUT, html);
'

node "$verifier" "$scratch/valid.html" >"$scratch/valid.out" 2>"$scratch/valid.err"
grep -Fq "ALL CHECKS PASSED" "$scratch/valid.out"
test ! -s "$scratch/valid.err"

echo "Diagram verifier interface passed."
