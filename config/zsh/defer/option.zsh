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


# ========================================
# 補完設定
# ========================================

# 補完スタイル
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Git補完の高速化
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}


 # ========================================
 # Google Cloud SDK
 # ========================================
if [ -f "$HOME/.gcloud/google-cloud-sdk/path.zsh.inc" ]; then
  zsh-defer source "$HOME/.gcloud/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/.gcloud/google-cloud-sdk/completion.zsh.inc" ]; then
  zsh-defer source "$HOME/.gcloud/google-cloud-sdk/completion.zsh.inc"
fi
