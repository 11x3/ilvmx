# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Elixir version
  version = "v0.12.5"

  # Box
  config.vm.box       = "hashicorp/precise64"

  # Shared folders
  config.vm.synced_folder ".", "/srv"
  
  # Network
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  
  # Setup
  config.vm.provision :shell, :inline => "apt-get update --fix-missing"
  config.vm.provision :shell, :inline => "apt-get install -q -y cowsay python-software-properties python g++ make git curl"
  config.vm.provision :shell, :inline => "wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb"
  config.vm.provision :shell, :inline => "dpkg -i erlang-solutions_1.0_all.deb"
  config.vm.provision :shell, :inline => "apt-get update && apt-get install erlang -q -y"
  config.vm.provision :shell, :inline => "git clone git://github.com/elixir-lang/elixir.git"
  config.vm.provision :shell, :inline => "git clone git://github.com/rebar/rebar.git && cd rebar && make"
  config.vm.provision :shell, :inline => "cd /home/vagrant/elixir && git checkout #{version}"
  config.vm.provision :shell, :inline => "cd /home/vagrant/elixir && make && make install"
  config.vm.provision :shell, :inline => "ln -s /home/vagrant/rebar/rebar /usr/local/bin/rebar"

  # Done
  config.vm.provision :shell, :inline => "cowsay \"Your development environment is ready!\""

end