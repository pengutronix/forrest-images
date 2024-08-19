#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

mkdir -p ~/.ssh
cat "$selfdir/known_hosts" >> ~/.ssh/known_hosts

sudo mkdir -p /srv/shared-git
echo "shared-git /srv/shared-git 9p defaults,nofail 0 0" | sudo tee -a /etc/fstab
