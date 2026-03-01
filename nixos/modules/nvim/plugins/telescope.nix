{ pkgs, ... }:
{
  programs.nixvim.plugins.telescope = {
    enable = true;

    settings = {
      defaults = {
        file_ignore_patterns = [
          "^__init__\\.py$"
          "^.git/"
          ".mypy-cache"
          ".*cache"
        ];
        hidden = false;
      };

      pickers = {
        find_files = {
          hidden = true;
          no_ignore = true;
        };
        live_grep = {
          additional_args = [ "--hidden" ];
        };
      };
    };
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
    };
  };
  programs.nixvim.extraPackages = with pkgs; [
    ripgrep
    fd
  ];
}
