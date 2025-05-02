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
      ".ideavimrc".source = ../../.ideavimrc;
      ".config/aerospace".source = ../../.config/aerospace;
      ".config/nvim".source = ../../.config/nvim;
    };

  };


  programs = {
    home-manager.enable = true;
    tmux = import ../shared/tmux.nix { inherit pkgs lib config; };
    zsh = import ../shared/zsh.nix { inherit pkgs lib config; };
    zoxide = import ../shared/zoxide.nix { inherit config lib pkgs; };
    fzf = import ../shared/fzf.nix { inherit pkgs lib config; };
    git = import ../shared/git.nix { inherit pkgs lib config; };
    wezterm = import ../shared/wezterm.nix { inherit pkgs lib config; };
  };
}
