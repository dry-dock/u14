#!/bin/bash -e

echo "================= Installing default-jdk & jre ==================="
apt-get install default-jre
apt-get install default-jdk

echo "================= Installing openjdk-6-jdk ==================="
apt-get install -y openjdk-6-jdk
update-alternatives --set java /usr/lib/jvm/java-6-openjdk-amd64/jre/bin/java
update-alternatives --set javac /usr/lib/jvm/java-6-openjdk-amd64/bin/javac
update-alternatives --set javaws /usr/lib/jvm/java-6-openjdk-amd64/jre/bin/javaws
echo 'export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64' >> $HOME/.bashrc
echo 'export PATH=$PATH:/usr/lib/jvm/java-6-openjdk-amd64/jre/bin' >> $HOME/.bashrc
