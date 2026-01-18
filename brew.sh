#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Darwin" ]
then

brew doctor

brew update
brew upgrade

brew install vim git gh git-delta tmux ghq ripgrep bat fd trash jq fzf sheldon mise kubectx d-kuro/tap/gwq
brew install --cask 1password-cli ghostty font-hackgen
brew cleanup

fi
