#!/usr/bin/env bash

set -e
sudo -v

if [ "$(uname -s)" == "Darwin" ]
then

brew doctor

brew update
brew upgrade

brew install vim git gh git-delta tmux ghq ripgrep bat fd trash jq yq fzf sheldon starship mise overmind kubectx
brew install --cask 1password-cli ghostty font-fira-code-nerd-font
brew cleanup

fi
