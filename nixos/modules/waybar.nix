{
  programs.waybar = {
    enable = true;
    settings = [
      {
        "position" = "top";
        "margin-top" = 0;
        "margin-left" = 8;
        "margin-right" = 8;
        "height" = 38;
        "modules-left" = [
          "clock"
          "hyprland/language"
          "custom/theme"
          "custom/appmenu"
        ];
        "modules-center" = [
          "hyprland/workspaces"
        ];
        "modules-right" = [
          "tray"
          "pulseaudio"
          "battery"
          "cpu"
          "temperature"
          "memory"
          "network"
          "custom/exit"
        ];
        "tray" = {
          "icon-size" = 21;
          "spacing" = 10;
        };
        "hyprland/window" = {
          "format" = "{}";
          "max-length" = 35;
          "rewrite" = {
            "" = "Hyprland";
          };
          "separate-outputs" = true;
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "format-icons" = {
            "active" = " ";
          };
          "sort-by-number" = true;
          "persistent-workspaces" = {
            "*" = 5;  # 5 workspaces by default on every monitor
          };
        };
        "clock" = {
          "format" = "{:%d.%m.%Y | %I:%M %p}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
          "interval" = 60;
          "timezone" = "Europe/Moscow";
        };
        "cpu" = {
          "format" = "  {usage}% | ";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "  {}% | ";
        };
        "temperature" = {
          "critical-threshold" = 80;
          "hwmon-path" = "/sys/class/hwmon/hwmon5/temp1_input";
          "format" = "{icon}  {temperatureC}°C | ";
          "format-icons" = [ "" "" "" ];
        };
        "network" = {
          "format-wifi" = "  {signalStrength}% | ";
          "format-ethernet" = " 󰈀 {cidr} | ";
          "format-linked" = "{ifname} (No IP) 󰖪 | ";
          "format-disconnected" = " ⚠ | ";
          "format-alt" = "{ifname}: {ipaddr}/{cidr} | ";
        };
        "pulseaudio" = {
          "format" = " | {icon}  {volume}% | ";
          "format-bluetooth" = " | {volume}% {icon}   {format_source} | ";
          "format-bluetooth-muted" = " | {icon}   {format_source} | ";
          "format-muted" = " |   | ";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = "";
          };
          "on-click" = "pavucontrol";
        };
        "battery" = {
          "bat" = "BAT0";
          "interval" = 60;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "events" = {
            "on-discharging-warning" = "notify-send -u normal 'Low Battery'";
            "on-discharging-critical" = "notify-send -u critical 'Very Low Battery'";
            "on-charging-100" = "notify-send -u normal 'Battery Full!'";
          };
          "format" = "{icon}  {capacity}% | ";
          "format-icons" = [ "" "" "" "" "" ];
          "max-length" = 25;
        };
        "custom/theme" = {
          "format" = "";
          "on-click" = "~/.config/colors/menu_theme.sh";
          "tooltip" = false;
        };
        "custom/appmenu" = {
          "format" = "  Apps";
          "on-click" = "wofi -show drun --style ~/.config/wofi/style.css";
          "tooltip" = false;
        };
        "custom/exit" = {
          "format" = "Exit";
          "on-click" = "wlogout -c 2 -b 2";
          "tooltip" = false;
        };
      }
    ];
  };
}
