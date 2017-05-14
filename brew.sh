#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Darwin" ]
then

brew doctor

brew update
brew upgrade

brew tap homebrew/boneyard

brew install ack
brew install autoconf
brew install ansible
brew install autojump
brew install bison
brew install ccache
brew install clamav
brew install coreutils
brew install ctags
brew install direnv
brew install findutils
brew install ffmpeg
brew install fzf
brew install gdbm
brew install gibo
brew install gcc
brew install git
brew install imagemagick
brew install jq
brew install jpeg
brew install libpng
brew install libxml2
brew install libxslt
brew install libyaml
brew install libevent
brew install libmpc
brew install mcrypt
brew install mongodb
brew install mpfr
brew install mercurial
brew install memcached
brew install mysql
brew install nginx
brew install nkf
brew install openssl
brew install ossp-uuid
brew install peco
brew install postgresql
brew install phantomjs
brew install pkgconfig
brew install q
brew install qt@5.5
brew install readline
brew install reattach-to-user-namespace
brew install redis
brew install rmtrash
brew install rsense
brew install sqlite
brew install socat
brew install tree
brew install thefuck
brew install tmux
brew install unixodbc
brew install unar
brew install lua
brew install vim --with-lua
brew install w3m
brew install wget
brew install yarn
brew install zeromq
brew install zsh

brew link --force qt55

brew cleanup

brew tap caskroom/cask
brew tap caskroom/versions
brew install brew-cask-completion

brew cask install atom
brew cask install android-studio
brew cask install alfred
brew cask install cyberduck
brew cask install dash
brew cask install docker
brew cask install dropbox
brew cask install flux
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install gyazo
brew cask install imageoptim
brew cask install jasper
brew cask install java
brew cask install magican
brew cask install ngrok
brew cask install postman
brew cask install postico
brew cask install rescuetime
brew cask install robomongo
brew cask install sequel-pro

brew cask cleanup

fi
