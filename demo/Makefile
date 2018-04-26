VERSION := 0.1.0

.DEFAULT_GOAL := help

.PHONY: all
all: help

.PHONY: help
help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  help        to print this help message. (Default)"
	@echo "  install     to install application by running Ansible."
	@echo "  clean       to delete all files that are created by running Ansible."


.PHONY: bootstrap
bootstrap:
	@echo "\nInstalling required Ansible roles from ansible-galaxy ..."
	@ansible-galaxy -p roles -r requirements.yml install

.PHONY: install
install: bootstrap
	@echo "\nInstalling application with Ansible ..."
	@ansible-playbook -c local playbook.yml

.PHONY: clean
clean:
	@echo "Cleaning ..."
	@git diff --quiet HEAD || echo "There are uncommited changes! Not doing 'git clean' ..."
	@-git clean -dfx -e *.bak
