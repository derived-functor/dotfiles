CONFIG_PATH=$HOME/.config/hyprpaper.conf

path="${1:-$HOME/wallpapers/wallpaper6}"

cat > "$CONFIG_PATH" <<EOF
wallpaper {
    monitor =
    path = $path
    fit_mode = cover
}
splash = false
EOF

pkill hyprpaper 2>/dev/null && hyprpaper -c $HOME/.config/hyprpaper.conf & disown
