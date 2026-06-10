#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

source "${selfdir}/../common/common.sh"

prepare

sudo cp "${selfdir}/20-cuskci.network" /etc/systemd/network/

sudo -E apt-get install --assume-yes --no-install-recommends \
    pipx qemu-system-x86 ovmf swtpm

sudo usermod -aG kvm runner

sudo -E pipx install --global --include-deps \
    git+https://github.com/labgrid-project/labgrid

echo 'LG_COORDINATOR="hekla.cuskci.stw.pengutronix.de:20408"' \
    | sudo tee -a /etc/environment

cleanup
