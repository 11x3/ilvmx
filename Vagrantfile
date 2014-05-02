# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  VAGRANTFILE_API_VERSION = "2"
  
  #config.ssh.insert_key = false
  
  # Securing Vagrant as found:
  # http://stackoverflow.com/questions/14715678/vagrant-insecure-by-default
  
  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # avoids 'stdin: is not a tty' error.
  # config.ssh.private_key_path = ["#{ENV['HOME']}/.ssh/id_rsa","#{ENV['HOME']}/.vagrant.d/insecure_private_key"]
  # config.vm.provision "shell", inline: <<-SCRIPT
  #   printf "%s\n" "#{File.read("#{ENV['HOME']}/.ssh/id_rsa.pub")}" > /root/.ssh/authorized_keys
  #   chown -R vagrant:vagrant /home/vagrant/.ssh
  # SCRIPT
  
  # Box
  config.vm.box       = "trusty64"

  # Providers
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
  
  config.vm.provider "rackspace" do |rs|
    rs.username           = ENV["RS_USERNAME"] || (throw "nil ENV['RS_USERNAME']")
    rs.api_key            = ENV["RS_API_KEY"]  || (throw "nil ENV['RS_API_KEY']")
    rs.flavor             = /1 GB Performance/
    rs.rackspace_region   = "dfw"
    rs.server_name        = "ilvmx"
  end
  
  # Shared folders
  config.vm.synced_folder ".", "/ilvmx"
  
  # Network
  config.vm.network "forwarded_port", guest: 8080, host: 8888
  
  # Custom
  config.vm.provision :shell, :path   => "vagrant.sh"
end