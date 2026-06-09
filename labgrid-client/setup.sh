#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

source "${selfdir}/../common/common.sh"

prepare

sudo cp "${selfdir}/20-cuskci.network" /etc/systemd/network/

sudo -E apt-get install --assume-yes --no-install-recommends \
    pipx

sudo -E pipx install --global --include-deps \
    git+https://github.com/labgrid-project/labgrid

cleanup
