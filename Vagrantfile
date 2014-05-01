# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Box
  config.vm.box       = "hashicorp/precise64"
  
  # Providers
   
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  # Shared folders
  config.vm.synced_folder ".", "/ilvmx"
  
  # Network
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  
  # Custom
  config.vm.provision :shell, :path   => "vagrant.sh"
end