{ config, pkgs, lib, user, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{

  home = {
    stateVersion = "24.05";
    homeDirectory = "/home/${user}";
    username = user;
    # everything that is not in nix or too complicated/large to do in nix
    file = {
      ".config/nvim".source = ../../.config/nvim;
    };
  };

  programs = {
    home-manager.enable = true;
    tmux = import ../shared/tmux.nix { inherit pkgs; };
    nushell = import ../shared/nushell.nix { inherit pkgs; };
    zsh = import ../shared/zsh.nix { inherit config pkgs lib; };
    zoxide = import ../shared/zoxide.nix { inherit config pkgs; };
    fzf = import ../shared/fzf.nix { inherit pkgs; };
    starship = import ../shared/starship.nix { inherit config pkgs lib; };
    git = import ../shared/git.nix { inherit pkgs lib config; };
  };
}
