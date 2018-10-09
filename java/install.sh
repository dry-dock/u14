#!/bin/bash -e

echo "================ Installing openjdk11-installer ================="
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt install -y openjdk-11-jdk --allow-unauthenticated

echo "================ Installing oracle-java11-installer ================="
export ORACLEJDK_VERSION=11
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/11+28/55eed80b163941c8885ad9298e6d786a/jdk-11_linux-x64_bin.tar.gz
tar -xzf jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
mv jdk-"$ORACLEJDK_VERSION"/ java-11-oraclejdk-amd64
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-11-oraclejdk-amd64/bin/java 2
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-11-oraclejdk-amd64/bin/javac 2
sudo update-alternatives --set java /usr/lib/jvm/java-11-oraclejdk-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-11-oraclejdk-amd64/bin/javac
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-oraclejdk-amd64' >> /etc/drydock/.env
echo 'export PATH=$PATH:/usr/lib/jvm/java-11-oraclejdk-amd64/bin' >> /etc/drydock/.env


