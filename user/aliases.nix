{
  # Keyboard layout
  fi = "hyprctl keyword input:kb_layout fi";
  us = "hyprctl keyword input:kb_layout us";
  no = "hyprctl keyword input:kb_layout no";

  # Nix commands
  kaskelotti-update = "pushd ~/kaskelottiOS; git fetch; git pull; sudo nixos-rebuild --flake '.#kaskelotti' switch; popd";

  # Editor
  edit = "$EDITOR";

  pdf = "zathura";
}
