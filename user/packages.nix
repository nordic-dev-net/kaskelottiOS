pkgs:
with pkgs; [
  # Browser
  firefox

  # Editors
  vscode
  lapce

  # Productivity
  obsidian
  blender

  # !TODO: Figure configuration
  zathura

  # Communication
  zulip
  slack
  discord
  whatsapp-for-linux
  thunderbird
  protonmail-bridge
  neomutt

  # Langauges
  jdk19
  perl
  rustup

  # Tools
  gh
  curl
  wget
  hardinfo
  ripgrep
  fd
  blueman
  minicom
  usbutils
  nmap
  alsa-lib
  alsa-tools
  alsa-utils
  deploy-rs
  jq
  git

  # Testing
  gpsd

  # Entertainment
  steam
  spotify

  # Security
  gnupg
  keeweb
  sops

  # Development
  gcc
  gnumake

  # Audio
  bitwig-studio
  audacity

  # Photo
  gimp
  inkscape
  darktable

  # Finance
  hledger

  # Fonts
  (nerdfonts.override {
    fonts = [
      "FiraCode"
      "DroidSansMono"
      "JetBrainsMono"
    ];
  })

  # Texlive
  (texlive.combine {inherit (texlive) scheme-medium xifthen ifmtarg framed paralist titlesec;})
]
