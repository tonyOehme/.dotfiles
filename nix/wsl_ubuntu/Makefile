.PHONY: nix-install
init:
	sudo apt-get update
	sudo apt install build-essential
	sh <(curl -L https://nixos.org/nix/install) --daemon

.PHONY: install-config
init:
	nix-shell -p git --run 'git clone https://github.com/tonyOehme/.dotfiles.git ~/personal/.dotfiles'
	nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/personal/.dotfiles/nix/intel_mac#intel_mac
	cd ~/personal/.dotfiles
	git submodule update --init --recursive
	stow --target=$HOME .
	rustup default stable

.PHONY: update-config
update:
	nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
	home-manager switch --extra-experimental-features 'nix-command flakes' --flake .#myprofile

.PHONY: clean
clean:
	nix-collect-garbage -d
