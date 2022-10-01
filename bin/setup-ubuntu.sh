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

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

LOCAL_BIN=$HOME/.local/bin
mkdir -p $LOCAL_BIN
export PATH="$PATH:$LOCAL_BIN"

if grep -qi microsoft /proc/version; then
  curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
  unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
  chmod +x /tmp/win32yank.exe
  sudo mv /tmp/win32yank.exe /usr/local/bin/
fi

curl -sSL https://install.python-poetry.org | python3 -
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

arch=$(dpkg --print-architecture)
curl -OL https://go.dev/dl/go1.18.4.linux-$arch.tar.gz
sudo tar -C /usr/local -xvf go1.18.4.linux-$arch.tar.gz
rm go1.18.4.linux-$arch.tar.gz

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

sudo chsh -s /usr/bin/fish $(whoami)

fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher jorgebucaran/nvm.fish && nvm install 16.16.0"

curl -sS https://starship.rs/install.sh | sudo sh

su - ${USER}
