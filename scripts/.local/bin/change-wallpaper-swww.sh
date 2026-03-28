#!/bin/bash

path="${1:-$HOME/wallpapers/wallpaper6.jpg}"

if [ -f "$path" ]; then
    swww img "$path" --transition-type wipe --transition-angle 30 --transition-step 90
else
    echo "Error: path $path not found"
fi
