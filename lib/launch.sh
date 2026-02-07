#!/bin/bash
set -euo pipefail

# Optional REF override via env (export REF=...) or launch arg 4.
# If REF is not provided, try to detect a sensible default branch.
REF_VALUE="${REF:-}"

if [ -z "$REF_VALUE" ]; then
  # Try main, then master.
  if git ls-remote --exit-code --heads "$REPO" main >/dev/null 2>&1; then
    REF_VALUE="main"
  elif git ls-remote --exit-code --heads "$REPO" master >/dev/null 2>&1; then
    REF_VALUE="master"
  else
    # Fallback to main (Cursor API requires a ref string).
    REF_VALUE="main"
  fi
fi

curl -s -X POST "https://api.cursor.com/v0/agents" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $CURSOR_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$(jq -n --arg text "$PROMPT" --arg repo "$REPO" --arg model "$MODEL" --arg ref "$REF_VALUE" \
    '{prompt: {text: $text}, model: $model, source: {repository: $repo, ref: $ref}}')"
