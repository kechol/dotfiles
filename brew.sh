#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Darwin" ]
then

brew doctor

brew update
brew upgrade

brew tap caskroom/cask
brew tap caskroom/versions
brew install brew-cask
 
brew install ack
brew install autoconf
brew install autojump
brew install ccache
brew install clamav
brew install coreutils
brew install ctags
brew install findutils
brew install gdbm
brew install gibo
brew install git
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
brew install mysql
brew install nginx
brew install nkf
brew install openssl
brew install ossp-uuid
brew install postgresql
brew install readline
brew install redis
brew install sqlite
brew install tree
brew install unixodbc
brew install lua
brew install vim --with-lua
brew install w3m
brew install wget
brew install zsh
brew install rmtrash

brew cask install 1password
brew cask install alfred
brew cask install android-studio
brew cask install caffeine
brew cask install clamxav
brew cask install cyberduck
brew cask install dash
brew cask install dropbox
brew cask install evernote
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install imageoptim
brew cask install java
brew cask install karabiner
brew cask install magican
brew cask install sequel-pro
brew cask install skitch
brew cask install slack
brew cask install atom

brew cleanup
brew cask cleanup

fi
