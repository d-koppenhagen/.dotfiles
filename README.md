# .dotfiles

This repository contains some common dotfiles I am using for my local dev environment.

## .editorconfig

A basic `.editorconfig` with some common settings.

## .gitconfig

Basic git configuration and shortcuts

## .osx

Some settings for macOS, for configuring finder, Desktop, enabling some debug options, display options (hidden files, file extensions, etc.)

## .brew

it contains a list of installed brew packages which is listes by running `brew list > ${HOME}/dev/.dotfiles/.brew`.
To install all listed packages, simply run: `xargs brew install < ${HOME}/dev/.dotfiles/.brew`

## .cask

it contains a list of installed homebrew cask packages which is listes by running `brew cask list > ${HOME}/dev/.dotfiles/.cask`.
To install all listed packages, simply run: `xargs brew cask install < ${HOME}/dev/.dotfiles/.cask`

## .profile

Some common `$PATH` and other environment variable exports.

## .vimrc

My custom vim configuration using _Vundle_ Plugin Manager.

Step1: Istall Vundle:

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Step2: Install and activate the Plugins by optening `vim` and typing the following command:

```vim
:PluginInstall
```

## .zprofile

Some common `$PATH` and other environment variable exports for zsh.

## .zshrc

my zsh configuration using _oh-my-zsh_. In this config some basic aliasses and functions are configured.

## com.googlecode.iterm2.plist

Not really a _dotfile_ but nonetheless usefull: my iTerm2 configuration.
