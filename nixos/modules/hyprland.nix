{ unstable, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = unstable.hyprland;
    xwayland.enable = true;
    portalPackage = unstable.xdg-desktop-portal-hyprland;
    settings = {
      monitor = ",prefered,auto,1";
      source = "~/.config/hypr/colors.conf";

      "$mainMod" = "SUPER";
      "$RESIZE" = 60;

      workspace = map
        (i:
          "${toString (i+1)}, monitor:DP-1"
        )
        (builtins.genList (i: i) 5);

      windowrule = [
        "match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen true, match:pin false, no_focus on"
        "match:class .*, suppress_event maximize"
        "match:class ^(librewolf)$, no_blur 1"
        "match:class ^(librewolf)$, opacity 1.0 1.0"
      ];

      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun --style ~/.config/wofi/style.css";
      "$browser" = "librewolf";
      "$telegram" = "Telegram";
      "$obsidian" = "obsidian";

      input = {
        kb_layout = "us,ru";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:caps_toggle, grp_led:caps";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      device = [
        {
          name = "etps/2-elantech-trackpoint";
          sensitivity = -0.1;
          accel_profile = "flat";
        }
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 3;
        "col.active_border" = "$accent $border 45deg";
        "col.inactive_border" = "$bg2";
        resize_on_border = false;
        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 0;
        rounding_power = 2;
        active_opacity = 1.00;
        inactive_opacity = 0.85;

        blur = {
          enabled = true;
          size = 6;
          passes = 1;
          new_optimizations = true;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba($shadowAlphaee)";
        };
      };

      "$speed" = 5.5;

      animations = {
        enabled = "yes, please :)";
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          # name, on/off, speed, curve, [style]
          "windows, 1, 3, fluent_decel, popin 60%"
          "windowsIn, 1, 3, fluent_decel, popin 60%"
          "windowsOut, 1, 3, fluent_decel, popin 60%"
          "border, 1, 5, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3.5, fluent_decel, slide"
          "specialWorkspace, 1, 3, fluent_decel, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, B, exec, $browser"
        "$mainMod, R, exec, $menu"
        "$mainMod Shift, L, exec, wlogout -b 2 -c 2"
        "$mainMod, T, exec, $telegram"
        "$mainMod, O, exec, $obsidian"
        "$mainMod, C, exec, calculator.sh"
        "$mainMod, W, exec, wallpaper_selector.sh"
        "$mainMod Shift, S, movetoworkspacesilent, special"
        "$mainMod, S, togglespecialworkspace"
        # ", PRINT, exec, hyprshot -m region"
        ", PRINT, exec, grimblast --notify copysave area"
        "Shift, PRINT, exec, grimblast --notify copysave screen"
        "$mainMod, PRINT, exec, grimblast --notify copysave active"

        "Shift, PRINT, exec, hyprshot -m output -m eDP-1"
        "$mainMod, l, movefocus, r"
        "$mainMod, h, movefocus, l"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, F, focuswindow, floating"
        "$mainMod Alt, h, movewindow, l"
        "$mainMod Alt, l, movewindow, r"
        "$mainMod Alt, k, movewindow, u"
        "$mainMod Alt, j, movewindow, d"
        "$mainMod, TAB, workspace, previous"
        "$mainMod Ctrl, left, workspace, -1"
        "$mainMod Ctrl, right, workspace, +1"
        "$mainMod, SPACE, exec, ~/.local/bin/togglefloat.sh"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod Shift, 1, movetoworkspace, 1"
        "$mainMod Shift, 2, movetoworkspace, 2"
        "$mainMod Shift, 3, movetoworkspace, 3"
        "$mainMod Shift, 4, movetoworkspace, 4"
        "$mainMod Shift, 5, movetoworkspace, 5"
        "$mainMod Shift, 6, movetoworkspace, 6"
        "$mainMod Shift, 7, movetoworkspace, 7"
        "$mainMod Shift, 8, movetoworkspace, 8"
        "$mainMod Shift, 9, movetoworkspace, 9"
        "$mainMod Shift, 0, movetoworkspace, 10"
        "$mainMod Shift, right, resizeactive, $RESIZE 0"
        "$mainMod Shift, left, resizeactive, -$RESIZE 0"
        "$mainMod Shift, up, resizeactive, 0 -$RESIZE"
        "$mainMod Shift, down, resizeactive, 0 $RESIZE"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      env = [
        "XCURSOR_SIZE,35"
        "XCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "HYPRCURSOR_SIZE,35"
        "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "GRIMBLAST_SCREENSHOT_DIRECTORY,$HOME/screenshots"
      ];

      exec-once = [
        "swww-daemon"
        "sleep 0.5 && fish ~/.local/bin/random_wallpaper-swww.fish >> ~/.swww.log"
        # "fish ~/.local/bin/random_wallpaper.fish >> ~/.hyprpaper.log"
        "wlsunset -l 55.75 -L 37.61"
        # "hyprpaper -c ~/.config/hyprpaper.conf"
        "mako"
        "waybar"
        "hypridle"
        "qs -p ~/.config/quickshell"
        "hyprctl setcursor catppuccin-mocha-mauve-cursors 35"
      ];
    };
  };
}
