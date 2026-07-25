{ pkgs, config, ... }:
{
  home.username = "danie";
  home.homeDirectory = "/home/danie";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    jq
    lazygit
    neovim
    claude-code
    wezterm
  ];

  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file.".config/wezterm".source = 
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/molda_dotfiles/home/.config/wezterm";
}
