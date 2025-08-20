#!/bin/bash

set -e

mkdir -p $HOME/Games/turtle-wow/
cd $HOME/Games/turtle-wow/
echo "Game directory created at $HOME/Games/turtle-wow/"
echo "Appimage will be installed in $HOME/Games/turtle-wow/"

APPIMAGE_URL="https://turtle-eu.b-cdn.net/client/9BEF2C29BE14CF2C26030B086DFC854DB56096DDEAABE31D33BFC6B131EC5529/TurtleWoW.AppImage"
APPIMAGE_NAME="TurtleWoW.AppImage"
MODIFIED_APPIMAGE_NAME="TurtleWoW-fix.AppImage"

TOOL_URL="https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"
TOOL_NAME="appimagetool-x86_64.AppImage"

echo "--- Downloading required files ---"
wget -q --show-progress -O "${APPIMAGE_NAME}" "${APPIMAGE_URL}"
wget -q --show-progress -O "${TOOL_NAME}" "${TOOL_URL}"

echo "--- Making files executable ---"
chmod +x "${APPIMAGE_NAME}"
chmod +x "${TOOL_NAME}"

echo "--- Extracting the AppImage ---"
./"${APPIMAGE_NAME}" --appimage-extract

echo "--- Removing bundled libraries ---"
find squashfs-root -type f \( -name "libX*.so*" -o -name "libxcb*.so*" -o -name "libwayland*.so*" \) -print -delete

echo "--- Repackaging the new AppImage ---"
./"${TOOL_NAME}" squashfs-root "${MODIFIED_APPIMAGE_NAME}"

echo "--- Cleaning up temporary files ---"
rm "${APPIMAGE_NAME}"
rm "${TOOL_NAME}"
rm -rf squashfs-root

echo "--- Finalizing the new AppImage ---"
chmod +x "${MODIFIED_APPIMAGE_NAME}"

echo ""
echo "Success! Your modified AppImage is ready: ${MODIFIED_APPIMAGE_NAME}"
echo "Launching ${MODIFIED_APPIMAGE_NAME}"
./"${MODIFIED_APPIMAGE_NAME}"