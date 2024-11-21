#!/bin/bash

# Set variables
IMAGE_NAME="arifcodes/php83-fpm-swoole"
VERSION="8.3"
PLATFORMS="linux/amd64,linux/arm64"

# Build and push multi-architecture image
echo "Building and pushing multi-architecture image..."
docker buildx build \
  --platform=${PLATFORMS} \
  --tag ${IMAGE_NAME}:${VERSION} \
  --tag ${IMAGE_NAME}:latest \
  --push \
  .

echo "Build and push completed!"

