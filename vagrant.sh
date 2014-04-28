#!/usr/bin/env bash

# Install Erlang/Elixir
apt-get update --fix-missing
apt-get install -q -y cowsay python-software-properties python g++ make git curl libncurses5-dev
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb
apt-get update && apt-get install -q -y erlang

cd /home/vagrant
git clone git://github.com/elixir-lang/elixir.git
git clone git://github.com/rebar/rebar.git
cd /home/vagrant/rebar && make 
cd /home/vagrant/elixir && git checkout v0.13.0 && make && make install 
mix clean --all && mix deps.get && mix compile

chown -R vagrant:vagrant elixir rebar /ilvmx

ln -s /home/vagrant/rebar/rebar /usr/local/bin/rebar

# Install Elm-lang env for front-end dev.
apt-get install -q -y ghc cabal-install haskell-platform haskell-platform-doc haskell-platform-prof

cabal update
cabal install elm
cabal install elm-server   # Highly-Recommended
cabal install elm-repl     # Optional
cabal install elm-get      # Optional

# Config the app.
#cd /ilvmx && mix deps.get && mix compile && mix test
