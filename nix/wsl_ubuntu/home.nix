{ lib, pkgs, ... }:
let
  username = "tonyyep";
in
{
  home = {
    packages = with pkgs; [
      vim
      go
      yazi
      tree
      neovim
      unzip
      git
      tmux
      tldr
      thefuck
      fzf
      zsh
      zoxide
      rustup
      eza
      ripgrep
      docker
      stow
      nodejs_20
      tree-sitter
    ];

    # This needs to actually be set to your username
    inherit username;
    homeDirectory = "/home/${username}";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "24.05";
  };
}
