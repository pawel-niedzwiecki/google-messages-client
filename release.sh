#!/bin/bash

# Configuration
REPO="pawel-niedzwiecki/google-messages-client"
VERSION="0.0.0"
TAG="v$VERSION"
TITLE="Google Message Client Desktop - v$VERSION"
DESCRIPTION="### Google Message Client Desktop v$VERSION 🚀\n\n$(awk '/## Introduction/,/## Table of Contents/' README.md | sed '1d;$d')\n\n[Full installation guide](https://github.com/$REPO#installation-for-regular-users)"

# File paths
WINDOWS_BINARY="release/0.0.0/GoogleMessagesClient-windows.exe"
MAC_BINARY="release/0.0.0/GoogleMessagesClient-mac.dmg"

# Check if the required files exist
if [[ ! -f "$WINDOWS_BINARY" || ! -f "$MAC_BINARY" ]]; then
    echo "❌ Error: Missing .exe or .dmg file in release/0.0.0/"
    exit 1
fi

# Create a new tag
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo "⚠️ Tag $TAG already exists. Skipping tag creation."
else
    git tag "$TAG"
    git push origin "$TAG"
fi

# Create GitHub Release
gh release create "$TAG" "$WINDOWS_BINARY" "$MAC_BINARY" \
    --repo "$REPO" \
    --title "$TITLE" \
    --notes "$DESCRIPTION"

echo "✅ Release $TAG has been successfully published!"