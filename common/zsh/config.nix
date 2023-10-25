# common/programs/zsh/config.nix
{
  pkgs,
  shellAliases,
  theme ? "robbyrussell",
}: {
  enable = true;
  shellAliases = shellAliases;

  oh-my-zsh = {
    enable = true;
    plugins = ["git"];
    theme = theme;
  };

  enableCompletion = true;

  plugins = [
    {
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.5.0";
        sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      };
    }
  ];
}
