#!/usr/bin/env bash
# Installs Codex, Copilot CLI, Cursor Agent, Antigravity. One failure doesn't stop the rest.
set -uo pipefail
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
rc=0
try() { "$@" || { echo "FAILED: $*" >&2; rc=1; }; }

if command -v codex >/dev/null 2>&1; then echo "codex already installed"
else try npm install -g @openai/codex; fi

if command -v copilot >/dev/null 2>&1; then echo "copilot already installed"
else try npm install -g @github/copilot; fi

if command -v cursor-agent >/dev/null 2>&1 || command -v agent >/dev/null 2>&1; then
  echo "cursor agent already installed"
else
  try bash -c 'curl -fsS https://cursor.com/install | bash'
fi

if command -v agy >/dev/null 2>&1 || [ -x "$HOME/.local/bin/agy" ]; then
  echo "agy already installed"
else
  try bash -c 'curl -fsSL https://antigravity.google/cli/install.sh | bash'
fi

exit $rc
