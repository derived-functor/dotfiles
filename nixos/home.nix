{ config, pkgs, unstable, ... }:

let
    dotfiles = "${config.home.homeDirectory}/dotfiles";
    link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
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

    wayland.windowManager.hyprland = {
        enable = true;
        settings = import ./modules/hyprland.nix;
    };

    programs.zen-browser.enable = true;

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
    };

    home.file = {
        # ".config/hypr".source = link "hypr/.config/hypr";
        ".config/nvim".source = link "nvim/.config/nvim";
        ".config/btop".source = link "btop/.config/btop";
        ".config/colors".source = link "colors/.config/colors";
        ".config/fastfetch".source = link "fastfetch/.config/fastfetch";
        # ".config/gtk-3.0".source = link "gtk-3.0/.config/gtk-3.0";
        ".config/kitty".source = link "kitty/.config/kitty";
        ".config/quickshell".source = link "quickshell/.config/quickshell";
        ".config/swaync".source = link "swaync/.config/swaync";
        ".config/waybar".source = link "waybar/.config/waybar";
        ".config/wlogout".source = link "wlogout/.config/wlogout";
        ".config/wofi".source = link "wofi/.config/wofi";

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
            set -g theme_display_nix_shell no
            fastfetch
            source $HOME/.config/fish/additional_vars.fish
            source $HOME/.config/fish/conf.d/colors.fish
            '';
        shellInit = ''
            set -g fish_greeting ""
            '';
    };
}
