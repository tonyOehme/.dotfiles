# .dotfiles
## Requirements
```
brew install git
brew install stow
```
## Installation
```
cd
git clone --bare git@github.com:tonyOehme/.dotfiles.git
cd ~/.dotfiles.git
git worktree add main main
cd main
git submodule update --recursive --init
stow --target=$HOME .
```

