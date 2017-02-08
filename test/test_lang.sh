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

echo "================= awsebcli Versions ==================="
printf "\n"
echo "eb --version"
eb --version

echo "================= Terraform Versions ==================="
printf "\n"
echo "Terraform --version"
terraform --version

echo "================= Packer Versions ==================="
printf "\n"
echo "Packer --version"
packer --version

echo "================= JQ Versions ==================="
printf "\n"
echo "jq --version"
jq --version

echo "================= JFrog CLI Versions ==================="
printf "\n"
echo "jfrog --version"
jfrog --version
