#!/usr/bin/env bash

# Install Erlang/Elixir
apt-get update --fix-missing
apt-get install -q -y cowsay python-software-properties python g++ make git curl libncurses5-dev
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb
apt-get update && apt-get install -q -y erlang

cd /
git clone git://github.com/elixir-lang/elixir.git
git clone git://github.com/rebar/rebar.git
cd /rebar && make 
cd /elixir && git checkout v0.13.0 && make && make install 

ln -s /rebar/rebar /usr/local/bin/rebar

# # Install Elm-lang env for front-end dev.
# apt-get install -q -y ghc cabal-install haskell-platform haskell-platform-doc haskell-platform-prof
# 
# cabal update
# cabal install elm
# cabal install elm-server   # Highly-Recommended

# [hack] 4/30/14 elm-get is failing due to pandoc failing
# cabal install pandoc
# cabal install elm-repl     # Optional
# cabal install elm-get      # Optional

# # Config the app.
# cd /ilvmx && mix clean --all

# todo: fix con_cache/exactor deps

# Install fish
# wget http://fishshell.com/files/2.1.0/linux/Ubuntu/fish_2.1.0-1~precise_amd64.deb
# sudo dpkg -i fish_2.1.0-1~precise_amd64.deb
# chsh -s /usr/bin/fish


mix deps.get && mix compile && mix test
