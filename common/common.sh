#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export DPKG_FORCE=confnew

prepare () {
    sudo -E apt-get update
    sudo -E apt-get --assume-yes dist-upgrade
}

cleanup () {
    sudo -E apt-get --assume-yes autoremove
    sudo -E apt-get --assume-yes clean
    rm -rf setup-data
}
