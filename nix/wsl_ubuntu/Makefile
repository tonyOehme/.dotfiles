.PHONY: init
init:
	sh <(curl -L https://nixos.org/nix/install) --daemon

.PHONY: update
update:
	nix-shell '<home-manager>' -A install
	home-manager switch --flake .#myprofile

.PHONY: clean
clean:
	nix-collect-garbage -d
