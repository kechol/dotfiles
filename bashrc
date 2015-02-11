[ -z "$PS1" ] && return

uname 022
ulimit -c 0
stty -ixon

PS1="\[\e]0;\u@\h\w\a\][\h \W]\$ "

export PATH="$HOME/.bin:/usr/local/bin:$PATH"
export PAGER=less
export EDITOR=vim
export HISTSIZE=10000
export HISTFILESIZE=20000
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export SSH_AGENT_LOG=$HOME/.ssh/agent.log

shopt -s autocd
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s sourcepath
shopt -s no_empty_cmd_completion

set -o noclobber
set -o nounset

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -lFh'
alias la='ls -lAFh'
alias more='less'
alias mkdir='mkdir -p'
alias rm='rm -i'
alias vi='vim'

alias a='awk'
alias c='cd'
alias d='diff'
alias e='echo'
alias f='find'
alias g='git'
alias h='hg'
alias k='kill -9'
alias l='ll'
alias m='mv'
alias o='open'
alias p='ps aux'
alias s='sudo'
alias t='top'
alias v='vim'
alias w='wget'

alias C='wc -l'
alias G='grep'
alias H='head'
alias L="less"
alias M='more'
alias S='sort'
alias T='tail'
alias X='xargs'
