SHELL := /bin/bash

.PHONY: help bootstrap apply power-user mission-control capture check

help:
	@echo "dotfiles targets:"
	@echo "  make bootstrap - wire zsh and apply the dotfiles stack safely"
	@echo "  make apply    - apply Terminal.app + iTerm Dev presets"
	@echo "  make power-user - apply the optional macOS power-user layer"
	@echo "  make mission-control - apply Mission Control and hot corners"
	@echo "  make capture  - capture local zsh/iTerm/Terminal settings"
	@echo "  make check    - dry-run and smoke-check repo scripts"

bootstrap:
	bash bootstrap.sh

apply:
	bash scripts/apply_all.sh

power-user:
	bash macos/power-user.sh

mission-control:
	bash macos/mission-control.sh

capture:
	bash scripts/capture_all.sh

check:
	bash scripts/check_all.sh
