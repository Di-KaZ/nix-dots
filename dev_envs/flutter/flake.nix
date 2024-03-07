{
  description = "Flutter dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/23.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.flutter-nix.url = "github:maximoffua/flutter.nix/3.16.8";

  outputs = { self, nixpkgs, flake-utils, flutter-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.android_sdk.accept_license = true;
          overlays = [ flutter-nix.overlays.default ]; # override flutter version
        };
      in
      {
        devShells.default =
          let
            android = pkgs.androidenv.composeAndroidPackages
              {
                toolsVersion = "26.1.1";
                platformToolsVersion = "34.0.5";
                buildToolsVersions = [ "34.0.0" "30.0.3" ];
                includeEmulator = true;
                emulatorVersion = "34.1.9";
                platformVersions = [ "28" "29" "30" "31" "32" "33" "34" ];
                includeSources = false;
                includeSystemImages = true;
                systemImageTypes = [ "system-images" "google_apis_playstore" "android-27" "x86_64" ];
                abiVersions = [ "x86_64" ];
                cmakeVersions = [ "3.10.2" ];
                includeNDK = true;
                ndkVersions = [ "22.0.7026061" ];
                useGoogleAPIs = true;
                useGoogleTVAddOns = false;
              };
          in
          pkgs.mkShell {
            buildInputs = with pkgs;
              [
                flutter
                jdk17
                android.platform-tools
                google-chrome
              ];
            ANDROID_SDK_ROOT = "${android.androidsdk}/libexec/android-sdk";
            GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android.androidsdk}/libexec/android-sdk/build-tools/34.0.0/aapt2";
            ANDROID_HOME = "${android.androidsdk}/libexec/android-sdk";
            JAVA_HOME = pkgs.jdk17;
            CHROME_EXECUTABLE = "google-chrome-stable";
            # ANDROID_AVD_HOME = (toString ./.) + "/.android/avd";
          };
      });
}
