#!/usr/bin/env bash

# Install Erlang/Elixir kit for server.
apt-get update --fix-missing
apt-get install -q -y cowsay python-software-properties python g++ make git curl
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb
apt-get install -q -y erlang

cd /home/vagrant
git clone git://github.com/elixir-lang/elixir.git
git clone git://github.com/rebar/rebar.git
cd /home/vagrant/rebar && make
cd /home/vagrant/elixir && git checkout #{version} && make && make install

ln -s /home/vagrant/rebar/rebar /usr/local/bin/rebar

# cd /ilmvx && mix deps.get && mix compile && mix test

# Setup Elm-lang env for front-end dev.
apt-get install -q -y ghc cabal-install haskell-platform haskell-platform-doc haskell-platform-prof

cabal update
cabal install elm
cabal install elm-server   # Highly-Recommended
cabal install elm-repl     # Optional
cabal install elm-get      # Optional
