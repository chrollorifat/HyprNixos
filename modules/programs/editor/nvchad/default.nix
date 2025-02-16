{
  config,
  pkgs,
  inputs,
  nvchad4nix,

  ...
}: {
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      emmet-language-server
      nixd
    ];
    extraConfig = inputs.nvchad-on-steroids;
    hm-activation = true;
    backup = false;
  };
}
