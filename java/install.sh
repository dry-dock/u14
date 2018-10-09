#!/bin/bash -e

export OPEN_JDK=11
echo "================ Installing openjdk"$OPEN_JDK"-installer ================="
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt install -y openjdk-"$OPEN_JDK"-jdk --allow-unauthenticated

export ORACLEJDK_VERSION=11
echo "================ Installing oracle-java"$ORACLEJDK_VERSION"-installer ================="
mkdir -p /usr/lib/jvm && cd /usr/lib/jvm
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/11+28/55eed80b163941c8885ad9298e6d786a/jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
tar -xzf jdk-"$ORACLEJDK_VERSION"_linux-x64_bin.tar.gz
mv jdk-"$ORACLEJDK_VERSION"/ java-"$ORACLEJDK_VERSION"-oraclejdk-amd64
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-"$ORACLEJDK_VERSION"-oraclejdk-amd64/bin/java 2
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-"$ORACLEJDK_VERSION"-oraclejdk-amd64/bin/javac 2
echo 'export JAVA_HOME=/usr/lib/jvm/java-"$ORACLEJDK_VERSION"-oraclejdk-amd64' >> /etc/drydock/.env
echo 'export PATH=$PATH:/usr/lib/jvm/java-"$ORACLEJDK_VERSION"-oraclejdk-amd64/bin' >> /etc/drydock/.env



