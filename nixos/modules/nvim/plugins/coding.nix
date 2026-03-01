{ pkgs, ... }:

{

  programs.nixvim = {

    extraConfigLua = ''
      require('pytest').setup({})
    '';
  };
  programs.nixvim.plugins = {
    autopairs.enable = true;
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
            custom_commentstring = ''
              function()
                return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
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

    lint = {
      enable = true;
      lintersByFt = {
        python = [ "mypy" "ruff" ];
        nix = [ "statix" ];
        haskell = [ "hlint" ];
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
      interpreter = "${pkgs.python3Packages.debugpy}/bin/python";
    };

    leap = {
      enable = true;
    };

    markdown-nvim = {
      enable = true;
      lazyLoad.settings.ft = "markdown";
      settings = {
        lists = {
          indent_size = 2;
        };
        navigation = {
          enabled = true;
        };
      };
    };

    render-markdown = {
      enable = true;
    };

    todo-comments = {
      enable = true;
      keymaps = {
        todoTelescope = {
          key = "<leader>ft";
          keywords = "TODO,FIXME";
        };
      };
    };
  };

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    vim-repeat
    pytest-nvim
  ];

  programs.nixvim.extraPackages = with pkgs; [
    ruff
    black
    nixpkgs-fmt
    statix
    hlint
    nodePackages.prettier
    python3Packages.debugpy
    python3Packages.pytest
  ];
}
