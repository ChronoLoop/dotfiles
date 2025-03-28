#!/bin/bash

sudo apt-get install ninja-build gettext cmake curl build-essential
git clone https://github.com/neovim/neovim.git ~/.config/nvim/neovim

sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/

cd ~/.config/nvim/neovim
git checkout stable

make CMAKE_BUILD_TYPE=Release
sudo make install

rm -rf ~/.config/nvim/neovim
