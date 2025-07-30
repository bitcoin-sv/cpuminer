#!/bin/bash

# Build, tag and push multi-architecture Docker image to GitHub Container Registry

REGISTRY="ghcr.io/bitcoin-sv/cpuminer"
TAG="latest"

# Ensure we're logged in to ghcr.io
echo "Building multi-architecture Docker image..."

# Create and use a new builder instance for multi-platform builds
docker buildx create --use --name multiarch-builder || docker buildx use multiarch-builder

# Build and push for both linux/amd64 and linux/arm64
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag "${REGISTRY}:${TAG}" \
  --push \
  .

# Clean up the builder
docker buildx rm multiarch-builder

echo "Build complete. Image pushed to ${REGISTRY}:${TAG}"
