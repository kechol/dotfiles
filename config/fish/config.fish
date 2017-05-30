balias a   'atom'
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

balias ga  'git add'
balias gb  'git branch -a'
balias gbl 'git blame'
balias gc  'git commit -v'
balias gca 'git commit -v --amend --no-edit'
balias gco 'git checkout'
balias gcl 'git clone --recursive'
balias gd  'git diff'
balias gdc 'git diff --cached'
balias gdh 'git diff "@{u}.."'
balias gf  'git fetch'
balias gl  'git log'
balias glh 'git log "@{u}.."'
balias gla 'git log --graph --decorate --pretty=oneline --abbrev-commit --date=relative --all'
balias gm  'git merge'
balias gpl 'git pull'
balias gps 'git push'
balias gr  'git rm'
balias grc 'git rm --cached'
balias grs 'git reset HEAD'
balias grv 'git checkout --'
balias gs  'git status -sb'
balias gt  'git tag'

balias dc  'docker-compose'
balias dm  'docker-machine'
balias docker-clean-images     'docker rmi (docker images -a --filter=dangling=true -q)'
balias docker-clean-containers 'docker rm  (docker ps --filter=status=exited --filter=status=created -q)'

balias be  'bundle exec'
balias bi  'bundle install'
balias bu  'bundle update'
balias bo  'bundle open'
balias rs  'bundle exec rails s'
balias rc  'bundle exec rails c'
balias rg  'bundle exec rails g'
balias rd  'bundle exec rails d'
balias rr  'bundle exec rails r'
balias rk  'bundle exec rake'
balias rt  'bundle exec rspec'

umask 022

set -gx PATH "$HOME/.bin" $PATH
set -gx EDITOR vim
set -gx PAGER  less
set -gx LANG   en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8

# plugin config
set -g Z_SCRIPT_PATH (brew --prefix)/etc/profile.d/z.sh

# anyenv
set -gx PATH "$HOME/.anyenv/bin" $PATH
anyenv init - | source

# tmux
test $TERM != 'screen-256color'; and exec tmux

# powerline
#set fish_function_path $fish_function_path "$HOME/.powerline/powerline/bindings/fish"
#powerline-setup

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
