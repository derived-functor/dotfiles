{
  programs.nixvim.plugins = {
    neorg = {
      enable = true;
      telescopeIntegration.enable = true;
      # -- Settings ---
      settings = {
        lazy_loading = true;
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
          "core.dirman" = {
            config = {
              workspaces = {
                home = "~/notes/home";
                work = "~/notes/work";
              };
            };
          };
          "core.integrations.image" = { };
          "core.latex.renderer" = {
            conceal = true;
            dpi = 350;
            debounce_ms = 200;
            min_length = 3;
          };
          "core.integrations.telescope" = { };
        };
      };
      # --- ---
    };
  };
}
