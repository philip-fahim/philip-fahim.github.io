#!/usr/bin/env bash
# Reads .env and writes env.js for local use (env.js is gitignored).
set -euo pipefail
cd "$(dirname "$0")/.."

if [[ ! -f .env ]]; then
  echo "Missing .env — copy .env.example to .env and add your key." >&2
  exit 1
fi

# shellcheck disable=SC1091
set -a
source .env
set +a

if [[ -z "${WEB3FORMS_ACCESS_KEY:-}" ]]; then
  echo "WEB3FORMS_ACCESS_KEY is empty in .env" >&2
  exit 1
fi

cat > env.js <<EOF
window.__ENV__ = { WEB3FORMS_ACCESS_KEY: "${WEB3FORMS_ACCESS_KEY}" };
EOF

echo "Wrote env.js"
