sudo apt update -y
sudo apt install zsh -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}

sudo apt install python3-pip -y
pip3 install virtualenvwrapper pynvim python-language-server
export PATH="$PATH/.local/bin"
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
source $HOME/.local/bin/virtualenvwrapper.sh

sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt install neovim -y

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source "$HOME/.nvm/nvm.sh"
nvm install 14
npm install -g yarn
yarn global add bash-language-server

sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep -y

./linkall

