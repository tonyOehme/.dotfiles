#!/bin/bash
sudo apt-get update
sudo apt-get install build-essential
sudo apt install zsh
chsh -s $(which zsh)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install fzf
git clone https://github.com/tonyOehme/.dotfiles.git ~/.dotfiles
mkdir personal
mkdir studium
mkdir work
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20
curl https://sh.rustup.rs -sSf | sh
ssh-keygen -t ed25519 -C "go98mub@mytum.de"
brew install stow
stow ~/.dotfiles
brew install neovim
brew install fzf
brew install tmux
tmux source-file ~/.tmux.conf
brew install git
brew install tldr
brew install ripgrep
brew install yazi
cargo install ttyper
source ~/.zshrc
tmux source-file ~/.tmux.conf
