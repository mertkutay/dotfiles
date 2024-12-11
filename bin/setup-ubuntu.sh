curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
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
    python3-pip \
    default-jre \
    default-jdk \
    zip \
    direnv \
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
sudo usermod -aG docker $USER

LOCAL_BIN=$HOME/.local/bin
mkdir -p $LOCAL_BIN
export PATH="$PATH:$LOCAL_BIN"

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

if grep -qi microsoft /proc/version; then
  curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
  unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
  chmod +x /tmp/win32yank.exe
  sudo mv /tmp/win32yank.exe /usr/local/bin/
fi

curl -LsSf https://astral.sh/uv/install.sh | sh

curl -f https://zed.dev/install.sh | sh

arch=$(dpkg --print-architecture)
curl -OL https://go.dev/dl/go1.18.4.linux-$arch.tar.gz
sudo tar -C /usr/local -xvf go1.18.4.linux-$arch.tar.gz
rm go1.18.4.linux-$arch.tar.gz

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

export PATH="$PATH:/usr/local/go/bin:$HOME/.cargo/bin"

go install github.com/jesseduffield/lazygit@latest
go install github.com/xxxserxxx/gotop/v4/cmd/gotop@v4.1.2

cargo install starship \
    git-delta \
    fd-find \
    ripgrep \
    bat

sudo chsh -s /usr/bin/fish $(whoami)

fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher jorgebucaran/nvm.fish && nvm install 16.16.0"

su - ${USER}
