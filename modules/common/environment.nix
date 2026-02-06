{ pkgs, ... }:
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
    ];
    variables = {
      EDITOR = "nvim";
    };
  };
}
