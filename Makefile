.PHONY: vm rebuild clean secrets help

.DEFAULT_GOAL := help

VM_NAME := $(shell cat /proc/cmdline | sed 's/.*nixos-system-\([^-]*-[^-]*-[^-]*\)-.*/\1/')

vm_name: ## Print the name of the virtual machine.
	@echo $(VM_NAME)

rebuild: ## Rebuild NixOS configuration.
	sudo nixos-rebuild switch --flake .#$(VM_NAME)

clean: ## Clean up the Nix store.
	nix-collect-garbage -d

secrets: ## Edit the secrets file
	sops secrets/secrets.enc.yaml

help: ## Show this help.
	@printf "Usage: make [target]\n\nTARGETS:\n"; grep -F "##" $(MAKEFILE_LIST) | grep -Fv "grep -F" | grep -Fv "printf " | sed -e 's/\\$$//' | sed -e 's/##//' | column -t -s ":" | sed -e 's/^/    /'; printf "\n"
