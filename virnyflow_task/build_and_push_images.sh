#!/bin/bash
# Script to build and push Docker images to Docker Hub
# Uses Docker BuildKit for better caching and optimization

# Enable BuildKit for better performance and caching
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Build VirnyFlow image (used by task-manager and worker) - linux/amd64 only
# This works on Mac (Intel native, Apple Silicon via emulation), Ubuntu, and Windows
echo "📦 Building virnyflow image for linux/amd64 platform..."
docker build \
    --platform linux/amd64 \
    --progress=plain \
    -f Dockerfile_VirnyFlow \
    -t denys8herasymuk/virnyflow:${VERSION_TAG} \
    -t denys8herasymuk/virnyflow:latest \
    .
docker push denys8herasymuk/virnyflow:${VERSION_TAG}
docker push denys8herasymuk/virnyflow:latest

# Build Interface image - linux/amd64 only
echo "📦 Building virnyflow-interface image for linux/amd64 platform..."
docker build \
    --platform linux/amd64 \
    --progress=plain \
    --build-arg SPACE_URL=https://huggingface.co/spaces/denys-herasymuk/virnyflow-interface \
    --build-arg SPACE_BRANCH=main \
    -f Dockerfile_Interface \
    -t denys8herasymuk/virnyflow-interface:${VERSION_TAG} \
    -t denys8herasymuk/virnyflow-interface:latest \
    .
docker push denys8herasymuk/virnyflow-interface:${VERSION_TAG}
docker push denys8herasymuk/virnyflow-interface:latest

echo "✅ Images have been built and pushed for linux/amd64 platform!"
