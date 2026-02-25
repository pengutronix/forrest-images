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

cache_git_repos () {
    common_git="/var/cache/forrest/common.git"
    git="sudo git --git-dir ${common_git}"

    while IFS= read -r url; do
        name="$(echo "${url}" | grep -oE '[^/]+$' | sed 's/\.git$//')"

        echo "::group::git fetch ${name}"
        $git fetch \
          --no-tags \
          --refetch \
          --no-auto-maintenance \
          --no-auto-gc \
          --write-commit-graph \
          "${url}" \
          "+refs/*:refs/cache/${name}/*"
        echo "::endgroup::"
    done < "$1"
}
