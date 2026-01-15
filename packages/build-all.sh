#!/bin/bash
# Build all packages in pkgbuilds directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKGBUILDS_DIR="${SCRIPT_DIR}/pkgbuilds"
OUTPUT_DIR="${SCRIPT_DIR}/x86_64"

echo "================================================"
echo "Building all packages in $PKGBUILDS_DIR"
echo "================================================"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Find all PKGBUILD directories
BUILD_COUNT=0
FAIL_COUNT=0
FAILED_PACKAGES=()

for pkgbuild_dir in "$PKGBUILDS_DIR"/*/; do
    if [ -f "$pkgbuild_dir/PKGBUILD" ]; then
        package_name=$(basename "$pkgbuild_dir")
        echo ""
        echo "Building: $package_name"
        
        if "$SCRIPT_DIR/build-package.sh" "$pkgbuild_dir"; then
            ((BUILD_COUNT++))
            echo "✓ $package_name built successfully"
        else
            ((FAIL_COUNT++))
            FAILED_PACKAGES+=("$package_name")
            echo "✗ $package_name failed to build"
        fi
    fi
done

echo ""
echo "================================================"
echo "Build Summary"
echo "================================================"
echo "Successful: $BUILD_COUNT"
echo "Failed: $FAIL_COUNT"

if [ $FAIL_COUNT -gt 0 ]; then
    echo ""
    echo "Failed packages:"
    for pkg in "${FAILED_PACKAGES[@]}"; do
        echo "  - $pkg"
    done
fi

echo "================================================"

# Update repository database
if [ $BUILD_COUNT -gt 0 ]; then
    echo ""
    echo "Updating repository database..."
    "$SCRIPT_DIR/update-repo.sh"
fi
