#!/bin/bash

echo "copying files that needs to be adjusted..."
echo "copy gitconfig! -> adjust the user afterwards!"
cp ${HOME}/dev/.dotfiles/.gitconfig ${HOME}/.gitconfig

echo "symlinking files files..."
ln -sf ${HOME}/dev/.dotfiles/.editorconfig ${HOME}/.editorconfig
ln -sf ${HOME}/dev/.dotfiles/.profile ${HOME}/.profile
ln -sf ${HOME}/dev/.dotfiles/.vimrc ${HOME}/.vimrc
ln -sf ${HOME}/dev/.dotfiles/.zprofile ${HOME}/.zprofile
ln -sf ${HOME}/dev/.dotfiles/.zshrc ${HOME}/.zshrc
ln -sf ${HOME}/dev/.dotfiles/.zshrc.local ${HOME}/.zshrc.local
