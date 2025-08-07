#!/bin/bash

# Set variables
ARCHITECTURE=$(uname --processor)
USERNAME=$(uname --nodename)
KERNELNAME=$(uname --kernel-name | tr '[:upper:]' '[:lower:]')
DOTFILESDIRECTORY=~/personal/.dotfiles
FLAKE="${DOTFILESDIRECTORY}/nix/stand-alone#${ARCHITECTURE}-${KERNELNAME}/${USERNAME}"

# Install config function
install_config() {
    echo "Installing configuration..."
    mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

    # Clone dotfiles repository
    nix-shell -p git --run "git clone https://github.com/tonyOehme/.dotfiles.git ${DOTFILESDIRECTORY}"

    # Insert username in quotes after first [
    sed -i "s/\[/[\"$(whoami)\"/" "${DOTFILESDIRECTORY}/nix/shared/users.nix"

    # Run home-manager switch
    nix run --extra-experimental-features 'nix-command flakes' home-manager -- switch --flake "${FLAKE}"
}

# Run the install
install_config
