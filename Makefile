SHELL := /bin/bash

.PHONY: help apply power-user capture check

help:
	@echo "dotfiles targets:"
	@echo "  make apply    - apply Terminal.app + iTerm Dev presets"
	@echo "  make power-user - apply the optional macOS power-user layer"
	@echo "  make capture  - capture local zsh/iTerm/Terminal settings"
	@echo "  make check    - dry-run and smoke-check repo scripts"

apply:
	bash scripts/apply_all.sh

power-user:
	bash macos/power-user.sh

capture:
	bash scripts/capture_all.sh

check:
	bash scripts/check_all.sh
