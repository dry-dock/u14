#!/bin/bash -e

#adding keys

cd /root

# added to fix https://github.com/rvm/rvm/issues/3108
curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -

echo "================= Installing RVM ==================="
curl -sSL https://get.rvm.io | bash -s stable

# Set source to rvm
source /usr/local/rvm/scripts/rvm
rvm requirements

echo "================= Installing default ruby ==================="
rvm install 2.3.5

# tell rvm to use this version as default
rvm use 2.3.5 --default

#update gems to current
rvm rubygems current
