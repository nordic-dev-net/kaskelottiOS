{
  # Nix commands
  kaskelotti-help = "pushd ~/kaskelottiOS > /dev/null; cat README.md; popd > /dev/null";
  kaskelotti-update = "pushd ~/kaskelottiOS; git fetch; git pull; sudo nixos-rebuild --flake '.#kaskelotti' switch; popd";

  # Editor
  edit = "$EDITOR";

  pdf = "zathura";
}
