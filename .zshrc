if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
## ZSH Options
# http://zsh.sourceforge.net/Doc/Release/Options.html

# Changing Directories
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
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
setopt rc_quotes               # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
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

# Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Aliases
alias ls='eza --icons=always'
alias n='nvim .'
alias c='code .'
alias a='tmux attach'
alias y='yazi'
alias gap='git commit -am "automated push"; git push'
alias b='bat'
alias gwtp='git pull origin $(git rev-parse --abbrev-ref HEAD)'


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh
[[ ! -f ~/.zprofile ]] || source ~/.zprofile
# Shell integrations
eval "$(zoxide init --cmd cd zsh)"


export PATH=$PATH:/Users/tony-andy.oehme/.spicetify
