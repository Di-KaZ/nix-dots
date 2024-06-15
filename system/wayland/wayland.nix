{ pkgs, ... }:
{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # services.pipewire = {
  #   enable = false;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

	#  xdg.portal = {
	#    enable = true;
	# wlr.enable = true;
	#    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	#    config.common = {
	#      default = "*";
	#    };
	#  };


  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  imports = [ ./wm/wayfire.nix ];
}
