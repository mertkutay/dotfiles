xcode-select --install
sudo softwareupdate --install-rosetta
defaults write -g ApplePressAndHoldEnabled -bool false

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install \
    stow \
    fish \
    starship \
    tmux \
    amethyst \
    neovim \
    direnv \
    wget \
    htop \
    gnupg \
    openssl \
    ffmpeg \
    pyenv \
    pipx \
    go \
    rust \
    lazygit \
    fzf \
    ripgrep \
    fd \
    jq \
    git-delta \
    bat \

cd ~/.dotfiles
stow .

echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
pyenv install 3.11.8
pyenv global 3.11.8

pipx install poetry ruff

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher jorgebucaran/nvm.fish

nvm install 16.20.0
npm install -g yarn prettier eslint
