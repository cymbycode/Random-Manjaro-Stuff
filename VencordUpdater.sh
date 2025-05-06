#!/bin/bash
set -e

sudo pacman -Sy --noconfirm git nodejs npm wget curl

if ! command -v pnpm &> /dev/null; then
    sudo npm install -g pnpm
fi

cd ~

if [ -d "Vencord" ]; then
    cd Vencord
    git pull
else
    git clone https://github.com/Vendicated/Vencord.git
    cd Vencord
fi

pnpm install
pnpm build
pnpm inject

echo "Done."
