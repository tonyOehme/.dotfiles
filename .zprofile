[ -d ~/.cargo ] && . "$HOME/.cargo/env"
export M2_HOME="/Users/pankaj/Downloads/apache-maven-3.6.3"
export PATH="${M2_HOME}/bin:${PATH}"
export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/Library/Application\ Support/Jetbrains/Toolbox/scripts:$PATH
export VISUAL="nvim"
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
eval $(ssh-agent) > /dev/null
find ~/.ssh -name 'id_*' ! -name '*.pub' -exec ssh-add -q {} \;

