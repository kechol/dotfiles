#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Darwin" ]
then

brew doctor

brew update
brew upgrade

brew install vim git tmux gh ghq ripgrep trash jq fzf direnv autossh antigen kubectx nkf
brew cleanup

fi
