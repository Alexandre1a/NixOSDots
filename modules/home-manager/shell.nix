{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        package = pkgs.zsh;
        enableCompletion = true;
        autocd = true;
        loginExtra = "echo Hello World!";

        autosuggestion = {
            enable = true;
            strategy = "match_prev_cmd";
        };

        dirHashes = {
            code = "$\{config.home.homeDirectory}/Developer";
        };

        history = {
            append = true;
            extended = true;
            ignoreSpace = false;
            save = 100000;
            size = 100000;
            saveNoDups = true;
            share = true;
        };
        
        oh-my-zsh = {
            enable = true;
            package = pkgs.oh-my-zsh;
            plugins = [
                "git"
                "react-native"
                "golang"
                "docker"
                #"brew"
                "eza"
                "fzf"
                "gh"
                "kitty"
                "zsh-autosuggestions"
                "zsh-syntax-highlighting"
            ];
        };
    };
}