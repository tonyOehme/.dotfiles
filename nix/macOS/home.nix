{ config, pkgs, lib, user, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{

  home = {
    stateVersion = "24.05";
    homeDirectory = "/Users/${user}";
    username = user;
  };
  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/nvim";


  programs = {
    home-manager.enable = true;
    tmux = import ../shared/tmux.nix { inherit pkgs; };
    zsh = import ../shared/zsh.nix { inherit config pkgs lib; };
    zoxide = import ../shared/zoxide.nix { inherit config pkgs; };
    alacritty = import ../shared/alacritty.nix { inherit pkgs; };
    fzf = import ../shared/fzf.nix { inherit pkgs; };
    git = import ../shared/git.nix { inherit pkgs config; };
    wezterm = import ../shared/wezterm.nix { inherit pkgs config; };
  };
}
