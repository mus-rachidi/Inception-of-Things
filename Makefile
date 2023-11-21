# Makefile for Inception of Things Project

.PHONY: help
help:
	@echo "Welcome to the Inception of Things Project!"
	@echo ""
	@echo "Available targets:"
	@echo "  install-vagrant       Install Vagrant on Ubuntu"
	@echo "  part1                 Set up K3s and Vagrant for Part 1"
	@echo "  part2                 Set up K3s and Three Simple Applications for Part 2"
	@echo "  bonus                 Set up Helm 3 and GitLab for Bonus"
	@echo "  clean                 Clean up the project"

.PHONY: install-vagrant
install-vagrant:
	@echo "Installing Vagrant on Ubuntu..."
	@./scripts/install-vagrant.sh

.PHONY: part1
part1:
	@echo "Setting up K3s and Vagrant for Part 1..."
	@cd p1 && vagrant up

.PHONY: part2
part2:
	@echo "Setting up K3s and Three Simple Applications for Part 2..."
	@cd p2 && vagrant up

.PHONY: bonus
bonus:
	@echo "Setting up Helm 3 and GitLab for Bonus..."
	@cd bonus && vagrant up

.PHONY: clean
clean:
	@echo "Cleaning up the project..."
	@cd p1 && vagrant destroy -f
	@cd p2 && vagrant destroy -f
	@cd bonus && vagrant destroy -f
