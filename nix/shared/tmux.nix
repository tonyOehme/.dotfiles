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

  # plugins = with pkgs.tmuxPlugins; [
  #   tokyo-night
  #   yank
  #   sensible
  #   vim-tmux-navigator
  # ];

  extraConfig = ''
    set -g default-terminal "screen-256color"
    set -g default-terminal "tmux-256color"
    set -g default-terminal screen-256color
    set-option -sa terminal-overrides ",xterm-256color:RGB"
    set -s escape-time 0

    unbind C-b
    unbind f
    set -g status-style 'bg=#21222c fg=#50fa7b'

    unbind %
    unbind c
    bind | split-window -h

    unbind '"'
    bind - split-window -v

    set-window-option -g mode-keys vi
    bind -T copy-mode-vi v send-keys -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
    unbind -T copy-mode-vi MouseDragEnd1Pane

    # vim-like pane switching
    bind -r ^ last-window
    bind -r k select-pane -U
    bind -r j select-pane -D
    bind -r h select-pane -L
    bind -r l select-pane -R
    bind -r w kill-pane

    # bind -r D neww -c "#{pane_current_path}" "[[ -e TODO.md ]] && nvim TODO.md || nvim ~/.dotfiles/personal/todo.md"

    # forget the find window.  That is for chumps
    bind-key -n C-f run-shell "tmux neww ~/personal/.dotfiles/scripts/tmux-sessionizer"

    # Easier and faster switching between next/prev window
    bind -r p previous-window
    bind -r n next-window
    bind -r t new-window

    bind-key -r i run-shell "tmux neww ~/personal/.dotfiles/scripts/tmux-cht.sh"
    bind-key -r S run-shell "~/personal/.dotfiles/scripts/tmux-sessionizer ~/studium"
    bind-key -r W run-shell "~/personal/.dotfiles/scripts/tmux-sessionizer ~/work"
    bind-key -r P run-shell "~/personal/.dotfiles/scripts/tmux-sessionizer ~/personal"
    bind-key -r H run-shell "~/personal/.dotfiles/scripts/tmux-sessionizer ~"

  '';
}
