# .dotfiles

Dotfiles and configuration for my macOS development setup.

## Backup (from existing Mac)

Run these steps before switching to a new Mac to capture the current state:

```bash
cd ~/dev/.dotfiles
```

1. **Update Brewfile**

   ```bash
   brew bundle dump --force --file=Brewfile
   ```

1. **Export VS Code / Kiro extensions**

   ```bash
   { kiro --list-extensions 2>/dev/null; code --list-extensions 2>/dev/null; } | sort -uf | sed 's/^/code --install-extension /' > extensions.sh
   ```

1. **Back up VS Code / Kiro settings**

   ```bash
   cp ~/Library/Application\ Support/Code/User/settings.json settings.json
   # or for Kiro:
   cp ~/Library/Application\ Support/Kiro/User/settings.json settings.json
   ```

1. **Back up local (gitignored) files**

   Files in `local/`, `.zshrc.local`, and `settings.local.json` are not committed. Copy them to a secure backup location separately.

1. **Export iTerm2 config**

   In iTerm2: *Settings → General → Settings → Save changes → Save Now*

1. **Commit and push**

   ```bash
   git add -A && git commit -m "chore: backup before new mac" && git push
   ```

---

## Fresh Mac Setup

### Prerequisites

- macOS installed, first-run assistant completed
- Terminal open
- Access to this git repo (SSH key or HTTPS)

### Step 1 — Clone repo

```bash
mkdir -p ~/dev
git clone <repo-url> ~/dev/.dotfiles
cd ~/dev/.dotfiles
```

### Step 2 — macOS system preferences (optional)

Configures Finder, Dock, Trackpad, screenshot folder, hot corners and more. Review the script before running.

```bash
sudo sh osx.sh
```

> ⚠️ This overrides various macOS defaults. Check and adjust settings in the script first.

### Step 3 — Install dotfiles & tools

> Consider installing Kiro / VSCode first since the upcoming script will also hook install extensions and settings when this apps are already installed.

The main setup script handles:
- Installing Homebrew (if not present)
- Installing all packages from `Brewfile`
- Copying `.gitconfig` and prompting for git user name/email
- Symlinking dotfiles to `$HOME` (`.zshrc`, `.profile`, `.vimrc`, `.gitmessage`, …)
- Installing Oh My Zsh and plugins
- Installing SDKMAN
- Symlinking VS Code / Kiro `settings.json` (if app is already installed)
- Symlinking AWS/Azure CLI to `/usr/local/bin` (for Leapp)
- Running `setup-dotfiles.local.sh` (if present)

```bash
sh setup-dotfiles.sh
```

> ℹ️ The VS Code / Kiro `settings.json` symlink is only created if the app's User directory already exists (`~/Library/Application Support/Code/User` or `~/Library/Application Support/Kiro/User`). If you install the editor later, re-run the script or create the symlink manually.

### Step 4 — Editor extensions

Requires VS Code or Kiro to be installed (installed via Brewfile cask).

```bash
sh extensions.sh
```

### Step 5 — Restore local settings

Restore gitignored files from your secure backup:

- **`settings.local.json`** — editor settings with sensitive/internal values (e.g. internal server URLs). See [Local modifications](#settingslocaljson) below.
- **`.zshrc.local`** — machine-specific shell overrides
- **`setup-dotfiles.local.sh`** — machine-specific setup steps
- **`local/`** — any other private config files

### Step 6 — iTerm2 config

In iTerm2: *Preferences → General → Preferences → Load preferences from a custom URL or folder* → set path to `~/dev/.dotfiles`.

![Load iTerm2 config](iterm2-load-config.png)

### Step 7 — Go environment (optional)

```bash
sh setup-go.sh
```

### Step 8 — Java (optional)

See [java.md](./java.md) for SDKMAN-based setup.

### Step 9 — Vim plugins (optional)

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

### Step 10 — GPG for signed commits (optional)

```bash
# Import your private key
gpg --import <path-to-private-key>

# Configure pinentry-mac
brew install pinentry-mac
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```

### Step 11 — Node.js

```bash
fnm install --lts
fnm default lts-latest
corepack enable
```

### Step 12 — Time Machine excludes (optional)

Excludes all `node_modules` directories under `~/dev` from Time Machine:

```bash
sh time-machine-excludes.sh
```

For recurring execution, add a cronjob:

```bash
crontab -e
# Entry:
# 0 12 * * *  cd $HOME/dev/.dotfiles && ./time-machine-excludes.sh
```

---

## File overview

| File / Folder | Description |
|---|---|
| `.editorconfig` | EditorConfig with spaces, indent 2, UTF-8, LF |
| `.gitconfig` | Git config with aliases, colors, LFS, pull rebase |
| `.gitmessage` | Commit template (Angular Commit Format) |
| `.gitignore` | Global gitignore |
| `.profile` | Env variables (Homebrew, Android, Go, Rust, …) |
| `.vimrc` | Vim config with Vundle, Nord theme, Airline |
| `.zprofile` | Oh My Zsh setup, sources `.profile` |
| `.zshrc` | Zsh config: plugins, aliases, functions, fnm, SDKMAN |
| `.zshrc.local` | Machine-specific zsh overrides (gitignored) |
| `Brewfile` | Homebrew packages (brew, cask, vscode extensions) |
| `settings.json` | VS Code / Kiro user settings (public) |
| `settings.local.json` | VS Code / Kiro settings with sensitive/internal values (gitignored) |
| `extensions.sh` | Install VS Code / Kiro extensions |
| `osx.sh` | macOS system preferences |
| `setup-dotfiles.sh` | Main setup script |
| `setup-dotfiles.local.sh` | Machine-specific setup (gitignored) |
| `setup-go.sh` | Go environment setup |
| `time-machine-excludes.sh` | Exclude node_modules from Time Machine |
| `com.googlecode.iterm2.plist` | iTerm2 configuration |
| `java.md` | Java setup instructions (SDKMAN, Maven) |
| `local/` | Machine-specific config files (gitignored) |

---

## Local modifications

The following files/directories are in `.gitignore` and will not be committed:

- **`.zshrc.local`** — machine-specific zsh customizations, automatically sourced by `.zshrc`
- **`setup-dotfiles.local.sh`** — machine-specific setup steps, executed by `setup-dotfiles.sh`
- **`settings.local.json`** — VS Code / Kiro settings containing sensitive or internal values (e.g. internal PlantUML server URLs)
- **`local/`** — any other private config files

### `settings.local.json`

This file holds editor settings that should not be publicly committed (e.g. internal server URLs). On a new Mac, restore it from your secure backup or create it manually:

```bash
cat > ~/dev/.dotfiles/settings.local.json << 'EOF'
{
  "markdown-preview-enhanced.plantumlServer": "https://your-internal-server/plantuml/svg",
  "plantuml.server": "https://your-internal-server/plantuml/svg"
}
EOF
```

To apply these settings in VS Code / Kiro, merge them into your workspace settings or copy the values into the editor's settings UI.
