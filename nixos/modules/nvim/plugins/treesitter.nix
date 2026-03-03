{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    nixvimInjections = true;
    settings = {
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = [ "latex" ];
      };
      indent.enable = true;
    };

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      pkgs.tree-sitter-grammars.tree-sitter-norg
      pkgs.tree-sitter-grammars.tree-sitter-norg-meta
      python
      latex
      nix
      bash
      lua
    ];

  };
}
