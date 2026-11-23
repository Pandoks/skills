#!/bin/sh
# Lists comment lines added by a unified diff as file:line: text.
set -eu

awk '
  /^diff --git / { in_hunk = 0; old_rem = 0; new_rem = 0; next }
  /^\+\+\+ / && !in_hunk {
    file = substr($0, 5)
    sub(/\t.*$/, "", file)
    if (file ~ /^".*"$/) file = substr(file, 2, length(file) - 2)
    if (file == "/dev/null") { file = ""; next }
    sub(/^[ab]\//, "", file)
    next
  }
  /^@@ / {
    n_old = split($2, old_r, ",")
    old_rem = (n_old == 2) ? old_r[2] + 0 : 1
    n_new = split($3, new_r, ",")
    line = substr(new_r[1], 2) + 0
    new_rem = (n_new == 2) ? new_r[2] + 0 : 1
    in_hunk = (old_rem > 0 || new_rem > 0)
    next
  }
  in_hunk && /^ / {
    line++; old_rem--; new_rem--
    if (old_rem <= 0 && new_rem <= 0) in_hunk = 0
    next
  }
  in_hunk && /^-/ {
    old_rem--
    if (old_rem <= 0 && new_rem <= 0) in_hunk = 0
    next
  }
  in_hunk && /^\+/ {
    text = substr($0, 2)
    line++; new_rem--
    if (old_rem <= 0 && new_rem <= 0) in_hunk = 0
    if (file == "" || file ~ /(\.(md|txt|json|lock|sum)|go\.mod)$/) next
    trimmed = text
    sub(/^[ \t]+/, "", trimmed)
    if (trimmed ~ /^(#!|# (renovate|shellcheck|hadolint|yaml-language-server|syntax=|options:)|\/\/ ?(eslint|@ts-|go:|nolint|prettier)|#nosec|--- ?@)/) next
    dashes = file ~ /\.(lua|sql)$/
    hashes = file ~ /(\.(sh|bash|zsh|ya?ml|py|rb|toml|cfg|ini|conf|env|tf|hcl|mk|pl|r|R|Dockerfile)|(^|\/)(Dockerfile|[Mm]akefile|GNUmakefile|[Jj]ustfile|Brewfile|Gemfile|Vagrantfile|\.[a-z]*(ignore|rc)))$/
    whole = trimmed ~ /^(\/\/|<!--|\/\*|\{\/\*)/ || (hashes && trimmed ~ /^#/) || (dashes && trimmed ~ /^--/) || (file ~ /\.(tsx?|jsx?|mjs|svelte|go|c|h|m|css)$/ && trimmed ~ /^\*/)
    trailing = (text ~ /[ \t]\/\/ / || (hashes && text ~ /[ \t]# /) || (dashes && text ~ /[ \t]-- /)) && text !~ /[ \t]# (v?[0-9][0-9.]*[ \t]*$|renovate:|shellcheck )/ && text !~ /\/\/ indirect$/
    marker = hashes ? "[ \t](#|//) " : dashes ? "[ \t](//|--) " : "[ \t]// "
    if (trailing && !whole && match(text, marker)) {
      before = substr(text, 1, RSTART)
      if (gsub(/"/, "", before) % 2 == 1) trailing = 0
    }
    if (whole || trailing) print file ":" line - 1 ": " trimmed
  }
'
