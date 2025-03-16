#!/bin/bash

set -e

sudo apt-get update

sudo apt-get install -y ripgrep

sudo apt-get install -y fd-find

rg --version && fdfind --version

echo "Installation complete!"
