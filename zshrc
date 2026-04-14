export PATH="/opt/homebrew/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$HOME/.browser-use-env/bin:$HOME/.gcloud/google-cloud-sdk/bin:$HOME/.bun/bin:$PATH"

# mise
eval "$(mise activate zsh)"
eval "$(direnv hook zsh)"

# sheldon
eval "$(sheldon source)"
# see: ~/.config/zsh/{sync,defer}/*.zsh

# starship
eval "$(starship init zsh)"

# fzf
source <(fzf --zsh)

# git-wt
eval "$(git wt --init zsh)"

# docker
source /Users/kazuyuki.suzuki/.docker/init-zsh.sh || true # Added by Docker Desktop

# gcloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kazuyuki.suzuki/.gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kazuyuki.suzuki/.gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kazuyuki.suzuki/.gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kazuyuki.suzuki/.gcloud/google-cloud-sdk/completion.zsh.inc'; fi

# salesforce
SF_AC_ZSH_SETUP_PATH=/Users/kazuyuki.suzuki/Library/Caches/sf/autocomplete/zsh_setup && test -f $SF_AC_ZSH_SETUP_PATH && source $SF_AC_ZSH_SETUP_PATH; # sf autocomplete setup

# coursier (sbt, scala)
export PATH="$HOME/.local/share/coursier/bin:$PATH"

# サプライチェーン攻撃対策
export PIP_INDEX_URL=https://pypi.flatt.tech/simple/
export UV_INDEX_URL=https://pypi.flatt.tech/simple/
export UV_EXCLUDE_NEWER="3 days"
