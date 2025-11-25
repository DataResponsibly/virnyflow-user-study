#!/bin/bash
# Script to build and push Docker images to Docker Hub

# Build VirnyFlow image (used by task-manager and worker) - linux/amd64 only
# This works on Mac (Intel native, Apple Silicon via emulation), Ubuntu, and Windows
echo "📦 Building virnyflow image for linux/amd64 platform..."
docker build \
    --platform linux/amd64 \
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
    --build-arg SPACE_URL=https://huggingface.co/spaces/denys-herasymuk/virnyflow-demo \
    --build-arg SPACE_BRANCH=main \
    -f Dockerfile_Interface \
    -t denys8herasymuk/virnyflow-interface:${VERSION_TAG} \
    -t denys8herasymuk/virnyflow-interface:latest \
    .
docker push denys8herasymuk/virnyflow-interface:${VERSION_TAG}
docker push denys8herasymuk/virnyflow-interface:latest

echo "✅ Images have been built and pushed for linux/amd64 platform!"
