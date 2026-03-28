{ pkgs, ... }:
let
  surface0 = "313244";
  surface1 = "45475a";
  text = "cdd6f4";
  sky = "89dceb";
  green = "a6e3a1";
  red = "f38ba8";
  yellow = "f9e2af";
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      effect-blur = "20x3";
      effect-vignette = "0.5:0.5";
      fade-in = 0.5;

      clock = true;
      timestr = "%I:%M %p";
      datestr = "----------";
      font = "JetBrains Mono";
      font-size = 50;

      indicator = true;
      indicator-radius = 120;
      indicator-thickness = 10;

      indicator-x-position = "center";
      indicator-y-position = "center";

      inside-color = "${surface1}aa";
      inside-ver-color = "${surface1}";
      inside-wrong-color = "${red}";
      inside-clear-color = "${surface1}";

      ring-color = "${surface0}";
      ring-ver-color = "${sky}";
      ring-wrong-color = "${red}";
      ring-clear-color = "${sky}";

      line-color = "00000000";
      separator-color = "00000000";

      text-color = "${text}";
      text-ver-color = "${text}";
      text-wrong-color = "${surface0}";
      text-clear-color = "${surface0}";

      key-hl-color = "${green}";
      caps-lock-bs-hl-color = "${yellow}";
      caps-lock-key-hl-color = "${yellow}";

      show-failed-attempts = true;
    };
  };
}
