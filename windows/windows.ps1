$setupScriptUrl = "https://raw.githubusercontent.com/tonyOehme/.dotfiles/refs/heads/main/windows/windows_setup.json"
$dotfilesPath = "$HOME\.dotfiles"
$setupScriptName = "windows_setup.json"
$setupScriptOutputPath = "$env:USERPROFILE\Desktop\$setupScriptName"

"Downloaded $setupScriptName to $setupScriptOutputPath"
Invoke-WebRequest -Uri $setupScriptName -OutFile $setupScriptOutputPath
"import $setupScriptOutputPath\$setupScriptName in the winutil"

irm christitus.com/win | iex
git clone https://github.com/tonyOehme/.dotfiles $dotfilesPath
# font
choco install nerd-fonts-jetbrainsmono
setx GLAZEWM_CONFIG_PATH "$dotfilesPath\.glzr\glazewm\config.yaml"
# you need spicetify
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
# wsl
wsl --install -d Ubuntu
