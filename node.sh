#!/usr/bin/env bash
# Installs Node 22 (needed by Copilot CLI) plus clipboard tools, if missing.
set -euo pipefail
SUDO=""; [ "$(id -u)" -eq 0 ] || SUDO="sudo"

$SUDO apt-get update || echo "apt-get update had warnings, continuing"
$SUDO apt-get install -y xclip wl-clipboard curl ca-certificates

major=0
command -v node >/dev/null 2>&1 && major="$(node -p 'process.versions.node.split(".")[0]')"
if [ "$major" -ge 22 ]; then
  echo "Node $(node -v) already OK"
else
  curl -fsSL https://deb.nodesource.com/setup_22.x | $SUDO bash -
  $SUDO apt-get install -y nodejs
fi
node -v && npm -v
