#!/bin/bash

if ! command -v clamscan &> /dev/null; then
    echo "ClamAV ist nicht installiert. Installiere ClamAV..."
    sudo pacman -S clamav --noconfirm
else
    echo "ClamAV ist bereits installiert."
fi

echo "Überprüfe ClamAV-Datenbank..."
freshclam_output=$(sudo freshclam 2>&1)
if echo "$freshclam_output" | grep -q "is up-to-date"; then
    echo "Datenbank ist bereits aktuell."
else
    echo "Datenbank wird aktualisiert..."
    sudo freshclam
fi

echo "Starte Vollscan des Dateisystems..."
sudo clamscan -r / --bell -i --exclude-dir="^/proc" --exclude-dir="^/sys" --exclude-dir="^/dev" --log=/home/$USER/clamscan_log.txt

echo "Scan abgeschlossen. Ergebnisse sind in /home/$USER/clamscan_log.txt gespeichert."