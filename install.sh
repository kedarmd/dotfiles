#!/bin/bash

DOTFILES_DIR=~/development/dotfiles

ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.wezterm.lua ~/.wezterm.lua
ln -sf $DOTFILES_DIR/.config/starship.toml ~/.config/starship.toml

# Remove existing nvim directory
NVIM_DIR=~/.config/nvim
if [ -d $NVIM_DIR ]; then
    echo "Found existing nvim config."
    rm -rf $NVIM_DIR
    echo "Removed existing nvim config."
fi

# Remove existing nvim directory
ALACRITTY_DIR=~/.config/alacritty
if [ -d $ALACRITTY_DIR ]; then
    echo "Found existing Alacritty config."
    rm -rf $ALACRITTY_DIR
    echo "Removed existing Alacritty config."
fi

# Create symlink for the nvim directory
ln -sf $DOTFILES_DIR/.config/nvim $NVIM_DIR
ln -sf $DOTFILES_DIR/.config/alacritty $ALACRITTY_DIR

echo "Dotfiles synced successfully."
