#!/bin/bash -e

echo "================= Installing NVM ==================="
curl https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

# Set NVM_DIR so the installations go to the right place
export NVM_DIR="/root/.nvm"

# add source of nvm to .bashrc - allows user to use nvm as a command
echo "source ~/.nvm/nvm.sh" >> $HOME/.bashrc

echo "================= Installing latest nodejs ==================="
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs
