{ pkgs, ... }:
{
  programs.nixvim = {
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      tabstop = 4;
      shiftwidth = 4;
      clipboard = "unnamedplus";
      winborder = "single";
      signcolumn = "yes";
    };

    keymaps = [
      { mode = "n"; key = "<leader>w"; action = ":w<CR>"; options.silent = true; }
      { mode = "n"; key = "<leader>q"; action = ":q<CR>"; options.silent = true; }
      { mode = "n"; key = "<leader>wq"; action = ":wq<CR>"; options.silent = true; }
      { mode = "n"; key = "<leader>bd"; action = ":bd<CR>"; options.silent = true; }
      {
        mode = "n";
        key = "<leader>d";
        action.__raw = "function() vim.diagnostic.open_float(nil, {focus = false}) end";
        options.desc = "Show diagnostic";
      }
    ];

    userCommands = {
      JsonFormat = {
        command = "%!python -m json.tool --no-ensure-ascii";
        desc = "Format JSON using python";
      };
      PythonFormat = {
        command.__raw = "function() require('conform').format({ bufnr = vim.api.nvim_get_current_buf() }) end";
      };
    };

    autoCmd = [
      # {
      #   event = [ "FileType" ];
      #   pattern = [ "python" ];
      #   callback.__raw = "function() vim.treesitter.start() end";
      # }
      {
        event = [ "BufWritePost" ];
        callback.__raw = "function() require('lint').try_lint() end";
      }
    ];
  };
}
