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

