{ pkgs, config, inputs, ... }:

let
  terminal = "kitty";
  menu = "wofi --show drun --style ~/.config/wofi/style.css";
  fileManager = "thunar";
  browser = "librewolf";
  telegram = "Telegram";
  notes = "obsidian";
in
{
  imports = [
    inputs.niri.homeModules.niri
  ];
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;

    settings = {
      prefer-no-csd = true;

      outputs."DP-1" = {
        scale = 1.0;
      };

      input = {
        keyboard.xkb = {
          layout = "us,ru";
          options = "grp:caps_toggle,grp_led:caps";
        };
        touchpad = {
          tap = true;
          natural-scroll = false;
        };
        mouse.accel-speed = 0.0;

        trackpoint = {
          accel-profile = "flat";
          accel-speed = -0.1;
        };
      };

      layout = {
        gaps = 10;
        struts = { left = 0; right = 0; top = 0; bottom = 0; };
        default-column-width = { proportion = 0.5; };
        focus-ring.enable = true;
        focus-ring.width = 3;
        focus-ring.active.color = "#6c7086";
        focus-ring.inactive.color = "#313244";
      };

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn terminal;
        "Mod+Q".action = close-window;
        "Mod+M".action = maximize-column;
        "Mod+E".action = spawn fileManager;
        "Mod+B".action = spawn browser;
        "Mod+R".action = spawn-sh menu;
        "Mod+T".action = spawn telegram;
        "Mod+O".action = spawn notes;

        "Mod+F".action = fullscreen-window;
        "Mod+Shift+F".action = toggle-windowed-fullscreen;

        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+J".action = focus-window-or-workspace-down;

        "Mod+Alt+H".action = move-column-left;
        "Mod+Alt+L".action = move-column-right;
        "Mod+Alt+K".action = move-window-up-or-to-workspace-up;
        "Mod+Alt+J".action = move-window-down-or-to-workspace-down;

        "Mod+Alt+Left".action = set-column-width "-5%";
        "Mod+Alt+Right".action = set-column-width "+5%";
        "Mod+Alt+Up".action = set-window-height "-5%";
        "Mod+Alt+Down".action = set-window-height "+5%";

        "Mod+Ctrl+1".action = switch-preset-column-width;
        "Mod+Ctrl+2".action = switch-preset-column-width-back;

        "Mod+Shift+L".action = spawn-sh "wlogout -c 2 -b 2";

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+Alt+1".action = move-window-to-workspace-down;
        "Mod+Alt+2".action = move-window-to-workspace-up;

        "Print".action = spawn-sh "grim -g \"$(slurp)\" - | tee \"$HOME/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png\" | wl-copy";
        "Mod+Print".action = spawn-sh "grim - | tee \"$HOME/screenshots/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\" | wl-copy";
        "Alt+Print".action = spawn-sh "grim -g \"$(slurp -w)\" - | tee \"$HOME/screenshots/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\" | wl-copy";

        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
        "XF86MonBrightnessUp".action = spawn "brightnessctl" "s" "10%+";
        "XF86MonBrightnessDown".action = spawn "brightnessctl" "s" "10%-";
      };

      window-rules = [
        {
          matches = [{ app-id = "kitty"; }];
          # open-maximized = true;
        }
      ];

      spawn-at-startup = [
        { command = [ "swww-daemon" ]; }
        { command = [ "waybar" ]; }
        { command = [ "mako" ]; }
        { command = [ "qs" "-p" "~/.config/quickshell" ]; }
        { command = [ "wlsunset" "-l" "55.75" "-L" "37.61" ]; }
      ];
    };
  };
}
