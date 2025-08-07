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
      ".ideavimrc".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.ideavimrc";
      ".config/aerospace/aerospace.toml".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/aerospace/aerospace.toml";
      ".config/nvim".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/nvim";
      ".config/git".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/git";
      ".config/tmux/tmux.conf".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/tmux/tmux.conf";
      ".config/ghostty/config".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.config/ghostty/config";
      ".zshrc".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.zshrc";
      ".zshenv".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.zshenv";
      ".zprofile".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/.zprofile";
      "zsh_plugins".source = mkOutOfStoreSymlink "/Users/${user}/personal/.dotfiles/zsh_plugins";
    };

  };


  programs = {
    home-manager.enable = true;
  };
}
