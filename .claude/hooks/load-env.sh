#!/bin/bash
set -e

ENV_FILE="$AIJOB_ROOT/.env"

if [ -z "$AIJOB_ROOT" ]; then
  echo "WARN: AIJOB_ROOT not set" >&2
  exit 0
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "WARN: $ENV_FILE not found" >&2
  exit 0
fi

source "$ENV_FILE" 2>/dev/null

if [ -n "$CLAUDE_ENV_FILE" ]; then
  cat "$ENV_FILE" >> "$CLAUDE_ENV_FILE"
fi

exit 0
