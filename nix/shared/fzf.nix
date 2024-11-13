{ pkgs, ... }: {
  enable = true;
  enableZshIntegration = true;
  enableBashIntegration = true;
  enableFishIntegration = true;
  tmux.enableShellIntegration = true;
}
