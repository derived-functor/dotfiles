{
  services.mako = {
    enable = true;

    # Catppuccin Mocha
    backgroundColor = "#1e1e2e"; # base
    textColor = "#cdd6f4"; # text
    borderColor = "#cba6f7"; # mauve (accent)
    progressColor = "over #313244"; # surface0

    borderRadius = 8;
    borderSize = 1;
    padding = "12,16";
    margin = "16";

    font = "JetBrainsMono Nerd Font 11";

    width = 350;
    height = 150;
    defaultTimeout = 5000;

    ignoreTimeout = false;

    extraConfig = ''
      [urgency=critical]
      border-color=#f38ba8
      background-color=#1e1e2e
      default-timeout=0
    '';
  };
}
