#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive
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
mkdir -p /etc/drydock

echo "================= Installing basic packages ==================="
apt-get install -y  \
  sudo=1.8* \
  build-essential=11.6* \
  curl=7.35* \
  gcc=4:4.8* \
  make=3.81* \
  openssl=1.0* \
  software-properties-common=0.92* \
  wget=1.15* \
  nano=2.2* \
  unzip=6.0* \
  zip=3.0*\
  openssh-client=1:6.6* \
  libxslt1-dev=1.1* \
  libxml2-dev=2.9* \
  htop=1.0* \
  gettext=0.18* \
  texinfo=5.2* \
  rsync=3.1* \
  psmisc=22.20* \
  vim=2:7.4* \
  groff=1.22.*

# rsync throws a warning that is not resolved yet - https://github.com/Microsoft/WSL/issues/2782

# Python throws a few warnings that can be ignored. New versions of python do not throw these warnings
echo "================= Installing Python packages ==================="
apt-get install  -y \
  python-pip=1.5* \
  python-software-properties=0.92* \
  python-dev=2.7*

pip install -q virtualenv==16.0.0

echo "================= Installing Git v2.19 ==================="
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install  -y git=1:2.*


# Git-LFS throws a warning that can be ignored - https://github.com/git-lfs/git-lfs/issues/2837
echo "================= Installing Git LFS ==================="
curl -sS https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install  git-lfs=2.5.1

echo "================= Adding JQ 1.3.x ==================="
apt-get install  -y jq=1.3*

echo "================= Installing Node 8.x ==================="
. /u14/node/install.sh

# Java throws warnings that not resolved yet - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=791531;msg=5
echo "================= Installing Java 1.10.0 ==================="
. /u14/java/install.sh

echo "================= Installing Ruby 2.5.1 ==================="
. /u14/ruby/install.sh

echo "================= Adding gclould ============"
CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk=216.0*

echo "================= Adding kubectl 1.11.0 ==================="
curl -sSLO https://storage.googleapis.com/kubernetes-release/release/v1.11.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

KOPS_VERSION=1.10.0
echo "Installing KOPS version: $KOPS_VERSION"
curl -LO https://github.com/kubernetes/kops/releases/download/"$KOPS_VERSION"/kops-linux-amd64
chmod +x kops-linux-amd64
mv kops-linux-amd64 /usr/local/bin/kops

HELM_VERSION=v2.10.0
echo "Installing helm version: $HELM_VERSION"
wget https://storage.googleapis.com/kubernetes-helm/helm-"$HELM_VERSION"-linux-amd64.tar.gz
tar -zxvf helm-"$HELM_VERSION"-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64

echo "================= Adding apache libcloud 2.3.0 ============"
sudo pip install 'apache-libcloud==2.3.0'

echo "================= Adding awscli 1.16.14 ============"
sudo pip install 'awscli==1.16.14'

echo "================= Adding awsebcli 3.14.6 ============"
sudo pip install 'awsebcli==3.14.6'

echo "================= Adding openstack client 3.16.1 ============"
sudo pip install python-openstackclient==3.16.1 --ignore-installed urllib3
sudo pip install shade==1.29.0

AZURE_CLI_VERSION=2.0*
echo "================ Adding azure-cli $AZURE_CLI_VERSION  =============="
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
  sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install -q apt-transport-https=1.0.1*
sudo apt-get update && sudo apt-get install -y -q azure-cli=$AZURE_CLI_VERSION

echo "================= Adding doctl 1.9.0 ============"
curl -OL https://github.com/digitalocean/doctl/releases/download/v1.9.0/doctl-1.9.0-linux-amd64.tar.gz
tar xf doctl-1.9.0-linux-amd64.tar.gz
sudo mv ./doctl /usr/local/bin
rm doctl-1.9.0-linux-amd64.tar.gz

echo "================= Adding jfrog-cli 1.19.1 ==================="
wget -nv https://api.bintray.com/content/jfrog/jfrog-cli-go/1.19.1/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 -O jfrog
sudo chmod +x jfrog
mv jfrog /usr/bin/jfrog

echo "================ Adding ansible 2.6.4 ===================="
sudo pip install -q 'ansible==2.6.4'

echo "================ Adding boto 2.49.0 ======================="
sudo pip install -q 'boto==2.49.0'

echo "============  Adding boto3 ==============="
pip install -q 'boto3==1.9.4'

echo "================ Adding azure 3.0.0 ======================="
sudo pip install -q 'azure==3.0.0'

echo "================ Adding dopy 0.3.7 ======================="
sudo pip install -q 'dopy==0.3.7'

export TF_VERSION=0.11.8
echo "================ Adding terraform-$TF_VERSION===================="
export TF_FILE=terraform_"$TF_VERSION"_linux_amd64.zip

echo "Fetching terraform"
echo "-----------------------------------"
rm -rf /tmp/terraform
mkdir -p /tmp/terraform
wget -nv https://releases.hashicorp.com/terraform/$TF_VERSION/$TF_FILE
unzip -o $TF_FILE -d /tmp/terraform
sudo chmod +x /tmp/terraform/terraform
mv /tmp/terraform/terraform /usr/bin/terraform

echo "Added terraform successfully"
echo "-----------------------------------"

export PK_VERSION=1.3.0
echo "================ Adding packer $PK_VERSION ===================="
export PK_FILE=packer_"$PK_VERSION"_linux_amd64.zip

echo "Fetching packer"
echo "-----------------------------------"
rm -rf /tmp/packer
mkdir -p /tmp/packer
wget -nv https://releases.hashicorp.com/packer/$PK_VERSION/$PK_FILE
unzip -o $PK_FILE -d /tmp/packer
sudo chmod +x /tmp/packer/packer
mv /tmp/packer/packer /usr/bin/packer

echo "Added packer successfully"
echo "-----------------------------------"

echo "================= Intalling Shippable CLIs ================="

git clone https://github.com/Shippable/node.git nodeRepo
./nodeRepo/shipctl/x86_64/Ubuntu_14.04/install.sh
rm -rf nodeRepo

echo "Installed Shippable CLIs successfully"
echo "-------------------------------------"

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
