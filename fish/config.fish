# export PATH="/opt/homebrew/opt/llvm@15/bin:$PATH"
# export PATH="/opt/homebrew/opt/llvm@16/bin:$PATH"

# set -x GPG_TTY $(tty)

mise activate fish | source
if status is-interactive
    starship init fish | source
end
