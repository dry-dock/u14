#!/bin/bash -e

#adding keys

cd /root
sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

echo "================= Installing RVM ==================="
curl -L https://get.rvm.io | bash -s stable

# Set source to rvm
source /usr/local/rvm/scripts/rvm
rvm requirements

echo "================= Installing default ruby ==================="
rvm install 2.3.1

# tell rvm to use this version as default
rvm use 2.3.1 --default

#update gems to current
rvm rubygems current
