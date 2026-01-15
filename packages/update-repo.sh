#!/bin/bash
# Update the package repository database

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="${SCRIPT_DIR}/x86_64"
REPO_NAME="relish-repo"

echo "================================================"
echo "Updating repository database: $REPO_NAME"
echo "================================================"

cd "$REPO_DIR"

# Remove old database files
rm -f "${REPO_NAME}.db"* "${REPO_NAME}.files"*

# Count packages
PKG_COUNT=$(ls -1 *.pkg.tar.zst 2>/dev/null | wc -l)

if [ "$PKG_COUNT" -eq 0 ]; then
    echo "Warning: No packages found in $REPO_DIR"
    echo "Skipping database creation."
    exit 0
fi

echo "Found $PKG_COUNT package(s)"

# Create repository database
echo "Creating repository database..."
repo-add "${REPO_NAME}.db.tar.gz" *.pkg.tar.zst

# Create symlinks for convenience
ln -sf "${REPO_NAME}.db.tar.gz" "${REPO_NAME}.db"
ln -sf "${REPO_NAME}.files.tar.gz" "${REPO_NAME}.files"

echo "================================================"
echo "Repository database updated successfully!"
echo "Database: ${REPO_NAME}.db.tar.gz"
echo "Packages: $PKG_COUNT"
echo "================================================"
