{ pkgs, ... }: {
  enable = true;

  aggressiveResize = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  clock24 = true;
  mouse = true;
  newSession = true;
  secureSocket = true;
  terminal = "screen-256color";
  prefix = "C-a";
  shell = "${pkgs.zsh}/bin/zsh";

  plugins = with pkgs.tmuxPlugins; [
    # tokyo-night
    # yank
    sensible
    # vim-tmux-navigator
  ];

  extraConfig = builtins.readFile ../../.config/tmux/tmux.conf;
}
