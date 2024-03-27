{ stdenv
, lib
, fetchFromGitHub
, meson
, ninja
, pkg-config
, wayfire
, wf-config
, wayland
, pango
, eudev
, libinput
, libxkbcommon
, librsvg
, libGL
, xcbutilwm
, boost
}:



stdenv.mkDerivation (finalAttrs: {

  pname = "firedecor";
  version = "0.9.0";


  src = fetchFromGitHub {
    owner = "AhoyISki";
    repo = "Firedecor";
    fetchSubmodules = true;
    rev = "68a701da430f0c70326964abf63ce8f542c26702";
    hash = "sha256-5CBHVdKC7A0/KVvQp5PqIWcqaxwRGg0nsNGEcTV605I=";
  };


  postPatch =
    let
      substitute = ''--replace-warn "wayfire.get_variable( pkgconfig: 'metadatadir' )" "join_paths(get_option('prefix'), 'share/wayfire/metadata')"'';
    in
    ''substituteInPlace meson.build ${substitute} && \
      substituteInPlace src/meson.build ${substitute} && \
      substituteInPlace metadata/meson.build ${substitute}
    '';


  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    wayfire
    wf-config
    wayland
    pango
    eudev
    libinput
    libxkbcommon
    librsvg
    libGL
    xcbutilwm
	boost
  ];

  mesonFlags = [ "--sysconfdir /etc" ];

  meta = {
    homepage = "https://github.com/AhoyISki/Firedecor";
    description = "A window decoration plugin for wayfire";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ AhoyISki ];
    inherit (wayfire.meta) platforms;
  };
})
