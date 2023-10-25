# common/programs/alacritty/default.nix
{colorScheme, ...}: {
  programs.alacritty = import ./config.nix colorScheme;
}
