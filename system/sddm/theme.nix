{pkgs}:
let
background = ./background.png;
config = ./conf-override.conf;
in
pkgs.stdenv.mkDerivation  {
		name = "sddm-theme";
		src = pkgs.fetchFromGitHub {
				owner = "aczw";
				repo = "sddm-theme-corners";
				rev = "6ff0ff455261badcae36cd7d151a34479f157a3c";
				sha256 = "0iiasrbl7ciyhq3z02la636as915zk9ph063ac7vm5iwny8vgwh8";
		};
		installPhase = ''
				mkdir -p $out/
				cp -R ./corners/* $out/
				cp ${background} $out/backgrounds/background.png
				cp ${config} $out/theme.conf
		'';
}
