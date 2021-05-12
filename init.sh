#!/bin/bash

set -o errexit
set -o xtrace

##############################
# dotfiles - Terminal setup
##############################

# expected that dotfiles is placed at home directory
# this script is run to integrate environment and settings defined in dotfiles

# download and install common utilities
sudo apt update
sudo apt -y --allow-change-held-packages install zsh wget curl git htop jq tree \
	                                     vim mosh openssh-server \
						                 fzf ctags ansible python3-pip \
						                 apt-transport-https gettext \
                                         software-properties-common

sudo apt -y --allow-change-held-packages install cifs-utils smbclient nfs-common

# ensure default is python3
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

# vs code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt update
sudo apt -y install code

# install tmux (latest)
if [ "$(. /etc/os-release; echo $PRETTY_NAME)" = "Debian GNU/Linux 9 (stretch)" ]; 
then 
  sudo apt -y --allow-change-held-packages install -t stretch-backports tmux;
elif [ "$(. /etc/os-release; echo $PRETTY_NAME)" = "Debian GNU/Linux 10 (buster)" ];
then
  sudo apt -y --allow-change-held-packages install -t buster-backports tmux;
else
  sudo apt -y --allow-change-held-packages install tmux;
fi

# install neovim
pip3 install pynvim
sudo wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O /usr/local/bin/nvim.appimage
sudo chmod +x /usr/local/bin/nvim.appimage 
if [ ! -f "/usr/local/bin/nvim" ]; then
sudo ln -s /usr/local/bin/nvim.appimage /usr/local/bin/nvim
fi

# install Base16 theme for shell                                         
if [ ! -d "$HOME/.config/base16-shell" ]; then                             
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell                                                               
fi

# powerline font
sudo apt -y --allow-change-held-packages install fonts-powerline

# resolves issue where terminal powerline is ignored by default and must be explicitly allowed via fontconfig
# and refresh font cache
mkdir -p ~/.config/fontconfig/conf.d/ 
curl https://raw.githubusercontent.com/powerline/fonts/master/fontconfig/50-enable-terminess-powerline.conf -o ~/.config/fontconfig/conf.d/50-enable-terminess-powerline.conf
fc-cache -vf

# download zprezto
if [ ! -d "$HOME/.zprezto" ]; then
  echo "Downloading zprezto framework for zsh shell environment..."
  /bin/zsh -c "git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto""
fi

# setup zprezto
ZSH_INIT_CONFIG=$(cat <<-EOF
  setopt EXTENDED_GLOB
  for rcfile in "\${ZDOTDIR:-\$HOME}"/.zprezto/runcoms/^README.md(.N); do
    if [ -f "\${ZDOTDIR:-\$HOME}/.\${rcfile:t}" ]; then
      rm "\${ZDOTDIR:-\$HOME}/.\${rcfile:t}"
    fi
    ln -s "\$rcfile" "\${ZDOTDIR:-\$HOME}/.\${rcfile:t}"
  done
EOF
)
/bin/zsh -c "$ZSH_INIT_CONFIG"

# override zprezto configuration with those from dotfiles
rm "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zpreztorc
ln $HOME/dotfiles/.zpreztorc "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zpreztorc
rm "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zshrc                      
ln $HOME/dotfiles/.zshrc "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zshrc

# switch to zsh
CHSH_PAM="auth sufficient pam_wheel.so trust group=chsh"
grep -qxF "$CHSH_PAM" /etc/pam.d/chsh || echo "auth sufficient pam_wheel.so trust group=chsh" | cat - /etc/pam.d/chsh | sudo tee /etc/pam.d/chsh
sudo groupadd -f chsh
MAIN_USER=$USER && sudo usermod -aG chsh $MAIN_USER
chsh -s /bin/zsh

if [ ! -f "$HOME/.editorconfig" ]; then
  ln -s $HOME/dotfiles/.editorconfig $HOME/.editorconfig
fi

if [ ! -f "$HOME/.tmux.conf" ]; then                                    
  ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf               
fi

if [ ! -f "$HOME/.vimrc" ]; then                                   
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

# setup project structure
sudo mkdir /development
sudo chown $USER:$USER /development
mkdir /development/projects
ln -s /developments $HOME/developments
