{ lib, pkgs, config, username, ... }:
let inherit (config.lib.file) mkOutOfStoreSymlink; in
{
  programs = {

    tmux = import ./tmux.nix { inherit pkgs; };
    zsh = import ./zsh.nix { inherit config pkgs lib; };
    zoxide = import ./zoxide.nix { inherit config pkgs; };
    fzf = import ./fzf.nix { inherit pkgs; };
    git = import ./git.nix { inherit pkgs config; };
  };

  home = {
    packages = with pkgs; [
      vim
      bat
      cmake
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
  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/nvim";
}
