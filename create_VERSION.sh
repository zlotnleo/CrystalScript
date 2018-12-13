#!/bin/bash
crystal env CRYSTAL_VERSION > "$(crystal env CRYSTAL_PATH |  awk -F: '{print $1}')/../VERSION"