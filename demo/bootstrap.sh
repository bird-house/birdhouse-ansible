#!/bin/bash

usage() {
    cat <<EOT
    Usage : bootstrap.sh [option]

    Options:
        -h   - Print this help message.
EOT
    exit 1
}

install_pkgs() {
    if [[ $EUID -eq 0 ]]; then
        echo "Enable sudo ..."
        if [ -f /etc/debian_version ] ; then
            apt-get update -y && apt-get install -y sudo
        elif [ -f /etc/redhat-release ] ; then
            yum update -y && yum install -y sudo
        fi
    fi

    if [ -f /etc/debian_version ] ; then
        echo "Install Debian/Ubuntu packages for Ansible ..."
        sudo apt-get -y update
        sudo apt-get -y install software-properties-common
        # install base packages
        sudo apt-get -y install build-essential
        # install ansible
        sudo apt-add-repository -y ppa:ansible/ansible
        sudo apt-get -y update
        sudo apt-get -y install ansible
        # sudo apt-get -y install vim-common # anaconda needs xxd
    elif [ -f /etc/redhat-release ] ; then
        echo "Install CentOS packages for Ansible ..."
        # sudo yum update -y && sudo yum install -y epel-release wget curl gcc-c++ make tar bzip2 unzip
    elif [ `uname -s` = "Darwin" ] ; then
        echo "Install Homebrew packages for Ansible ..."
        brew install ansible
    fi
}

bootstrap() {
    echo "Bootstrapping ..."

    if [ $# -eq 0 ] || [ $1 = '-b' ] || [ $1 = '-i' ]; then
        install_pkgs
    fi

    echo "Bootstrapping done"
}

# Handling arguments

if [ $# -gt 1 ]; then
    echo -e "Too many arguments.\n"
    usage
fi

if [ $# -gt 0 ] && [ $1 = '-h' ]; then
    usage
fi

if [ $# -eq 0 ]; then
    bootstrap $@
else
    echo -e "Unknown option: $1.\n"
    usage
fi
