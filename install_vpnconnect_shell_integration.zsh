#!/usr/bin/env bash

# Set the URL of the repository
REPO_URL="https://raw.githubusercontent.com/gmkey/tunnelblick_cli_macos"

# Set the directory to install the scripts
INSTALL_DIR="$HOME/vpnconnect"

# Check if Tunnelblick is installed
if [ ! -d "/Applications/Tunnelblick.app" ]; then
    echo "Tunnelblick is not installed. Please download and install it from https://tunnelblick.net/downloads.html"
    exit 1
fi

# Create the installation directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Download the scripts
curl -L "$REPO_URL/master/vpnconnect.sh" -o "$INSTALL_DIR/vpnconnect.sh"
curl -L "$REPO_URL/master/.vpnconnect_shell_integration.zsh" -o "$HOME/.vpnconnect_shell_integration.zsh"

# Set the permissions on the scripts
chmod +x "$INSTALL_DIR/vpnconnect.sh"

# Source the shell integration from .zshrc if it's not already there
if ! grep -q "if [ -f '${HOME}/.vpnconnect_shell_integration.zsh' ]; then . '${HOME}/.vpnconnect_shell_integration.zsh'; fi" "$HOME/.zshrc"; then
    echo "if [ -f '${HOME}/.vpnconnect_shell_integration.zsh' ]; then . '${HOME}/.vpnconnect_shell_integration.zsh'; fi" >>"$HOME/.zshrc"
fi

# Inform the user that the installation is complete
echo "Installation complete. Please restart your terminal, or run 'source ~/.zshrc'"
