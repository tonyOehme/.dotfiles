.PHONY: init
init:
	sh <(curl -L https://nixos.org/nix/install) --daemon

.PHONY: update
update:
	nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
	home-manager switch --extra-experimental-features 'nix-command flakes' --flake .#myprofile 

.PHONY: clean
clean:
	nix-collect-garbage -d
