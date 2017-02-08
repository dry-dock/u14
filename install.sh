#!/bin/bash -e

export TF_INSTALL_LOCATION=/opt
export TF_VERSION=0.8.5
export PK_INSTALL_LOCATION=/opt
export PK_VERSION=0.12.2
export PK_FILENAME=packer_"$PK_VERSION"_linux_amd64.zip

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
  python-software-properties \
  python-dev

pip install virtualenv

echo "================= Installing Git ==================="
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install -y git

echo "================= Installing Node 7.x ==================="
. /u16/node/install.sh

echo "================= Installing Java 1.8.0 ==================="
. /u16/java/install.sh

echo "================= Installing Ruby 2.3.3 ==================="
. /u16/ruby/install.sh

echo "================= Adding gclould ============"
CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk

echo "================= Adding awscli 1.11.44 ============"
sudo pip install 'awscli==1.11.44'

echo "================= Adding awsebcli 3.9.0 ============"
sudo pip install 'awsebcli==3.9.0'

echo "================= Adding jfrog-cli 1.7.0 ==================="
wget -v https://api.bintray.com/content/jfrog/jfrog-cli-go/1.7.0/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 -O jfrog
sudo chmod +x jfrog
mv jfrog /usr/bin/jfrog

echo "================ Adding terraform-0.8.5===================="
export TF_INSALL_LOCATION=/opt
export TF_VERSION=0.8.5
pushd $TF_INSALL_LOCATION
echo "Fetching terraform"
echo "-----------------------------------"
rm -rf $TF_INSALL_LOCATION/terraform
mkdir -p $TF_INSALL_LOCATION/terraform
wget -q https://releases.hashicorp.com/terraform/$TF_VERSION/terraform_"$TF_VERSION"_linux_386.zip
apt-get install unzip
unzip -o terraform_"$TF_VERSION"_linux_386.zip -d $TF_INSALL_LOCATION/terraform
echo "export PATH=$PATH:$TF_INSALL_LOCATION/terraform" >> ~/.bashrc
export PATH=$PATH:$TF_INSALL_LOCATION/terraform
echo "downloaded terraform successfully"
echo "-----------------------------------"
  
echo "================ Adding packer 0.12.2 ===================="
pushd $PK_INSALL_LOCATION
echo "Fetching packer"
echo "-----------------------------------"

rm -rf $PK_INSALL_LOCATION/packer
mkdir -p $PK_INSALL_LOCATION/packer

wget -q https://releases.hashicorp.com/packer/$PK_VERSION/"$PK_FILENAME"
apt-get install unzip
unzip -o $PK_FILENAME -d $PK_INSALL_LOCATION/packer
echo "export PATH=$PATH:$PK_INSALL_LOCATION/packer" >> ~/.bashrc
export PATH=$PATH:$PK_INSALL_LOCATION/packer  
echo "downloaded packer successfully"
echo "-----------------------------------"

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
