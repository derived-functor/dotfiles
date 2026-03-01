{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        nil_ls.enable = true;
        lua_ls = { enable = true; settings.Lua.runtime.version = "LuaJIT"; };
        qmlls.enable = true;
        tinymist.enable = true;
        clangd.enable = true;
        pyright = {
          enable = true;
          settings.python.analysis.inlayHints = {
            variableTypes = true;
            functionReturnTypes = true;
            parameterNames = true;
          };
        };
        ruff = {
          enable = true;
          initOptions.settings = {
            configurationPreference = "filesystemFirst";
            inlayHints.enable = true;
            lint.enable = true;
          };
          extraOptions = { init_options.settings.capabilities.hoverProvider = false; };
        };
        hls = {
          enable = true;
          installLanguageServer = false;
          settings.haskell = { formattingProvider = "ormolu"; checkProject = true; };
        };
      };
      keymaps = {
        silent = true;
        lspBuf = {
          "K" = "hover"; "gd" = "definition"; "gD" = "declaration";
          "gi" = "implementation"; "go" = "type_definition";
          "gr" = "references"; "gs" = "signature_help";
          "<F2>" = "rename"; "<F4>" = "code_action";
        };
      };
      extra = [{
        mode = [ "n" "x" ];
        key = "<F3>";
        action = "<cmd>lua vim.lsp.buf.format({async = true})<cr>";
      }];
      postConfig = ''
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
      '';
    };

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
        mapping = {
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-Enter>" = "cmp.mapping.confirm({ select = true })";
          "<C-Space>" = "cmp.mapping.complete()";
        };
        snippet.expand = "function(args) vim.snippet.expand(args.body) end";
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
    cmp-buffer.enable = true;
  };
}
