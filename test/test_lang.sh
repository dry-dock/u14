echo "OS information"
lsb_release -a

echo "java version"
java -version

echo "python version"
python --version

echo "node version"
node --version

echo "ruby versions"
source /usr/local/rvm/scripts/rvm
rvm list
