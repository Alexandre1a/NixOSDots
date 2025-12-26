{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;
  cfg = config.services.ollama;
  ollama = lib.getExe cfg.package;
in
{
  options = {
    services.ollama = {
      enable = lib.mkEnableOption "ollama server for local large language models";

      package = lib.mkPackageOption pkgs "ollama" {
        example = "pkgs.ollama";
        extraDescription = ''
          On macOS, hardware acceleration is automatically handled by Metal.
          The standard `ollama` package should work for most users.
        '';
      };

      home = lib.mkOption {
        type = types.str;
        default = "$HOME/.ollama";
        example = "/Users/foo/.ollama";
        description = ''
          The home directory that the ollama service uses for its data.
          On macOS, this defaults to the user's home directory.
        '';
      };

      models = lib.mkOption {
        type = types.str;
        default = "${cfg.home}/models";
        defaultText = "\${config.services.ollama.home}/models";
        example = "/Users/foo/.ollama/models";
        description = ''
          The directory that the ollama service will read models from and download new models to.
        '';
      };

      host = lib.mkOption {
        type = types.str;
        default = "127.0.0.1";
        example = "0.0.0.0";
        description = ''
          The host address which the ollama server HTTP interface listens to.
        '';
      };

      port = lib.mkOption {
        type = types.port;
        default = 11434;
        example = 11111;
        description = ''
          Which port the ollama server listens to.
        '';
      };

      environmentVariables = lib.mkOption {
        type = types.attrsOf types.str;
        default = { };
        example = {
          OLLAMA_DEBUG = "1";
          OLLAMA_NUM_PARALLEL = "2";
        };
        description = ''
          Set arbitrary environment variables for the ollama service.

          Be aware that these are only seen by the ollama server (launchd daemon),
          not normal invocations like `ollama run`.
          Since `ollama run` is mostly a shell around the ollama server, this is usually sufficient.
        '';
      };

      loadModels = lib.mkOption {
        type = types.listOf types.str;
        apply = builtins.filter (model: model != "");
        default = [ ];
        example = [
          "llama3.2"
          "qwen2.5:7b"
          "deepseek-r1:8b"
        ];
        description = ''
          Download these models using `ollama pull` after the service starts.

          This creates a separate LaunchAgent that will pull the models in the background.
          Models are only pulled if not already present.

          Search for models at: <https://ollama.com/library>
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Ajouter le package ollama au PATH système
    environment.systemPackages = [ cfg.package ];

    # Service principal ollama
    launchd.user.agents.ollama = {
      path = [ config.environment.systemPath ];
      serviceConfig = {
        # Garder le service actif en permanence
        KeepAlive = true;
        # Démarrer au login
        RunAtLoad = true;
        # Commande pour lancer ollama
        ProgramArguments = [ "${ollama}" "serve" ];
        # Variables d'environnement
        EnvironmentVariables = cfg.environmentVariables // {
          # L'adresse et le port d'écoute
          OLLAMA_HOST = "${cfg.host}:${toString cfg.port}";
          # Le répertoire des modèles (on utilise toujours OLLAMA_MODELS)
          OLLAMA_MODELS = cfg.models;
        };
        # Logs de sortie standard
        StandardOutPath = "${cfg.home}/ollama.log";
        StandardErrorPath = "${cfg.home}/ollama-error.log";
      };
    };

    # Service optionnel pour télécharger les modèles
    launchd.user.agents.ollama-model-loader = lib.mkIf (cfg.loadModels != [ ]) {
      path = [ config.environment.systemPath ];
      serviceConfig = {
        # Ne garder actif que pendant le téléchargement
        KeepAlive = false;
        # Démarrer au login
        RunAtLoad = true;
        # Script pour télécharger les modèles
        ProgramArguments = [
          "${pkgs.bash}/bin/bash"
          "-c"
          ''
            # Attendre que le service ollama soit prêt
            for i in {1..30}; do
              if ${ollama} list &>/dev/null; then
                break
              fi
              echo "Waiting for ollama service to be ready... ($i/30)"
              sleep 2
            done

            # Télécharger chaque modèle s'il n'existe pas déjà
            ${lib.concatMapStringsSep "\n" (model: ''
              if ! ${ollama} list | grep -q "${lib.escapeShellArg model}"; then
                echo "Pulling model: ${model}"
                ${ollama} pull ${lib.escapeShellArg model}
              else
                echo "Model already exists: ${model}"
              fi
            '') cfg.loadModels}
          ''
        ];
        StandardOutPath = "${cfg.home}/model-loader.log";
        StandardErrorPath = "${cfg.home}/model-loader-error.log";
      };
    };

    # Message informatif lors de l'activation
    system.activationScripts.postActivation.text = lib.mkIf cfg.enable ''
      echo "Ollama service configured to listen on ${cfg.host}:${toString cfg.port}"
      echo "Models will be stored in: ${cfg.models}"
      ${lib.optionalString (cfg.loadModels != [ ]) ''
        echo "The following models will be downloaded automatically:"
        ${lib.concatMapStringsSep "\n" (model: ''  echo "  - ${model}"'') cfg.loadModels}
      ''}
    '';
  };

  meta.maintainers = with lib.maintainers; [ ];
}
