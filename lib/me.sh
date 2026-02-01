#!/bin/bash
curl -s -X GET "https://api.cursor.com/v0/me" \
  -H "Authorization: Bearer $CURSOR_API_KEY"
