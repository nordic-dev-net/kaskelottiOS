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
in
  inputs.common.mkUser {
    inherit
      inputs
      pkgs
      system
      shellAliases
      sessionVariables
      extraPackages
      ;

    name = "physeter";

    description = "KaskelottiOS common user Physeter";
}
