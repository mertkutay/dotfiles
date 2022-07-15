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
    wget tmux direnv gnupg  \
    neovim iterm2 bluesnooze \
    ripgrep fd fzf stylua \
    libpq openssl ffmpeg \
    jq pidof imagemagick neofetch fortune

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
pyenv install 3.10.5
pyenv global 3.10.5
pip install flake8 black isort ipython
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install jorgebucaran/nvm.fish
nvm install 16.16.0
npm install -g yarn
yarn global add prettier eslint
