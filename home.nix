{ pkgs, ... }:
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
  ];

  programs.zsh.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
