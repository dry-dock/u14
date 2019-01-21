#!/bin/bash -e

apt-get update
dpkg --purge --force-depends ca-certificates-java
apt-get install ca-certificates-java

export JAVA_VERSION=11
export ORACLEJDK_VERSION=11.0.2
echo "================ Installing oracle-java"$ORACLEJDK_VERSION"-installer ================="
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/11.0.2+7/f51449fcd52f4d52b93a989c5c56ed3c/jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
tar -xzf jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
mv jdk-"$ORACLEJDK_VERSION"/ java-"$JAVA_VERSION"-oraclejdk-amd64

echo "export JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-oraclejdk-amd64" >> /etc/drydock/.env
echo "export PATH=\$PATH:/usr/lib/jvm/java-${JAVA_VERSION}-oraclejdk-amd64/bin" >> /etc/drydock/.env

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-"$JAVA_VERSION"-oraclejdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-"$JAVA_VERSION"-oraclejdk-amd64/bin/javac 1

echo "================ Installing openjdk"$JAVA_VERSION"-installer ============================="
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt install -y openjdk-"$JAVA_VERSION"-jdk --allow-unauthenticated
