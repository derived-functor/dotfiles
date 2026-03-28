{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    events = [
      { event = "lock"; command = "hyprlock"; }

      { event = "unlock"; command = "${pkgs.libnotify}/bin/notify-send 'Unlocked!'"; }

      { event = "before-sleep"; command = "loginctl lock-session"; }

      { event = "after-resume"; command = "${pkgs.libnotify}/bin/notify-send 'Awake!'"; }
    ];

    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.libnotify}/bin/notify-send 'AFK'";
        resumeCommand = "${pkgs.libnotify}/bin/notify-send 'Oh, hi Mark'";
      }
    ];
  };
}
