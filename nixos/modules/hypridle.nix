{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        unlock_cmd = "notify-send 'Unlocked!'";
        before_sleep_cmd = "hyprlock";
        after_sleep_cmd = "notify-send 'Awake!'";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };
      listener = [
        {
          timeout = 180; # seconds
          on-timeout = "notify-send 'AFK' && hyprlock";
          on-resume = "notify-send 'Oh, hi Mark'";
        }
      ];
    };
  };
}
