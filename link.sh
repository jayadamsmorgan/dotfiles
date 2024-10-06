#!/bin/sh

# Use $HOME to get the user's home directory, which works on both Linux and macOS
USER_DIR=$HOME
CONFIG_DIR=$USER_DIR/.config

# Create symbolic links to the dotfiles
ln -s ./zshrc $USER_DIR/.zshrc

# Create the configuration directory if it doesn't exist
mkdir -p $CONFIG_DIR

# Link the nvim configuration
ln -s ./nvim $CONFIG_DIR/nvim

# Link the wezterm configuration
ln -s ./wezterm $CONFIG_DIR/wezterm

# Ensure the btop directory exists and link the btop configuration
mkdir -p $CONFIG_DIR/btop
ln ./btop/btop.conf $CONFIG_DIR/btop/btop.conf

