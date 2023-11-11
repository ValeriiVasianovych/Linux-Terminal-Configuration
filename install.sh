#!/bin/bash

# Check for administrator privileges
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run with administrator privileges." >&2
   exit 1
fi

# Check for the presence of wget
if ! command -v wget &> /dev/null; then
    echo "wget is not installed. Installing..."
    apt update -y
    apt install -y wget
    if [ $? -ne 0 ]; then
        echo "Error installing wget." >&2
        exit 1
    fi
    echo "wget installed successfully."
fi

# Update
apt update -y
if [ $? -eq 0 ]; then
   echo "Update successful."
else
   echo "Error during update." >&2
   exit 1
fi

# Install git
apt install -y git-all
if [ $? -eq 0 ]; then
   echo "Git installed successfully."
else
   echo "Error installing Git." >&2
   exit 1
fi

# Install Zsh and Oh My Zsh
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Installing..."
    apt install -y zsh
    if [ $? -ne 0 ]; then
        echo "Error installing Zsh." >&2
        exit 1
    fi
    echo "Zsh installed successfully."

    # Install Oh My Zsh
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O install_oh_my_zsh.sh
    sh install_oh_my_zsh.sh
    echo "Oh My Zsh installed successfully."
else
    echo "Zsh is already installed."
fi

# Install Neovim
apt install -y neovim
if [ $? -eq 0 ]; then
   echo "Neovim installed successfully."
else
   echo "Error installing Neovim." >&2
   exit 1
fi

# Install Tmux
apt install -y tmux
if [ $? -eq 0 ]; then
   echo "Tmux installed successfully."
else
   echo "Error installing Tmux." >&2
   exit 1
fi

# Unzip the archive
unzip source_config.zip -d ~
if [ $? -eq 0 ]; then
   echo "Unpacking completed successfully."
else
   echo "Error unpacking the archive." >&2
   exit 1
fi

rm -rf ~/.config/nvim/init.vim
cd ~ ; mv init.vim ~/.config/nvim/

echo "All operations completed successfully."
