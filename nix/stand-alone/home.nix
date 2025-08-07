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
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-autocomplete
    ];

    # This needs to actually be set to your username
    inherit username;
    homeDirectory = "/home/${username}";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "24.05";
    file = {
      ".ideavimrc".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.ideavimrc";
      ".config/aerospace/aerospace.toml".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/aerospace/aerospace.toml";
      ".config/nvim".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/nvim";
      ".config/git".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/git";
      ".config/tmux/tmux.conf".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/tmux/tmux.conf";
      ".config/ghostty/config".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.config/ghostty/config";
      ".zshrc".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.zshrc";
      ".zshenv".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.zshenv";
      ".zprofile".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/.zprofile";
      "zsh_plugins".source = mkOutOfStoreSymlink "/home/${username}/personal/.dotfiles/zsh_plugins";
};
  };
}
