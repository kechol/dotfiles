# ========================================
# 関数定義
# ========================================

function chpwd() { ls }

function git-clean-local-branch() {
  target='master'
  if [ "$1" != "" ]; then
    target="$1"
  fi
  git branch --merged "$target" | grep -v "$target" | xargs git branch -d
}

function git-commit-ai() {
  git commit -m "$(git diff --cached | claude -p 'Generate a concise commit message. Output only the message.')"
}

# ========================================
# 補完設定
# ========================================

# 補完スタイル
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Git補完の高速化
zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}

