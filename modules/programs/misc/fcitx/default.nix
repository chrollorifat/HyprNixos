{pkgs, ...}:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-skk
      fcitx5-lua
      fcitx5-gtk
      fcitx5-tokyonight
      catppuccin-fcitx5
      fcitx5-mellow-themes
      kdePackages.fcitx5-qt
      kdePackages.fcitx5-configtool
      fcitx5-m17n 
    ];
  };
}
