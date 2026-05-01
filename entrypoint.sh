#!/usr/bin/env bash
set -e

APP_DIR="${FOUNDRY_APP_DIR:-/opt/foundry/app}"
DATA_DIR="${FOUNDRY_DATA_DIR:-/data}"
PORT="${FOUNDRY_PORT:-30000}"

if [ ! -f "$APP_DIR/package.json" ]; then
  echo "ERROR: Foundry is not installed in $APP_DIR"
  echo "Install Foundry Node.js into the mounted app volume first."
  exit 1
fi

mkdir -p "$DATA_DIR"

exec node "$APP_DIR/main.mjs" \
  --dataPath="$DATA_DIR" \
  --port="$PORT" \
  "$@"