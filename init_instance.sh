#!/bin/bash

# Determine OS distribution (Debian/Ubuntu only)
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  OS=$ID
  [[ "$OS" != "ubuntu" && "$OS" != "debian" ]] && \
    echo "Unsupported OS: $OS. Only Debian and Ubuntu are supported." >&2 && exit 1
elif type lsb_release >/dev/null 2>&1; then
  OS=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
  [[ "$OS" != "ubuntu" && "$OS" != "debian" ]] && \
    echo "Unsupported OS: $OS. Only Debian and Ubuntu are supported." >&2 && exit 1
else
  echo "Unable to determine OS distribution. Exiting." >&2
  exit 1
fi


# Update apt
sudo apt update -y

# Install packages
sudo apt install -y wget vim git zsh

# Change default shell to zsh
chsh -s $(which zsh)

# Create ~/.zsh if it doesn't exist
if [ ! -d "$HOME/.zsh" ]; then
  mkdir "$HOME/.zsh"
fi

# Clone zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc


# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sh
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> ${ZDOTDIR:-$HOME}/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ${ZDOTDIR:-$HOME}/.zshrc

# install golang
GO_VERSION="1.22.7"
GO_TARBALL="go$GO_VERSION.linux-amd64.tar.gz"
wget https://go.dev/dl/$GO_TARBALL
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf $GO_TARBALL
echo 'export PATH=$PATH:/usr/local/go/bin' >> ${ZDOTDIR:-$HOME}/.zshrc

# install nginx
sudo apt install nginx -y
sudo systemctl enable nginx -y 
sudo systemctl start nginx -y

# install docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/$OS/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$OS \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin




