#!/bin/bash

echo "copy global .gitconfig..."
cp ${HOME}/dev/.dotfiles/.gitconfig ${HOME}/.gitconfig

echo "Setup global Username / E-mail for default usage with git..."
printf 'Name (e.g. "John Doe")?\t\t\t'
IFS="" read -r git_user
git config --global user.name "$git_user"

printf 'E-Mail (e.g. "john.doe@example.org")?\t'
read git_mail
git config --global user.email "$git_mail"

echo "symlinking files..."
ln -sf ${HOME}/dev/.dotfiles/.editorconfig ${HOME}/.editorconfig
ln -sf ${HOME}/dev/.dotfiles/.profile ${HOME}/.profile
ln -sf ${HOME}/dev/.dotfiles/.vimrc ${HOME}/.vimrc
ln -sf ${HOME}/dev/.dotfiles/.zprofile ${HOME}/.zprofile
ln -sf ${HOME}/dev/.dotfiles/.zshrc ${HOME}/.zshrc
ln -sf ${HOME}/dev/.dotfiles/.zshrc.local ${HOME}/.zshrc.local

echo "activating/cloning zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

if [ -e setup-dotfiles.local.sh ]; then
  echo "Executing local setup script..."
  source setup-dotfiles.local.sh
fi

# link aws cli to be available in Leapp
echo "symlinking aws cli tools from /opt/homebrew/ to /usr/local/bin/"
sudo ln -s /opt/homebrew/bin/aws /usr/local/bin/aws
sudo ln -s /opt/homebrew/bin/az /usr/local/bin/az

