#!/bin/bash

set -e

# Ask for sudo password upfront and keep it alive for the script duration
/usr/bin/sudo -v
while true; do /usr/bin/sudo -n true; sleep 10; kill -0 "$$" || exit; done 2>/dev/null &

DOTFILES_DIR="${HOME}/dev/.dotfiles"

# ─── Homebrew ────────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing packages from Brewfile..."
brew bundle --file="${DOTFILES_DIR}/Brewfile"

# ─── Git ─────────────────────────────────────────────────────────────────────────
echo "Copy global .gitconfig..."
cp "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"

echo "Setup global Username / E-mail for default usage with git..."
printf 'Name (e.g. "John Doe")?\t\t\t'
IFS="" read -r git_user
git config --global user.name "$git_user"

printf 'E-Mail (e.g. "john.doe@example.org")?\t'
read git_mail
git config --global user.email "$git_mail"

# ─── Symlinks ────────────────────────────────────────────────────────────────────
echo "Symlinking files..."
ln -sf "${DOTFILES_DIR}/.editorconfig" "${HOME}/.editorconfig"
ln -sf "${DOTFILES_DIR}/.gitmessage" "${HOME}/.gitmessage"
ln -sf "${DOTFILES_DIR}/.profile" "${HOME}/.profile"
ln -sf "${DOTFILES_DIR}/.vimrc" "${HOME}/.vimrc"
ln -sf "${DOTFILES_DIR}/.zprofile" "${HOME}/.zprofile"
ln -sf "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_DIR}/.zshrc.local" "${HOME}/.zshrc.local"

# ─── Oh My Zsh ───────────────────────────────────────────────────────────────────
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Activating/cloning zsh-autosuggestions..."
ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
fi

echo "Activating/cloning nx-completion..."
if [ ! -d "${ZSH_CUSTOM}/plugins/nx-completion" ]; then
  git clone https://github.com/jscutlery/nx-completion.git "${ZSH_CUSTOM}/plugins/nx-completion"
fi

# ─── SDKMAN ──────────────────────────────────────────────────────────────────────
if [ ! -d "${HOME}/.sdkman" ]; then
  echo "Installing SDKMAN..."
  curl -s "https://get.sdkman.io?rcupdate=false" | bash
fi

# ─── VS Code / Kiro Settings ────────────────────────────────────────────────────
VSCODE_USER_DIR="${HOME}/Library/Application Support/Code/User"
KIRO_USER_DIR="${HOME}/Library/Application Support/Kiro/User"

if [ -d "${VSCODE_USER_DIR}" ]; then
  echo "Symlinking VS Code settings.json..."
  ln -sf "${DOTFILES_DIR}/settings.json" "${VSCODE_USER_DIR}/settings.json"
fi

if [ -d "${KIRO_USER_DIR}" ]; then
  echo "Symlinking Kiro settings.json..."
  ln -sf "${DOTFILES_DIR}/settings.json" "${KIRO_USER_DIR}/settings.json"
fi

# ─── Local setup ─────────────────────────────────────────────────────────────────
if [ -e "${DOTFILES_DIR}/setup-dotfiles.local.sh" ]; then
  echo "Executing local setup script..."
  source "${DOTFILES_DIR}/setup-dotfiles.local.sh"
fi

# ─── Symlink CLI tools to /usr/local/bin (for Leapp compatibility) ───────────────
echo "Symlinking CLI tools to /usr/local/bin (if needed)..."
mkdir -p /usr/local/bin 2>/dev/null || true

if [ -f /opt/homebrew/bin/aws ] && [ ! -e /usr/local/bin/aws ]; then
  sudo ln -sf /opt/homebrew/bin/aws /usr/local/bin/aws
fi

if [ -f /opt/homebrew/bin/az ] && [ ! -e /usr/local/bin/az ]; then
  sudo ln -sf /opt/homebrew/bin/az /usr/local/bin/az
fi

echo ""
echo "✅ Done! Open a new terminal to pick up all changes."
