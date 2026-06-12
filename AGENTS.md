# AGENTS.md

Rules and conventions for AI agents working in this repository.

## Language

- All documentation, comments, and commit messages must be in **English**.
- Commit messages follow the [Angular Commit Message Format](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#commit) (see `.gitmessage` for template and examples).

## Shell scripts

- Use `#!/bin/bash` as shebang.
- Use `set -e` for error handling.
- Quote all variable expansions: `"${HOME}"` not `${HOME}` or `$HOME` unquoted.
- Use `${HOME}` instead of `~` in scripts (tilde expansion is unreliable in non-interactive shells).
- Prefer `ln -sf` for symlinks (force-overwrite existing).
- Check for existence before creating directories or cloning repos (idempotent scripts).

## File organization

- Public dotfiles live at the repo root and are symlinked into `$HOME` by `setup-dotfiles.sh`.
- Machine-specific or sensitive files are gitignored:
  - `.zshrc.local` — shell overrides
  - `setup-dotfiles.local.sh` — local setup steps
  - `settings.local.json` — editor settings with internal/sensitive values
  - `local/` — private config files
- Never commit secrets, tokens, or internal URLs.

## Editor settings

- `settings.json` contains public VS Code / Kiro settings.
- `settings.local.json` contains sensitive settings (gitignored). Keep them separate.
- Do not merge `settings.local.json` values into `settings.json`.

## Homebrew

- `Brewfile` is the source of truth for installed packages.
- Use `brew bundle dump --force --file=Brewfile` to update it.
- Do not add packages via `brew install` without also adding them to the Brewfile.

## Git

- Pull with rebase (`pull.rebase = true`).
- Use Git LFS for large binary files (filter is configured in `.gitconfig`).
- Sign commits with GPG when a key is available.

## Node.js

- Use `fnm` (fast node manager) for Node version management. Do not use `nvm`.
- Corepack is enabled — respect `packageManager` fields in `package.json`.

## Line endings & formatting

- LF line endings (configured in `.editorconfig`).
- Indent with 2 spaces.
- UTF-8 encoding.
- Trim trailing whitespace.
