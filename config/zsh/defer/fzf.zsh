# ========================================
# fzf
# ========================================

export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --inline-info
  --color=dark
  --preview-window=right:60%
"

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ========================================
# コマンド履歴検索 (^R)
# fzfのデフォルトで提供
# ========================================
# デフォルトの ^R を使用

# ========================================
# ファイル検索 (^T)
# fzfのデフォルトで提供
# ========================================
# デフォルトの ^T を使用

# ========================================
# ディレクトリ履歴移動 (^U)
# ========================================
function fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | \
        fzf --prompt="Directory > " \
            --preview 'ls -la {}')
    if [[ -n "$selected_dir" ]]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N fzf-cdr
bindkey '^U' fzf-cdr

# ========================================
# ghqリポジトリ移動 (^B)
# ========================================
function fzf-ghq() {
    local selected_dir=$(ghq list --full-path | \
        fzf --prompt="Repository > " \
            --preview "bat --color=always --style=header,grid --line-range :80 {}/README.md 2>/dev/null")
    if [[ -n "$selected_dir" ]]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N fzf-ghq
bindkey '^B' fzf-ghq

