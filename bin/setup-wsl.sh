sudo add-apt-repository ppa:neovim-ppa/unstable -y
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt update
sudo apt upgrade -y

sudo apt install stow -y
cd ~/.dotfiles
stow .

sudo apt install -o Dpkg::Options::="--force-overwrite" \
    build-essential \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    pkg-config \
    autoconf \
    cmake \
    libpq-dev \
    python3-pip \
    nodejs \
    default-jre \
    default-jdk \
    zip \
    fortune \
    direnv \
    emacs \
    neovim \
    fish \
    swig \
    tree -y

LOCAL_BIN=$HOME/.local/bin
mkdir -p $LOCAL_BIN
export PATH="$PATH:$LOCAL_BIN"

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

curl -OL https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.18.4.linux-amd64.tar.gz
rm go1.18.4.linux-amd64.tar.gz

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

export PATH="$PATH:/usr/local/go/bin:$HOME/.cargo/bin"

go install github.com/jesseduffield/lazygit@latest
go install github.com/xxxserxxx/gotop/v4/cmd/gotop@v4.1.2

cargo install starship \
    git-delta \
    fd-find \
    ripgrep \
    bat \
    stylua

chsh -s /usr/bin/fish

fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher jorgebucaran/nvm.fish && nvm install 16.16.0"

su - ${USER}
