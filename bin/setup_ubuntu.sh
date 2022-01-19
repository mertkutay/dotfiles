sudo apt update -y

sudo apt install build-essential \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    pkg-config \
    autoconf \
    cmake \
    zsh -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose -y
sudo usermod -aG docker ${USER}

sudo apt install python3-pip -y
pip3 install flake8 black isort
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

export PATH="$PATH/.local/bin"

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

sudo apt install -o Dpkg::Options::="--force-overwrite" \
    libpq-dev \
    swig \
    ctags \
    fd-find \
    ripgrep \
    bat \
    tree -y

ln -s $(which fdfind) ~/.local/bin/fd
ln -s $(which batcat) ~/.local/bin/bat

TEMP_DEB="$(mktemp)"
wget -O "$TEMP_DEB" 'https://github.com/dandavison/delta/releases/download/0.7.1/git-delta_0.7.1_amd64.deb'
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
$ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/sindresorhus/pure $ZSH_CUSTOM/themes/pure
rm "$HOME/.zshrc"

chsh -s /bin/zsh
su - ${USER}
