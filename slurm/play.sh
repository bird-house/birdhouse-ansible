#!/bin/bash
#ansible-playbook -c local -i hosts.example --become --ask-become-pass site.yml
ansible-playbook -c local -i hosts.example site.yml
