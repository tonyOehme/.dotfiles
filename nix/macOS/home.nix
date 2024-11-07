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
  xdg = {
    enable = true;
    configFile.nvim.source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/nvim";
  };


  programs = {
    home-manager.enable = true;

    tmux = import ../home/tmux.nix { inherit pkgs; };
    zsh = import ../home/zsh.nix { inherit config pkgs lib; };
    zoxide = import ../home/zoxide.nix { inherit config pkgs; };
    alacritty = import ../home/alacritty.nix { inherit  pkgs; };
    fzf = import ../home/fzf.nix { inherit pkgs; };
    git = import ../home/git.nix { inherit pkgs config; };
  };
}
