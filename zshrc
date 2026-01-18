export PATH="/opt/homebrew/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# mise
eval "$(mise activate zsh)"
eval "$(mise hook-env)"

# sheldon
eval "$(sheldon source)"
# see: ~/.config/zsh/{sync,defer}/*.zsh
