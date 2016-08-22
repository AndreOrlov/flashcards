# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos6_7"
  config.vm.box_url = 'https://dl.dropboxusercontent.com/u/51478659/vagrant/morungos-centos67.box'

  # config.vm.network 'private_network', ip: "11.11.11.11"
  # config.vm.network :public_network
  config.vm.network :forwarded_port, quest_ip: '0.0.0.0', guest: 3000, host_ip: '127.0.0.1', host: 3001

  config.omnibus.chef_version = :latest
  config.vm.provision 'chef_solo' do |chef|

    chef.add_recipe 'yum'
    chef.add_recipe 'build-essential'
    chef.add_recipe 'rvm::vagrant'
    chef.add_recipe 'rvm::system'
    chef.add_recipe 'rvm::gem_package'
    # chef.add_recipe 'postgresql::server'
    chef.add_recipe 'nodejs'

    chef.add_recipe "git"

    chef.json = {
        postgresql: {
            password: {
                postgres: '1'
            }#,
            # version: '9.4',
            # client: {
            #     packages: 'postgresql-devel'
            # },
            # server: {
            #     packages: 'postgresql-server'
            # },
            # contrib: {
            #     packages: 'postgresql-contrib'
            # }
        }
    }

=begin
     chef.json = {
        'rvm' => {
            'default_ruby' => "ruby-2.2.2",
            # 'user_default_ruby' => "ruby-2.2.2"
            # 'rubies' => ['ruby-2.2.2', 'ruby-2.2.4']
        }
    }
=end
    # node['rvm']['user_default_ruby'] = "ruby-2.2.2"
    # node['rvm']['rubies'] = ['2.2.2', '2.2.4']

  end
end
