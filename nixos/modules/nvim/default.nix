{
  imports = [
    ./options.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    version.enableNixpkgsReleaseCheck = false;
  };
}
