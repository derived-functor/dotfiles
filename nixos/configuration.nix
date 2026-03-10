{ config, lib, pkgs, unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.kernelModules = [ "uinput" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  networking.hostName = "desktop";

  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 1701 9001 ];

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "ru_RU.UTF-8";

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "gameoflife";
      waylandsessions = "/run/current-system/sw/share/wayland-sessions";
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  services.xserver.videoDrivers = [ "nvidia" ];

  programs.fish.enable = true;
  programs.dconf.enable = true;

  users.groups.uinput = { };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mreblan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "uinput" ];
    initialPassword = "changeme";
    home = "/home/mreblan";
    shell = pkgs.fish;
  };

  programs.firefox.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = unstable.hyprland;
    xwayland.enable = true;
    portalPackage = unstable.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    kitty
    bluez
    home-manager
    ddcutil
    ddcui
    weylus
    gsettings-desktop-schemas
    gtk3
    cudatoolkit
  ];
  environment.pathsToLink = [
    "/share/wayland-sessions"
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 20d";
  };

  system.stateVersion = "25.11";
}

