#!/bin/bash

set -eux

BOOTLIN_YOCTO_DIR="$HOME/trainings/bootlin-yocto"
POKY_DIR="$BOOTLIN_YOCTO_DIR/poky"
META_ARM_DIR="$BOOTLIN_YOCTO_DIR/meta-arm"
META_TI_DIR="$BOOTLIN_YOCTO_DIR/meta-ti"
BUILD_DIR="$BOOTLIN_YOCTO_DIR/build"
BOOTLIN_YOCTO_LABS_DIR="$BOOTLIN_YOCTO_DIR/bootlin-yocto-labs"

if [ ! -d "$POKY_DIR" ]; then
	pushd "$BOOTLIN_YOCTO_DIR" || exit
	git clone https://git.yoctoproject.org/git/poky
	cd poky || exit
	git checkout -b kirkstone-4.0.2 kirkstone-4.0.2
	popd || exit
fi

if [ ! -d "$META_ARM_DIR" ]; then
	pushd "$BOOTLIN_YOCTO_DIR" || exit
	git clone https://git.yoctoproject.org/git/meta-arm
	cd meta-arm || exit
	git checkout -b yocto-4.0 yocto-4.0
	popd || exit
fi

if [ ! -d "$META_TI_DIR" ]; then
	pushd "$BOOTLIN_YOCTO_DIR" || exit
	git clone https://git.yoctoproject.org/git/meta-ti
	cd meta-ti || exit
	git am "$BOOTLIN_YOCTO_LABS_DIR/bootlin-lab-data/0001-Simplify-linux-ti-staging-recipe-for-the-Bootlin-lab.patch"
	popd || exit
fi

set +ux
# shellcheck source=/dev/null
source "$POKY_DIR/oe-init-build-env" "$BUILD_DIR"
set -ux

if [ ! -L "$BUILD_DIR/conf/local.conf" ]; then
	rm "$BUILD_DIR/conf/local.conf"
	ln -s "$BOOTLIN_YOCTO_LABS_DIR/build-conf/local.conf" "$BUILD_DIR/conf/local.conf"
fi

if [ ! -L "$BUILD_DIR/conf/bblayers.conf" ]; then
	rm "$BUILD_DIR/conf/bblayers.conf"
	ln -s "$BOOTLIN_YOCTO_LABS_DIR/build-conf/bblayers.conf" "$BUILD_DIR/conf/bblayers.conf"
fi
