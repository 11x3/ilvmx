# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Elixir version
  version = "v0.12.5"

  # Box
  config.vm.box       = "hashicorp/precise64"
  
  # Hardware
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
  
  # Shared folders
  config.vm.synced_folder ".", "/ilvmx"
  
  # Network
  config.vm.network "forwarded_port", guest: 8080, host: 8888
  
  # Custom
  config.vm.provision :shell, :path   => "vagrant.sh"
end