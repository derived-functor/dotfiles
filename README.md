# Dotfiles

Just dotfiles for my config

## Arch Linux packages

Install these to use the dotfiles (official repos unless marked AUR):

### Core: Hyprland & session
- `hyprland` – compositor
- `hyprlock` – lock screen
- `hyprshot` – screenshots (AUR: `hyprshot-git` or `hyprshot`)
- `hyprpaper` – wallpaper
- `hypridle` – idle/sleep/lock daemon

### Bar, launcher, notifications
- `waybar` – status bar
- `wofi` – app launcher / dmenu
- `wlogout` – logout screen (AUR: `wlogout`)
- `swaync` – notification daemon
- `libnotify` – `notify-send` (for hypridle, theme menu, etc.)
- **Quickshell** – QML bar (AUR: `quickshell` or `quickshell-git`); autostart runs `qs -p ~/.config/quickshell`

### Terminal & shell
- `kitty` – terminal (uses `kitten icat` in fish)
- `fish` – shell
- `fastfetch` – login/info (optional; config uses `--logo`; put a logo at `~/.config/fastfetch/logo.png` or adjust)

### Editor & CLI
- `neovim` – editor (plugins managed by lazy.nvim; Mason installs LSP/formatters)
- `ranger` – file manager (bound to Super+E in Hyprland)
- `bat` – `cat` replacement (aliased as `cat` in fish)
- `lsd` – `ls` replacement (aliased as `ls` / `ll` in fish)

### Audio & media
- `pipewire` + `wireplumber` – audio (keybinds use `wpctl`)
- `pavucontrol` – volume GUI (Waybar pulseaudio click)
- `playerctl` – media keys (play/pause/next/prev)

### Display & power
- `brightnessctl` – screen brightness (XF86MonBrightnessUp/Down)
- `wlsunset` – night light / redshift for Wayland (autostart with fixed lat/lon; adjust for your location)

### Applications (from keybinds / autostart)
- **Browser:** `zen-browser` (AUR; or set `$browser` in `hypr/config/program_binding.conf`)
- **Telegram:** `telegram-desktop` (bound to Super+T)
- **Obsidian:** `obsidian` (AUR; bound to Super+O)
- **Syncthing:** `syncthing` – autostart `syncthing serve --no-browser`

### Fonts
- **Kitty & Wofi:** `ttf-jetbrains-mono` or Nerd variant, e.g. `ttf-jetbrains-mono-nerd` (AUR) for “JetBrains Mono Nerd”
- **Cursors (env in hypr):** e.g. `nordzy-cursor-theme` (AUR) if you use Nordzy (see `hypr/config/env_vars.conf`)

### Optional / situational
- **NVIDIA GPU:** `nvidia` or `nvidia-utils` – Waybar `custom/gpu` script uses `nvidia-smi`
- **Python dev:** `python`, `uv` (or pip), `pytest` – fish alias `ttest`, nvim Python LSP/DAP/format (ruff via Mason)
- **Docker:** `docker`, Docker Desktop or compat – fish uses `DOCKER_HOST` for `docker compose` (`cmps`)
### Themes (colors/themes)

Theme scripts in `colors/themes/` set GTK/icon/cursor env and expect these packages:

| Theme | AUR packages | Official |
|-------|----------------|----------|
| **Nord** (`nord.sh`) | `nordic-theme` `nordzy-icon-theme` `nordzy-cursors` | — |
| **Gruvbox** (`gruvbox.sh`) | `gruvbox-dark-gtk` `gruvbox-plus-icon-theme` `simp1e-cursors` | — |
| **Catppuccin Mocha** (`catppuccin-mocha.sh`) | `catppuccin-gtk-theme-mocha` `catppuccin-papirus-folders-git` `catppuccin-cursors-git` | `papirus-icon-theme` |

Install only the theme(s) you use, or all three for the theme switcher menu.

### One-liner (official repos only, no AUR)

```bash
sudo pacman -S hyprland hyprlock hyprpaper hypridle waybar wofi swaync libnotify kitty fish fastfetch neovim ranger bat lsd pipewire wireplumber pavucontrol playerctl brightnessctl wlsunset syncthing telegram-desktop ttf-jetbrains-mono
```

AUR packages (e.g. with `yay`). Core + fonts + all three themes:

```bash
yay -S hyprshot wlogout quickshell zen-browser obsidian ttf-jetbrains-mono-nerd \
  nordic-theme nordzy-icon-theme nordzy-cursors \
  gruvbox-dark-gtk gruvbox-plus-icon-theme simp1e-cursors \
  catppuccin-gtk-theme-mocha catppuccin-papirus-folders-git catppuccin-cursors-git
```

For Catppuccin icons (Papirus) install from official repos:

```bash
sudo pacman -S papirus-icon-theme
```

To install only one theme, use the packages from the table above. Adjust `~/scripts/togglefloat.sh` and `~/scripts/random_wallpaper.sh` if you use those keybinds/autostart.

## AI Alert

I used vibe coding for some things I don't wanted to do by myself, so be careful with it.
