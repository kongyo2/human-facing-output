#!/bin/sh
# Regenerate plugins/human-facing-output-manual from the main plugin.
# The copy differs only by `disable-model-invocation: true` in SKILL.md.
set -eu
cd "$(dirname "$0")/.."

src=skills/human-facing-output
manual=plugins/human-facing-output-manual
dst=$manual/skills/human-facing-output

rm -rf "$dst"
mkdir -p "$dst"
cp -R "$src/." "$dst/"

# Insert the flag just before the line that closes the frontmatter.
awk 'NR > 1 && /^---$/ && !done { print "disable-model-invocation: true"; done = 1 } { print }' \
  "$src/SKILL.md" > "$dst/SKILL.md"

# Keep the version in step with the main plugin.
version=$(sed -n 's/^ *"version": *"\([^"]*\)".*/\1/p' .claude-plugin/plugin.json)
sed 's/^\( *"version": *"\)[^"]*"/\1'"$version"'"/' "$manual/.claude-plugin/plugin.json" > "$manual/.claude-plugin/plugin.json.tmp"
mv "$manual/.claude-plugin/plugin.json.tmp" "$manual/.claude-plugin/plugin.json"
