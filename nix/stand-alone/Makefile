ARCHITECTURE = $(shell uname --processor)
USERNAME = $(shell uname --nodename)
KERNELNAME = $(shell uname --kernel-name | tr '[:upper:]' '[:lower:]')
DOTFILESDIRECTORY = ~/personal/.dotfiles
FLAKE = $(DOTFILESDIRECTORY)/nix/stand-alone#$(ARCHITECTURE)-$(KERNELNAME)/$(USERNAME)


.PHONY: install-config
install-config:
	nix-shell -p git --run 'git clone https://github.com/tonyOehme/.dotfiles.git $(DOTFILESDIRECTORY)'
	sed -i "s/\[/[\"$(whoami)\"/" $(DOTFILESDIRECTORY)/nix/shared/users.nix

	nix run --extra-experimental-features 'nix-command flakes' home-manager -- switch --flake $(FLAKE)
