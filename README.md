# .dotfiles
## Requirements

install nix
```
sh <(curl -L https://nixos.org/nix/install)
```

## Installation

on a new machine paste this into terminal
```
nix-shell -p git --run 'git clone https://github.com/tonyOehme/.dotfiles.git ~/personal/.dotfiles'
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/personal/.dotfiles/nix/intel_mac#intel_mac
cd ~/personal/.dotfiles
git submodule update --init --recursive
stow --target=$HOME .
```
