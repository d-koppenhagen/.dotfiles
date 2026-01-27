# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"
# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# include .profile file
if [ -f ~/.profile ]; then
  source ~/.profile
fi

# Created by `pipx` on 2025-09-16 14:40:27
export PATH="$PATH:/${HOME}/.local/bin"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"
