{ config, lib, pkgs, ... }:

let
  cfg = config.programs.zed-ai;

  homeDir = config.home.homeDirectory;

  zedSettings = {
    language_models = {
      ollama = {
        api_url = "http://localhost:11434";
        available_models = [
          { name = "deepseek-r1:8b"; display_name = "DeepSeek-R1 8B (CoT Native)"; max_tokens = 64000; supports_tools = true; supports_thinking = true; supports_images = false; }
          { name = "deepseek-r1:14b"; display_name = "DeepSeek-R1 14B (CoT Native)"; max_tokens = 64000; supports_tools = true; supports_thinking = true; supports_images = false; }
          { name = "deepseek-coder-v2:16b"; display_name = "Deepseek Coder V2 16B"; max_tokens = 160000; supports_tools = false; supports_thinking = false; supports_images = false; }
          { name = "starcoder2:7b"; display_name = "StarCoder2 7B"; max_tokens = 16384; supports_tools = false; supports_thinking = false; supports_images = false; }
          { name = "codegemma:7b-instruct"; display_name = "CodeGemma 7B Instruct"; max_tokens = 8192; supports_tools = true; supports_thinking = false; supports_images = false; }
          { name = "codegemma:2b"; display_name = "CodeGemma 2B (Fast)"; max_tokens = 8192; supports_tools = false; supports_thinking = false; supports_images = false; }
        ];
      };
    };

    inline_completions = {
      provider = "ollama";
      ollama = {
        model = "codegemma:2b";
        api_url = "http://localhost:11434";
        low_speed_timeout_in_seconds = 30;
        timeout_in_seconds = 5;
      };
    };

    show_edit_predictions = false;

    agent = {
      default_profile = "reasoning";
      play_sound_when_agent_done = true;
      dock = "right";
      default_model = {
        provider = "ollama";
        model = "deepseek-r1:14b";
      };

      profiles = lib.mapAttrs (name: profile:
        profile // {
          context_servers = cfg.mcpServers;
        }
      ) {
        reasoning = {
          name = "Deep Reasoning (CoT)";
          tools = {
            copy_path = true; create_directory = true; delete_path = true; diagnostics = true; edit_file = true;
            fetch = true; list_directory = true; move_path = true; now = true; find_path = true; read_file = true;
            grep = true; terminal = true; thinking = true; web_search = true; project_notifications = false;
          };
          enable_all_context_servers = true;
          system_prompt = ''
            You are an expert programming assistant. Break down problems, think step by step, consider edge cases.
          '';
        };

        fast = {
          name = "Fast Development";
          tools = {
            copy_path = true; create_directory = true; delete_path = true; diagnostics = true; edit_file = true;
            fetch = true; list_directory = true; move_path = true; now = true; find_path = true; read_file = true;
            grep = true; terminal = true; thinking = false; web_search = true; project_notifications = false;
          };
          enable_all_context_servers = true;
          default_model = { provider = "ollama"; model = "codegemma:7b-instruct"; };
          system_prompt = "Fast assistant: concise, clear, efficient.";
        };
      };
    };

    ui_font_size = 16;
    buffer_font_size = 16;
    theme = "Rosé Pine";
    icon_theme = "Material Icon Theme";
  };

in
{
  options.programs.zed-ai = {
    enable = lib.mkEnableOption "Enable Zed AI with CoT";

    mcpServers = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "MCP servers config";
    };

    githubToken = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Github token for MCP";
    };

    braveSearchApiKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Brave Search API key";
    };
  };

  config = lib.mkIf cfg.enable {

    # MCP servers dynamiques
    programs.zed-ai.mcpServers = lib.mkDefault (
      lib.recursiveUpdate {
        filesystem = {
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-filesystem" "${homeDir}/Developer"];
        };

        github = lib.optionalAttrs (cfg.githubToken != null) {
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-github"];
          env = { GITHUB_PERSONAL_ACCESS_TOKEN = cfg.githubToken; };
        };

        git = { command = "npx"; args = ["-y" "@modelcontextprotocol/server-git"]; };

        brave-search = lib.optionalAttrs (cfg.braveSearchApiKey != null) {
          command = "npx";
          args = ["-y" "@modelcontextprotocol/server-brave-search"];
          env = { BRAVE_API_KEY = cfg.braveSearchApiKey; };
        };
      } {}
    );

    # Générer settings.json
    home.file.".config/zed/settings.json" = {
      text = builtins.toJSON zedSettings;
    };

  };
}
