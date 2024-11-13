{ config, pkgs, lib, user, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{

  home = {
    stateVersion = "24.05";
    homeDirectory = "/Users/${user}";
    username = user;
    file = {

      ".config/nvim".source = ../../.config/nvim;
      ".config/wezterm".source = ../../.config/wezterm;
      ".config/git".source = ../../.config/git;
      ".config/tmux".source = ../../.config/tmux;
      ".config/alacritty".source = ../../.config/alacritty;
      ".config/kitty".source = ../../.config/kitty;
      ".config/aerospace".source = ../../.config/aerospace;
    };
  };


  programs = {
    home-manager.enable = true;
    zsh = import ../shared/zsh.nix { inherit config pkgs lib; };
    zoxide = import ../shared/zoxide.nix { inherit config pkgs; };
    fzf = import ../shared/fzf.nix { inherit pkgs; };
  };
}
