#!/bin/bash

# Bootstrap script to setup dotfiles and install dependencies

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install dependencies
echo "Installing dependencies..."
bash "$DOTFILES_DIR/install.sh"
echo ""

# Function to backup and create symlink
backup_and_link() {
    local source="$1"
    local target="$2"

    # If target exists and is not a symlink, back it up
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        cp "$target" "${target}_bck"
        echo "Backed up existing file: $target -> ${target}_bck"
    fi

    # Create the symlink
    ln -sf "$source" "$target"
    echo "Created symlink: $target -> $source"
}

# Create symlink for zsh config
echo "Bootstrapping: zsh"
backup_and_link "$DOTFILES_DIR/zsh/zshrc" ~/.zshrc

# Create symlink for vim config
echo "Bootstrapping: vim"
backup_and_link "$DOTFILES_DIR/vim/vimrc" ~/.vimrc

# Create symlink for Ghostty config
echo "Bootstrapping: ghostty"
GHOSTTY_CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
GHOSTTY_CONFIG="$GHOSTTY_CONFIG_DIR/config"
mkdir -p "$GHOSTTY_CONFIG_DIR"
backup_and_link "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_CONFIG"

echo ""
echo "Done."
