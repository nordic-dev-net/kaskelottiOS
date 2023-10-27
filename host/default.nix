# hosts/nova/default.nix
{
  inputs,
  pkgs,
  ...
}: let
  name = "kaskelotti";
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
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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
    tailscale.enable = true;
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

  time.timeZone = "Europe/Oslo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nb_NO.UTF-8";
      LC_IDENTIFICATION = "nb_NO.UTF-8";
      LC_MEASUREMENT = "nb_NO.UTF-8";
      LC_MONETARY = "nb_NO.UTF-8";
      LC_NAME = "nb_NO.UTF-8";
      LC_NUMERIC = "nb_NO.UTF-8";
      LC_PAPER = "nb_NO.UTF-8";
      LC_TELEPHONE = "nb_NO.UTF-8";
      LC_TIME = "nb_NO.UTF-8";
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
      tailscale
    ];
  };
}
