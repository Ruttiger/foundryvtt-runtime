#!/bin/bash
set -e

MAJOR="${1:-14}"
IMAGE="ruttiger/foundryvtt-runtime:${MAJOR}"
APP_DIR="/mnt/user/appdata/foundry-${MAJOR}/app"
DATA_DIR="/mnt/user/appdata/foundry-${MAJOR}/data"

read -p "Pega la URL temporal Node.js de Foundry v${MAJOR}: " FOUNDRY_URL

mkdir -p "$APP_DIR" "$DATA_DIR"

echo "Building runtime image..."
docker build -t "$IMAGE" .

echo "Cleaning previous app..."
rm -rf "$APP_DIR"/*

echo "Installing Foundry..."
docker run --rm \
  --entrypoint bash \
  -v "$APP_DIR:/opt/foundry/app" \
  "$IMAGE" \
  -lc "cd /tmp && curl -L '$FOUNDRY_URL' -o foundry.zip && unzip -q foundry.zip -d /opt/foundry/app"

echo "Fixing permissions..."
chown -R 1000:1000 "$APP_DIR" "$DATA_DIR"

echo "Done."
echo "App:  $APP_DIR"
echo "Data: $DATA_DIR"