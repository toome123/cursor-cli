#!/bin/bash
curl -s -X POST "https://api.cursor.com/v0/agents/$AGENT_ID/stop" \
  -H "Authorization: Bearer $CURSOR_API_KEY"
