# Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g CA="2>&1 | cat -A"
alias -g C='| wc -l'
alias -g DN=/dev/null
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g G='| egrep'
alias -g H='| head'
alias -g L="| less"
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g S='| sort'
alias -g T='| tail'
alias -g X='| xargs'

alias a='awk'
alias b='brew'
alias c='cd'
alias d='diff'
alias e='echo'
alias f='find'
alias g='git'
alias h='hg'
alias j='autojump'
alias k='kill -9'
alias l='ls -al'
alias m='mv'
alias n='ngrok'
alias o='open'
alias p='ps aux'
alias rm='rmtrash'
alias s='sudo'
alias v='vim'
alias w='wget'
alias z='zsh'

alias -s php='php'
alias -s phar='php'
alias -s rb='ruby'
alias -s py='python'
alias -s js='node'

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

export PATH="$HOME/.bin:/usr/local/bin:$PATH"
export EDITOR=vim
export PAGER=less
export LANG=
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

umask 022

# unset C-s
stty -ixon -ixoff

# strong complement
autoload -Uz compinit; compinit

# un-ls
function chpwd() { ls }

# autojump
if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi
