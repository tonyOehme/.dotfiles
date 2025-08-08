# .dotfiles

## flake appendix
or change darwin with linux
kernels:
aarch64-darwin
x86_64-darwin
aarch64-linux
x86_64-linux

```
#kernel/username
```
## stow
works with stow too go to project directory and stowrc is already there
```
stow .
```
## linux installation
```
curl https://raw.githubusercontent.com/tonyOehme/.dotfiles/refs/heads/main/linuxinstall.sh | sh
```
## windows Installation
```
iwr -Uri "https://raw.githubusercontent.com/tonyOehme/.dotfiles/main/windows/windows.ps1" | iex
```
## mac Installation
### Requirements

install nix
give terminal full disk access
```
sh <(curl -L https://nixos.org/nix/install)
```

on a new machine paste this into terminal

```
curl https://raw.githubusercontent.com/tonyOehme/.dotfiles/refs/heads/main/macinstall.sh | sh
```
