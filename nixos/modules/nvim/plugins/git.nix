{
  programs.nixvim.plugins = {
    neogit = {
      enable = true;
      settings = {
        integrations.diffview = true;
      };
    };
    diffview.enable = true;
  };
}
