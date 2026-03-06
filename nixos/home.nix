{ config, lib, pkgs, unstable, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{

  imports = [
    inputs.nixvim.homeModules.nixvim
    ./modules/bootstrap.nix
  ];
  home.username = "mreblan";
  home.homeDirectory = "/home/mreblan";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    tree
    vim
    wget
    curl
    git
    gitflow
    pre-commit
    nwg-look
    glib
    gsettings-desktop-schemas
    gtk3
    gcc

    haskell.compiler.native-bignum.ghcHEAD

    blanket

    nil
    nixpkgs-fmt
    nodejs

    cmatrix

    xfce.thunar
    matugen

    lua5_1
    python314
    uv
    luarocks
    imagemagick
    gettext
    wl-clipboard-rs

    ripgrep
    fzf
    jq

    btop
    unzip
    zip
    lm_sensors

    fish
    oh-my-fish

    gh

    hyprlock
    hypridle
    hyprshot
    hyprsunset

    waybar
    wofi
    wlogout

    swaynotificationcenter
    libnotify
    quickshell
    fastfetch

    bat
    lsd

    pavucontrol
    playerctl
    wireplumber

    brightnessctl
    upower

    telegram-desktop
    obsidian
    spotify
    amnezia-vpn
    texliveMedium
    imagemagick
    typst

    # nordic
    # nordzy-icon-theme
    # nordzy-cursor-theme
    #
    # gruvbox-dark-gtk
    # gruvbox-plus-icons
    # simp1e-cursors

  ] ++ (with unstable; [
    hyprpaper
  ]);

  # programs.zen-browser.enable = true;
  # programs.zen-browser.suppressXdgMigrationWarning = true;

  home.sessionVariables = {
    GIT_EDITOR = "vim";

    HYPRSHOT_DIR = "$HOME/screenshots";
    QS_NO_RELOAD_POPUP = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ADW_DISABLE_PORTAL = "1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-desktop-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.file = {
    ".config/colors".source = link "colors/.config/colors";
    ".config/quickshell".source = link "quickshell/.config/quickshell";

    ".local/bin".source = link "scripts/.local/bin";
    "wallpapers".source = link "wallpapers/wallpapers";

    ".local/share/applications" = {
      source = link "desktop-apps/.local/share/applications";
      recursive = true;
    };
  };

  xdg.configFile = {
    "fish/additional_vars.fish".text = ''
      set -gx LATITUDE "55.75"
      set -gx LONGITUDE "37.62"
      set -gx headphones_mac "48:05:E2:F0:DD:58"
    '';
    "fastfetch/logo.png".source = ./modules/assets/logo.png;
    "hypr/colors.conf".source = ./modules/assets/colors-hyprland.conf;
    "swaync/style.css".source = ./modules/assets/style-swaync.css;
    "swaync/colors.css".source = ./modules/assets/colors.css;
    "waybar/colors.css".source = ./modules/assets/colors.css;
    "waybar/style.css".source = ./modules/assets/style-waybar.css;
    "wlogout/colors.css".source = ./modules/assets/colors.css;
    "wlogout/style.css".source = ./modules/assets/style-wlogout.css;
    "wlogout/icons".source = ./modules/assets/icons;
    "wofi/style.css".source = ./modules/assets/style-wofi.css;
    "kitty/colors/.conf".source = ./modules/assets/colors-kitty.conf;
  };
}
