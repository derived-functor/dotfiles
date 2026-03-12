{ pkgs, config, ... }:
let
  kitty-scrollback-python = "${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py";
in
{
  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";
      font_family = "JetBrains Mono Nerd";
      font_size = 17;
      disable_ligatures = "never";
      cursor_trail = 1;
      cursor_shape = "block";
      cursor_blink_interval = 0.5;
      window_padding_width = 10;
      tab_bar_edge = "bottom";
      tab_bar_style = "slant";
      background_opacity = 0.75;
    };
    keybindings = {
      "ctrl+shift+h" = "kitty_scrollback_nvim";
      "ctrl+shift+g" = "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
    };
    extraConfig = ''
      action_alias kitty_scrollback_nvim kitten ${kitty-scrollback-python}

      mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output

      # BEGIN_KITTY_THEME
      include colors.conf
      # END_KITTY_THEME
    '';
  };
}
