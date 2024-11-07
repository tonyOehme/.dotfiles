{ config, pkgs, lib, user, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.05";
    homeDirectory = "/Users/${user}";
    username = user;
  };
  xdg.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/nvim";


  programs = {
    tmux = import ../home/tmux.nix { inherit pkgs; };
    zsh = import ../home/zsh.nix { inherit config pkgs lib; };
    zoxide = (import ../home/zoxide.nix { inherit config pkgs; });
    fzf = import ../home/fzf.nix { inherit pkgs; };
    git = import ../home/git.nix { inherit pkgs config; };
  };
}
