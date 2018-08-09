#!/bin/bash -e

echo "================= Installing default-jdk & jre ==================="
apt-get install -q default-jre=2:1.7*
apt-get install -q default-jdk=2:1.7*

echo "================= Installing openjdk-10-jdk ==================="
add-apt-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get install -y -q openjdk-10-jdk


echo "================ Installing oracle-java10-installer ================="
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
add-apt-repository -y ppa:linuxuprising/java
apt-get update
apt-get install -q -y oracle-java10-installer
sudo apt-get install oracle-java10-set-default
echo 'export JAVA_HOME=/usr/lib/jvm/java-10-oracle' >> /etc/drydock/.env
echo 'export PATH=$PATH:/usr/lib/jvm/java-10-oracle/jre/bin' >> /etc/drydock/.env
