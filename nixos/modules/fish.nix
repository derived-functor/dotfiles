{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = {
        body = "";
      };
    };

    plugins = [
      {
        name = "bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "e3b4d4eafc23516e35f162686f08a42edf844e40";
          sha256 = "cXOYvdn74H4rkMWSC7G6bT4wa9d3/3vRnKed2ixRnuA=";
        };
      }
    ];

    shellAliases = {
      nv = "nvim";
      py = "python";
      cat = "bat";
      c = "clearf";
      icat = "kitten icat";
      last_n = "ls -lAth | head -n";
      ll = "lsd -lA";
      ls = "lsd";
      cmatrix = "cmatrix -u 3 -C $CMATRIX_COLOR";
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos#x13";
    };
    interactiveShellInit = ''
      set -gx fish_greeting
      set -g theme_display_nix_shell no
      fastfetch
      source $HOME/.config/fish/additional_vars.fish
      source $HOME/.config/fish/conf.d/colors.fish
    '';
  };
}
