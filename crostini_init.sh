#!/bin/bash

set -o errexit 
set -o xtrace

if [ "$(. /etc/os-release; echo $PRETTY_NAME)" = "Debian GNU/Linux 9 (stretch)" ]; then
  if [ ! -f "/etc/apt/sources.list.d/stretch-backports.list" ]; then
    echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee /etc/apt/sources.list.d/stretch-backports.list
    sudo apt update
  fi
elif [ "$(. /etc/os-release; echo $PRETTY_NAME)" = "Debian GNU/Linux 10 (buster)" ]; then
  if [ ! -f "/etc/apt/sources.list.d/buster-backports.list" ]; then
    echo 'deb http://ftp.debian.org/debian buster-backports main' | sudo tee /etc/apt/sources.list.d/buster-backports.list 
    sudo apt update
  fi
fi  

# install tilix
sudo apt -y install tilix

# install fuse support for running tools using AppImage
sudo apt -y install fuse libfuse2

# ensure sh scripts in profile.d will be executed 
# - minic login shell experience
# weird that Crostini login shell does not conform to this behavior 
# thus, the need for this step
if [ -f "$HOME/dotfiles/.zsh_os_custom.sh" ]; then
  rm $HOME/dotfiles/.zsh_os_custom.sh
fi
echo "#!/bin/bash" >> $HOME/dotfiles/.zsh_os_custom.sh
echo ". /etc/profile" >> $HOME/dotfiles/.zsh_os_custom.sh


