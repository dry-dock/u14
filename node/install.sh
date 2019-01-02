#!/bin/bash -e

export NVM_VERSION=v0.33.9
echo "================= Installing NVM "$NVM_VERSION" ==================="
curl -sS https://raw.githubusercontent.com/creationix/nvm/"$NVM_VERSION"/install.sh | bash

# Set NVM_DIR so the installations go to the right place
export NVM_DIR="/root/.nvm"

# add source of nvm to .bashrc - allows user to use nvm as a command
echo "source ~/.nvm/nvm.sh" >> /etc/drydock/.env

export NODE_VERSION=10.14*
export NPM_VERSION=6.5.0
echo "================= Installing nodejs "$NODE_VERSION" ==================="
curl -sSL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -q -y nodejs="$NODE_VERSION"
npm install npm@"$NPM_VERSION" -g

export YARN_VERSION=1.12*
echo "================= Installing yarn "$YARN_VERSION" ==================="
sudo apt-key adv --fetch-keys http://dl.yarnpkg.com/debian/pubkey.gpg
echo "deb http://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install -q -y yarn="$YARN_VERSION"
