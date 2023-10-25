# lib
#
# Reusable functions and variables for Nix expressions.
{inputs, ...}: let
  programs = {
    zsh = import ./zsh;
    alacritty = import ./alacritty;
  };
  # A function that generates attributes for each system architecture. It takes
  # a list of system architectures as input and returns a set of attributes
  # with each architecture as the attribute name.
  forEachSystem = inputs.nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];

  # A function that applies a given function to each system architecture and
  # its corresponding package set. It takes a function as input and applies it
  # to each system architecture's package set, returning the result as a set of
  # attributes.
  forEachPkgs = f: forEachSystem (sys: f (inputs.nixpkgs.legacyPackages.${sys}));

  # A function that creates a NixOS host system configuration. It takes a
  # module set as input and returns a NixOS system configuration with the
  # provided module set and additional special arguments.
  mkNixos = modules: system:
    inputs.nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = {inherit inputs system;};
    };

  # A function that creates a user configuration. It takes a list of packages,
  # a system architecture, a username, a description, a git configuration, a
  # list of extra packages, a list of session variables, a list of shell
  # aliases, a list of user imports, and a color scheme as input and returns a
  # NixOS user configuration.
  mkUser = {
    inputs,
    pkgs,
    system,
    name,
    description,
    extraPackages ? [],
    sessionVariables ? {},
    shellAliases ? {},
    userImports ? [],
    colorScheme ? inputs.nix-colors.colorSchemes.dracula,
    ...
  }: {
    users.users.${name} = {
      isNormalUser = true;
      description = "${description}";
      extraGroups = ["networkmanager" "wheel" "dialout"];
      shell = "${pkgs.zsh}/bin/zsh";
    };

    home-manager.users.${name} = {
      nixpkgs.config.allowUnfree = true;

      fonts.fontconfig.enable = true;

      home = {
        inherit sessionVariables;
        inherit (inputs) stateVersion;

        username = "${name}";
        homeDirectory = "/home/${name}";
        packages = extraPackages;
      };

      imports = userImports;

      gtk = {
        enable = true;
        theme = {
          name = "Materia-dark";
          package = pkgs.materia-theme;
        };
      };
    };
  };
in {
  inherit programs forEachSystem forEachPkgs mkNixos mkUser;
}
