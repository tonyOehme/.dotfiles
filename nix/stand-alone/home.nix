{ lib, pkgs, config, username, ... }:
let inherit (config.lib.file) mkOutOfStoreSymlink; in
{

  home = {
    packages = with pkgs; [
      vim
      bash
      bat
      cmake
      go
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
    file = {

        ".config/nvim".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/nvim";
        ".config/tmux".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/tmux";
        ".config/nix".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/nix";
        ".zshrc".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.zshrc";
        ".zprofile".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.zprofile";
        ".zshenv".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.zshenv";
        ".zshrc".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.zshrc";
        "zsh_plugins".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/zsh_plugins";
};
  };
}
