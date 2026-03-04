{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Boyarov Danil";
        email = "boy4rov.da@gmail.com";
      };
      credential.helper = "store";
    };
    lfs.enable = true;
  };
}
