{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "70G";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/";
              };
            };
            swap = {
              size = "8G";
              type = "8200";
              content = {
                type = "swap";
              };
            };
            home = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/home";
              };
            };
          };
        };
      };
    };
  };
}
