{ config, pkgs, lib, ... }: {
  enable = true;
  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";
  envExtra = ''

    export PATH=$PATH:$HOME/.local/bin
    export PATH=$PATH:$HOME/Library/Application\ Support/Jetbrains/Toolbox/scripts
    export PATH=$PATH:$HOME/.spicetify
    export PATH=$PATH:$HOME/development/flutter/bin
    export PATH=$PATH:$HOME/.gem/ruby/3.3.0/bin
  '';
  profileExtra = ''

    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    eval $(ssh-agent) > /dev/null
    [ -d ~/.ssh ] && find ~/.ssh -name 'id_*' ! -name '*.pub' -exec ssh-add -q {} \;
    [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ] && $HOME/.nix-profile/etc/profile.d/nix.sh;

  '';
  sessionVariables = import ./variables.nix;
  shellAliases = import ./aliases.nix;
  initExtra = ''


    # disable sort when completing `git checkout`
    zstyle ':completion:*:git-checkout:*' sort false

    # set descriptions format to enable group support
    # NOTE: don't use escape sequences here, fzf-tab will ignore them
    zstyle ':completion:*:descriptions' format '[%d]'

    # set list-colors to enable filename colorizing
    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    zstyle ':completion:*' menu no

    # preview directory's content with eza when completing cd
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    zstyle ':fzf-tab:complete:ls:*' fzf-preview 'cat $realpath'

    # switch group using `<` and `>`
    zstyle ':fzf-tab:*' switch-group '<' '>'

    setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir
    setopt auto_pushd              # make cd push the old directory onto the directory stack
    setopt pushd_ignore_dups       # don’t push multiple copies of the same directory onto the directory stack
    setopt pushd_minus             # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack

    # Completions
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-2
    setopt always_to_end           # move cursor to the end of a completed word
    setopt auto_list               # automatically list choices on ambiguous completion
    setopt auto_menu               # show completion menu on a successive tab press
    setopt auto_param_slash        # if completed parameter is a directory, add a trailing slash
    setopt complete_in_word        # complete from both ends of a word
    unsetopt menu_complete         # don't autoselect the first completion entry

    # Expansion and Globbing
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
    unsetopt extended_glob           # use more awesome globbing features
    unsetopt glob_dots               # include dotfiles when globbing

    # History
    # http://zsh.sourceforge.net/Doc/Release/Options.html#History
    setopt append_history          # append to history file
    setopt extended_history        # write the history file in the ':start:elapsed;command' format
    unsetopt hist_beep             # don't beep when attempting to access a missing history entry
    setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
    setopt hist_find_no_dups       # don't display a previously found event
    setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
    setopt hist_ignore_dups        # don't record an event that was just recorded again
    setopt hist_ignore_space       # don't record an event starting with a space
    setopt hist_no_store           # don't store history commands
    setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
    setopt hist_save_no_dups       # don't write a duplicate event to the history file
    setopt hist_verify             # don't execute immediately upon history expansion
    setopt inc_append_history      # write to the history file immediately, not when the shell exits
    setopt share_history           # don't share history between all sessions

    # Initialization
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation

    # Input/Output
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
    unsetopt clobber               # must use >| to truncate existing files
    unsetopt correct               # don't try to correct the spelling of commands
    unsetopt correct_all           # don't try to correct the spelling of all arguments in a line
    unsetopt flow_control          # disable start/stop characters in shell editor
    setopt interactive_comments    # enable comments in interactive shell
    unsetopt mail_warning          # don't print a warning message if a mail file has been accessed
    setopt path_dirs               # perform path search even on command names with slashes
    setopt rc_quotes
    unsetopt rm_star_silent        # ask for confirmation for `rm *' or `rm path/*'

    # Job Control
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
    setopt auto_resume            # attempt to resume existing job before creating a new process
    unsetopt bg_nice              # don't run all background jobs at a lower priority
    unsetopt check_jobs           # don't report on jobs when shell exit
    unsetopt hup                  # don't kill jobs on shell exit
    setopt long_list_jobs         # list jobs in the long format by default
    setopt notify                 # report status of background jobs immediately

    # Prompting
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
    setopt prompt_subst           # expand parameters in prompt variables

    # Scripts and Functions
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Scripts-and-Functions

    # Shell Emulation
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-Emulation

    # Shell State
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-State

    # Zle
    # http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
    unsetopt beep                 # be quiet!
    setopt combining_chars        # combine zero-length punctuation characters (accents) with the base character
    setopt vi                     # use emacs keybindings in the shell

    export NIX_LD=$(nix eval --impure --raw --expr ' let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD ')

    [ -f ~/personal/.dotfiles/.p10k.zsh ] && source ~/personal/.dotfiles/.p10k.zsh

  '';
  antidote = {
    enable = true;
    useFriendlyNames = true;
    plugins = [
      # omz plugins
      "getantidote/use-omz"
      "ohmyzsh/ohmyzsh path:plugins/git"
      "ohmyzsh/ohmyzsh path:plugins/sudo"
      "ohmyzsh/ohmyzsh path:plugins/command-not-found"
    ];
  };
  plugins = [
    {
      # will source zsh-autosuggestions.plugin.zsh
      name = "zsh-autosuggestions";
      src = pkgs.zsh-autosuggestions;
      file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
    }
    {
      name = "zsh-completions";
      src = pkgs.zsh-completions;
      file = "share/zsh-completions/zsh-completions.zsh";
    }
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.zsh-syntax-highlighting;
      file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
    }
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    {
      name = "powerlevel10k-config";
      src = lib.cleanSource ../../.p10k.zsh;
      file = ".p10k.zsh";
    }
    {
      name = "fzf-tab";
      src = pkgs.zsh-fzf-tab;
      file = "share/fzf-tab/fzf-tab.plugin.zsh";
    }
  ];
}

