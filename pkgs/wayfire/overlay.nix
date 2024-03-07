{ pkgs, ... }:
(self: super: {
  wayfire = super.wayfire.overrideAttrs (prev: {
    version = "0.9.0";
    buildInputs = with pkgs; [
      mesa
      glm
      libGL
      libdrm
      libexecinfo
      libevdev
      libinput
      libjpeg
      libxkbcommon
      wayland-protocols
      xorg.xcbutilwm
      xorg.xcbutilrenderutil
      xorg.xcbutilerrors
      libxml2
      wayland
      cairo
      pango
      nlohmann_json
      vulkan-tools
      vulkan-headers
      vulkan-loader
      vulkan-validation-layers
      glslang
      libseat
      hwdata
      libdisplay-info
      xwayland
    ];
    mesonFlags = [
      "--sysconfdir /etc"
      "-Duse_system_wlroots=disabled"
      "-Duse_system_wfconfig=disabled"
      # (lib.mesonEnable "wf-touch:tests" (stdenv.buildPlatform.canExecute stdenv.hostPlatform))
    ];
    src = pkgs.fetchFromGitHub {
      owner = "WayfireWM";
      repo = "wayfire";
      rev = "2e0926f8f5a1c3834c51e97673bfbf074f4506ac";
      fetchSubmodules = true;
      hash = "sha256-/cVsuBCkt7WxPauMyko9FXdAsO6eYbkCgMP9YRbzaP8=";
    };
  });
})

