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
      variable = {
        ELECTRON_BUILDER_DISABLE_SIGNING = "true";
      };
    };
}
