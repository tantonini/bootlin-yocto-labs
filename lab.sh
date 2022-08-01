#!/bin/bash

set -eux

BOOTLIN_YOCTO_DIR="$HOME/trainings/bootlin-yocto"
POKY_DIR="$BOOTLIN_YOCTO_DIR/poky"
BUILD_DIR="$BOOTLIN_YOCTO_DIR/build"
BOOTLIN_YOCTO_LABS_DIR="$BOOTLIN_YOCTO_DIR/bootlin-yocto-labs"

set +ux
# shellcheck source=/dev/null
source "$POKY_DIR/oe-init-build-env" "$BUILD_DIR"
set -ux

if [ ! -d "$POKY_DIR/meta/recipes-extended/ninvaders" ]; then
	ln -s "$BOOTLIN_YOCTO_LABS_DIR"/ninvaders "$POKY_DIR/meta/recipes-extended/ninvaders"
	bitbake ninvaders
fi

bitbake core-image-minimal
