#!/bin/bash
curl -s -X POST "https://api.cursor.com/v0/agents" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $CURSOR_API_KEY" \
  -d "$(jq -n --arg text "$PROMPT" --arg repo "$REPO" --arg model "$MODEL" \
    '{prompt: {text: $text}, model: $model, source: {repository: $repo, ref: "main"}}')"
