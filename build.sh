#!/bin/bash
set -e

MAJOR="${1:-14}"
IMAGE="ruttiger/foundryvtt-runtime:${MAJOR}"

echo "Building image $IMAGE"
docker build -t "$IMAGE" .

echo "Done"