{ pkgs, ... }:
{
  home.username = "danie";
  home.homeDirectory = "/home/danie";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    jq
    lazygit
    neovim
  ];

  programs.zsh.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
