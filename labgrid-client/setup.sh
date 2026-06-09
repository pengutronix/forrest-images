#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

source "${selfdir}/../common/common.sh"

prepare

sudo cp "${selfdir}/hosts" /etc/hosts
sudo cp "${selfdir}/20-openlab.network" /etc/systemd/network/

sudo -E apt-get install --assume-yes --no-install-recommends \
    pipx

pipx ensurepath
pipx install git+https://github.com/labgrid-project/labgrid

cleanup
