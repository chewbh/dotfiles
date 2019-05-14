#!/bin/bash

if [ ! -f "/etc/apt/sources.list.d/stretch-backports.list" ]; then
  echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee /etc/apt/sources.list.d/stretch-backports.list
  sudo apt update
fi

# install tilix
sudo apt -y install tilix

# ensure sh scripts in profile.d will be executed 
# - minic login shell experience
# weird that Crostini login shell does not conform to this behavior 
# thus, the need for this step
if [ -f "$HOME/dotfiles/.zsh_os_custom.sh" ]; then
  rm $HOME/dotfiles/.zsh_os_custom.sh
fi
echo "#!/bin/bash" >> $HOME/dotfiles/.zsh_os_custom.sh
echo ". /etc/profile" >> $HOME/dotfiles/.zsh_os_custom.sh


