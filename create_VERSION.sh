#!/bin/bash
VERSION_FILE="$(crystal env CRYSTAL_PATH |  awk -F: '{print $1}')/../VERSION"
crystal env CRYSTAL_VERSION > $VERSION_FILE