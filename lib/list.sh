#!/bin/bash
curl -s -X GET "https://api.cursor.com/v0/agents?limit=${LIMIT:-20}" \
  -H "Authorization: Bearer $CURSOR_API_KEY"
