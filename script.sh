#!/bin/bash -e

locale-gen en_US en_US.UTF-8 && \
dpkg-reconfigure locales

echo "Updating package lists..."
apt-get update

echo "Installing packages: sudo, build-essential, curl, gcc, make, python-pip, software-properties-common, python-software-properties, openssl, wget, unzip"
# add packages needed for many languages
apt-get install -y \
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

echo "Installing git..."
# Install the latest git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install -y git
