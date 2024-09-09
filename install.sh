#!/bin/bash

DOTFILES_DIR=~/work/dotfiles

ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/.wezterm.lua ~/.wezterm.lua
ln -sf $DOTFILES_DIR/.config/starship.toml ~/.config/starship.toml
ln -sf $DOTFILES_DIR/.config/nvim ~/.config/nvim

echo "Dotfiles synced successfully."
