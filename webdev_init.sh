#!/bin/bash

# ensure zsh environment setup already applied before setting up nvm
. $HOME/.zshrc

# install nvm (node version manager)
if [ ! -d "${XDG_CONFIG_HOME/:-$HOME/.}nvm"  ]; then
  [ -z "$NVM_DIR" ] && NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.}/nvm"
  mkdir -p $NVM_DIR
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | zsh
  export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  command -v nvm
fi

echo "install latest node and specifically v8.9.3"
nvm install node
nvm install 8.9.3

echo "set v8.9.3 as default"
nvm use 8.9.3
nvm alias default 8.9.3

echo "check version of runtime Node.JS is switched correct"
node -v

# yarn (package manager)
# node is not needed/installed via apt as it will be managed by nvm
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt -y install --no-install-recommends yarn

curl -L https://go.microsoft.com/fwlink/?LinkID=760868 > code.deb
sudo apt -y install ./code.deb
rm code.deb

