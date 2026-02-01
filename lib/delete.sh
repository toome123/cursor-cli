#!/bin/bash
curl -s -X DELETE "https://api.cursor.com/v0/agents/$AGENT_ID" \
  -H "Authorization: Bearer $CURSOR_API_KEY"
