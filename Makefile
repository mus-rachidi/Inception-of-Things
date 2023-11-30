.PHONY: help
help:
	@echo "Welcome to the Inception of Things Project!"
	@echo ""
	@echo "Available targets:"
	@echo "  install-vagrant       Install Vagrant on Ubuntu"
	@echo "  p1                 Set up K3s and Vagrant for Part 1"
	@echo "  p2                 Set up K3s and Three Simple Applications for Part 2"
	@echo "  bonus                 Set up Helm 3 and GitLab for Bonus"
	@echo "  clean                 Clean up the project"

.PHONY: install-vagrant
install-vagrant:
	@echo "Installing Vagrant on Ubuntu..."
	@./scripts/install-vagrant.sh

.PHONY: p1
p1:
	@echo "Setting up K3s and Vagrant for Part 1..."
	@cd p1 && vagrant up

.PHONY: p1-provision
p1-provision:
	@echo "provisioning process for a running Vagrant environment for Part 1..."
	@cd p1 && vagrant provision


.PHONY: p2
p2:
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
	@cd p1 && rm -rf .vagrant
	@cd p1 && rm -rf confs/node-token
	@cd p2 && vagrant destroy -f
	@cd p2 && rm -rf .vagrant
	@cd bonus && vagrant destroy -f
	@cd bonus && rm -rf .vagrant
