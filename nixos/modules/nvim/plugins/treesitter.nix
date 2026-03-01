{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };

    grammarPackages = with pkgs.tree-sitter-grammars; [
      tree-sitter-python
      tree-sitter-c
      tree-sitter-vim
      tree-sitter-lua
      tree-sitter-vimdoc
      tree-sitter-yaml
      tree-sitter-json
      tree-sitter-toml
      tree-sitter-markdown
      tree-sitter-gitignore
      tree-sitter-dockerfile
      tree-sitter-nix
    ];
  };
}
