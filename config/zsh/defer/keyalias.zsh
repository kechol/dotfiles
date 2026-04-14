# ========================================
# エイリアス
# ========================================

# グローバルエイリアス
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# 一般
alias b='brew'
alias c='claude'
alias cc='claude -c'
alias cr='claude -r'
alias cl='clear'
alias f='find'
alias l='ls -al'
alias m='mv'
alias md='mo --foreground --watch "./**/*.md"'
alias o='open'
alias rm='trash'
alias s='ssh'
alias v='vim'
alias vi='vim'

# Git / GitHub
alias g='git'
alias gi='gh issue'
alias gil='gh issue list'
alias giv='gh issue view'
alias gic='gh issue create'
alias gs='git status -sb'
alias gb='gh browse'
alias gca='git commit --amend --no-edit'
alias gcai='git-commit-ai'
alias gdc='git diff --cached'
alias grs='git reset HEAD'
alias grv='git checkout --'
alias gpf='git push --force-with-lease'
alias gpr='gh pr'
alias gprl='gh pr list'
alias gprc='gh pr create'
alias gprv='gh pr view'
alias gsw='git update-index --skip-worktree'
alias gtw='git update-index --no-skip-worktree'
alias gclb='git-clean-local-branch'

# Docker
alias d='docker'
alias dm='docker-machine'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcuf='docker-compose up --force-recreate'
alias dcr='docker-compose run --rm'
alias dcd='docker-compose down'
alias dcl='docker-compose logs -f -t --tail=200'

# Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'

# Node / npm
alias ns='npm start'
alias nt='npm test'
alias nr='npm run'
alias ni='npm install'

# Kubernetes
alias k='kubectl'
alias kg='kubectl get'
alias kx='kubectl exec'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias kc='kubectx'
alias kn='kubens'
alias -g kP='$(kubectl get pods | fzf | awk "{print \$1}")'
