{ pkgs, ... }:

{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;

        custom_highlights = ''
          function(colors)
            return {

              FloatBorder = { fg = colors.blue, bg = "none" },

              LineNr = { fg = colors.flamingo }, 
              CursorLineNr = { fg = colors.flamingo, style = { "bold" } },
            }
          end
        '';
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
      NormalFloat.bg = "none";
      FloatBorder.bg = "none";

      TelescopeNormal.bg = "none";
      TelescopeBorder.bg = "none";
      TelescopePromptNormal.bg = "none";
      TelescopePromptBorder.bg = "none";
      TelescopePromptTitle.bg = "none";
      TelescopeResultsNormal.bg = "none";
      TelescopeResultsBorder.bg = "none";
      TelescopeResultsTitle.bg = "none";
      TelescopePreviewNormal.bg = "none";
      TelescopePreviewBorder.bg = "none";
      TelescopePreviewTitle.bg = "none";
    };

    diagnostics.float.border = "single";

  };
  programs.nixvim.plugins = {
    dashboard = {
      enable = true;
      settings = {
        hideTabline = true;
        hideStatusline = true;
        theme = "doom";
        config = {
          vertical_center = true;
          header = [
            ""
            " _   _                 _           "
            "| \\ | |                _           "
            "|  \\| | ___  _____   ___ _ __ ___  "
            "| . ` |/ _ \\/ _ \\ \\ / / | '_ ` _ \\ "
            " | |\\  |  __/  _  \\ V /| | | | | | | "
            "\\_| \\_/\\___|\\___/ \\_/ |_|_| |_| |_|"
            ""
            "   ℝ[x] / (x² + 1) ≅ ℂ "
            ""
          ];
          center = [
            {
              action = "Telescope oldfiles";
              desc = "Recently opened files    ";
              icon = "  ";
              key = "s";
            }
            {
              action = "require('telescope.builtin').find_files({cwd = '~/dotfiles/nixos/modules/nvim'})";
              desc = "Config";
              icon = "  ";
              key = "c";
            }
            {
              action = "Telescope find_files";
              desc = "Find File    ";
              icon = "󰭎  ";
              key = "f";
            }
            {
              action = "Neotree toggle";
              desc = "File Browser    ";
              icon = "  ";
              key = "e";
            }
            {
              action = "Telescope live_grep";
              desc = "Find word    ";
              icon = "  ";
              key = "b";
            }
            {
              action = "Neogit";
              desc = "Open Neogit";
              icon = "  ";
              key = "N";
            }
          ];
          footer = [
            ""
            "Managed by NixOS — Declarative & Pure"
          ];
        };
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
            delay = 65;
            animation.__raw = ''
              function(s, n)
                return 12 -- скорость анимации в мс
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

    web-devicons = {
      enable = true;

      overrideByExtension = {
        norg = {
          icon = "󰎚";
          color = "#7aa2f7";
          name = "Neorg";
        };
      };
    };

    neo-tree = {
      enable = true;
      settings = {
        sources = [
          "filesystem"
          "buffers"
          "git_status"
        ];
        window = {
          width = 25;
          position = "right";
        };
        enable_git_status = true;
      };
    };

    noice = {
      enable = true;
      settings = {

        cmdline = {
          view = "cmdline_popup";
        };

        views = {
          cmdline_popup = {
            position = {
              row = "50%";
              col = "50%";
            };
            size = {
              width = 60;
              height = "auto";
            };
            border = {
              style = "single";
              padding = [ 0 1 ];
            };
            hover = {
              border = {
                style = "single";
              };
            };
            popup = {
              border = {
                style = "single";
              };
            };
            confirm = {
              border = {
                style = "single";
              };
            };
          };
        };
      };
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
      };
    };
    notify = {
      enable = true;
      settings = {
        background_colour = "#000000";
        timeout = 3000;
        top_down = true;
      };
    };

    rainbow-delimiters = {
      enable = true;
    };
  };

}
