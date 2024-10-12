# .dotfiles
## Requirements
```
brew install git
brew install stow
```
## Installation
```
cd
git clone --bare https://github.com/tonyOehme/.dotfiles.git
cd ~/.dotfiles.git
git worktree add main main
cd main
git submodule foreach git pull
stow --target=$HOME .
```
```
sh <(curl -L https://nixos.org/nix/install)  
nix-shell -p git --run 'git clone https://github.com/tonyOehme/.dotfiles.git ~/personal/.dotfiles'  
nix run nix-darwin --extra-experimental-features 'nix-command flakes' --switch --flake ~/personal/.dotfiles/flake.nix#tony-andy.oehme  
```
