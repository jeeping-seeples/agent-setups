#!/usr/bin/env bash
set -euo pipefail
mkdir -p "$HOME/.local/bin"
touch "$HOME/.bashrc"
if ! grep -qF '$HOME/.local/bin' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"' >> "$HOME/.bashrc"
  echo "PATH line added to ~/.bashrc"
else
  echo "PATH already in ~/.bashrc"
fi
