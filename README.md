# .dotfiles

## flake appendix
or change darwin with linux
kernels:
aarch64-darwin
x86_64-darwin
```
#kernel/username
```

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
xcode-select --install
dotfiles=~/personal/.dotfiles
nix-shell -p git --run 'git clone https://github.com/tonyOehme/.dotfiles.git ~/personal/.dotfiles'


sed -i '' "/testuser/a\\\t \t\"$(whoami)\" " $dotfiles/nix/macOS/flake.nix

nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake $dotfiles/nix/macOS#$(uname -m)-$(uname  | tr '[:upper:]' '[:lower:]')/$(whoami)
cd $dotfiles
git submodule update --init --recursive
stow --target=$HOME .
```
