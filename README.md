# Cursor Agent CLI (Bash Wrapper)

A lightweight Bash CLI for interacting with the Cursor Agent API. It provides
simple commands to launch agents, inspect their status, manage lifecycles,
send follow-ups, and query account metadata.

## Project Overview

This repository contains a small set of Bash scripts that wrap the Cursor
Agent API. The `master_control.sh` script acts as the entry point and delegates
to command-specific scripts under `lib/`. Requests are sent via `curl`, with
JSON payloads built using `jq`.

## Prerequisites

- `jq`
- `curl`
- `CURSOR_API_KEY` environment variable set to your Cursor API key

Example:

```bash
export CURSOR_API_KEY="your_api_key_here"
```

## Installation / Setup

1. Clone the repository:

   ```bash
   git clone <your-repo-url>
   cd <your-repo-directory>
   ```

2. Make scripts executable (if needed):

   ```bash
   chmod +x master_control.sh lib/*.sh
   ```

3. Set your API key:

   ```bash
   export CURSOR_API_KEY="your_api_key_here"
   ```

## Usage

All commands are invoked via the main script:

```bash
./master_control.sh <command> [args...]
```

### launch
Create a new agent.

```bash
./master_control.sh launch "Summarize the repo README" "https://github.com/org/repo" "gpt-5.2"
```

Optionally specify a repo ref (branch/tag):

```bash
./master_control.sh launch "Summarize the repo README" "https://github.com/org/repo" "gpt-5.2" "master"
```

Notes:
- If `model` is omitted, it defaults to `claude-3-5-sonnet-20241022`.
- If `ref` is omitted, the CLI will try `main`, then `master`.

### list
List agents (optionally limit the number of results).

```bash
./master_control.sh list 10
```

### status
Get status and details for a specific agent.

```bash
./master_control.sh status AGENT_ID
```

### stop
Stop a running agent.

```bash
./master_control.sh stop AGENT_ID
```

### delete
Delete an agent by ID.

```bash
./master_control.sh delete AGENT_ID
```

### followup
Send a follow-up prompt to an existing agent.

```bash
./master_control.sh followup AGENT_ID "Please also check for test coverage gaps."
```

### history
Fetch the conversation history for an agent.

```bash
./master_control.sh history AGENT_ID
```

### models
List available models.

```bash
./master_control.sh models
```

### repos
List repositories available to the account.

```bash
./master_control.sh repos
```

### whoami
Show account information for the current API key.

```bash
./master_control.sh whoami
```

## Directory Structure

```
.
├── master_control.sh     # Main CLI entry point
├── utils.sh              # Logging + dependency/auth checks
└── lib/
    ├── launch.sh         # POST /v0/agents
    ├── list.sh           # GET /v0/agents
    ├── status.sh         # GET /v0/agents/{id}
    ├── stop.sh           # POST /v0/agents/{id}/stop
    ├── delete.sh         # DELETE /v0/agents/{id}
    ├── followup.sh       # POST /v0/agents/{id}/followup
    ├── conversation.sh   # GET /v0/agents/{id}/conversation
    ├── models.sh         # GET /v0/models
    ├── repos.sh          # GET /v0/repositories
    └── me.sh             # GET /v0/me
```
