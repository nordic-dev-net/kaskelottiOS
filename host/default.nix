# hosts/nova/default.nix
{
  inputs,
  pkgs,
  ...
}: let
  name = "luna";
in {
  imports = [
    ./hardware-configuration.nix
    (import "${inputs.home-manager}/nixos")
  ];

  system.stateVersion = inputs.stateVersion;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    opengl.enable = true;
    opengl.driSupport32Bit = true; # Required for Steam
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager = {
        gnome.enable = true;
      };
    };
  };

  services = {
    blueman.enable = true;
    openssh.enable = true;
  };

  networking = {
    hostName = name;
    networkmanager.enable = true;
    firewall.extraCommands = ''
      iptables -A FORWARD -i enp5s0 -o wlp3s0 -j ACCEPT
      iptables -A FORWARD -i wlp3s0 -o enp5s0 -m state --state ESTABLISHED,RELATED -j ACCEPT
      iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE
    '';
  };

  time.timeZone = "Europe/Helsinki";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fi_FI.UTF-8";
      LC_IDENTIFICATION = "fi_FI.UTF-8";
      LC_MEASUREMENT = "fi_FI.UTF-8";
      LC_MONETARY = "fi_FI.UTF-8";
      LC_NAME = "fi_FI.UTF-8";
      LC_NUMERIC = "fi_FI.UTF-8";
      LC_PAPER = "fi_FI.UTF-8";
      LC_TELEPHONE = "fi_FI.UTF-8";
      LC_TIME = "fi_FI.UTF-8";
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.dconf.enable = true;
  sound.enable = true;
  security.rtkit.enable = true;
  environment = {
    systemPackages = with pkgs; [
      perl
      python3
      nodejs
      wget
      curl
      pkg-config
      openssl
      helix
      efibootmgr
      nixpkgs-fmt
      ripgrep
      pulsemixer
    ];
  };
}
