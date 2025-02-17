#!/bin/bash

# Ensure version argument is provided
if [ -z "$1" ]; then
    echo "❌ Error: Version argument is required."
    echo "Usage: $0 <version>"
    exit 1
fi

# Configuration
REPO="pawel-niedzwiecki/google-messages-client"
VERSION="$1"
TAG="v$VERSION"
TITLE="Google Message Client Desktop - v$VERSION"
DESCRIPTION="### Google Message Client Desktop v$VERSION 🚀\n\n$(awk '/## Introduction/,/## Table of Contents/' README.md | sed '1d;$d')\n\n[Full installation guide](https://github.com/$REPO#installation-for-regular-users)"

# File paths
WINDOWS_BINARY="release/$VERSION/GoogleMessagesClient-windows.exe"
MAC_BINARY="release/$VERSION/GoogleMessagesClient-mac.dmg"

# Check if binary files exist
if [[ ! -f "$WINDOWS_BINARY" || ! -f "$MAC_BINARY" ]]; then
    echo "❌ Error: Missing .exe or .dmg file in release/$VERSION/"
    exit 1
fi

# Create a new tag if it doesn't exist
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo "⚠️ Tag $TAG already exists. Skipping tag creation."
else
    git tag "$TAG"
    git push origin "$TAG"
    echo "✅ Created new tag: $TAG"
fi

# Create GitHub Release and upload binaries
gh release create "$TAG" "$WINDOWS_BINARY" "$MAC_BINARY" \
    --repo "$REPO" \
    --title "$TITLE" \
    --notes "$DESCRIPTION"

echo "🎉 Release $TAG has been successfully published!"