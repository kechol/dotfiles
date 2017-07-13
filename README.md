# Kechol's dotfiles


## Installation

Checkout project.

```
git clone https://github.com/kechol/dotfiles.git ~/.dotfiles
git submodule update --init --recursive
```

Install packages and apps

```
./brew.sh
```

Setup config files

```
./bootstrap.sh
```

Override OSX defaults

```
./osx/defaults.sh
```

## Requirements

- [Command Line Tools](https://developer.apple.com/downloads/index.action)
- [Homebrew](http://brew.sh/)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
