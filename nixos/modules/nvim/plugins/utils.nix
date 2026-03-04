{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      kitty-scrollback-nvim
      # toggleterm-nvim
      # typst-preview-nvim
    ];
    extraConfigLua = ''
            require("kitty-scrollback").setup()
            --require("toggleterm").setup({
      		--keys = {
      		--	{ "<leader>td", "<cmd>ToggleTerm size=17 dir=. direction=horizontal<cr>", desc = "Open a horizontal terminal at the Desktop directory" }
      		--},
            --})

            --require("typst-preview").setup({
              --  lazy = false, -- or ft = 'typst'
               --- version = '1.*',
                --opts = {}, -- lazy.nvim will implicitly calls `setup {}`
            --})
    '';
    userCommands = {
      KittyScrollbackGenerateKittens = {
        command = "lua require('kitty-scrollback').generate_kittens()";
      };
    };

    plugins = {
      leap.enable = true;
      neogit.enable = true;
      # toggleterm.enable = true;
      dap = {
        enable = true;
      };
      dap-ui.enable = true;
      dap-python.enable = true;
      typst-preview = {
        enable = true;
      };
      toggleterm = {
        enable = true;
        settings = {
          size = 17;
          direction = "horizontal";
          open_mapping = "[[<c-t>]]";
        };
      };
      img-clip = {
        enable = true;
        settings = {
          default = {
            dir_path = "assets";
            file_name = "%y-%m-%d-%h-%m-%s";
            relative_to_current_file = false;
            use_absolute_path = false;
          };
        };
      };
    };

    keymaps = [
      { mode = "n"; key = "<leader>e"; action = ":Neotree<CR>"; }
      { mode = [ "n" "x" "o" ]; key = "s"; action = "<Plug>(leap)"; }
      { mode = "n"; key = "S"; action = "<Plug>(leap-from-window)"; }
      { mode = "n"; key = "<leader>gg"; action = "<cmd>Neogit<CR>"; }
      { mode = "n"; key = "<leader>td"; action = "<cmd>ToggleTerm size=17 dir=. direction=horizontal<cr>"; }

      # DAP
      { mode = "n"; key = "<leader>Db"; action.__raw = "require('dap').toggle_breakpoint"; }
      { mode = "n"; key = "<leader>Dc"; action.__raw = "require('dap').continue"; }
      { mode = "n"; key = "<leader>Dr"; action.__raw = "function() require('dap').repl.open() end"; }
      { mode = "n"; key = "<leader>Ds"; action.__raw = "require('dap').step_over"; }
      { mode = "n"; key = "<leader>Di"; action.__raw = "require('dap').step_into"; }
      { mode = "n"; key = "<leader>Do"; action.__raw = "require('dap').step_out"; }

      # Python run
      {
        mode = "n";
        key = "<leader>pr";
        action.__raw = ''
          function()
            local file = vim.fn.expand("%")
            vim.cmd("TermExec cmd=\"python3 " .. file .. "\"")
          end
        '';
      }
    ];
  };
}
