{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        vimium
        darkreader
      ];
      settings = {
        "privacy.clearOnShutdown.cookies" = false;
        "network.cookie.lifetimePolicy" = 2;
      };
    };
    policies = {
      Cookies = {
        Allow = [
          "https://github.com"
          "https://youtube.com"
          "https://aistudio.google.com"
        ];
        Default = "session-only";
      };
    };
  };
}
