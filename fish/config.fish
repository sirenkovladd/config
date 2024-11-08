# export PATH="/opt/homebrew/opt/llvm@15/bin:$PATH"
# export PATH="/opt/homebrew/opt/llvm@16/bin:$PATH"

set -x GPG_TTY $(tty)

if status is-interactive
    set -U fish_greeting ""
    mise activate fish | source
    starship init fish | source
end

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
