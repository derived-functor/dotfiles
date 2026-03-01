{ pkgs, ... }:

{

  programs.nixvim = {

    extraPlugins = with pkgs.vimPlugins; [
      markdown-nvim
      vim-repeat
      nvim-lint
    ];

    extraConfigLua = ''
      require('markdown').setup({
      })

      require("lint").linters_by_ft = {
            python = { "ruff" },
            nix = { "statix" },
            haskell = { "hlint" }
        }
    '';

    extraPackages = with pkgs; [
      ruff
      black
      nixpkgs-fmt
      statix
      hlint
      nodePackages.prettier
      python3Packages.debugpy
      python3Packages.pytest
      gcc
      gnumake
    ];
  };

  programs.nixvim.plugins = {
    nvim-autopairs.enable = true;
    comment.enable = true;
    nvim-bqf = {
      enable = true;
      settings = {
        auto_enable = true;
        preview = {
          win_height = 12;
          win_vheight = 12;
          delay_syntax = 80;
          border = "single";
        };
      };
    };
    mini = {
      enable = true;
      modules = {
        comment = {
          options = {
            custom_commentstring.__raw = ''
              function()
                  local ok, ts_context = pcall(require, "ts_context_commentstring.internal")
                  if ok then
                    return ts_context.calculate_commentstring() or vim.bo.commentstring
                  else
                    return vim.bo.commentstring
                  end
                end
            '';
          };
        };
        git = { };
      };
    };

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          python = [ "ruff_format" "black" ];
          nix = [ "nixpkgs_fmt" ];
          markdown = [ "prettier" ];
          "_" = [ "trim_whitespace" ];
        };

        format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
      };
    };

    dap = {
      enable = true;
    };

    dap-ui = {
      enable = true;
    };

    dap-virtual-text = {
      enable = true;
    };

    dap-python = {
      enable = true;
      adapterPythonPath = "${pkgs.python3Packages.debugpy}/bin/python";
    };

    leap = {
      enable = true;
    };

    render-markdown = {
      enable = true;
    };

    todo-comments = {
      enable = false;
      keymaps = {
        todoTelescope = {
          key = "<leader>ft";
          keywords = "TODO,FIXME";
        };
      };
    };
  };
}
