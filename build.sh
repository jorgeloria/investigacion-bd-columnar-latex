#!/bin/sh

# # Stop if any command fails
# set -e

# # Image name (must match what you built)
# IMAGE_NAME="my-latex-apa7"

# docker build -t $IMAGE_NAME .

# # Clean old build files inside container
# docker run --rm -v "$(pwd)":/workdir $IMAGE_NAME latexmk -C

# # Build fresh PDF
# docker run --rm -v "$(pwd)":/workdir $IMAGE_NAME latexmk -pdf -interaction=nonstopmode main.tex


#!/bin/sh

# Stop on first error
set -e

# Default values
IMAGE_NAME="my-latex-apa7"
TEX_FILE="main.tex"
DOCKER_BUILD=true

show_help() {
    echo "Usage: ./build.sh [options]"
    echo ""
    echo "Options:"
    echo "  -i IMAGE   Docker image name (default: $IMAGE_NAME)"
    echo "  -f FILE    TeX file to compile (default: $TEX_FILE)"
    echo "  -n         Skip rebuilding Docker image"
    echo "  -h         Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./build.sh                # build main.tex using 'my-latex'"
    echo "  ./build.sh -f report.tex  # build report.tex"
    echo "  ./build.sh -i teximg      # use custom Docker image name"
    echo "  ./build.sh -n             # skip Docker build step"
}

# Parse arguments
while getopts "i:f:nh" opt; do
  case ${opt} in
    i ) IMAGE_NAME=$OPTARG ;;
    f ) TEX_FILE=$OPTARG ;;
    n ) DOCKER_BUILD=false ;;
    h ) show_help; exit 0 ;;
    \? ) show_help; exit 1 ;;
  esac
done

# 1. Build Docker image (unless skipped)
if [ "$DOCKER_BUILD" = true ]; then
  echo "📦 Building Docker image: $IMAGE_NAME"
  docker build -t "$IMAGE_NAME" .
else
  echo "⏭️ Skipping Docker build step"
fi

# 2. Clean old build files
echo "🧹 Cleaning old files for $TEX_FILE"
docker run --rm -v "$(pwd)":/workdir "$IMAGE_NAME" latexmk -C "$TEX_FILE"

# 3. Build fresh PDF
echo "📝 Compiling $TEX_FILE → PDF"
docker run --rm -v "$(pwd)":/workdir "$IMAGE_NAME" latexmk -pdf -interaction=nonstopmode "$TEX_FILE"

echo "✅ Build complete: $(basename "$TEX_FILE" .tex).pdf"
