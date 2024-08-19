#!/bin/bash

set -ex

self="$(realpath "${0}")" && selfdir="$(dirname "${self}")"

H=/home/runner

mkdir -p $H/.yocto
cp "$selfdir/auto.conf" $H/.yocto/

cat "$selfdir/ssh_config" >> $H/.ssh/config

mkdir -p /srv/cache
echo "cache /srv/cache 9p defaults,nofail 0 0" >> /etc/fstab
