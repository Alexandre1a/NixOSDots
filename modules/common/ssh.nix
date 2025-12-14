{
  # The OpenSSH agent
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      # Test if github.com works with ssh for cloning
      Host github.com
      IdentityFile ~/.ssh/github
    '';
  };
}
