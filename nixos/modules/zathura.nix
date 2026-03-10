{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;

    options = {
      selection-clipboard = "clipboard";
      scroll-step = 50;
      zoom-step = 10;

      # Catppuccin Mocha Palette
      default-bg = "#1e1e2e";
      default-fg = "#cdd6f4";

      statusbar-bg = "#313244";
      statusbar-fg = "#cdd6f4";
      inputbar-bg = "#1e1e2e";
      inputbar-fg = "#cdd6f4";
      completion-bg = "#313244";
      completion-fg = "#cdd6f4";
      completion-highlight-bg = "#585b70";
      completion-highlight-fg = "#cdd6f4";

      highlight-color = "#f9e2af";
      highlight-active-color = "#f5e0dc";

      recolor = "true";
      recolor-lightcolor = "#1e1e2e";
      recolor-darkcolor = "#cdd6f4";
    };
  };
}
