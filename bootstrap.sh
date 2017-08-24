#!/bin/bash
#
# Name: bootstrap.sh
# Description: Bootstrap the Ansible installation with conda.

CONDA_PREFIX=$HOME/miniconda2
SYS_INSTALL=0

usage() {
  cat <<EOT
  Usage : bootstrap.sh [option]

  Options:
    -h           print this help message and exit
    -i           install system packages neccessary for ansible (needs sudo)
    -p PREFIX    install prefix, defaults to $CONDA_PREFIX
EOT
  exit 2
}

enable_sudo() {
  if [[ $EUID -eq 0 ]]; then
    echo "Enable sudo ..."
    if [ -f /etc/debian_version ] ; then
      apt-get update -y && apt-get install -y sudo
    elif [ -f /etc/redhat-release ] ; then
      yum update -y && yum install -y sudo
    fi
  fi
}

install_pkgs() {
  enable_sudo
  if [ -f /etc/debian_version ] ; then
    echo "Install Debian/Ubuntu packages for Ansible ..."
    sudo apt-get update --fix-missing
    sudo apt-get install -y python curl bzip2 ca-certificates \
      libglib2.0-0 libxext6 libsm6 libxrender1
  elif [ -f /etc/redhat-release ] ; then
    echo "Install CentOS packages for Ansible ..."
    sudo yum update -y && sudo yum install -y curl bzip2
  elif [ `uname -s` = "Darwin" ] ; then
    echo "Install Homebrew packages for Ansible ..."
    brew install curl libmagic
  fi
}

install_conda() {
  if [ ! -d $CONDA_PREFIX ] ; then
    curl -L -o /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
    bash /tmp/miniconda.sh -b -p $CONDA_PREFIX
    rm /tmp/miniconda.sh
  fi
  export PATH=$CONDA_PREFIX/bin:$PATH
}

install_ansible() {
  conda install -y -c conda-forge ansible
}

while getopts "hip:" x; do
  case "$x" in
    h)
      usage
      ;;
    i)
      SYS_INSTALL=1
      ;;
    p)
      CONDA_PREFIX="$OPTARG"
      ;;
    ?)
      echo "Error: did not recognize option, please try -h"
      exit 1
      ;;
  esac
done
echo "Bootstrapping ..."
if [[ $SYS_INSTALL == 1 ]]; then
  install_pkgs
fi
install_conda
install_ansible
echo "Bootstrapping done"
