#!/bin/bash -e

locale-gen en_US en_US.UTF-8 && \
dpkg-reconfigure locales

# add packages needed for many languages
apt-get update && apt-get install -y \
  sudo  \
  build-essential \
  curl \
  gcc \
  make \
  python-pip \
  software-properties-common \
  python-software-properties \
  openssl \
  wget \
  unzip

# Install the latest git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install -y git

# Create user 'shippable' if it doesn't exist
sudo id -u shippable &>/dev/null || sudo useradd -m -s /bin/bash shippable
sudo echo 'shippable  ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
chown shippable:shippable -R /home/shippable
