.DEFAULT_GOAL := all

.PHONY: all
all: help

.PHONY: help
help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  help        to print this help message. (Default)"
	@echo "  roles       to install roles from ansible-galaxy."
	@echo "  play        to run ansible playbook."

.PHONY: roles
roles:
	@echo "Installing required Ansible roles from ansible-galaxy ..."
	ansible-galaxy install -p roles -r requirements.yml --ignore-errors

.PHONY: play
play: roles
	echo "Installing PyWPS application with Ansible ..."
	ansible-playbook -c local playbook.yml
