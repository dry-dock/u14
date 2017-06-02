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
  sudo=1.8.9p5-1ubuntu1  \
  build-essential=11.6ubuntu6 \
  curl=7.35.0-1ubuntu2.10 \
  gcc=4:4.8.2-1ubuntu6 \
  make=3.81-8.2ubuntu3 \
  openssl=1.0.1f-1ubuntu2.22 \
  software-properties-common=0.92.37.8 \
  wget=1.15-1ubuntu1.14.04.2 \
  nano=2.2.6-1ubuntu1 \
  unzip=6.0-9ubuntu1.5 \
  openssh-client=1:6.6p1-2ubuntu2.8 \
  libxslt1-dev=1.1.28-2ubuntu0.1 \
  libxml2-dev=2.9.1+dfsg1-3ubuntu4.9 \
  htop=1.0.2-3 \
  gettext=0.18.3.1-1ubuntu3 \
  texinfo=5.2.0.dfsg.1-2 \
  rsync=3.1.0-2ubuntu0.2

echo "================= Installing Python packages ==================="
apt-get install -y \
  python-pip=1.5.4-1ubuntu4 \
  python-software-properties=0.92.37.8 \
  python-dev=2.7.5-5ubuntu3

# Update pip version
python -m pip install -U pip
pip install virtualenv

echo "================= Installing Git ==================="
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install -y git=1:2.13.0-0ppa1~ubuntu14.04.1

echo "================= Installing Git LFS ==================="
curl -sS https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs=2.0.2
git lfs install

echo "================= Adding JQ 1.3.1 ==================="
apt-get install -y jq=1.3-1.1ubuntu1

echo "================= Installing Node 7.x ==================="
. /u14/node/install.sh

echo "================= Installing Java 1.8.0 ==================="
. /u14/java/install.sh

echo "================= Installing Ruby 2.3.3 ==================="
. /u14/ruby/install.sh

echo "================= Adding gclould ============"
CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk=157.0.0-0

echo "================= Adding kubectl 1.5.1 ==================="
curl -sSLO https://storage.googleapis.com/kubernetes-release/release/v1.5.1/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo "================= Adding awscli 1.11.44 ============"
sudo pip install 'awscli==1.11.44'

echo "================= Adding awsebcli 3.9.0 ============"
sudo pip install 'awsebcli==3.9.0'

echo "================ Adding azure-cli 2.0 =============="
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
  sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install apt-transport-https=1.0.1ubuntu2.17
sudo apt-get update && sudo apt-get install azure-cli=0.2.8-1

echo "================= Adding doctl 1.6.0 ============"
curl -OL https://github.com/digitalocean/doctl/releases/download/v1.6.0/doctl-1.6.0-linux-amd64.tar.gz
tar xf doctl-1.6.0-linux-amd64.tar.gz
sudo mv ~/doctl /usr/local/bin
rm doctl-1.6.0-linux-amd64.tar.gz

echo "================= Adding jfrog-cli 1.7.0 ==================="
wget -nv https://api.bintray.com/content/jfrog/jfrog-cli-go/1.7.0/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 -O jfrog
sudo chmod +x jfrog
mv jfrog /usr/bin/jfrog

echo "================ Adding ansible 2.3.0.0 ===================="
sudo pip install 'ansible==2.3.0.0'

echo "================ Adding boto 2.46.1 ======================="
sudo pip install 'boto==2.46.1'

echo "================ Adding apache-libcloud 2.0.0 ======================="
sudo pip install 'apache-libcloud==2.0.0'

echo "================ Adding azure 2.0.0rc5 ======================="
sudo pip install 'azure==2.0.0rc5'

echo "================ Adding dopy 0.3.7a ======================="
sudo pip install 'dopy==0.3.7a'

echo "================ Adding terraform-0.8.7===================="
export TF_VERSION=0.8.7
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

echo "================ Adding packer 0.12.2 ===================="
export PK_VERSION=0.12.2
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
echo "Installing shippable_decrypt"
cp /u14/shippable_decrypt /usr/local/bin/shippable_decrypt

echo "Installing shippable_retry"
cp /u14/shippable_retry /usr/local/bin/shippable_retry

echo "Installing shippable_replace"
cp /u14/shippable_replace /usr/local/bin/shippable_replace

echo "Installed Shippable CLIs successfully"
echo "-------------------------------------"

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
