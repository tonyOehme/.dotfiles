{ pkgs, ... }: {
  enable = true;

  aggressiveResize = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  newSession = true;
  secureSocket = true;
  shell = "${pkgs.zsh}/bin/zsh";
  terminal = "screen-256color";

  plugins = with pkgs.tmuxPlugins; [
    # tokyo-night
    # yank
    # sensible
    # vim-tmux-navigator
  ];

  extraConfig = ''
    set -g default-terminal "screen-256color"
    set -g default-terminal "tmux-256color"
    set -g default-terminal screen-256color
    set-option -sa terminal-overrides ",xterm-256color:RGB"
    set -s escape-time 0
    set -g mouse on

    unbind C-b
    unbind f
    set-option -g prefix C-a
    bind-key C-a send-prefix
    set -g status-style 'bg=#21222c fg=#50fa7b'

    unbind r
    bind r source-file ~/.tmux.conf
    set -g base-index 1

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
    bind-key -n C-f run-shell "tmux neww ~/scripts/tmux-sessionizer"

    # Easier and faster switching between next/prev window
    bind -r p previous-window
    bind -r n next-window
    bind -r t new-window

    bind-key -r i run-shell "tmux neww ~/scripts/tmux-cht.sh"
    bind-key -r S run-shell "~/scripts/tmux-sessionizer ~/studium"
    bind-key -r W run-shell "~/scripts/tmux-sessionizer ~/work"
    bind-key -r P run-shell "~/scripts/tmux-sessionizer ~/personal"
    bind-key -r H run-shell "~/scripts/tmux-sessionizer ~"


 '';
}
