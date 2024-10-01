#!/bin/bash

read -p "Bitte geben Sie den Git-Link ein: " git_url

temp_dir=$(mktemp -d)
cd "$temp_dir" || exit

git clone "$git_url" || { echo "Fehler beim Klonen des Git-Repositorys"; exit 1; }

cd "$(basename "$git_url" .git)" || { echo "Fehler beim Navigieren in das geklonte Repository"; exit 1; }

makepkg --syncdeps --clean --noconfirm || { echo "Fehler beim Ausführen von makepkg"; exit 1; }

echo "Das Paket wurde erfolgreich gebuilded."

cd ..
rm -rf "$temp_dir"
