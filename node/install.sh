#!/bin/bash -e

echo "================= Installing NVM ==================="
curl https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

# Set NVM_DIR so the installations go to the right place
export NVM_DIR="/root/.nvm"

# add source of nvm to .bashrc - allows user to use nvm as a command
echo "source ~/.nvm/nvm.sh" >> $HOME/.bashrc

echo "================= Installing latest nodejs ==================="
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
