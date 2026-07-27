{ pkgs, config, user, ... }:
{
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    jq
    lazygit
    neovim
    claude-code
    nerd-fonts.hack
  ];

  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/molda_dotfiles/home/.config/wezterm";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    '';
  };
}
