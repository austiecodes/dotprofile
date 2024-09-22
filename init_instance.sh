#!/bin/bash

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
GO_VERSION="1.22.0"
GO_TARBALL="go$GO_VERSION.linux-amd64.tar.gz"
wget https://go.dev/dl/$GO_TARBALL
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf $GO_TARBALL
echo 'export PATH=$PATH:/usr/local/go/bin' >> ${ZDOTDIR:-$HOME}/.zshrc




