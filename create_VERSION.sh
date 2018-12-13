#!/bin/bash
CRYSTAL_INSTALL_DIR="$(crystal env CRYSTAL_PATH |  awk -F: '{print $1}')/../"
crystal env CRYSTAL_VERSION > "$CRYSTAL_INSTALL_DIR/VERSION"
chown $USER "$CRYSTAL_INSTALL_DIR/VERSION"