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
    package = inputs.niri.packages.${pkgs.system}.niri;

    settings = {

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

        "etps/2-elantech-trackpoint" = {
          accel-profile = "flat";
          accel-speed = -0.1;
        };
      };

      layout = {
        gaps = 4;
        struts = { left = 0; right = 0; top = 0; bottom = 0; };
        default-column-width = { proportion = 0.5; };
        focus-ring.enable = true;
        focus-ring.width = 3;
        focus-ring.active.color = "#8839ef";
        focus-ring.inactive.color = "#313244";
      };

      binds = with config.lib.niri.actions; {
        "Mod+Return".action = spawn terminal;
        "Mod+Q".action = close-window;
        "Mod+M".action = quit;
        "Mod+E".action = spawn "thunar";
        "Mod+B".action = spawn browser;
        "Mod+R".action = spawn menu;
        "Mod+T".action = spawn "telegram-desktop";
        "Mod+O".action = spawn "obsidian";

        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+J".action = focus-window-or-workspace-down;

        "Mod+Alt+H".action = move-column-left;
        "Mod+Alt+L".action = move-column-right;
        "Mod+Alt+K".action = move-window-up-or-to-workspace-up;
        "Mod+Alt+J".action = move-window-down-or-to-workspace-down;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;
        "Mod+Shift+5".action = move-column-to-workspace 5;

        "Print".action = spawn "grimblast" "--notify" "copysave" "area";
        "Mod+Print".action = spawn "grimblast" "--notify" "copysave" "active";

        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
        "XF86MonBrightnessUp".action = spawn "brightnessctl" "s" "10%+";
        "XF86MonBrightnessDown".action = spawn "brightnessctl" "s" "10%-";
      };

      spawn-at-startup = [
        { command = [ "swww-daemon" ]; }
        { command = [ "waybar" ]; }
        { command = [ "mako" ]; }
        { command = [ "wlsunset" "-l" "55.75" "-L" "37.61" ]; }
      ];
    };
  };
}
