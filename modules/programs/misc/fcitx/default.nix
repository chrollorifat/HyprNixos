{pkgs, ...}:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-lua
      fcitx5-gtk
      catppuccin-fcitx5
      fcitx5-m17n 
      # kdePackages.fcitx5-configtool
      # fcitx5-skk
      # fcitx5-tokyonight
      # fcitx5-mellow-themes
      # kdePackages.fcitx5-qt
    ];
    fcitx5.waylandFrontend = true;
  };
}
