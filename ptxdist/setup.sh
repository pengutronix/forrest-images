#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

sudo cp "$selfdir/ptx.list" /etc/apt/sources.list.d/
sudo cp "$selfdir/*.gpg" /etc/apt/trusted.gpg.d/

sudo apt-get install -y --no-install-recommends \
	oselas.toolchain-2023.07.1-arm-v7a-linux-gnueabihf \
	oselas.toolchain-2023.07.1-x86-64-unknown-linux-gnu \
	bc bison flex gawk libxml-parser-perl python3-jinja2 python3-setuptools texinfo unzip wget

cat "$selfdir/ssh_config" >> ~/.ssh/config

sudo mkdir -p /srv/cache
echo "cache /srv/cache 9p defaults,nofail 0 0" | tee -a /etc/fstab
