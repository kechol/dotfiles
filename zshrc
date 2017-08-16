source /usr/local/share/antigen/antigen.zsh

export ANDROID_SDK_HOME="$HOME/Library/Android/sdk"
export EDITOR=vim
export PATH="$HOME/.bin:/usr/local/bin:$HOME/.anyenv/bin:$PATH"
export PAGER=less
export LANG=
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_ITERM2=true

eval "$(anyenv init -)"
eval "$(hub alias -s)"
eval "$(direnv hook zsh)"

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
autoload -Uz compinit; compinit
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

antigen use oh-my-zsh
antigen theme refined
antigen bundle aws
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle docker
antigen bundle git
antigen bundle heroku
antigen bundle npm
antigen bundle osx
antigen bundle rails
antigen bundle z
antigen bundle mollifier/anyframe
antigen bundle zsh-users/zsh-completions
antigen apply

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias a='atom'
alias b='brew'
alias c='cd'
alias cu='cd ../'
alias e='echo'
alias f='find'
alias h='hg'
alias k='kill'
alias k9='kill -9'
alias l='ls -al'
alias m='mv'
alias n='ngrok'
alias o='open'
alias p='ps aux'
alias rm='rmtrash'
alias s='ssh'
alias v='vim'
alias vi='vim'
alias w='wget'

alias g='git'
alias gi='git'
alias gs='git status -sb'
alias gh='git browse'
alias gca='git commit --amend --no-edit'
alias gdc='git diff --cached'
alias grs='git reset HEAD'
alias grv='git checkout --'
alias gsw='git update-index --skip-worktree'
alias gtw='git update-index --no-skip-worktree'
alias gclb='git-clean-local-branch'

alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'

alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'

alias r='bundle exec rails'
alias rk='bundle exec rake'
alias rp='bundle exec rspec'

bindkey '^T' anyframe-widget-cdr
bindkey '^R' anyframe-widget-put-history
bindkey '^G' anyframe-widget-cd-ghq-repository
bindkey '^B' anyframe-widget-checkout-git-branch
bindkey '^F' anyframe-widget-insert-git-filename

function chpwd() { ls }

function git-clean-local-branch() {
  target='master'
  if [ "$1" != "" ]; then
    target="$1"
  fi
  git branch --merged "$target" | grep -v "$target" | xargs git branch -d
}

if [ "$TMUX" = "" ]; then tmux; fi
