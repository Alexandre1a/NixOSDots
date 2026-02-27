{
  # The OpenSSH agent
  programs = {
    ssh = {
      startAgent = true;
      extraConfig = ''
        Host github.com
        IdentityFile ~/.ssh/git
        Host git.alexdelcamp.fr
        IdentityFile ~/.ssh/git
      '';
    };
  };
}
