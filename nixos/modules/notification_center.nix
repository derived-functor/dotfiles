{
  services.mako = {
    enable = true;

    settings = {
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#cba6f7";
      progress-color = "over #313244";

      border-radius = 0;
      border-size = 1;
      padding = "12,16";
      margin = "16";

      font = "JetBrainsMono Nerd Font 11";

      width = 350;
      height = 150;
      default-timeout = 5000;

      anchor = "bottom-right";
    };

    extraConfig = ''
      [urgency=critical]
      border-color=#f38ba8
      default-timeout=0
    '';
  };
}
