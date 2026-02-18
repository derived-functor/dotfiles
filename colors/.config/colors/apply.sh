#!/usr/bin/env bash
set -e

COLORS_DIR="$HOME/.config/colors"
THEME="${1:-$(basename "$(readlink "$COLORS_DIR/current")" .sh)}"
THEME_FILE="$COLORS_DIR/themes/$THEME.sh"

# ─── Check ────────────────────────────────────────────────────────────────

if [[ ! -f "$THEME_FILE" ]]; then
    echo "Theme '$THEME' not found"
    echo "  Available themes"
    for f in "$COLORS_DIR/themes/"*.sh; do
        echo "    - $(basename "$f" .sh)"
    done
    exit 1
fi

# ─── Load Envs ────────────────────────────────────────────────────────────────

ln -sf "$THEME_FILE" "$COLORS_DIR/current"
set -a; source "$THEME_FILE"; set +a

# ─── Fish ─────────────────────────────────────────────────────────────────────

envsubst < "$COLORS_DIR/templates/fish.tpl" \
    > "$HOME/.config/fish/conf.d/colors.fish"

# ─── Kitty ────────────────────────────────────────────────────────────────────

envsubst < "$COLORS_DIR/templates/kitty.tpl" \
    > "$HOME/.config/kitty/colors.conf"

pkill -USR1 kitty 2>/dev/null || true

# ─── Waybar ───────────────────────────────────────────────────────────────────

envsubst < "$COLORS_DIR/templates/colors.css.tpl" \
    > "$HOME/.config/waybar/colors.css"

pkill waybar 2>/dev/null; sleep 0.3
waybar & disown

# ─── SwayNC ──────────────────────────────────────────────────────────────────

if [[ -d "$HOME/.config/swaync" ]]; then
    envsubst < "$COLORS_DIR/templates/colors.css.tpl" \
        > "$HOME/.config/swaync/colors.css"
    pkill swaync 2>/dev/null || true
    sleep 0.5
    swaync & disown
fi

# ─── WLogout ─────────────────────────────────────────────────────────────────

envsubst < "$COLORS_DIR/templates/colors.css.tpl" \
    > "$HOME/.config/wlogout/colors.css"

# ─── Hyprland ─────────────────────────────────────────────────────────────────

strip() { echo "${1//#/}"; }

export COLOR_BG_RAW=$(strip "$COLOR_BG")
export COLOR_FG_RAW=$(strip "$COLOR_FG")
export COLOR_SURFACE_RAW=$(strip "$COLOR_SURFACE")
export COLOR_OVERLAY_RAW=$(strip "$COLOR_OVERLAY")
export COLOR_MUTED_RAW=$(strip "$COLOR_MUTED")
export COLOR_RED_BRIGHT_RAW=$(strip "$COLOR_RED_BRIGHT")
export COLOR_ORANGE_BRIGHT_RAW=$(strip "$COLOR_ORANGE_BRIGHT")
export COLOR_YELLOW_BRIGHT_RAW=$(strip "$COLOR_YELLOW_BRIGHT")
export COLOR_GREEN_BRIGHT_RAW=$(strip "$COLOR_GREEN_BRIGHT")
export COLOR_BLUE_BRIGHT_RAW=$(strip "$COLOR_BLUE_BRIGHT")
export COLOR_PURPLE_BRIGHT_RAW=$(strip "$COLOR_PURPLE_BRIGHT")
export COLOR_AQUA_BRIGHT_RAW=$(strip "$COLOR_AQUA_BRIGHT")
export COLOR_ACCENT_RAW=$(strip "$COLOR_ACCENT")
export COLOR_BORDER_RAW=$(strip "$COLOR_BORDER")

SUBST_VARS=$(env | grep '^COLOR_.*_RAW=' | sed 's/=.*//' | sed 's/^/\$/' | tr '\n' ' ')

envsubst "$SUBST_VARS" < "$COLORS_DIR/templates/hyprland.tpl" \
    > "$HOME/.config/hypr/colors.conf"
envsubst < "$COLORS_DIR/templates/hyprland_envs.tpl" \
    > "$HOME/.config/hypr/config/env_vars.conf" && hyprctl reload 2>/dev/null || true
hyprctl setcursor $CURSOR_THEME 35 2>/dev/null || true

# ─── Quickshell ───────────────────────────────────────────────────────────────
envsubst "$SUBST_VARS" < "$COLORS_DIR/templates/quickshell.qml.tpl" \
    > "$HOME/.config/quickshell/options/Colors.qml" && \
    qs ipc call Quickshell reload true 2>/dev/null || true

# ─── Fastfetch ────────────────────────────────────────────────────────────────

if [[ -d "$HOME/.config/fastfetch" ]]; then
    envsubst < "$COLORS_DIR/templates/fastfetch.jsonc.tpl" \
        > "$HOME/.config/fastfetch/config.jsonc"
fi

# ─── Wofi ─────────────────────────────────────────────────────────────────────

if [[ -d "$HOME/.config/wofi" ]]; then
    envsubst < "$COLORS_DIR/templates/wofi.css.tpl" \
        > "$HOME/.config/wofi/style.css"
fi

# ─── Walker ────────────────────────────────────────────────────────────────────

if [[ -d "$HOME/.config/walker" ]]; then
    WALKER_CONFIG="$HOME/.config/walker/config.toml"
    WALKER_THEMES_DIR="$HOME/.config/walker/themes/$THEME"

    mkdir -p "$WALKER_THEMES_DIR"

    if [[ -f "$COLORS_DIR/templates/walker-style.css.tpl" ]]; then
        envsubst < "$COLORS_DIR/templates/walker-style.css.tpl" \
            > "$WALKER_THEMES_DIR/style.css"
    fi

    # Copy default layout files if they don't exist yet
    if [[ -d "/etc/xdg/walker/themes/default" ]]; then
        for f in layout.xml item.xml item_archlinuxpkgs.xml item_calc.xml \
                 item_clipboard.xml item_dmenu.xml item_dnfpackages.xml \
                 item_files.xml item_providerlist.xml item_symbols.xml \
                 item_symbols_grid.xml item_todo.xml item_unicode.xml \
                 keybind.xml preview.xml; do
            if [[ ! -f "$WALKER_THEMES_DIR/$f" && -f "/etc/xdg/walker/themes/default/$f" ]]; then
                cp "/etc/xdg/walker/themes/default/$f" "$WALKER_THEMES_DIR/$f"
            fi
        done
    fi

    # Keep walker theme in sync with selected colors theme
    if [[ -f "$WALKER_CONFIG" ]]; then
        sed -i "s/^theme = \".*\"/theme = \"$THEME\"/" "$WALKER_CONFIG" || true
    fi
fi

# ─── GTK ──────────────────────────────────────────────────────────────────────

export GTK_THEME=$(strip $GTK_THEME)
export ICON_THEME=$(strip $ICON_THEME)
export CURSOR_THEME=$(strip $CURSOR_THEME)
export GTK_FONT=$(strip $GTK_FONT)

envsubst < $HOME/.config/colors/templates/gtk-3.0.ini.tpl \
    > $HOME/.config/gtk-3.0/settings.ini || true
envsubst < ~/.config/colors/templates/gtkrc-2.0.tpl \
    > $HOME/.gtkrc-2.0 || true

gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME" || true
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME" || true
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME" || true

# ─── btop ─────────────────────────────────────────────────────────────────────

envsubst < $COLORS_DIR/templates/btop.conf.tpl \
    > $HOME/.config/btop/btop.conf

# ─── Firefox (userChrome / userContent) ──────────────────────────────────────

FF_DIR="$HOME/.config/.mozilla/firefox"
if [[ -d "$FF_DIR" ]]; then
    for prof in "$FF_DIR"/*.default*; do
        [[ -d "$prof" ]] || continue
        mkdir -p "$prof/chrome"
        envsubst < "$COLORS_DIR/templates/firefox-userChrome.css.tpl" \
            > "$prof/chrome/userChrome.css"
        envsubst < "$COLORS_DIR/templates/firefox-userContent.css.tpl" \
            > "$prof/chrome/userContent.css"
    done
fi
