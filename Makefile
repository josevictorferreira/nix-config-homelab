.PHONY: rebuild clean help

.DEFAULT_GOAL := help

rebuild: ## Rebuild NixOS configuration.
	sudo nixos-rebuild switch --flake .

clean: ## Clean up the Nix store.
	nix-collect-garbage -d

help: ## Show this help.
	@printf "Usage: make [target]\n\nTARGETS:\n"; grep -F "##" $(MAKEFILE_LIST) | grep -Fv "grep -F" | grep -Fv "printf " | sed -e 's/\\$$//' | sed -e 's/##//' | column -t -s ":" | sed -e 's/^/    /'; printf "\n"
