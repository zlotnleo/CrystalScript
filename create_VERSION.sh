#!/bin/bash
CRYSTAL_INSTALL_DIR="$(crystal env CRYSTAL_PATH |  awk -F: '{print $1}')/../"
sudo crystal env CRYSTAL_VERSION > "$CRYSTAL_INSTALL_DIR/VERSION"
sudo chown $USER $CRYSTAL_INSTALL_DIR/VERSION