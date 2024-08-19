#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

H=/home/runner

cp "$selfdir/ptx.list" /etc/apt/sources.list.d/
cp "$selfdir/*.gpg" /etc/apt/trusted.gpg.d/

apt-get update
apt-get install -y --no-install-recommends \
	oselas.toolchain-2023.07.1-arm-v7a-linux-gnueabihf \
	oselas.toolchain-2023.07.1-x86-64-unknown-linux-gnu \
	bc bison flex gawk libxml-parser-perl python3-jinja2 python3-setuptools texinfo unzip wget

cat "$selfdir/ssh_config" >> $H/.ssh/config

mkdir -p /srv/cache
echo "cache /srv/cache 9p defaults,nofail 0 0" >> /etc/fstab
