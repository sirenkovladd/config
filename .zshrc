export PATH=/usr/local/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@15/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@16/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Applications/kitty.app/Contents/MacOS:$PATH"
export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"
export FPATH="$(dirname $(realpath ~/.zshrc))/completions:$FPATH"
export ZSH="$HOME/.oh-my-zsh"
export GIT_EXTERNAL_DIFF=difft

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
plugins=(mise git kubectl aws brew docker docker-compose eza helm kubectx fzf rust asdf)

source $ZSH/oh-my-zsh.sh
compinit -u

# export LANG=en_US.UTF-8

export GPG_TTY=$(tty)

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
alias ssh="kitten ssh"
alias ls="eza --icons"
alias ll="ls -lohUmZ --git --time-style=long-iso --no-permissions"
alias du="ncdu"
alias lg="lazygit"
alias cat="bat -P"
alias clear="printf '\033[2J\033[3J\033[1;1H'"
alias kitty-upgrade="curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin"

# K8S
alias kx="kubectx"
alias kn="kubens"

alias m="mise"
alias mr="m run"
alias zedtmp="zed $(mktemp -d)"
# kitty search - <ctrl>+<shift>+h

# displayplacer "id:1 res:1920x1080 scaling:off origin:(0,0) degree:0" "id:2 res:1920x1080 scaling:off origin:(1920,0) degree:0"

[ -s "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
