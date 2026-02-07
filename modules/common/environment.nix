{ pkgs, inputs, ... }:
{
    environment = {
        systemPackages = with pkgs; [
          # Text editors
          neovim
          vim
          # Sytem utilities
          wget
          git
          tree
          btop
          eza
          fastfetch
          ffmpeg
          fzf
          netcat
          tmux
          gnupg
          cmatrix
          gh
	  # Browser
	  inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    variables = {
      EDITOR = "nvim";
    };
  };
}
