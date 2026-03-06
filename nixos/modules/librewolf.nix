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
        "privacy.resistFingerprinting" = false;
        "ui.systemUsesDarkTheme" = 1;
        "layout.css.prefers-color-scheme.content-override" = 2;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.cache" = true;
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
      DisplayBookmarksToolbar = "always";
    };
  };
}
