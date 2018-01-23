#!/bin/bash -e

echo "================= Installing default-jdk & jre ==================="
apt-get install -q default-jre=2:1.7-51
apt-get install -q default-jdk=2:1.7-51

echo "================= Installing openjdk-8-jdk ==================="
add-apt-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get install -y -q openjdk-8-jdk=8u141*
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac
apt-get install --reinstall ca-certificates=20170717*
add-apt-repository ppa:maarten-fonville/ppa
apt-get update
apt-get install -q icedtea-8-plugin=1.5.3*
update-alternatives --set javaws /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/javaws

echo "================ Installing oracle-java8-installer ================="
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
add-apt-repository -y ppa:webupd8team/java
apt-get update
apt-get install -q -y oracle-java8-installer=8u161*
update-alternatives --set java /usr/lib/jvm/java-8-oracle/jre/bin/java
update-alternatives --set javac /usr/lib/jvm/java-8-oracle/bin/javac
update-alternatives --set javaws /usr/lib/jvm/java-8-oracle/jre/bin/javaws
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-oracle' >> $HOME/.bashrc
echo 'export PATH=$PATH:/usr/lib/jvm/java-8-oracle/jre/bin' >> $HOME/.bashrc
