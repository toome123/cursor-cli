#!/bin/bash
set -euo pipefail

# Optional REF override via env (export REF=...) or launch arg 4.
# If REF is not provided, try to detect a sensible default branch.
REF_VALUE="${REF:-}"
export REF_VALUE

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

payload=$(python3 - <<'PY'
import json, os
payload = {
  "prompt": {"text": os.environ.get("PROMPT", "")},
  "model": os.environ.get("MODEL", ""),
  "source": {"repository": os.environ.get("REPO", ""), "ref": os.environ.get("REF_VALUE", os.environ.get("REF", ""))},
}
print(json.dumps(payload))
PY
)

curl -s -X POST "https://api.cursor.com/v0/agents" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $CURSOR_API_KEY" \
  -d "$payload"
