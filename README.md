# Dotfiles

NixOS configuration with Hyprland, managed via Home Manager.

![Desktop screenshot 1](img/img1.png)
![Desktop screenshot 2](img/img2.png)

## Structure

- `nixos/` — NixOS flake with all configs
  - `flake.nix` — main entry point
  - `home.nix` — Home Manager configuration
  - `modules/` — NixOS/Home Manager modules (hyprland, kitty, waybar, etc.)

## Usage

```bash
# Rebuild the system
sudo nixos-rebuild switch --flake ~/dotfiles/nixos#x13

# Rebuild home manager (if needed separately)
home-manager switch --flake ~/dotfiles/nixos#mreblan@x13
```

## Components

- **WM:** Hyprland with hyprlock, hypridle, hyprpaper, hyprshot
- **Bar:** Waybar
- **Launcher:** Wofi
- **Notifications:** SwayNC
- **Terminal:** Kitty
- **Shell:** Fish with bobthefish theme
- **Editor:** NixVim

## Theme

Catppuccin Mocha (configured in `home.nix`).
