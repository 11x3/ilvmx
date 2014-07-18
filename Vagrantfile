# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  VAGRANTFILE_API_VERSION = "2"
  
  config.ssh.insert_key = false
  
  # todo: Securing Vagrant as found:
  # http://stackoverflow.com/questions/14715678/vagrant-insecure-by-default
  
  # Box
  config.vm.box       = "trusty64"

  # Providers
  config.vm.provider :virtualbox do |v|
    v.memory = 1024
    v.cpus = 2
  end
  
  # config.vm.provider :rackspace do |rs|
  #   rs.username           = ENV["RS_USERNAME"] || (throw "nil ENV['RS_USERNAME']")
  #   rs.api_key            = ENV["RS_API_KEY"]  || (throw "nil ENV['RS_API_KEY']")
  #   rs.flavor             = /1 GB Performance/
  #   rs.rackspace_region   = "dfw"
  #   rs.server_name        = "ilvmx"
  # end
  
  # config.vm.provider :digital_ocean do |provider, override|
  #   override.ssh.private_key_path = '~/.ssh/id_rsa'
  #   override.vm.box               = 'digital_ocean'
  #   override.vm.box_url           = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
  #
  #   provider.client_id            = ENV["DO_CLIENT_ID"] || (throw "nil ENV['RS_USERNAME']")
  #   provider.api_key              = ENV["DO_API_KEY"]  || (throw "nil ENV['RS_API_KEY']")
  # end
  
  # Shared folders
  config.vm.synced_folder ".", "/ilvmx"
  
  # Network
  config.vm.network "forwarded_port", guest: 8080, host: 8888
  
  # Custom
  config.vm.provision :shell, :path   => "vagrant.sh"
end