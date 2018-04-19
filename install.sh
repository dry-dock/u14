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
mkdir -p /etc/drydock

echo "================= Installing basic packages ==================="
apt-get install -y  \
  sudo=1.8* \
  build-essential=11.6* \
  curl=7.35.0* \
  gcc=4:4.8.2* \
  make=3.81* \
  openssl=1.0.1f* \
  software-properties-common=0.92.37* \
  wget=1.15* \
  nano=2.2.6* \
  unzip=6.0* \
  zip=3.0*\
  openssh-client=1:6.6p1* \
  libxslt1-dev=1.1.28* \
  libxml2-dev=2.9.1* \
  htop=1.0.2* \
  gettext=0.18.3.1* \
  texinfo=5.2.0* \
  rsync=3.1.0* \
  psmisc=22.20* \
  vim=2:7.4.052*

echo "================= Installing Python packages ==================="
apt-get install  -y \
  python-pip=1.5* \
  python-software-properties=0.92* \
  python-dev=2.7*

# Update pip version
python -m pip install  -U pip
pip install -q virtualenv==15.2.0

echo "================= Installing Git ==================="
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install  -y git=1:2.17.0*

echo "================= Installing Git LFS ==================="
curl -sS https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install  git-lfs=2.0*
git lfs install

echo "================= Adding JQ 1.3.1 ==================="
apt-get install  -y jq=1.3*

echo "================= Installing Node 8.x ==================="
. /u14/node/install.sh

echo "================= Installing Java 1.8.0 ==================="
. /u14/java/install.sh

echo "================= Installing Ruby 2.5.0 ==================="
. /u14/ruby/install.sh

echo "================= Adding gclould ============"
CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk=194.0*

echo "================= Adding kubectl 1.9.0 ==================="
curl -sSLO https://storage.googleapis.com/kubernetes-release/release/v1.9.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

KOPS_VERSION=1.8*
echo "Installing KOPS version: $KOPS_VERSION"
curl -LO https://github.com/kubernetes/kops/releases/download/"$KOPS_VERSION"/kops-linux-amd64
chmod +x kops-linux-amd64
mv kops-linux-amd64 /usr/local/bin/kops

HELM_VERSION=v2.8.2
echo "Installing helm version: $HELM_VERSION"
wget https://storage.googleapis.com/kubernetes-helm/helm-"$HELM_VERSION"-linux-amd64.tar.gz
tar -zxvf helm-"$HELM_VERSION"-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64

echo "================= Adding awscli 1.14.64 ============"
sudo pip install  'awscli==1.14.64'

echo "================= Adding awsebcli 3.12.4 ============"
## fixing issues with colorama package installed using distutils
## https://github.com/pypa/pip/issues/3165
sudo pip install 'awsebcli==3.12.4' --ignore-installed colorama

exit 1

AZURE_CLI_VERSION=2.0*
echo "================ Adding azure-cli $AZURE_CLI_VERSION  =============="
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
  sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install -q apt-transport-https=1.0.1*
sudo apt-get update && sudo apt-get install -y -q azure-cli=$AZURE_CLI_VERSION

echo "================= Adding doctl 1.7.2 ============"
curl -OL https://github.com/digitalocean/doctl/releases/download/v1.7.2/doctl-1.7.2-linux-amd64.tar.gz
tar xf doctl-1.7.2-linux-amd64.tar.gz
sudo mv ~/doctl /usr/local/bin
rm doctl-1.7.2-linux-amd64.tar.gz

echo "================= Adding jfrog-cli 1.14.0 ==================="
wget -nv https://api.bintray.com/content/jfrog/jfrog-cli-go/1.14.0/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 -O jfrog
sudo chmod +x jfrog
mv jfrog /usr/bin/jfrog

echo "================ Adding ansible 2.4.3.0 ===================="
sudo pip install -q 'ansible==2.4.3.0'

echo "================ Adding boto 2.48.0 ======================="
sudo pip install -q 'boto==2.48.0'

echo "============  Adding boto3 ==============="
pip install -q 'boto3==1.6.16'

echo "================ Adding apache-libcloud 2.3.0 ======================="
sudo pip install -q 'apache-libcloud==2.3.0'

echo "================ Adding azure 3.0.0 ======================="
sudo pip install -q 'azure==3.0.0'

echo "================ Adding dopy 0.3.7 ======================="
sudo pip install -q 'dopy==0.3.7'

export TF_VERSION=0.11.5
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

export PK_VERSION=1.2.2
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
