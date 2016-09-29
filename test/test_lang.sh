#!/bin/bash -e

echo "================= OS Information ==================="
printf "\n"
echo "lsb_release -a"
lsb_release -a
printf "\n\n"

echo "================= Java Version ==================="
printf "\n"
echo "java -version"
java -version
printf "\n\n"

echo "================= Python Version ==================="
printf "\n"
echo "python --version"
python --version
printf "\n\n"

echo "================= Node Version ==================="
printf "\n"
echo "node --version"
node --version
printf "\n\n"

echo "================= Ruby Versions ==================="
printf "\n"
echo "rvm list"
source /usr/local/rvm/scripts/rvm
rvm list

echo "================= gclould Versions ==================="
printf "\n"
echo "gcloud version"
gcloud version

echo "================= awscli Versions ==================="
printf "\n"
echo "aws --version"
aws --version

echo "================= JFrog CLI Versions ==================="
printf "\n"
echo "jfrog --version"
jfrog --version
