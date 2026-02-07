---
name: cursor-api
description: Control the Cursor Cloud Agent via CLI. Launch, list, stop, and manage autonomous coding agents.
---

# Cursor API

Use this skill to interact with the Cursor Cloud Agent API using the local CLI wrapper.

## CLI Location
The CLI is located at: `/root/.openclaw/workspace/cursor-cli/master_control.sh`

## Usage

### 1. Launch an Agent
Launch a new coding agent on a repository.

```bash
/root/.openclaw/workspace/cursor-cli/master_control.sh launch "Your prompt here" "https://github.com/owner/repo" "optional-model"
```
- **Prompt**: Instructions for the agent.
- **Repo**: Full URL of the GitHub repository.
- **Model**: (Optional) Default is `claude-3-5-sonnet-20241022`.

### 2. List Agents
View running or recent agents.

```bash
/root/.openclaw/workspace/cursor-cli/master_control.sh list [limit]
```

### 3. Get Agent Status
Check details of a specific agent.

```bash
/root/.openclaw/workspace/cursor-cli/master_control.sh status <agent_id>
```

### 4. Stop an Agent
Stop a running agent.

```bash
/root/.openclaw/workspace/cursor-cli/master_control.sh stop <agent_id>
```

### 5. Follow-up
Send new instructions to a running agent.

```bash
/root/.openclaw/workspace/cursor-cli/master_control.sh followup <agent_id> "Follow up instructions"
```

### 6. Get Conversation History
Retrieve the logs/conversation of an agent.

```bash
/root/.openclaw/workspace/cursor-cli/master_control.sh history <agent_id>
```

## Error Handling
- If you get `401 Unauthorized`, check `CURSOR_API_KEY` env var.
- If you get `429`, wait and retry.
