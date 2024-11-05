ARCHITECTURE = $(shell uname --processor)
USERNAME = $(shell uname --nodename)
KERNELNAME = $(shell uname --kernel-name | tr '[:upper:]' '[:lower:]')
DOTFILESDIRECTORY = ~/personal/.dotfiles
FLAKE = $(DOTFILESDIRECTORY)/nix/wsl_ubuntu#$(ARCHITECTURE)-$(KERNELNAME)/$(USERNAME)


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
	nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
	home-manager switch --extra-experimental-features 'nix-command flakes' --flake $(FLAKE)
	cd $(DOTFILESDIRECTORY)
	git submodule update --init --recursive
	stow --target=$HOME .
	rustup default stable

.PHONY: update-config
update-config:
	nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
	home-manager switch --extra-experimental-features 'nix-command flakes' --flake $(FLAKE)

.PHONY: clean
clean:
	nix-collect-garbage -d
