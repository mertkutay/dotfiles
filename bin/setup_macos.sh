sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install python@3.8
brew link python@3.8
brew pin python

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

pip3 install flake8 black isort mypy

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source "$HOME/.nvm/nvm.sh"
nvm install node 14
npm install -g yarn
yarn global add pyright \
     typescript \
     typescript-language-server \
     bash-language-server \
     docker-langserver \
     yaml-language-server \
     solcjs

brew install openssl \
    openblas \
    tmux \
    libpq \
    zlib \
    jpeg \
    swig \
    universal-ctags \
    fd \
    ripgrep \
    bat \
    git-delta \
    tree \
    gh \
    ffmpeg \
    rust \
    htop \
    coreutils
