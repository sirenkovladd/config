# export PATH="/opt/homebrew/opt/llvm@15/bin:$PATH"
# export PATH="/opt/homebrew/opt/llvm@16/bin:$PATH"

set -x GPG_TTY $(tty)

if status is-interactive
    set -U fish_greeting ""
    mise activate fish | source
    starship init fish | source
end
