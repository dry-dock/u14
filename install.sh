#!/bin/bash -e

locale-gen en_US en_US.UTF-8 && \
dpkg-reconfigure locales

cd /u14

echo "================= Updating package lists ==================="
apt-get update

echo "================= Adding some global settings ==================="
mv gbl_env.sh /etc/profile.d/
mkdir -p $HOME/.ssh/
mv config $HOME/.ssh/
mv 90forceyes /etc/apt/apt.conf.d/

echo "================= Installing basic packages ==================="
apt-get install -y \
  sudo  \
  build-essential \
  curl \
  gcc \
  make \
  openssl \
  software-properties-common \
  wget \
  nano \
  unzip \
  libxslt-dev \
  libxml2-dev

echo "================= Installing Python packages ==================="
apt-get install -y \
  python-pip \
  python-software-properties

pip install virtualenv

echo "================= Installing Git ==================="
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install -y git

echo "================= Installing default Node ==================="
. node/install.sh

echo "================= Installing default Java ==================="
. java/install.sh

echo "================= Installing default Ruby ==================="
. ruby/install.sh

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
