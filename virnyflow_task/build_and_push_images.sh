#!/bin/bash
# Script to build and push Docker images to Docker Hub
# Usage: ./build_and_push_images.sh <dockerhub_username> [version_tag]

set -e

DOCKERHUB_USERNAME=${1:-"your-dockerhub-username"}  # Replace with your Docker Hub username
VERSION_TAG=${2:-"latest"}  # Default to 'latest', or specify a version like 'v1.0.0'

if [ "$DOCKERHUB_USERNAME" == "your-dockerhub-username" ]; then
    echo "❌ Error: Please provide your Docker Hub username"
    echo "Usage: ./build_and_push_images.sh <dockerhub_username> [version_tag]"
    echo "Example: ./build_and_push_images.sh myusername v1.0.0"
    exit 1
fi

echo "🔨 Building and pushing images to Docker Hub..."
echo "Docker Hub Username: $DOCKERHUB_USERNAME"
echo "Version Tag: $VERSION_TAG"
echo ""

# Build VirnyFlow image (used by task-manager and worker)
echo "📦 Building virnyflow image..."
docker build -f Dockerfile_VirnyFlow -t ${DOCKERHUB_USERNAME}/virnyflow:${VERSION_TAG} .
docker tag ${DOCKERHUB_USERNAME}/virnyflow:${VERSION_TAG} ${DOCKERHUB_USERNAME}/virnyflow:latest

# Build Interface image
echo "📦 Building virnyflow-interface image..."
docker build \
    --build-arg SPACE_URL=https://huggingface.co/spaces/denys-herasymuk/virnyflow-demo \
    --build-arg SPACE_BRANCH=main \
    -f Dockerfile_Interface \
    -t ${DOCKERHUB_USERNAME}/virnyflow-interface:${VERSION_TAG} .
docker tag ${DOCKERHUB_USERNAME}/virnyflow-interface:${VERSION_TAG} ${DOCKERHUB_USERNAME}/virnyflow-interface:latest

# Login to Docker Hub
echo "🔐 Logging in to Docker Hub..."
docker login

# Push images
echo "🚀 Pushing virnyflow:${VERSION_TAG}..."
docker push ${DOCKERHUB_USERNAME}/virnyflow:${VERSION_TAG}
docker push ${DOCKERHUB_USERNAME}/virnyflow:latest

echo "🚀 Pushing virnyflow-interface:${VERSION_TAG}..."
docker push ${DOCKERHUB_USERNAME}/virnyflow-interface:${VERSION_TAG}
docker push ${DOCKERHUB_USERNAME}/virnyflow-interface:latest

echo ""
echo "✅ Successfully built and pushed images!"
echo ""
echo "Images pushed:"
echo "  - ${DOCKERHUB_USERNAME}/virnyflow:${VERSION_TAG}"
echo "  - ${DOCKERHUB_USERNAME}/virnyflow:latest"
echo "  - ${DOCKERHUB_USERNAME}/virnyflow-interface:${VERSION_TAG}"
echo "  - ${DOCKERHUB_USERNAME}/virnyflow-interface:latest"
echo ""
echo "Update docker-compose.yaml to use:"
echo "  image: ${DOCKERHUB_USERNAME}/virnyflow:${VERSION_TAG}"
echo "  image: ${DOCKERHUB_USERNAME}/virnyflow-interface:${VERSION_TAG}"

