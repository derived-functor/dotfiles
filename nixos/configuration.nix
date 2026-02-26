{ config, lib, pkgs, unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "t420";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "ru_RU.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

	# services.displayManager.sddm = {
	# 	enable = true;
	# 	wayland.enable = true;
	#
	# 	theme = "sddm-astronaut-theme";
	#
	# 	extraPackages = with pkgs; [
	# 		kdePackages.qtmultimedia
	# 		kdePackages.qtsvg
	# 		kdePackages.qt5compat
	# 		kdePackages.qtvirtualkeyboard
	# 	];
	# };

	services.displayManager.ly.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
		alsa.enable = true;
		jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

	services.tlp.enable = true;

	programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mreblan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
		initialPassword = "changeme";
		shell = pkgs.fish;
  };

  programs.firefox.enable = true;
  programs.hyprland = {
		enable = true;
		package = unstable.hyprland;
	};

  environment.systemPackages = with pkgs; [
    vim
    wget
		curl
		git
		kitty
		sddm-astronaut
		kdePackages.qtmultimedia
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

  system.stateVersion = "25.11";
}

