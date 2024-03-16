{pkgs}:
let name = "cartograph";
in
pkgs.stdenv.mkDerivation {
		inherit name;
		version = "1.0.0";
		src = ./.;
		installPhase = ''
		mkdir -p $out/share/fonts/truetype/${name}
		cp -r files/*.ttf $out/share/fonts/truetype/${name}/.
		'';
}
