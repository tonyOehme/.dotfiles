#!/bin/bash

# Set variables
ARCHITECTURE=$(uname --processor)
USERNAME=$(whoami)
KERNELNAME=$(uname --kernel-name | tr '[:upper:]' '[:lower:]')
DOTFILESDIRECTORY=~/personal/.dotfiles
FLAKE="${DOTFILESDIRECTORY}/nix/stand-alone#${ARCHITECTURE}-${KERNELNAME}/${USERNAME}"

# Install config function
install_config() {
    mkdir -p ~/.config/nix
    if [ ! grep -q "^experimental-features = nix-command flakes" ~/.config/nix/nix.conf 2>/dev/null ]; then
        echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    fi


    # Clone dotfiles if not already cloned
    if [ ! -d "${DOTFILESDIRECTORY}" ]; then
        nix-shell -p git --run "git clone https://github.com/tonyOehme/.dotfiles.git ${DOTFILESDIRECTORY}"
    fi

    # Insert username in quotes after first [
    sed -i "s/\[/[\n  \"$(whoami)\"/" ~/personal/.dotfiles/nix/shared/users.nix

    # Run home-manager switch
    nix run --extra-experimental-features 'nix-command flakes' home-manager -- switch --flake "${FLAKE}"
}


# Run the install
install_config
