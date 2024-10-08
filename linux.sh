#!/bin/bash
sudo apt-get update
sudo apt install zsh
sudo apt-get install build-essential
chsh -s $(which zsh)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.zshenv
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
git clone --recurse-submodules https://github.com/tonyOehme/.dotfiles.git ~/.dotfiles
mkdir personal
mkdir studium
mkdir work
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20
curl https://sh.rustup.rs -sSf | sh
ssh-keygen -t ed25519 -C "go98mub@mytum.de"
brew install stow
cd ~/.dotfiles
stow ~/.dotfiles
cd ..
brew install neovim
brew install fzf
brew install tmux
brew install git
brew install tldr
brew install ripgrep
brew install zoxide
brew install yazi
source ~/.zshrc
tmux source-file ~/.tmux.conf
