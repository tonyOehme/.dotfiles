{ config, pkgs, lib, user, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{

  home = {
    stateVersion = "24.05";
    homeDirectory = "/home/${user}";
    username = user;
  };
  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/${user}/personal/.dotfiles/.config/nvim";


  programs = {
    home-manager.enable = true;
    tmux = import ../shared/tmux.nix { inherit pkgs; };
    zsh = import ../shared/zsh.nix { inherit config pkgs lib; };
    zoxide = import ../shared/zoxide.nix { inherit config pkgs; };
    fzf = import ../shared/fzf.nix { inherit pkgs; };
    starship = import ../shared/starship.nix {inherit config pkgs lib;};
    git = import ../shared/git.nix { inherit pkgs config; };
  };
}
