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

Setup fish plugins with fisherman

```
fisher
```

Override OSX defaults

```
./osx/defaults.sh
```

Install Vim bundles (in Vim)

```
:NeoBundleInstall
```

Install Powerline

```
pip install powerline-status
```


## Requirements

- [Command Line Tools](https://developer.apple.com/downloads/index.action)
- [Homebrew](http://brew.sh/)
- [Fish shell](https://fishshell.com/)
- [Fisherman](https://github.com/fisherman/fisherman)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
- [Powerline](https://github.com/powerline/powerline)

