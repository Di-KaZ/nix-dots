{ inputs, pkgs, lib, config, ... }:
{
  options =
    {
      test = lib.mkOption
        {
          default = "Bruh";
          type = lib.types.str;
          description = ''Test parameter'';
        };
    };

  config = {
    home.file.".config/test.ini".text = lib.generators.toINI { } {
      test = {
        bruh = config.test;
      };
    };
  };
}
