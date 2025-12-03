#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOCKER_DIR="$ROOT_DIR/docker"

# Image Prefix (Organisation)
PREFIX="solarswarm"

# Timestamp-Tag (optional)
TAG="${TAG:-latest}"

usage() {
    echo "Usage: $0 [image1 image2 ...]"
    echo "If no images are specified, all images in docker/ will be built."
    exit 1
}

# If parameters were provided → build only those
if [ $# -gt 0 ]; then
    TARGETS=("$@")
else
    # Else → build all folders in docker/
    mapfile -t TARGETS < <(find "$DOCKER_DIR" -maxdepth 1 -mindepth 1 -type d -printf "%f\n")
fi

echo "--------------------------------------------------"
echo " Building Docker images"
echo " Prefix: $PREFIX"
echo " Tag:    $TAG"
echo " Targets: ${TARGETS[*]}"
echo "--------------------------------------------------"

for target in "${TARGETS[@]}"; do
    IMAGE_NAME="${PREFIX}/${target}:${TAG}"
    DIR="${DOCKER_DIR}/${target}"

    if [ ! -f "$DIR/Dockerfile" ]; then
        echo "❌ ERROR: No Dockerfile found for $target in $DIR"
        exit 1
    fi

    echo "-------------------------------------------"
    echo "🚧 Building image: $IMAGE_NAME"
    echo "📁 Directory:      $DIR"
    echo "-------------------------------------------"

    # Use BuildKit cache to speed up builds
    DOCKER_BUILDKIT=1 docker build \
        --progress=plain \
        -t "$IMAGE_NAME" \
        "$DIR" || {
            echo "❌ ERROR: Build failed for ${IMAGE_NAME}"
            exit 1
        }

    echo "✔ Successfully built $IMAGE_NAME"
done

echo "--------------------------------------------------"
echo "🎉 All images built successfully!"
