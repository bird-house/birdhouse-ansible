#!/bin/bash

echo "\nInstalling required Ansible roles from ansible-galaxy ..."
ansible-galaxy -p roles -r requirements.yml install

echo "\nInstalling application with Ansible ..."
ansible-playbook -c local playbook.yml
