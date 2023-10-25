{
  # Keyboard layout
  fi = "hyprctl keyword input:kb_layout fi";
  en = "hyprctl keyword input:kb_layout us";

  # Firefox shortcuts

  reddit = "firefox -new-window https://reddit.com";
  youtube = "firefox -new-window https://youtube.com";
  protonmail = "firefox -new-window https://mail.protonmail.com";

  # Nix commands
  rebuild = "pushd /etc/nixos; sudo nixos-rebuild --flake '.#vega' switch; popd";

  # Git
  stage = "git add";
  commit = "git commit -s -S";
  push = "git push";

  # Editor
  edit = "$EDITOR";

  # Shortcuts
  repos = "cd ~/Repos";
  nixos = "cd ~/Repos/nixos";

  mail = "protonmail-bridge &";

  pdf = "zathura";
}
