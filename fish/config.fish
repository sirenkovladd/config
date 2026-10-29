# export PATH="/opt/homebrew/opt/llvm@15/bin:$PATH"
# export PATH="/opt/homebrew/opt/llvm@16/bin:$PATH"
# aes -in backup_documents_22_07_24.zip -out backup_documents_22_07_24.zip.aes
# aes -d -in backup_documents_22_07_24.zip -out backup_documents_22_07_24.zip.aes

# set -x GPG_TTY $(tty)

mise activate fish | source
if status is-interactive
    starship init fish | source
end

zoxide init fish | source

# (removed: Antigravity PATH entry — app uninstalled, VSCodium kept)

# opencode
fish_add_path /Users/vlad/.opencode/bin
set -gx ANDROID_HOME ~/Library/Android/sdk
set -gx PATH $PATH ~/Library/Android/sdk/platform-tools ~/Library/Android/sdk/cmdline-tools/latest/bin

# (removed: Antigravity IDE PATH entry — app uninstalled, VSCodium kept)


# Added by Antigravity CLI installer
set -gx PATH "/Users/vlad/.local/bin" $PATH

# Editor: zed (fast) for shell tools like git commit / sudoedit / crontab.
# codium stays as the yazi `o` opener for real coding sessions.
# `--wait` is REQUIRED for GUI editors so shell tools actually block
# until you close the editor window.
set -gx EDITOR "zed --wait"
set -gx VISUAL "zed --wait"

# (removed: duplicate Antigravity IDE PATH entry — app uninstalled)

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/vlad/.lmstudio/bin
# End of LM Studio CLI section


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
