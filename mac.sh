# terminal setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
mkdir personal
mkdir studium
mkdir work
git clone https://github.com/tonyOehme/scripts.git ~/personal/scripts
echo .DS_Store >> ~/.gitignore_global
curl https://raw.githubusercontent.com/tonyOehme/dotfiles/main/terminal-configs/.zprofile > ~/.zprofile
curl https://raw.githubusercontent.com/tonyOehme/dotfiles/main/.gitconfig > ~/.gitconfig
curl https://raw.githubusercontent.com/tonyOehme/dotfiles/main/code-editors/Jetbrains/.ideavimrc > ~/.ideavimrc
curl https://raw.githubusercontent.com/tonyOehme/dotfiles/main/terminal-configs/.zshrc > ~/.zshrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20
curl https://sh.rustup.rs -sSf | sh
tmux source-file ~/.tmux.conf
ssh-keygen -t ed25519 -C "go98mub@mytum.de"
# brew setup
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$('$(brew --prefix)'/bin/brew shellenv)"') >> ~/.zshrc
eval "$("$(brew --prefix)"/bin/brew shellenv)"
# mac settings
sudo nvram "enable-ambient-light-sensor=0"
defaults write -g NSWindowShouldDragOnGesture YES
defaults write -g AppleReduceDesktopTinting -bool yes
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
defaults write -g AppleShowScrollBars -string "Always"
defaults write .GlobalPreferences com.apple.mouse.scaling -1
defaults write com.apple.universalaccess mouseDriverCursorSize 4.0
defaults write com.apple.universalaccess reduceTransparency 1
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.BezelServices dAuto -boolean false
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "YES"
defaults write com.apple.finder autohide-delay -float 0;killall Finder
defaults write com.apple.dock orientation bottom;defaults write com.apple.dock autohide -bool true;defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# terminal programs
brew install neovim
git clone https://github.com/tonyOehme/nvim.git ~/.config/nvim

brew install fzf
echo 'eval "$(fzf --zsh)"' >>~/.zshrc

brew install tmux
curl https://raw.githubusercontent.com/tonyOehme/dotfiles/main/terminal-configs/.tmux.conf > ~/.tmux.conf

brew install git
brew install tldr
brew install ripgrep
brew install yazi

# mac specific things
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font
brew install --cask shottr
brew install --cask firefox
brew install --cask keka
brew install --cask docker
brew install --cask topnotch
brew install --cask google-chrome
brew install --cask maccy
brew install --cask alacritty
brew install --cask alfred
brew install --cask scroll-reverser
brew install --cask appcleaner
brew install --cask spotify
brew install --cask jetbrains-toolbox
brew install --cask microsoft-office
brew install --cask visual-studio-code
brew install --cask rectangle
brew install --cask jetbrains-toolbox
# spotify blockthespot
bash <(curl -sSL https://raw.githubusercontent.com/Nuzair46/BlockTheSpot-Mac/main/install.sh)
