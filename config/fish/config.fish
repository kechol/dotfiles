balias a   'awk'
balias b   'brew'
balias c   'cd'
balias d   'docker'
balias e   'echo'
balias f   'find'
balias g   'git'
balias gi  'git'
balias h   'hg'
balias k   'kill -9'
balias l   'ls -al'
balias m   'mv'
balias n   'ngrok'
balias o   'open'
balias p   'ps aux'
balias r   'rmtrash'
balias s   'sudo'
balias v   'vim'
balias vi  'vim'
balias w   'wget'
balias z   'zsh'

balias ga  'git add'
balias gb  'git branch -a'
balias gc  'git commit -v'
balias gca 'git commit -v --amend'
balias gco 'git checkout'
balias gcl 'git clone --recursive'
balias gd  'git diff'
balias gdc 'git diff --cached'
balias gl  'git log "@{u}.."'
balias gll 'git log'
balias gla 'git log --graph --decorate --pretty=oneline --abbrev-commit --date=relative --all'
balias gm  'git merge'
balias gr  'git reset'
balias grs 'git reset HEAD'
balias grv 'git checkout --'
balias grm 'git rm'
balias grc 'git rm --cached'
balias gpl 'git pull'
balias gps 'git push'
balias gt  'git tag'
balias gs  'git status -sb'

balias dc  'docker-compose'
balias dm  'docker-machine'
balias docker-clean-images     'docker rmi (docker images -a --filter=dangling=true -q)'
balias docker-clean-containers 'docker rm (docker ps --filter=status=exited --filter=status=created -q)'

balias be  'bundle exec'
balias bo  'bundle open'
balias rs  'bundle exec rails'
balias rk  'bundle exec rake'

umask 022

set -gx EDITOR vim
set -gx PAGER  less
set -gx LANG   en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8

set -gx PATH "$HOME/.bin" $PATH

# tmux
test $TERM != 'screen-256color'; and exec tmux

# anyenv
set -gx PATH "$HOME/.anyenv/bin" $PATH
anyenv init - | source

# Android
set -gx ANDROID_SDK_HOME "$HOME/Library/Android/sdk"
set -gx PATH "$ANDROID_SDK_HOME/platform-tools" "$ANDROID_SDK_HOME/tools" $PATH

# ls after cd
function cd
  builtin cd $argv
  ls
end

# rmtrach as rm
function rm
  rmtrash $argv
end
