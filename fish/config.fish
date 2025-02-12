# export PATH="/opt/homebrew/opt/llvm@15/bin:$PATH"
# export PATH="/opt/homebrew/opt/llvm@16/bin:$PATH"
# aes -in backup_documents_22_07_24.zip -out backup_documents_22_07_24.zip.aes
# aes -d -in backup_documents_22_07_24.zip -out backup_documents_22_07_24.zip.aes

# set -x GPG_TTY $(tty)

mise activate fish | source
if status is-interactive
    starship init fish | source
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/vlad/.lmstudio/bin
