# common/programs/alacritty/config.nix
colorScheme: {
  enable = true;
  settings = {
    font = {
      normal = {
        family = "JetBrains Mono Nerd Font";
        style = "Regular";
        size = 12;
      };
      bold = {
        family = "JetBrains Mono Nerd Font";
        style = "Bold";
        size = 12;
      };
    };
    # window = {
    #   padding = {
    #     x = 10;
    #     y = 10;
    #   };
    # };
    colors = {
      primary = {
        background = "#${colorScheme.colors.base00}";
        foreground = "#${colorScheme.colors.base05}";
      };
      normal = {
        black = "#${colorScheme.colors.base00}";
        red = "#${colorScheme.colors.base08}";
        green = "#${colorScheme.colors.base0B}";
        yellow = "#${colorScheme.colors.base0D}";
        blue = "#${colorScheme.colors.base0E}";
        magenta = "#${colorScheme.colors.base0C}";
        cyan = "#${colorScheme.colors.base0A}";
        white = "#${colorScheme.colors.base05}";
      };
    };
  };
}
