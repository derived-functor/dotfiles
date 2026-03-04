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
    nwg-look
    glib
    gsettings-desktop-schemas
    gtk3
    gcc

    haskell.compiler.native-bignum.ghcHEAD

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

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 35;
  };

  programs.zen-browser.enable = true;
  programs.zen-browser.suppressXdgMigrationWarning = true;

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-mauve-standard+default";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Boyarov Danil";
        email = "boy4rov.da@gmail.com";
      };
      credential.helper = "store";
    };
    lfs.enable = true;
  };

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

  xdg.configFile = {
    "fish/additional_vars.fish".text = ''
      set -gx LATITUDE "55.75"
      set -gx LONGITUDE "37.62"
      set -gx headphones_mac "48:05:E2:F0:DD:58"
    '';
    "fastfetch/logo.png".source = ./modules/logo.png;
    "hypr/colors.conf".source = ./modules/colors-hyprland.conf;
    "swaync/style.css".source = ./modules/style-swaync.css;
    "swaync/colors.css".source = ./modules/colors.css;
    "waybar/colors.css".source = ./modules/colors.css;
    "waybar/style.css".source = ./modules/style-waybar.css;
    "wlogout/colors.css".source = ./modules/colors.css;
    "wlogout/style.css".source = ./modules/style-wlogout.css;
    "wlogout/icons".source = ./modules/icons;
    "wofi/style.css".source = ./modules/style-wofi.css;
    "kitty/colors/.conf".source = ./modules/colors-kitty.conf;
  };

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

  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = {
        body = "";
      };
    };

    plugins = [
      {
        name = "agnoster";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "e3b4d4eafc23516e35f162686f08a42edf844e40";
          sha256 = "cXOYvdn74H4rkMWSC7G6bT4wa9d3/3vRnKed2ixRnuA=";
        };
      }
    ];

    shellAliases = {
      nv = "nvim";
      py = "python";
      cat = "bat";
      c = "clearf";
      icat = "kitten icat";
      last_n = "ls -lAth | head -n";
      ll = "lsd -lA";
      ls = "lsd";
      cmatrix = "cmatrix -u 3 -C $CMATRIX_COLOR";
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos#x13";
    };
    interactiveShellInit = ''
      set -gx fish_greeting
      set -g theme_display_nix_shell no
      fastfetch
      source $HOME/.config/fish/additional_vars.fish
      source $HOME/.config/fish/conf.d/colors.fish
    '';
  };
}
