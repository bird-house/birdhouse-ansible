VERSION := 0.1.0

# guess OS (Linux, Darwin, ...)
OS_NAME := $(shell uname -s 2>/dev/null || echo "unknown")
CPU_ARCH := $(shell uname -m 2>/dev/null || uname -p 2>/dev/null || echo "unknown")

# end of configuration

.DEFAULT_GOAL := help

.PHONY: all
all: help

.PHONY: help
help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  help        to print this help message. (Default)"
	@echo "  version     to print version number of this Makefile."
	@echo "  info        to print information about your System."
	@echo "  install     to install application by running Ansible."
	@echo "\nSupervisor targets:"
	@echo "  status      to show supervisor status"

.PHONY: version
version:
	@echo "Version: $(VERSION)"

.PHONY: info
info:
	@echo "Information about your System:"
	@echo "  OS_NAME             $(OS_NAME)"
	@echo "  CPU_ARCH            $(CPU_ARCH)"

.PHONY: bootstrap
bootstrap:
	@echo "\nInstalling required Ansible roles from ansible-galaxy ..."
	@ansible-galaxy -p roles -r requirements.yml install

.PHONY: install
install: bootstrap
	@echo "\nInstalling application with Ansible ..."
	@ansible-playbook -c local playbook.yml

.PHONY: status
status:
	supervisorctl status
