# flake.nix
#
{
  description = "NixOS system configurations";

  inputs = {
    # Nixpkgs is a comprehensive collection of packages, package definitions,
    # and build infrastructure used by Nix and NixOS. It provides a wide range
    # of pre-built packages for various purposes, including system utilities,
    # programming languages, libraries, desktop environments, and applications.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home-manager is a powerful tool for managing user-specific configurations
    # using the Nix package manager. It allows users to declaratively define
    # and manage their shell configuration, environment variables, editor
    # settings, and more, providing a consistent and reproducible environment
    # across different systems.
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake-utils is a utility library specifically designed for working with
    # flakes in Nix. It offers a collection of functions and tools that assist
    # in the development and management of Nix flakes, simplifying tasks such
    # as building, testing, and deployment of flake-based projects.
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ flake-inputs: let
    inputs =
      flake-inputs
      // {
        stateVersion = "23.05";
        common = import ./common {inherit inputs;};
      };
  in {
    # The nixosConfigurations attribute in the flake.nix file defines
    # different NixOS system configurations that can be built using the
    # mkNixos function from the lib library.
    nixosConfigurations.kaskelotti = inputs.common.mkNixos [
        ./host
        ./user
      ] "x86_64-linux";

    formatter = inputs.common.forEachPkgs (pkgs: pkgs.alejandra);
  };
}
