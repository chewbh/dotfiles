#!/bin/bash

##############################
# dotfiles - Terminal setup
##############################

# expected that dotfiles is placed at home directory
# this script is run to integrate environment and settings defined in dotfiles

# download and install common utilities
sudo apt update
sudo apt -y --allow-change-held-packages install zsh wget curl git git-core htop jq tree vim neovim mosh openssh-server ansible
sudo apt -y --allow-change-held-packages install cifs-utils smbclient nfs-common

# install Base16 theme for shell                                         
if [ ! -d "$HOME/.config/base16-shell" ]; then                             git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell                                                               
fi

git clone https://github.com/powerline/fonts.git --depth=1
fonts/install.sh
#resolves issue where terminess pwerline is ignored by default and must be explicitly allowed via fontconfig
mkdir -p ~/.config/fontconfig/conf.d/ && cp fonts/fontconfig/50-enable-terminess-powerline.conf ~/.config/fontconfig/conf.d/
# refresh font cache
fc-cache -vf


# download zprezto
if [ ! -d "$HOME/.zprezto" ]; then
  echo "Downloading zprezto framework for zsh shell environment..."
  /bin/zsh -c "git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto""
fi

# setup zprezto
read -r -d '' ZSH_INIT_CONFIG << EOM
setopt EXTENDED_GLOB
for rcfile in "\${ZDOTDIR:-\$HOME}"/.zprezto/runcoms/^README.md(.N); do
  if [ "\${ZDOTDIR:-\$HOME}/.\${rcfile:t}" ]; then
    rm "\${ZDOTDIR:-\$HOME}/.\${rcfile:t}"
  fi
  ln -s "\$rcfile" "\${ZDOTDIR:-\$HOME}/.\${rcfile:t}"
done
EOM
/bin/zsh -c "$ZSH_INIT_CONFIG"

# override zprezto configuration with those from dotfiles
rm "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zpreztorc
ln $HOME/dotfiles/.zpreztorc "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zpreztorc
rm "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zshrc                      
ln $HOME/dotfiles/.zshrc "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zshrc

# switch to zsh
#chsh -s /bin/zsh

if [ ! "$HOME/.editorconfig" ]; then
  ln -s $HOME/dotfiles/.editorconfig $HOME/.editorconfig
fi

if [ ! "$HOME/.tmux.conf" ]; then                                    
  ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf               
fi

if [ ! "$HOME/.vimrc" ]; then                                   
  ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc                  
  ln -s $HOME/dotfiles/.vimrc_background $HOME/.vimrc_background
fi

# setup vimrc for vim and neovim
# create and symlink vimrc for neovim
if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p "$HOME/.config/nvim"
  touch $HOME/.config/nvim/init.vim
  echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> $HOME/.config/nvim/init.vim
  echo "let &packpath = &runtimepath" >> $HOME/.config/nvim/init.vim
  echo "source ~/.vimrc" >> $HOME/.config/nvim/init.vim
fi

# download Vundle for vim plugin management
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# install Vundle plugins defined in .vimrc
vim +PluginInstall +qall


