#!/bin/bash

set -eux

BOOTLIN_YOCTO_DIR="$HOME/trainings/bootlin-yocto"
POKY_DIR="$BOOTLIN_YOCTO_DIR/poky"
BUILD_DIR="$BOOTLIN_YOCTO_DIR/build"

set +ux
# shellcheck source=/dev/null
source "$POKY_DIR/oe-init-build-env" "$BUILD_DIR"
set -ux

bitbake core-image-minimal
