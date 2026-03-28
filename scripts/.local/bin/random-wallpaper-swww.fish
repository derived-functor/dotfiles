#!/usr/bin/env fish

set wallpaper_dir $HOME/wallpapers

while not swww query > /dev/null 2>&1
    sleep 0.1
end

set random_wallpaper (random choice $wallpaper_dir/*)

if test -n "$random_wallpaper"
    echo "[(date)] Setting: $random_wallpaper"
    swww img "$random_wallpaper" --transition-type grow --transition-duration 1.5
else
    echo "[(date)] No wallpapers found"
end
