# ========================================
# zshオプション（起動時に必要）
# ========================================

umask 022
stty -ixon -ixoff

setopt autocd
setopt autopushd
setopt autolist
setopt autoparamslash
setopt chaselinks
setopt listpacked
setopt listtypes
setopt nobeep
setopt print_eight_bit
setopt no_flow_control
setopt extended_glob

# 履歴設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# ディレクトリ履歴
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs


# ========================================
# 環境変数（起動時に必要）
# ========================================

export EDITOR=vim
export PAGER=less
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadacec

# ロケール設定
export LANG=
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ツール設定
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export WORDCHARS='*?_-[]~=&!#$%^(){}<>'

# 言語/SDK
export CLOUDSDK_PYTHON=python3
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"
