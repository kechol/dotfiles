# ========================================
# キーバインド（起動時に必要）
# ========================================

bindkey '^[^[OC' forward-word
bindkey '^[^[OD' backward-word
bindkey '^[^[3~' backward-kill-word

# anyframe（遅延読み込み後に有効化）
bindkey '^T' anyframe-widget-cdr
bindkey '^R' anyframe-widget-put-history
bindkey '^G' anyframe-widget-cd-ghq-repository
bindkey '^B' anyframe-widget-checkout-git-branch
bindkey '^F' anyframe-widget-insert-git-filename

