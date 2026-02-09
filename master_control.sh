#!/bin/bash
# Master Controller for Cursor Agent CLI

# Get directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/utils.sh"

check_deps
check_auth

COMMAND=$1
shift

case "$COMMAND" in
  "launch")
    # Usage: ./cursor_ops.sh launch "Prompt" "RepoURL" [Model] [Ref]
    export PROMPT="$1"
    export REPO="$2"
    # Cursor model names change over time; keep this in sync with `master_control.sh models`.
    # Current defaults (2026-02): gpt-5.2 / gpt-5.2-high / gpt-5.2-codex-high / claude-4.6-opus-high-thinking
    export MODEL="${3:-gpt-5.2-codex-high}"
    if [ -z "${3:-}" ]; then export MODEL="gpt-5.2-codex-high"; fi 
    export REF="$4"

    "$DIR/lib/launch.sh"
    ;;
  "list")
    export LIMIT="${1:-20}"
    "$DIR/lib/list.sh"
    ;;
  "status")
    export AGENT_ID="$1"
    "$DIR/lib/status.sh"
    ;;
  "stop")
    export AGENT_ID="$1"
    "$DIR/lib/stop.sh"
    ;;
  "delete")
    export AGENT_ID="$1"
    "$DIR/lib/delete.sh"
    ;;
  "followup")
    export AGENT_ID="$1"
    export FOLLOWUP_TEXT="$2"
    "$DIR/lib/followup.sh"
    ;;
  "history")
    export AGENT_ID="$1"
    "$DIR/lib/conversation.sh"
    ;;
  "models")
    "$DIR/lib/models.sh"
    ;;
  "repos")
    "$DIR/lib/repos.sh"
    ;;
  "whoami")
    "$DIR/lib/me.sh"
    ;;
  *)
    echo "Usage: $0 {launch|list|status|stop|delete|followup|history|models|repos|whoami} [args...]"
    exit 1
    ;;
esac
