{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = { };
      background = [
        {
          monitor = "";
          blur_passes = 8;
          blur_size = 18;
          noise = 0.0117;
          contrast = 1.2;
          brightness = 1.0;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
          fade-in = {
            steps = 6;
            bezier = "easeOutQuint";
            time = 0.5;
          };
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "500, 50";
          outline_thickness = 2;
          dots_size = 0.3;
          dots_spacing = 0.4;
          dots_center = true;
          outer_color = "rgb(49, 50, 68)"; # Surface0
          inner_color = "rgb(69, 71, 90)"; # Surface1
          font_color = "rgb(205, 214, 244)"; # Text
          placeholder_text = ''<i><span foreground="##a6adc8">Enter password</span></i>'';
          rounding = 6;
          check_color = "rgb(166, 227, 161)";
          fail_color = "rgb(237, 135, 150)";
          fail_text = ''<i><span foreground="##f38ba8">Retard! ($ATTEMPTS)</span></i>'';
          capslock_color = "rgb(249, 226, 175)";
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%I:%M %p")"'';
          font_family = "JetBrains Mono";
          font_size = 50;
          color = "rgba(137, 220, 235, 1.0)";
          halign = "center";
          valign = "center";
          position = "0, 140";
        }
        {
          monitor = "";
          text = "----------"; # 10 дефисов
          font_family = "JetBrains Mono";
          font_size = 50;
          color = "rgba(137, 220, 235, 1.0)";
          halign = "center";
          valign = "center";
          position = "0, 110";
        }
        {
          monitor = "";
          text = "$USER";
          font_family = "JetBrains Mono";
          font_size = 50;
          color = "rgba(205, 214, 244, 1.0)";
          halign = "center";
          valign = "center";
          position = "0, 50";
        }
      ];
    };
  };
}
