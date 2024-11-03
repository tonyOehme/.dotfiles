irm christitus.com/win | iex
git clone https://github.com/tonyOehme/.dotfiles $HOME\.dotfiles
# font
choco install nerd-fonts-jetbrainsmono
setx GLAZEWM_CONFIG_PATH "$HOME\.dotfiles\.glzr\glazewm\config.yaml"
# you need spicetify
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
# wsl
wsl --install -d Ubuntu
