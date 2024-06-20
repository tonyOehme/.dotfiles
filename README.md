# .dotfiles
## Requirements
```
brew install git
brew install stow
```
## Installation
```
git clone --bare git@github.com:tonyOehme/.dotfiles.git
cd ~/.dotfiles.git
git worktree add main main
cd main
git pull --recurse-submodules
stow --target=[home-folder] .
```

