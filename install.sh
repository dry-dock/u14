#!/bin/bash -e

dpkg-divert --local --rename --add /sbin/initctl
locale-gen en_US en_US.UTF-8 && \
dpkg-reconfigure locales

echo "HOME=$HOME"
cd /u14

echo "================= Updating package lists ==================="
apt-get update

echo "================= Adding some global settings ==================="
mv gbl_env.sh /etc/profile.d/
mkdir -p $HOME/.ssh/
mv config $HOME/.ssh/
mv 90forceyes /etc/apt/apt.conf.d/
touch $HOME/.ssh/known_hosts

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
    openssh-client \
    libxslt-dev \
    libxml2-dev \
    htop \
    gettext \
    texinfo

echo "================= Installing Python packages ==================="
apt-get install -y \
  python-pip \
  python-software-properties \
  software-properties-common \
  python-dev

#update pip version
python -m pip install -U pip
pip install virtualenv

echo "================= Installing Git ==================="
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install -y git

echo "================= Installing Git LFS ==================="
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs install

echo "================= Adding JQ 1.5.1 ==================="
apt-get install -y jq

echo "================= Installing Node 7.x ==================="
. /u14/node/install.sh

echo "================= Installing Java 1.8.0 ==================="
. /u14/java/install.sh

echo "================= Installing Ruby 2.3.3 ==================="
. /u14/ruby/install.sh

echo "================= Adding gclould ============"
CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk

echo "================= Adding kubectl 1.5.1 ==================="
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.5.1/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl


echo "================= Adding awscli 1.11.44 ============"
sudo pip install 'awscli==1.11.44'

echo "================= Adding awsebcli 3.9.0 ============"
sudo pip install 'awsebcli==3.9.0'

echo "================= Adding jfrog-cli 1.7.0 ==================="
wget -v https://api.bintray.com/content/jfrog/jfrog-cli-go/1.7.0/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 -O jfrog
sudo chmod +x jfrog
mv jfrog /usr/bin/jfrog

echo "================ Adding terraform-0.8.7===================="
export TF_VERSION=0.8.7
export TF_FILE=terraform_"$TF_VERSION"_linux_amd64.zip

echo "Fetching terraform"
echo "-----------------------------------"
rm -rf /tmp/terraform
mkdir -p /tmp/terraform
wget -q https://releases.hashicorp.com/terraform/$TF_VERSION/$TF_FILE
unzip -o $TF_FILE -d /tmp/terraform
sudo chmod +x /tmp/terraform/terraform
mv /tmp/terraform/terraform /usr/bin/terraform

echo "Added terraform successfully"
echo "-----------------------------------"

echo "================ Adding packer 0.12.2 ===================="
export PK_VERSION=0.12.2
export PK_FILE=packer_"$PK_VERSION"_linux_amd64.zip

echo "Fetching packer"
echo "-----------------------------------"
rm -rf /tmp/packer
mkdir -p /tmp/packer
wget -q https://releases.hashicorp.com/packer/$PK_VERSION/$PK_FILE
unzip -o $PK_FILE -d /tmp/packer
sudo chmod +x /tmp/packer/packer
mv /tmp/packer/packer /usr/bin/packer

echo "Added packer successfully"
echo "-----------------------------------"

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
