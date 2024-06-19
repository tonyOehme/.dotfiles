# need to install browser(s), peazip, code editors, discord with vencord, powertoys, windows terminal and everything else you might need
irm christitus.com/win | iex
wsl --install -d [ your favorite linux flavor ]
winget install --id=Flow-Launcher.Flow-Launcher  -e
winget install --id=Microsoft.Office  -e
winget install --id=Spotify.Spotify  -e
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'ht tps://raw.githubusercontent.com/mrpond/BlockTheSpot/master/install.ps1') } -UninstallSpotifyStoreEdition -UpdateSpotify"
