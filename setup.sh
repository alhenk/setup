#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
# git usually installed manually
# and curl is already installed in EC2
# sudo apt-get install -y git
# sudo apt-get install -y curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/alhenk/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

# install gcc
sudo apt-get update
sudo apt-get install -y make gcc


# install zip/unzip
sudo apt-get install zip -y
# install H2 database
cd ~
wget https://h2database.googlecode.com/files/h2-2014-01-18.zip
unzip h2-2014-01-18.zip
sudo mv h2 /usr/local/bin/
rm -f h2-2014-01-18.zip

wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz
tar -xzvf jdk-7u67-linux-x64.tar.gz
sudo mv jdk1.7.0_67 /usr/local/bin/
rm -f jdk-7u67-linux-x64.tar.gz

export JAVA_HOME=/usr/local/bin/jdk1.7.0_67
export JRE_HOME=/usr/local/bin/jdk1.7.0_67/jre
#export PATH=$PATH
#export PATH=$HOME/bin:$PATH
#export PATH=/usr/bin:$PATH
#export PATH=/usr/sbin:$PATH
#export PATH=/usr/local/bin:$PATH
#export PATH=/usr/local/sbin:$PATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

# intstalling sqlite database
wget http://www.sqlite.org/2013/sqlite-autoconf-3071700.tar.gz
tar -xzvf sqlite-autoconf-3071700.tar.gz
cd sqlite-autoconf-3071700
./configure --prefix=$HOME/sqlite # pick whatever name you want
make
make install
cd $HOME
ln -s ../sqlite/bin/sqlite3 .
# export PATH=$HOME/bin:$PATH






