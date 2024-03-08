{ pkgs, ... }:
{
  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.iconTheme.package = pkgs.papirus-icon-theme;
  gtk.iconTheme.name = "Papirus";

  # fix crash on pixdecor wayfire
  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    SWWW_TRANSITION_FPS = "60";
    SWWW_TRANSITION = "outer";
  };

}
