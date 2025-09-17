#!/bin/sh

CONFIG_DIR="$HOME/.config"

mkdir -p $CONFIG_DIR

rm -rf $HOME/.zshrc
rm -rf $CONFIG_DIR/nvim
rm -rf $CONFIG_DIR/wezterm
rm -rf $CONFIG_DIR/btop
rm -rf $CONFIG_DIR/hypr
rm -rf $CONFIG_DIR/fastfetch
rm -rf $CONFIG_DIR/fuzzel
rm -rf $CONFIG_DIR/waybar

ln -s $PWD/config/zshrc $HOME/.zshrc
ln -s $PWD/config/nvim $CONFIG_DIR/nvim
ln -s $PWD/config/wezterm $CONFIG_DIR/wezterm
ln -s $PWD/config/btop $CONFIG_DIR/btop
ln -s $PWD/config/hypr $CONFIG_DIR/hypr
ln -s $PWD/config/fastfetch $CONFIG_DIR/fastfetch
ln -s $PWD/config/fuzzel $CONFIG_DIR/fuzzel
ln -s $PWD/config/waybar $CONFIG_DIR/waybar
