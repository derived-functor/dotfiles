#!/usr/bin/env fish

set wallpaper_dir $HOME/wallpapers
set random_wallpaper (random choice $wallpaper_dir/*)

if test -f "$random_wallpaper"
    echo "[(date)] Setting wallpaper: $random_wallpaper"

    swww img "$random_wallpaper" --transition-type grow --transition-duration 2
else
    echo "[(date)] Error: No wallpaper found in $wallpaper_dir"
end
