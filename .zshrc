export PATH=/usr/local/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Users/vlad/.local/bin:$PATH"
export PATH="/Applications/kitty.app/Contents/MacOS:$PATH"
export FPATH="~/programming/eza/completions/zsh:$FPATH"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# zstyle ':omz:update' frequency 13
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# HIST_STAMPS="mm/dd/yyyy"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git kubectl aws brew docker docker-compose eza helm kubectx mise node fzf ripgrep)

source $ZSH/oh-my-zsh.sh

# export LANG=en_US.UTF-8

eval "$(starship init zsh)"
export GPG_TTY=$(tty)

# bun completions
[ -s "/Users/vlad/.bun/_bun" ] && source "/Users/vlad/.bun/_bun"

eval "$(/Users/vlad/.local/bin/mise activate zsh)"

eval "$(mise completion zsh)"
eval "$(zoxide init zsh)"

alias ssh="kitten ssh"
alias ls="eza"
alias ll="ls -lohUmZ --git --time-style=long-iso --no-permissions"
alias du="ncdu"
alias lg="lazygit"

# for f in `ls ~/.kube/config/`
# do
#     export KUBECONFIG="$HOME/.kube/config/$f:$KUBECONFIG";
# done
