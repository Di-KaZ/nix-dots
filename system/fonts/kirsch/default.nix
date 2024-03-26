{pkgs}:
let 
name = "kirsch";
version = "0.0.0";
in
pkgs.stdenv.mkDerivation {
		inherit name version;
		src = pkgs.fetchzip {
				url = "https://github.com/molarmanful/kirsch/releases/download/v${version}/${name}_v${version}.zip";
				hash = "sha256-YmU41DCDF1G6eofdTh4KbaaZi0d/Mmm/9rQ4m44cqdQ=
";
		};
		installPhase = ''
				mkdir -p $out/share/fonts/truetype/${name}
				cp *.ttf $out/share/fonts/truetype/${name}/.

				mkdir -p $out/share/fonts/opentype/${name}
				cp *.otb $out/share/fonts/opentype/${name}/.
		'';
}
