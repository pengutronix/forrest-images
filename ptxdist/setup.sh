#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

source "${selfdir}/../common/common.sh"

sudo cp "$selfdir/ptx.list" /etc/apt/sources.list.d/
sudo cp "$selfdir/pengutronix-archive-keyring-2024.gpg" /etc/apt/trusted.gpg.d/

cat "$selfdir/ssh_config" >> ~/.ssh/config

# PTXDist needs to be able to write to the SRCDIR in /srv/cache/src.
# The cache is however readonly. Use an overlayfs to make it writable.
sudo mkdir -p /srv/cache /srv/cache-ro /srv/cache-overlay /srv/cache-work
echo "cache /srv/cache-ro 9p defaults,nofail,ro 0 0" | sudo tee -a /etc/fstab
echo "overlayfs /srv/cache overlayfs defaults,lowerdir=/srv/cache-ro,upperdir=/srv/cache-overlay,workdir=/srv/cache-work 0 0" | sudo tee -a /etc/fstab

prepare

sudo apt-get install -y --no-install-recommends \
	oselas.toolchain-2023.07.1-mipsel-softfloat-linux-gnu \
	oselas.toolchain-2023.07.1-mips-softfloat-linux-gnu \
	oselas.toolchain-2023.07.1-aarch64-v8a-linux-gnu \
	oselas.toolchain-2023.07.1-arm-1136jfs-linux-gnueabihf \
	oselas.toolchain-2023.07.1-arm-v7a-linux-gnueabihf \
	oselas.toolchain-2023.07.1-x86-64-unknown-linux-gnu \
	ptxdist-2023.12.0 \
	ptxdist-2024.08.0 \
	build-essential bc bison cpio flex gawk libxml-parser-perl \
	python3-jinja2 python3-setuptools python3-venv \
	texinfo unzip wget

cleanup
