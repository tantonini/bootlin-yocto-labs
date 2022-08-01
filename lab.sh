#!/bin/bash

set -eux

BOOTLIN_YOCTO_DIR="$HOME/trainings/bootlin-yocto"
POKY_DIR="$BOOTLIN_YOCTO_DIR/poky"
BUILD_DIR="$BOOTLIN_YOCTO_DIR/build"
BOOTLIN_YOCTO_LABS_DIR="$BOOTLIN_YOCTO_DIR/bootlin-yocto-labs"
META_BOOTLINLABS_DIR="$BOOTLIN_YOCTO_LABS_DIR/meta-bootlinlabs"

set +ux
# shellcheck source=/dev/null
source "$POKY_DIR/oe-init-build-env" "$BUILD_DIR"
set -ux

# Remove layer added into poky at lab3
if [ -L "$POKY_DIR/meta/recipes-extended/ninvaders" ]; then
	rm "$POKY_DIR/meta/recipes-extended/ninvaders"
fi

# Layer created with
# bitbake-layers create-layer "$META_BOOTLINLABS_DIR" -p 7

# Layer added with
# bitbake-layers add-layer "$META_BOOTLINLABS_DIR"

bitbake ninvaders
bitbake core-image-minimal
