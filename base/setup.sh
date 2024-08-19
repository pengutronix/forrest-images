#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

H=/home/runner

mkdir -p $H/.ssh
cat "$selfdir/known_hosts" >> $H/.ssh/known_hosts

mkdir -p /srv/shared-git
echo "shared-git /srv/shared-git 9p defaults,nofail 0 0" >> /etc/fstab
