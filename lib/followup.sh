#!/bin/bash
curl -s -X POST "https://api.cursor.com/v0/agents/$AGENT_ID/followup" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $CURSOR_API_KEY" \
  -d "$(jq -n --arg text "$FOLLOWUP_TEXT" '{prompt: {text: $text}}')"
