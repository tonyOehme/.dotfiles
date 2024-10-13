# .dotfiles
## Requirements
```
brew install git
brew install stow
```
## Installation
```
cd
git clone  https://github.com/tonyOehme/.dotfiles.git ~/personal/.dotfiles
cd ~/personal/.dotfiles
cd main
git submodule update --init --recursive
stow --target=$HOME .
```
```
sh <(curl -L https://nixos.org/nix/install)
nix-shell -p git --run 'git clone https://github.com/tonyOehme/.dotfiles.git ~/personal/.dotfiles'
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/personal/.dotfiles/nix/intel_mac#inte_mac
```
