#!/bin/bash

# Function to update Neovim theme
set_nvim_theme() {
    local theme="$1"
    nvim --headless -c "lua vim.cmd('colorscheme $theme')" -c "qa"
    echo "Neovim themes changed to $THEME."
}

# Function to update Starship configuration
set_starship_theme() {
    local theme="$1"
    local starship_local_config_dir="$HOME/development/dotfiles/themes/starship"
    local starship_config_dir="$HOME/.config/"
    local starship_theme_file="$starship_local_config_dir/${theme}.toml"

    if [[ -f "$starship_theme_file" ]]; then
        ln -sf "$starship_theme_file" "$starship_config_dir/starship.toml"
        pkill -USR1 starship  # Refresh Starship configuration
        echo "Starship theme set to $theme."
    else
        echo "Theme file $starship_theme_file does not exist."
    fi
}

# Check if theme argument is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <theme>"
    exit 1
fi

# Set both themes
THEME="$1"
set_nvim_theme "$THEME"
set_starship_theme "$THEME"

echo "Neovim and Starship themes changed to $THEME."
