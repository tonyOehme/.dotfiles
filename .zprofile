export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/Library/Application\ Support/Jetbrains/Toolbox/scripts:$PATH
export PATH=$PATH:/Users/tony-andy.oehme/.spicetify
export VISUAL="nvim"
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export PATH=$PATH:/Users/tony-andy.oehme/.spicetify
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
eval $(ssh-agent) > /dev/null
find ~/.ssh -name 'id_*' ! -name '*.pub' -exec ssh-add -q {} \;
