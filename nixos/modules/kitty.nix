{ config, }:

{
    settings = {
        font_family = "JetBrains Mono Nerd";
        font_size = 15;
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
          "ctrl+shift+h" = "kitten ${config.home.homeDirectory}/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py";
          "ctrl+shift+g" = "kitten ${config.home.homeDirectory}/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py --config ksb_builtin_last_cmd_output";
        };

        extraConfig = ''
        # mousebindings
                    mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitten ${config.home.homeDirectory}/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py --config ksb_builtin_last_visited_cmd_output
        # BEGIN_KITTY_THEME
                    include colors.conf
        # END_KITTY_THEME
        '';
}
