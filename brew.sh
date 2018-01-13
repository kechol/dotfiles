#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Darwin" ]
then

brew doctor

brew update
brew upgrade

brew install ack
brew install autoconf
brew install ansible
brew install antigen
brew install autojump
brew install awscli
brew install bison
brew install ccache
brew install clamav
brew install cmake
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
brew install git-extras
brew install ghq
brew install hub
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
brew install postgresql
brew install phantomjs
brew install pkgconfig
brew install q
brew install qt@5.5
brew install readline
brew install reattach-to-user-namespace
brew install redis
brew install ripgrep
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

brew link --force qt@5.5

brew cleanup

brew tap caskroom/cask
brew tap caskroom/versions
brew install brew-cask-completion

brew cask install android-studio
brew cask install alfred
brew cask install cyberduck
brew cask install dash
brew cask install docker
brew cask install dropbox
brew cask install flux
brew cask install google-chrome
brew cask install iterm2
brew cask install imageoptim
brew cask install jasper
brew cask install java
brew cask install karabiner-elements
brew cask install magican
brew cask install ngrok
brew cask install postman
brew cask install postico
brew cask install rescuetime
brew cask install robomongo
brew cask install sequel-pro

brew cask cleanup

fi
