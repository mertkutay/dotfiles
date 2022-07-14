xcode-select --install
sudo softwareupdate --install-rosetta
defaults write -g ApplePressAndHoldEnabled -bool false

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install fish
chsh -s /opt/homebrew/bin/fish

brew install \
    coreutils stow \
    pyenv go rust \
    htop gotop lazygit spotify-tui \
    wget tmux direnv \
    gnupg pass browserpass pinentry-mac \
    neovim alacritty bluesnooze \
    ripgrep fd fzf \
    libpq openssl ffmpeg \
    jq pidof imagemagick neofetch fortune \
    koekeishiya/formulae/yabai koekeishiya/formulae/skhd

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
pyenv install 3.9.11
pyenv global 3.9.11
pip install flake8 black isort ipython pywal
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

curl -sL https://git.io/fisher | source
fisher install jorgebucaran/fisher
fisher install IlanCosman/tide

fisher install jorgebucaran/nvm.fish
nvm install 16
npm install -g yarn
yarn global add prettier eslint

cargo install stylua

brew services start yabai
brew services start skhd
