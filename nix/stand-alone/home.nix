{ lib, pkgs, config, username, ... }:
let inherit (config.lib.file) mkOutOfStoreSymlink; in
{
  programs = {

    tmux = import ../shared/tmux.nix { inherit pkgs; };
    nushell = import ../shared/nushell.nix { inherit pkgs; };
    zsh = import ../shared/zsh.nix { inherit config pkgs lib; };
    zoxide = import ../shared/zoxide.nix { inherit config pkgs; };
    fzf = import ../shared/fzf.nix { inherit pkgs; };
    starship = import ../shared/starship.nix { inherit config pkgs lib; };
    git = import ../shared/git.nix { inherit pkgs lib config; };

  };

  home = {
    packages = with pkgs; [
      vim
      bash
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
      nushell
      starship
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
      python3
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
