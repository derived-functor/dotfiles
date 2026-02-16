set CONFIG_PATH $HOME/.config/hypr/hyprpaper.conf
set wallpapers $HOME/wallpapers/*
set i $(random 1 $(count $wallpapers))

set random_wallpaper $wallpapers[$i]

echo "Current wallpaper is $random_wallpaper"

set config_str "wallpaper {
    monitor = 
    path = $random_wallpaper
    fit_mode = cover
}
splash = false"

echo $config_str > $CONFIG_PATH
