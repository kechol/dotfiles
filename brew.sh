#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Darwin" ]
then

brew doctor

brew update
brew upgrade

brew install vim git gh tmux ghq ripgrep bat fd trash jq fzf sheldon mise kubectx
brew install --cask 1password-cli ghostty font-hackgen
brew cleanup

fi
