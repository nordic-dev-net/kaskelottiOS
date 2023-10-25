# users/juliuskoskela/default.nix
{
  inputs,
  pkgs,
  system,
  ...
}: let
  shellAliases = import ./aliases.nix;
  sessionVariables = import ./environment.nix;
  extraPackages = import ./packages.nix pkgs;
  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;
in
  inputs.common.mkUser {
    inherit
      inputs
      pkgs
      system
      shellAliases
      sessionVariables
      extraPackages
      colorScheme
      ;

    name = "physeter";

    description = "KaskelottiOS common user Physeter";

    userImports = [
      (inputs.common.programs.zsh {inherit pkgs shellAliases;})
      (inputs.common.programs.alacritty {inherit colorScheme;})
    ];
  }
