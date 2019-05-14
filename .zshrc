#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# source additional customization specific to os                         
[[ -f "$HOME/dotfiles/.zsh_os_custom.sh" ]] && source "$HOME/dotfiles/.zsh_os_custom.sh"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customizations
###################################

export EDITOR="vim"
export VISUAL=$EDITOR
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# add path for yarn
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

# add path for golang
export PATH=$PATH:/usr/local/go/bin

# added by Anaconda2 installer
export PATH="$HOME/anaconda2/bin:$PATH"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source "/etc/profile.d/vte-2.91.sh"
fi

# enable base16 color theme for shell
export BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# use this base16 theme for shell
base16_tomorrow-night

# aliases
[[ -f "$HOME/dotfiles/.aliases" ]] && source "$HOME/dotfiles/.aliases"

# nvm setup
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/boonheng/.sdkman"
#[[ -s "/home/boonheng/.sdkman/bin/sdkman-init.sh" ]] && source "/home/boonheng/.sdkman/bin/sdkman-init.sh"


