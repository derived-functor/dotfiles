hyprctl dispatch togglefloating
sleep 0.03

if [ "$(hyprctl activewindow -j | jq -r '.floating')" = "true" ]; then
    hyprctl dispatch resizeactive exact 1200 800
    hyprctl dispatch centerwindow
fi
