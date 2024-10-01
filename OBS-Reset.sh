#!/bin/bash

pkill obs
cd ~/.config/obs-studio || exit
cp -r . ../OBS_Backup/
rm -rf * && rm -rf ./basic/*
rm -rf ./cache/*
obs &
