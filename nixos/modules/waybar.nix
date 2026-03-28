{ pkgs, ... }:

let
  get-lang = pkgs.writeShellScript "get-niri-lang" ''
    ${pkgs.niri}/bin/niri msg --json keyboard-layouts | \
    ${pkgs.jq}/bin/jq -r '.names[.current_idx]' | \
    ${pkgs.gnused}/bin/sed 's/English (US)/EN/;s/Russian/RU/'
  '';
in
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
          "custom/appmenu"
          "custom/language"
          "tray"
        ];
        "modules-center" = [ "niri/workspaces" ];
        "modules-right" = [
          "pulseaudio"
          "cpu"
          "temperature"
          "custom/gpu"
          "memory"
          "network"
          "custom/exit"
        ];
        "tray" = {
          "icon-size" = 21;
          "spacing" = 10;
        };
        "niri/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "default" = "○";
            "active" = "●";
          };
        };
        "niri/window" = {
          "format" = "{}";
          "max-length" = 35;
          "separate-outputs" = true;
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
          "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
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
        "custom/appmenu" = {
          "format" = "  Apps";
          "on-click" = "wofi -show drun --style ~/.config/wofi/style.css";
          "tooltip" = false;
        };
        "custom/exit" = {
          "format" = "Exit";
          "on-click" = "wlogout -c 2 -b 2";
          "tooltip" = false;
        };
        "custom/gpu" = {
          exec = "~/.local/bin/gpu_mem.sh";
          interval = 5;
        };
        "custom/language" = {
          "exec" = "${get-lang}";
          "interval" = 1;
          "format" = "  {}";
          "on-click" = "${pkgs.niri}/bin/niri msg action switch-layout next";
          "tooltip" = false;
        };
      }
    ];
  };
}
