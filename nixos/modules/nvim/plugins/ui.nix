{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;
        integrations = {
          cmp = true;
          treesitter = true;
          notify = true;
          mini.enabled = true;
          indent_blankline.enabled = true;
        };
      };
    };

    highlight = {
      NormalFloat.bg = "#434c5e";
      NormalFloat.fg = "#d8dee9";
      FloatBorder.bg = "#434c5e";
      FloatBorder.fg = "#d8dee9";
    };

    diagnostics.float.border = "single";
  };
  programs.nixvim.plugins = {
    dashboard = {
      enable = true;
      hideTabline = true;
      hideStatusline = true;
      theme = "doom";
      config = {
        header = [
          ""
          " _   _                 _           "
          "| \\ | |                _           "
          "|  \\| | ___  _____   ___ _ __ ___  "
          "| . ` |/ _ \\/ _ \\ \\ / / | '_ ` _ \\ "
          "| |\\  |  __/  _  \\ V /| | | | | | | "
          "\\_| \\_/\\___|\\___/ \\_/ |_|_| |_| |_|"
          ""
          "   ℝ[x] / (x² + 1) ≅ ℂ "
          ""
        ];
        center = [
          {
            icon = "  ";
            desc = "Recently opened files    ";
            action = "Telescope oldfiles";
            key = "s";
          }
          {
            icon = "󰭎  ";
            desc = "Find File    ";
            action = "Telescope find_files";
            key = "f";
          }
          {
            icon = "  ";
            desc = "File Browser    ";
            action = "Neotree toggle";
            key = "e";
          }
          {
            icon = "  ";
            desc = "Find word    ";
            action = "Telescope live_grep";
            key = "b";
          }
          {
            icon = "  ";
            desc = "Open Neogit";
            action = "Neogit";
            key = "N";
          }
        ];
        footer = [
          ""
          "Managed by NixOS — Declarative & Pure"
        ];
      };
    };


    mini = {
      enable = true;
      modules = {
        indentscope = {
          symbol = "│";
          options = {
            try_as_border = true;
          };
          draw = {
            delay = 100;
            animation.__raw = ''
              function(s, n)
                return 20 -- скорость анимации в мс
              end
            '';
          };
        };

        comment = { };
        git = { };
      };
    };
    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "auto";
          globalstatus = true;
          icons_enabled = true;
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" "diagnostics" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "encoding" "fileformat" "filetype" ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };
    neo-tree = {
      enable = true;
      sources = [ "filesystem" "buffers" "git_status" ];
      window = {
        width = 30;
        mappings = {
          "<leader>e" = "close_window";
        };
      };
      enableGitStatus = true;
    };

    neodev = {
      enable = true;
    };

    noice = {
      enable = true;
      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.set_editing_highlight" = true;
          "table.lsp.signature.enabled" = false; # Если мешает при вводе
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
        };
      };
    };
    notify = {
      enable = true;
      settings = {
        background_colour = "#000000";
        timeout = 3000;
      };
    };

    rainbow-delimiters = {
      enable = true;
    };
  };

  programs.nixvim.plugins.web-devicons.enable = true;
}
