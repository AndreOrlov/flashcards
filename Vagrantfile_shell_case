# -*- mode: ruby -*-
# vi: set ft=ruby :

$script_test = <<SCRIPT
echo Start script
SCRIPT

$install_rvm = <<SCRIPT
# Example from http://tecadmin.net/install-ruby-2-2-on-centos-rhel/#
#  Install Required Packages
sudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel
sudo yum install -y libyaml-devel libffi-devel openssl-devel make
sudo yum install -y bzip2 autoconf automake libtool bison iconv-devel sqlite-devel

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L get.rvm.io | bash -s stable

source /etc/profile.d/rvm.sh
rvm reload
rvm requirements run

rvm install 2.2.2
rvm use 2.2.2 --default
ruby --version
gem install bundler

cd /vagrant
bundle update
SCRIPT

$install_git = <<SCRIPT
sudo yum install -y git
git --version
SCRIPT

$install_postgresql = <<SCRIPT
sudo yum install -y postgresql-server postgresql-contrib postgresql-devel
sudo postgresql-setup initdb
sudo systemctl start postgresql
sudo systemctl enable postgresql
SCRIPT


# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos6_7"
  config.vm.synced_folder '/home/andre/flashcards', '/vagrant'

  config.vm.provision "shell", inline: $script_test
  config.vm.provision "shell", inline: $install_rvm
  config.vm.provision "shell", inline: $install_postgresql
  config.vm.provision "shell", inline: $install_git


end
