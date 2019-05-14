#!/bin/bash

# ensure zsh environment setup already applied before setting up nvm
. $HOME/.zshrc

# setup and install java 8
sudo apt -y install software-properties-common
sudo add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"
sudo apt update
sudo apt -y install oracle-java8-installer
sudo apt -y install oracle-java8-set-default

# install docker-ce
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
$ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io

# install sublime text 3
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt -y install sublime-text

# install pgadmin 3 (note that it's no longer maintained, should use pgadmin4 instead)
# e.g. sudo docker pull dpage/pgadmin4
sudo apt -y install pgadmin3

# install vlc
sudo apt -y install vlc browser-plugin-vlc

# install sdkman
sudo apt -y install zip unzip
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle
sdk install maven
sdk install kotlin
sdk install kscript
sdk install scala

# install golang
export GO_VERSION=1.12.1 && wget https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz

# install anaconda2
wget https://repo.anaconda.com/archive/Anaconda2-2018.12-Linux-x86_64.sh
chmod +x Anaconda2-2018.12-Linux-x86_64.sh && ./Anaconda2-2018.12-Linux-x86_64.sh
export PATH="$HOME/anaconda2/bin:$PATH"
conda upgrade conda
conda upgrade --all
conda install -y nb_conda_kernels

conda create -n py3 python=3 numpy pandas pytouch scipy ipykernel anaconda
conda create -n deep-learning python=3 numpy pandas pytouch scipy ipykernel anaconda
source activate py3
conda install -y pytorch torchvision cudatoolkit=9.0 -c pytorch
source activate deep-learning
conda install -y pytorch torchvision cudatoolkit=9.0 -c pytorch

# please manually install intellij
