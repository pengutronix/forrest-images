#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export DPKG_FORCE=confnew

save_setup_info () {
    date="$(date --rfc-3339=seconds)"
    job="${GITHUB_JOB}"
    commit="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}"
    run="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/attempts/${GITHUB_RUN_ATTEMPT}"

    detail="Build date: ${date}\nBuild job: ${job}\nRecipe commit: ${commit}\nBuild run: ${run}"

    echo "Setup info"
    echo "----------"
    echo
    echo -e "${detail}"
    echo

    cat > ~/runner/.setup_info <<EOF
[
  {
    "group": "Image Detail",
    "detail": "${detail}"
  }
]
EOF
}

prepare () {
    sudo -E apt-get update
    sudo -E apt-get --assume-yes dist-upgrade
}

cleanup () {
    sudo -E apt-get --assume-yes autoremove
    sudo -E apt-get --assume-yes clean
    rm -rf setup-data
}
