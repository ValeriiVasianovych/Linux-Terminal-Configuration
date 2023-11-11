#!/bin/bash

# Function to handle errors
cleanup_and_exit() {
    echo "Error: $1" >&2
    echo "Cleaning up..."
    # Add commands to delete downloaded files or perform any other necessary cleanup
    rm -rf ~/source_config  # Example: Remove the downloaded files
    exit 1
}

# Function to reload configurations
reload_configurations() {
    echo "Reloading configurations..."
    source ~/.bashrc
    source ~/.zshrc
    tmux source-file /tmux/.tmux.conf
    tmux source-file /tmux/.tmux.conf.local
}

# Function to restart tmux
restart_tmux() {
    echo "Restarting Tmux..."
    tmux kill-server
    tmux
}

# Set up trap for script errors
trap 'cleanup_and_exit "Script execution failed"' ERR

# Check for administrator privileges
if [ "$(id -u)" != "0" ]; then
    cleanup_and_exit "This script must be run with administrator privileges."
fi

# Check for the presence of wget
if ! command -v wget &> /dev/null; then
    echo "wget is not installed. Installing..."
    apt update -y || cleanup_and_exit "Error updating packages."
    apt install -y wget || cleanup_and_exit "Error installing wget."
    echo "wget installed successfully."
fi

# Update
apt update -y || cleanup_and_exit "Error during update."
echo "Update successful."

# Install Zsh and Oh My Zsh
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Installing..."
    apt install -y zsh || cleanup_and_exit "Error installing Zsh."
    echo "Zsh installed successfully."

    # Install Oh My Zsh
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O install_oh_my_zsh.sh
    sh install_oh_my_zsh.sh || cleanup_and_exit "Error installing Oh My Zsh."
    echo "Oh My Zsh installed successfully."
else
    echo "Zsh is already installed."
fi

# Install Neovim
apt install -y neovim || cleanup_and_exit "Error installing Neovim."
echo "Neovim installed successfully."

# Install Tmux
apt install -y tmux || cleanup_and_exit "Error installing Tmux."
echo "Tmux installed successfully."

# Unzip the archive
unzip source_config.zip -d ~ || cleanup_and_exit "Error unpacking the archive."
echo "Unpacking completed successfully."

# Reload configurations
reload_configurations

# Restart tmux
restart_tmux

echo "All operations completed successfully."

