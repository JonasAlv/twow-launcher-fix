#!/bin/bash

set -e

INSTALL_DIR="$HOME/Games/turtle-wow"
APPIMAGE_URL="https://turtle-eu.b-cdn.net/client/9BEF2C29BE14CF2C26030B086DFC854DB56096DDEAABE31D33BFC6B131EC5529/TurtleWoW.AppImage"
APPIMAGE_NAME="TurtleWoW.AppImage"
MODIFIED_APPIMAGE_NAME="TurtleWoW-SystemLibs.AppImage"
TOOL_URL="https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"
TOOL_NAME="appimagetool-x86_64.AppImage"

mkdir -p "${INSTALL_DIR}"
cd "${INSTALL_DIR}"
echo "Game directory is at ${INSTALL_DIR}"

echo "--- Downloading required files ---"
wget -q --show-progress -O "${APPIMAGE_NAME}" "${APPIMAGE_URL}"
wget -q --show-progress -O "${TOOL_NAME}" "${TOOL_URL}"

echo "--- Making files executable ---"
chmod +x "${APPIMAGE_NAME}"
chmod +x "${TOOL_NAME}"

echo "--- Extracting the AppImage ---"
./"${APPIMAGE_NAME}" --appimage-extract

echo "--- Removing ALL bundled shared libraries ---"
find squashfs-root -type f -name "*.so*" -print -delete

echo "--- Repackaging the new AppImage ---"
./"${TOOL_NAME}" squashfs-root "${MODIFIED_APPIMAGE_NAME}"

echo "--- Cleaning up temporary files ---"
rm "${APPIMAGE_NAME}"
rm "${TOOL_NAME}"
rm -rf squashfs-root

echo "--- Finalizing the new AppImage ---"
chmod +x "${MODIFIED_APPIMAGE_NAME}"

echo ""
echo "Your modified AppImage is ready: ${MODIFIED_APPIMAGE_NAME}"
echo "Attempting to launch ${MODIFIED_APPIMAGE_NAME}..."
./"${MODIFIED_APPIMAGE_NAME}"