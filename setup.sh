#!/usr/bin/env bash
# Parent script: runs every scripts/NN-*.sh in order and reports what failed.
# Usage:  bash setup.sh            # run everything
#         bash setup.sh 04 05      # run only scripts starting with 04 / 05
set -uo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"

if [ "$#" -gt 0 ]; then
  steps=()
  for prefix in "$@"; do
    for f in "$DIR"/scripts/"$prefix"*.sh; do [ -e "$f" ] && steps+=("$f"); done
  done
else
  steps=("$DIR"/scripts/[0-9][0-9]-*.sh)
fi

failed=()
for s in "${steps[@]}"; do
  name="$(basename "$s")"
  echo
  echo "==> $name"
  if bash "$s"; then
    echo "<== $name ok"
  else
    echo "<== $name FAILED" >&2
    failed+=("$name")
  fi
done

echo
if [ "${#failed[@]}" -eq 0 ]; then
  echo "All done. Run: source ~/.bashrc"
else
  echo "Finished with failures: ${failed[*]}" >&2
  echo "Re-run just those with: bash setup.sh ${failed[*]%%-*}" >&2
  exit 1
fi
