{ pkgs, ... }:

{
  systemd.user.services.notes-sync = {
    Unit.Description = "Auto-sync Neorg notes with Git";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/mreblan/.local/bin/sync-notes.sh";
    };
  };

  systemd.user.timers.notes-sync = {
    Unit.Description = "Run notes sync every 5 minutes";
    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "5m";
      Unit = "notes-sync.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
