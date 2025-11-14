#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
DOTFILES_DIR="$SCRIPT_DIR"

ln -sf $DOTFILES_DIR/zshrc ~/.zshrc
ln -sf $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -sf $DOTFILES_DIR/config/starship.toml ~/.config/starship.toml

# Remove existing nvim directory
NVIM_DIR=~/.config/nvim
if [ -d $NVIM_DIR ]; then
    echo "Found existing nvim config."
    rm -rf $NVIM_DIR
    echo "Removed existing nvim config."
fi

# Remove existing rofi directory
ROFI_DIR=~/.config/rofi
if [ -d $ROFI_DIR ]; then
    echo "Found existing rofi config."
    rm -rf $ROFI_DIR
    echo "Removed existing rofi config."
fi

# WEZTERM_DIR=~/.config/wezterm/plugins
# if [ -d $WEZTERM_DIR ]; then
#     echo "Found existing WezTerm config."
#     rm -rf $WEZTERM_DIR
#     echo "Removed existing WezTerm config."
# else
#     mkdir -p $WEZTERM_DIR
# fi

# Create symlink for the nvim directory
ln -sf $DOTFILES_DIR/config/nvim $NVIM_DIR
ln -sf $DOTFILES_DIR/config/rofi $ROFI_DIR
# ln -sf $DOTFILES_DIR/config/wezterm/plugins $WEZTERM_DIR

echo "Dotfiles synced successfully."

# Install KMDot CLI
sudo ln -s ~/development/projects/kmdot-cli/kmdot-cli /usr/local/bin/kmdot
echo "KMDot CLI installed successfully."
