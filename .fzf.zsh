# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/tony-andy.oehme/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/tony-andy.oehme/.fzf/bin"
fi

eval "$(fzf --zsh)"
