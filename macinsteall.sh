#!/bin/bash

set -e  # Exit on error

# Set variables
USERNAME=$(whoami)
DOTFILESDIRECTORY=~/personal/.dotfiles

# Install config function
install_config() {
    echo "Installing configuration..."

    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

    # Clone dotfiles if not already cloned
    if [ ! -d "${DOTFILESDIRECTORY}" ]; then
        nix-shell -p git --run "git clone https://github.com/tonyOehme/.dotfiles.git ${DOTFILESDIRECTORY}"
    fi

    # Insert username in quotes after first [ (macOS sed)
    sed -i '' "s/\[/[\n  \"${USERNAME}\"/" "${DOTFILESDIRECTORY}/nix/shared/users.nix"

    # Run home-manager switch
    nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ${DOTFILESDIRECTORY}/nix/macOS#$(uname -m)-$(uname  | tr '[:upper:]' '[:lower:]')/$(whoami)
}

# Check if Nix is installed
if ! command -v nix &> /dev/null; then
    echo "❌ Nix is not installed. Please install Nix first: https://nixos.org/download.html"
    exit 1
fi

# Run the install
install_config

