#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

source "${selfdir}/../common/common.sh"

prepare

sudo -E apt-get install --assume-yes --no-install-recommends \
    debos device-tree-compiler dosfstools e2fsprogs genimage \
    user-mode-linux rauc squashfs-tools

cleanup
