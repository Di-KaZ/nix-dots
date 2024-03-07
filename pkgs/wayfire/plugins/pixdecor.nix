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
}:



stdenv.mkDerivation (finalAttrs: {

  pname = "pixdecor";
  version = "0.9.0";


  src = fetchFromGitHub {
    owner = "soreau";
    repo = "pixdecor";
    fetchSubmodules = true;
    rev = "80215d151075fdd97c36a1e674fbdd68aa8cf2f2";
    hash = "sha256-mWMZpJPBPvabaayOgGJzWLsZ9fwufkWKhD2eRo8DSg8=";
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
  ];

  mesonFlags = [ "--sysconfdir /etc" ];

  meta = {
    homepage = "https://github.com/soreau/pixdecor";
    description = "A window decoration plugin for wayfire";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ soreau ];
    inherit (wayfire.meta) platforms;
  };
})
