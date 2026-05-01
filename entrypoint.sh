#!/usr/bin/env bash
set -e

APP_DIR="${FOUNDRY_APP_DIR:-/opt/foundry/app}"
DATA_DIR="${FOUNDRY_DATA_DIR:-/data}"
PORT="${FOUNDRY_PORT:-30000}"

mkdir -p "$APP_DIR" "$DATA_DIR"

echo "Ensuring permissions..."
chown -R node:node "$APP_DIR" "$DATA_DIR"

if [ ! -f "$APP_DIR/package.json" ]; then
  echo "Foundry is not installed in $APP_DIR"

  if [ -z "${FOUNDRY_RELEASE_URL:-}" ]; then
    echo "ERROR: FOUNDRY_RELEASE_URL is required for first install."
    echo "Get it from Foundry VTT account -> Purchased Licenses -> Download -> Node.js"
    exit 1
  fi

  echo "Installing Foundry from FOUNDRY_RELEASE_URL..."
  curl -L "$FOUNDRY_RELEASE_URL" -o /tmp/foundry.zip
  unzip -q /tmp/foundry.zip -d "$APP_DIR"
  rm /tmp/foundry.zip

  echo "Fixing permissions after install..."
  chown -R node:node "$APP_DIR"
fi

exec gosu node node "$APP_DIR/main.mjs" \
  --dataPath="$DATA_DIR" \
  --port="$PORT" \
  "$@"