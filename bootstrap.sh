#!/bin/bash

usage() {
  cat <<EOT
  Usage : bootstrap.sh [option]

  Options:
    -h   - Print this help message.
    -i   - Install system packages.
EOT
  exit 1
}

install_pkgs() {
  if [ -f /etc/debian_version ] ; then
    echo "Install Debian/Ubuntu packages for Ansible ..."
    apt-get update --fix-missing
    apt-get install -y curl bzip2 ca-certificates \
      libglib2.0-0 libxext6 libsm6 libxrender1
  elif [ -f /etc/redhat-release ] ; then
    echo "Install CentOS packages for Ansible ..."
    yum update -y && yum install -y curl bzip2
  elif [ `uname -s` = "Darwin" ] ; then
    echo "Install Homebrew packages for Ansible ..."
    brew install curl libmagic
  fi
}

install_conda() {
  if [ ! -d /opt/conda ] ; then
    curl -L -o /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
    bash /tmp/miniconda.sh -b -p /opt/conda
    rm /tmp/miniconda.sh
  fi
  export PATH=/opt/conda/bin:$PATH
}

install_ansible() {
  conda install -y -c conda-forge ansible
}

bootstrap() {
  echo "Bootstrapping ..."
  if [ $# -gt 0 ] && [ $1 = '-i' ]; then
    install_pkgs
  fi
  if [ $# -eq 0 ] || [ $1 = '-b' ] || [ $1 = '-i' ]; then
    install_conda
    install_ansible
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

if [ $# -eq 0 ] || [ $1 = '-b' ] || [ $1 = '-i' ]; then
  bootstrap $@
else
  echo -e "Unknown option: $1.\n"
  usage
fi
