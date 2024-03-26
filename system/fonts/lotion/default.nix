{pkgs}:
let 
name = "lotion";
version = "1.0.0";
in
pkgs.stdenv.mkDerivation {
		inherit name version;
		src = pkgs.fetchzip {
				url = "https://gitlab.com/nefertiti/lotion-dist/-/archive/master/lotion-dist-master.zip";
				hash = "sha256-0EOIilsSvGKwlAftvGZ7bE3hcASppT4cquVomhfU8WA=";
		};
		installPhase = ''
				mkdir -p $out/share/fonts/truetype/${name}
				cp ttf/*.ttf $out/share/fonts/truetype/${name}/.
		'';
}
