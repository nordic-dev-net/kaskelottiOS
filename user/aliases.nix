{
  # Nix commands
  kaskelotti-help = "pushd ~/kaskelottiOS; cat README.md; popd";
  kaskelotti-update = "pushd ~/kaskelottiOS; git fetch; git pull; sudo nixos-rebuild --flake '.#kaskelotti' switch; popd";

  # Editor
  edit = "$EDITOR";

  pdf = "zathura";
}
