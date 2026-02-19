#!/bin/bash
# install.sh — called by VS Code devcontainer dotfiles support
#
# Sources custom dotfiles WITHOUT overwriting the container's .bashrc,
# which already has important setup (Homebrew, nvm, etc.)

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Append a source line to .bashrc so customizations load on every shell
if ! grep -q 'bashrc_custom' ~/.bashrc 2>/dev/null; then
  echo "" >> ~/.bashrc
  echo "# Personal dotfiles" >> ~/.bashrc
  echo "source $DOTFILES_DIR/.bashrc_custom" >> ~/.bashrc
fi

# Layer in git config if present
if [ -f "$DOTFILES_DIR/.gitconfig_custom" ]; then
  git config --global include.path "$DOTFILES_DIR/.gitconfig_custom"
fi

# Remind about env file if not set up
if [ ! -f ~/.env.global ]; then
  echo ""
  echo "╔═══════════════════════════════════════════════════╗"
  echo "║  No ~/.env.global found.                          ║"
  echo "║  Copy .env.global.example to ~/.env.global        ║"
  echo "║  and fill in your values, or bind-mount from host.║"
  echo "╚═══════════════════════════════════════════════════╝"
  echo ""
fi
