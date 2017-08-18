#!/bin/bash
echo "Bootstrapping ..."

if [ -f /etc/debian_version ] ; then
  echo "Install Debian/Ubuntu packages for Ansible ..."
  sudo apt-get update -y
  sudo apt-get install -y software-properties-common
  # sudo apt-add-repository -y ppa:ansible/ansible
  echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
  sudo apt-get update -y
  sudo apt-get install -y ansible
elif [ -f /etc/redhat-release ] ; then
  echo "Install CentOS packages for Ansible ..."
  sudo yum update -y
  # ansible is in EPEL
  sudo yum install -y epel-release
  sudo yum install -y ansible
fi

echo "Bootstrapping done"
