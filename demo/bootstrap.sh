#!/bin/bash

bootstrap() {
    echo "Bootstrapping Ansible ..."

    if [[ $EUID -eq 0 ]]; then
        echo "Enable sudo ..."
        if [ -f /etc/debian_version ] ; then
            apt-get update -y && apt-get install -y sudo
        elif [ -f /etc/redhat-release ] ; then
            yum update -y && yum install -y sudo
        fi
    fi

    if [ -f /etc/debian_version ] ; then
        echo "Install Debian/Ubuntu packages ..."
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
        echo "Install CentOS packages ..."
        # sudo yum update -y && sudo yum install -y epel-release wget curl gcc-c++ make tar bzip2 unzip
    elif [ `uname -s` = "Darwin" ] ; then
        echo "Install Homebrew packages ..."
        brew install ansible
    fi
}


bootstrap
