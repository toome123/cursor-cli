#!/bin/bash
curl -s -X GET "https://api.cursor.com/v0/agents/$AGENT_ID" \
  -H "Authorization: Bearer $CURSOR_API_KEY"
