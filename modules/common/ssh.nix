{
  # The OpenSSH agent
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      Host github.com
      IdentityFile ~/.ssh/github
    '';
  };
}
