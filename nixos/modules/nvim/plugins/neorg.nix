{ pkgs, ... }:

{

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    neorg-telescope
  ];

  programs.nixvim.plugins = {
    neorg-telescope.enable = true;
    telescope.enable = true;
    neorg = {
      enable = true;
      telescopeIntegration.enable = true;
      # -- Settings ---
      settings = {
        lazy_loading = false;
        load = {
          "core.concealer" = {
            config = {
              icon_preset = "diamond";
              conceal = true;
            };
          };
          "core.defaults" = {
            __empty = null;
          };
          "core.journal" = {
            config = {
              strategy = "flat";
            };
          };
          "core.completion" = {
            config = { engine = "nvim-cmp"; };
          };
          "core.dirman" = {
            config = {
              workspaces = {
                home = "~/notes/home";
                work = "~/notes/work";
              };
            };
          };
          "core.integrations.image" = { __empty = null; };
          "core.latex.renderer" = {
            config = {
              conceal = true;
              dpi = 350;
              debounce_ms = 200;
              min_length = 3;
            };
          };
          "core.integrations.telescope" = { __empty = null; };
        };
      };
      # --- ---
    };
    image = {
      enable = true;
      backend = "kitty";
    };
  };
}
