#!/bin/sh

. /etc/os-release

if [ "$VERSION_ID" = "20.10" ]
    sudo apt install -y podman
then
    . /etc/os-release
    echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
    curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -
    sudo apt-get update
    sudo apt-get -y install podman
fi

sudo curl -H "Content-Type: application/json" --unix-socket /var/run/docker.sock http://localhost/_ping
