#!/bin/bash
set -euo pipefail

MAJOR="${1:-14}"
CONTAINER="${2:-foundryvtt}"

SOURCE_DIR="/mnt/user/appdata/foundry-${MAJOR}"
BACKUP_DIR="/mnt/user/backups/foundry"

DATE="$(date +%Y-%m-%d_%H-%M-%S)"
BACKUP_FILE="${BACKUP_DIR}/foundry-${MAJOR}-${DATE}.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "Stopping container..."
docker stop "$CONTAINER" >/dev/null 2>&1 || true

echo "Creating backup: $BACKUP_FILE"
tar -czf "$BACKUP_FILE" -C "/mnt/user/appdata" "foundry-${MAJOR}"

echo "Starting container..."
docker start "$CONTAINER" >/dev/null 2>&1 || true

echo "Backup done."