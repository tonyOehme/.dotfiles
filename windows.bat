# need to install browser(s), peazip, code editors, discord with vencord, powertoys, windows terminal and everything else you might need
irm christitus.com/win | iex
wsl --install -d [ your favorite linux flavor ]
choco install GlazeWM
choco install zebar
choco install spotify
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'ht tps://raw.githubusercontent.com/mrpond/BlockTheSpot/master/install.ps1') } -UninstallSpotifyStoreEdition -UpdateSpotify"
