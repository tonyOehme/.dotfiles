# .dotfiles


## windows Installation
```
iwr -Uri "https://raw.githubusercontent.com/tonyOehme/.dotfiles/main/windows/windows.ps1" | iex
```

## mac Installation
### Requirements

install nix
give terminal full disk access
```
sh <(curl -L https://nixos.org/nix/install)
```

on a new machine paste this into terminal
```
nix-shell -p git --run 'git clone https://github.com/tonyOehme/.dotfiles.git ~/personal/.dotfiles'
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/personal/.dotfiles/nix/macOS#x86_64-darwin/tonyandyoehme
cd ~/personal/.dotfiles
git submodule update --init --recursive
stow --target=$HOME .
```
