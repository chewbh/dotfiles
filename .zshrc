#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customizations
###################################

export EDITOR="vim"
export VISUAL=$EDITOR
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

# added by Anaconda2 installer
export PATH="/home/boonheng/anaconda2/bin:$PATH"

# enable base16 color theme for shell
export BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# use this base16 theme for shell
base16_tomorrow-night

# aliases
[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/boonheng/.sdkman"
[[ -s "/home/boonheng/.sdkman/bin/sdkman-init.sh" ]] && source "/home/boonheng/.sdkman/bin/sdkman-init.sh"


