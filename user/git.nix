{ pkgs, config, ... }:
{

  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    userName = "GET MOUSSED";
    userEmail = "moussa.fof.pro@gmail.com";
    includes =
      [
        {
          condition = "gitdir:${config.home.homeDirectory}/come_on/";
          contents = {
            user = {
              email = "m.fofana@come-on.co";
              name = "Moussa Fofana";
            };
            core = {
              sshCommand = "ssh -i ${config.home.homeDirectory}/.ssh/come_on";
            };
          };
        }
      ];
  };

}
