#!/bin/bash -e

echo "================= Installing default-jdk & jre ==================="
apt-get install -q default-jre=2:1.7*
apt-get install -q default-jdk=2:1.7*

echo "================= Installing openjdk-10-jdk ==================="
export OPENJDK_VERSION="10.0.2"
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget "https://download.java.net/java/GA/jdk10/$OPENJDK_VERSION/19aef61b38124481863b1413dce1855f/13/openjdk-"$OPENJDK_VERSION"_linux-x64_bin.tar.gz"
tar -xzf openjdk-"$OPENJDK_VERSION"_linux-x64_bin.tar.gz
mv jdk-"$OPENJDK_VERSION"/ java-10-openjdk-amd64

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-10-openjdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-10-openjdk-amd64/bin/javac 1
sudo update-alternatives --set java /usr/lib/jvm/java-10-openjdk-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-10-openjdk-amd64/bin/javac


echo "================ Installing oracle-java10-installer ================="
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
add-apt-repository -y ppa:linuxuprising/java
apt-get update
apt-get install -q -y oracle-java10-installer
sudo apt-get install oracle-java10-set-default
echo 'export JAVA_HOME=/usr/lib/jvm/java-10-oracle' >> /etc/drydock/.env
echo 'export PATH=$PATH:/usr/lib/jvm/java-10-oracle/jre/bin' >> /etc/drydock/.env
