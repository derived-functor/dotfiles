{ config, lib, pkgs, unstable, ... }:

let
    dotfiles = "${config.home.homeDirectory}/dotfiles";
    link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
    cssPath = "${dotfiles}/swaync/.config/swaync/style.css";
in
{
    imports = [
        ./modules/hyprland.nix
        ./modules/hypridle.nix
        ./modules/hyprlock.nix
        ./modules/kitty.nix
        ./modules/swaync.nix
        ./modules/waybar.nix
        ./modules/wofi.nix
        ./modules/wlogout.nix
        ./modules/nvim/default.nix
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

        neovim
        bat
        lsd

        pavucontrol
        playerctl
        wireplumber

        brightnessctl

        telegram-desktop
        obsidian

        nordic
        nordzy-icon-theme
        nordzy-cursor-theme

        gruvbox-dark-gtk
        gruvbox-plus-icons
        simp1e-cursors

        # catppuccin-gtk
        # catppuccin-papirus-folders
        # catppuccin-cursors
        ] ++ (with unstable; [
                hyprpaper
        ]);

    programs.zen-browser.enable = true;
    programs.zen-browser.suppressXdgMigrationWarning = true;

    dconf = {
        enable = true;
        settings = {
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                gtk-theme = "catppuccin-mocha-mauve-standard+default";
            };
        };
    };

    gtk = {
        enable = true;
        theme = {
            name = "catppuccin-mocha-mauve-standard+default";
            package = pkgs.catppuccin-gtk.override {
                accents = [ "mauve" ];
                variant = "mocha";
            };
        };
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.catppuccin-papirus-folders.override {
                accent = "mauve";
                flavor = "mocha";
            };
        };
        cursorTheme = {
            name = "catppuccin-mocha-mauve-cursors";
            package = pkgs.catppuccin-cursors.mochaMauve;
        };
        gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
        gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
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
        XDG_DATA_DIRS = "/run/current-system/sw/share:$HOME/.local/share:$XDG_DATA_DIRS";
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
        "hypr/colors.conf".source = ./modules/colors-hyprland.conf;
        "swaync/style.css".source = ./modules/style-swaync.css;
        "waybar/colors.css".source = ./modules/colors.css;
        "waybar/style.css".source = ./modules/style-waybar.css;
        "wlogout/colors.css".source = ./modules/colors.css;
        "wlogout/style.css".source = ./modules/style-wlogout.css;
        "wlogout/icons".source = ./modules/icons;
        "wofi/style.css".source = ./modules/style-wofi.css;
        "kitty/colors/.conf".source = ./modules/colors-kitty.conf;
    };

    home.file = {
        # ".config/nvim".source = link "nvim/.config/nvim";
        ".config/btop".source = link "btop/.config/btop";
        ".config/colors".source = link "colors/.config/colors";
        ".config/fastfetch".source = link "fastfetch/.config/fastfetch";
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
