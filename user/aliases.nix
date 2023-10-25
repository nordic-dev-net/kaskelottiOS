{
  # Nix commands
  kaskelotti-help = "pushd -q ~/kaskelottiOS; cat README.md; popd -q";
  kaskelotti-update = "pushd ~/kaskelottiOS; git fetch; git pull; sudo nixos-rebuild --flake '.#kaskelotti' switch; popd";

  # Editor
  edit = "$EDITOR";

  pdf = "zathura";
}
