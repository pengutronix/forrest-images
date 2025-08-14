#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

source "${selfdir}/../common/common.sh"

mkdir -p ~/.yocto
cp "$selfdir/auto.conf" ~/.yocto/

cat "$selfdir/ssh_config" >> ~/.ssh/config

sudo mkdir -p /srv/cache
echo "cache /srv/cache 9p defaults,nofail 0 0" | sudo tee -a /etc/fstab

prepare

sudo -E apt-get install --assume-yes --no-install-recommends \
          build-essential chrpath diffstat gawk lz4 python3-setuptools tree

cleanup
