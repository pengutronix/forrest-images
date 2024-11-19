#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

source "${selfdir}/../common/common.sh"

# Most copies of this disk image will not be persisted.
# Instead they will only live for one build job and will then be deleted.
# Do not waste time sending discard request in that case.
# The persist action calls fstrim for disk images that are persisted.
sudo sed -i "s/,discard,/,nodiscard,/" /etc/fstab

# There is never a case where we have to recover from an unclean shutdown,
# as the disk image will be thrown away if the machine is stopped.
# There is thus no need for a filesystem journal.
sudo tune2fs -O "^has_journal" /dev/vda1

mkdir -p ~/.ssh
cat "$selfdir/known_hosts" >> ~/.ssh/known_hosts

sudo mkdir -p /srv/shared-git
echo "shared-git /srv/shared-git 9p defaults,nofail 0 0" | sudo tee -a /etc/fstab

prepare

sudo systemctl stop unattended-upgrades
sudo -E apt-get --assume-yes purge openssh-server unattended-upgrades
sudo -E apt-get --assume-yes install rsync ssh gcc

cleanup
