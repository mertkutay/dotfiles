sudo apt update -y
sudo apt install zsh -y

sudo apt install build-essential \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    software-properties-common \
    pkg-config \
    autoconf \
    cmake -y

 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
 echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose -y
sudo usermod -aG docker ${USER}

sudo apt install python3-pip -y
pip3 install virtualenvwrapper pynvim python-language-server flake8 black
export PATH="$PATH/.local/bin"
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
source $HOME/.local/bin/virtualenvwrapper.sh

sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt install neovim -y

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source "$HOME/.nvm/nvm.sh"
nvm install 14
npm install -g yarn
yarn global add bash-language-server dockerfile-language-server-nodejs

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

./linkall

