#!/usr/bin/env bash
# Pull this file down, make it executable and run it with sudo
# wget https://raw.github.com/gist/5487621/build-erlang-r16b.sh
# chmod u+x build-erlang-r16b.sh
# sudo ./build-erlang-r16b.sh

if [ $(id -u) != "0" ]; then
  echo "You must be the superuser to run this script" >&2
  exit 1
fi

# Setup
cd /
apt-get update --fix-missing

# Install the build tools (dpkg-dev g++ gcc libc6-dev make)
apt-get install -q -y cowsay build-essential git curl
apt-get install -q -y python-software-properties python

# automatic configure script builder (debianutils m4 perl)
apt-get -y install autoconf

# Needed for HiPE (native code) support, but already installed by autoconf
# apt-get -y install m4
 
# Needed for terminal handling (libc-dev libncurses5 libtinfo-dev libtinfo5 ncurses-bin)
apt-get -y install libncurses5-dev
 
# For building with wxWidgets
apt-get -y install libwxgtk2.8-dev libgl1-mesa-dev libglu1-mesa-dev libpng3
 
# For building ssl (libssh-4 libssl-dev zlib1g-dev)
apt-get -y install libssh-dev
 
# ODBC support (libltdl3-dev odbcinst1debian2 unixodbc)
apt-get -y install unixodbc-dev

# Install Erlang
mkdir -p /erlang
cd /erlang

if [ -e otp_src_17.0.tar.gz ]; then
  echo "Good! 'otp_src_17.0.tar.gz' already exists. Skipping download."
else
  wget http://www.erlang.org/download/otp_src_17.0.tar.gz
fi
 
tar -xvzf otp_src_17.0.tar.gz
chmod -R 777 otp_src_17.0
cd otp_src_17.0
./configure
make
make install

# Install Elixir
cd /

git clone git://github.com/elixir-lang/elixir.git
git clone git://github.com/rebar/rebar.git

cd /rebar && make 
cd /elixir && git checkout master && make && make install 

ln -s /rebar/rebar /usr/local/bin/rebar

# # Install Elm-lang env for front-end dev.
#apt-get install -q -y ghc cabal-install haskell-platform haskell-platform-doc haskell-platform-prof
 
# cabal update
# cabal install elm
# cabal install elm-server   # Highly-Recommended

# [bug] 4/30/14 elm-get is failing due to pandoc dep failing
# cabal install pandoc
# cabal install elm-repl     # Optional
# cabal install elm-get      # Optional

# Install fish
# wget http://fishshell.com/files/2.1.0/linux/Ubuntu/fish_2.1.0-1~precise_amd64.deb
# sudo dpkg -i fish_2.1.0-1~precise_amd64.deb
# chsh -s /usr/bin/fish

# # Config the app.
#cd /ilvmx && mix deps.get && mix compile && mix test && mix server
