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

# Ensure buildx is available and create a builder if needed
echo "🔧 Setting up Docker buildx for multi-platform builds..."
docker buildx create --use --name multiarch-builder 2>/dev/null || docker buildx use multiarch-builder

# Build VirnyFlow image (used by task-manager and worker) - multi-platform
echo "📦 Building virnyflow image for multiple platforms (linux/amd64, linux/arm64)..."
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -f Dockerfile_VirnyFlow \
    -t ${DOCKERHUB_USERNAME}/virnyflow:${VERSION_TAG} \
    -t ${DOCKERHUB_USERNAME}/virnyflow:latest \
    --push \
    .

# Build Interface image - multi-platform
echo "📦 Building virnyflow-interface image for multiple platforms (linux/amd64, linux/arm64)..."
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --build-arg SPACE_URL=https://huggingface.co/spaces/denys-herasymuk/virnyflow-demo \
    --build-arg SPACE_BRANCH=main \
    -f Dockerfile_Interface \
    -t ${DOCKERHUB_USERNAME}/virnyflow-interface:${VERSION_TAG} \
    -t ${DOCKERHUB_USERNAME}/virnyflow-interface:latest \
    --push \
    .

# Login to Docker Hub (needed before buildx push)
echo "🔐 Logging in to Docker Hub..."
docker login

# Note: Images are already pushed during buildx build with --push flag above
echo "✅ Images have been built and pushed for multiple platforms!"

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

