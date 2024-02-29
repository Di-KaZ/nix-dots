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
      vulkan-validation-layers # maybe?
      glslang # or shaderc
      libseat
      hwdata
      libdisplay-info
      xwayland
    ];
    mesonFlags = [
      "--sysconfdir /etc"
      "-Duse_system_wlroots=disabled"
      "-Duse_system_wfconfig=disabled"
      # TODO: (lib.mesonEnable "wf-touch:tests" (stdenv.buildPlatform.canExecute stdenv.hostPlatform))
    ];
    src = pkgs.fetchFromGitHub {
      owner = "WayfireWM";
      repo = "wayfire";
      rev = "27ddca3000a17ed7e1f1619dd14152373e39cb1b";
      fetchSubmodules = true;
      hash = "sha256-vl0Qc8HEkMN+rhC2ZB5+jsr1nBNTLC+y1uZw2Qqr1oM=";
    };
  });
})

