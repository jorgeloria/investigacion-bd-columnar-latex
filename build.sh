#!/bin/sh

# Stop if any command fails
set -e

# Image name (must match what you built)
IMAGE_NAME="my-latex-apa7"

# Clean old build files inside container
docker run --rm -v "$(pwd)":/workdir $IMAGE_NAME latexmk -C

# Build fresh PDF
docker run --rm -v "$(pwd)":/workdir $IMAGE_NAME latexmk -pdf -interaction=nonstopmode main.tex
