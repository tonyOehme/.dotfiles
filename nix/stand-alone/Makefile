ARCHITECTURE = $(shell uname --processor)
USERNAME = $(shell uname --nodename)
KERNELNAME = $(shell uname --kernel-name | tr '[:upper:]' '[:lower:]')
DOTFILESDIRECTORY = ~/personal/.dotfiles
FLAKE = $(DOTFILESDIRECTORY)/nix/stand-alone#$(ARCHITECTURE)-$(KERNELNAME)/$(USERNAME)


.PHONY: nix-install
nix-install:
	mkdir studium
	mkdir personal
	mkdir work
	ssh-keygen -t ed25519 -f ~/.ssh/id_personal_github_wslUbuntu
	sudo apt-get update
	sudo apt install build-essential
	sh <(curl -L https://nixos.org/nix/install) --daemon

.PHONY: install-config
install-config:
	nix-shell -p git --run 'git clone https://github.com/tonyOehme/.dotfiles.git $(DOTFILESDIRECTORY)'
	sed -i '' "/testuser/a\\\t \"$(whoami)\" " $(DOTFILESDIRECTORY)/nix/macOS/flake.nix

	home-manager switch --extra-experimental-features 'nix-command flakes' --flake $(FLAKE)
	cd $(DOTFILESDIRECTORY)
	git submodule update --init --recursive
	stow --target=$HOME .
	rustup default stable

.PHONY: update-config
update-config:
	nix run home-manager --extra-experimental-features 'nix-command flakes' -- switch --flake $(DOTFILESDIRECTORY)/nix/stand-alone#x86_64-linux/tonyyep

.PHONY: clean
clean:
	nix-collect-garbage -d
