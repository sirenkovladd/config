# brew install fish

fish_add_path /opt/homebrew/opt/postgresql@15/bin $HOME/.cargo/bin $HOME/.local/bin /opt/homebrew/bin
set -U GIT_EXTERNAL_DIFF difft
ln -fs $(pwd)/fish/config.fish ~/.config/fish/config.fish

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
docker completion fish > .config/fish/completions/docker.fish
mise completion fish > ~/.config/fish/completions/mise.fish
wget https://raw.githubusercontent.com/eza-community/eza/refs/heads/main/completions/fish/eza.fish -O .config/fish/completions/eza.fish
bun completions
ln -s ~/.local/share/mise/installs/bat/latest/autocomplete/bat.fish .config/fish/completions/bat.fish
ln -s ~/.local/share/mise/installs/ripgrep/latest/complete/rg.fish .config/fish/completions/rg.fish
