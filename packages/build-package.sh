#!/bin/bash
# Build a single package from PKGBUILD

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKGBUILD_DIR="${1}"
OUTPUT_DIR="${SCRIPT_DIR}/x86_64"

if [ -z "$PKGBUILD_DIR" ]; then
    echo "Usage: $0 <path-to-pkgbuild-directory>"
    echo "Example: $0 pkgbuilds/my-package"
    exit 1
fi

if [ ! -f "$PKGBUILD_DIR/PKGBUILD" ]; then
    echo "Error: PKGBUILD not found in $PKGBUILD_DIR"
    exit 1
fi

echo "================================================"
echo "Building package from: $PKGBUILD_DIR"
echo "================================================"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Copy PKGBUILD to temp directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

cp -r "$PKGBUILD_DIR"/* "$TEMP_DIR/"
cd "$TEMP_DIR"

# Build package
echo "Running makepkg..."
makepkg -sf --noconfirm

# Move built packages to output directory
echo "Moving packages to $OUTPUT_DIR..."
set +e  # Temporarily disable exit on error
mv *.pkg.tar.zst "$OUTPUT_DIR/" 2>/dev/null
EXIT_CODE=$?
set -e  # Re-enable exit on error

if [ $EXIT_CODE -eq 0 ]; then
    echo "Packages moved successfully!"
else
    echo "Note: Some packages may not have been moved (this is normal for some PKGBUILDs)"
fi

echo "================================================"
echo "Package built successfully!"
echo "Output: $OUTPUT_DIR"
echo "================================================"
