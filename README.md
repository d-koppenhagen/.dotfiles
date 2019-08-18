# .dotfiles

This repository contains some common dotfiles I am using for my local dev environment.

## Files and their content

### .editorconfig

A basic `.editorconfig` with some common settings.

### .gitconfig

Basic git configuration and shortcuts

### .osx

Some settings for macOS, for configuring finder, Desktop, enabling some debug options, display options (hidden files, file extensions, etc.)

### .profile

Some common `$PATH` and other environment variable exports.

### .vimrc

My custom vim configuration using _Vundle_ Plugin Manager.

Step1: Istall Vundle:

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Step2: Install and activate the Plugins by optening `vim` and typing the following command:

```vim
:PluginInstall
```

### .zprofile

Some common `$PATH` and other environment variable exports for zsh.

### .zshrc

my zsh configuration using _oh-my-zsh_. In this config some basic aliasses and functions are configured.

### com.googlecode.iterm2.plist

Not really a _dotfile_ but nonetheless usefull: my iTerm2 configuration.

### Brewfile

The `Brewfile` contains the installed package configuration. You can simply
install the packages in the file by running `brew bundle` if you are in the
current directory or by using the path to the file:
`brew bundle ${HOME}/dev/.dotfiles/Brewfile`.
It will install the packages from `brew`, `cask` and `mas`.

Creating a new file can be achieved by exporting it e.g. via `cakebrew`:

- Tools
- Export Brew Installation

## new setup

When seeting up your mac completely new, I recommend the following steps:

- proceed the macOS conmfiguration (`sudo sh .osx`).
- Install Homebrew (<https://brew.sh>)
- Install Homebrew packages via `Brewfile`.
- Link your dotfiles (`ln -sf ${HOME}/dev/.dotfiles/<DOTFILE> ${HOME}/<DOTFILE>`) or copy them (`cp ${HOME}/dev/.dotfiles/<DOTFILE> ${HOME}/<DOTFILE>`)
- Install [iTerm2](https://www.iterm2.com/)
- Import / link iTerm2 configuration (Preferences -> Gerneral -> Preferences -> Load preferences from a custom URL or folder)
