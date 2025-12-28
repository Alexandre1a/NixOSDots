{ config, lib, pkgs, ... }:

let
  cfg = config.programs.zed-custom;

  # Zed configuration
  zedSettings = {
    # Ollama AI config
    language_models = {
      ollama = {
        api_url = "http://localhost:11434";
        # List available models

        available_models = [
          # AIs with native CoT
          {
            name = "deepseek-r1:8b";
            display_name = "DeepSeek-R1 8B (CoT Native)";
            max_tokens = 64000;
            supports_tools = true;
            supports_thinking = true;
            supports_images = false;
          }
          {
            name = "deepseek-r1:14b";
            display_name = "DeepSeek-R1 14B (CoT Native)";
            max_tokens = 64000;
            supports_tools = true;
            supports_thinking = true;
            supports_images = false;
          }
          {
            name = "deepseek-coder-v2:16b";
            display_name = "Deepseek Coder V2 16B";
            max_tokens = 160000;
            supports_tools = false;
            supports_thinking = false;
            supports_images = false;
          }
          {
            name = "starcoder2:7b";
            display_name = "StarCoder2 7B";
            max_tokens = 16384;
            supports_tools = false;
            supports_thinking = false;
            supports_images = false;
          }
          {
            name = "codegemma:7b-instruct";
            display_name = "CodeGemma 7B Instruct";
            max_tokens = 8192;
            supports_tools = true;
            supports_thinking = false;
            supports_images = false;
          }
          {
            name = "codegemma:2b";
            display_name = "CodeGemma 2B (Fast)";
            max_tokens = 8192;
            supports_tools = false;
            supports_thinking = false;
            supports_images = false;
          }
        ];
      };
    };

    # Inline autocompletion
    # Small and fast AI model
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
    edit_predictions = {
      mode = "subtle";
      enabled_in_text_threads = false;
    };

    agent = {
      default_profile = "reasoning";
      play_sound_when_agent_done = true;
      dock = "right";
      default_model = {
        provider = "ollama";
        model = "deepseek-r1:14b";
      };

      profiles = {
        reasoning = {
          name = "Deep Reasoning (CoT)";
          tools = {
            copy_path = true;
            create_directory = true;
            delete_path = true;
            diagnostics = true;
            edit_file = true;
            fetch = true;
            list_directory = true;
            move_path = true;
            now = true;
            find_path = true;
            read_file = true;
            grep = true;
            terminal = true;
            thinking = true;
            web_search = true;
            project_notifications = false;
          };
          enable_all_context_servers = true;
          context_servers = {};
          system_prompt = ''
            You are an expert programming assistant. When solving complex problems:
            1. Break down the problem into smaller steps
            2. Think through each step carefully before providing code
            3. Consider edge cases and potential issues
            4. Explain your reasoning process

            For debugging tasks, trace through the code logic step by step.
            For architecture decisions, evaluate multiple approaches before recommending one.
            For optimization problems, analyze the time and space complexity at each step.
          '';
        };

        fast = {
          name = "Fast Development";
          tools = {
            copy_path = true;
            create_directory = true;
            delete_path = true;
            diagnostics = true;
            edit_file = true;
            fetch = true;
            list_directory = true;
            move_path = true;
            now = true;
            find_path = true;
            read_file = true;
            grep = true;
            terminal = true;
            thinking = false;
            web_search = true;
            project_notifications = false;
          };
          enable_all_context_servers = true;
          context_servers = {};
          # Uses a faster model
          default_model = {
            provider = "ollama";
            model = "codegemma:7b-instruct";
          };
          system_prompt = ''
            You are a fast and efficient programming assistant.
            Provide clear, concise solutions while still being thorough.
            Think through the problem but focus on delivering results quickly.
          '';
        };

        debug = {
          name = "Debug & Analysis";
          tools = {
            copy_path = true;
            create_directory = true;
            delete_path = true;
            diagnostics = true;
            edit_file = true;
            fetch = true;
            list_directory = true;
            move_path = true;
            now = true;
            find_path = true;
            read_file = true;
            grep = true;
            terminal = true;
            thinking = true;
            web_search = true;
            project_notifications = true;
          };
          enable_all_context_servers = true;
          context_servers = {};
          default_model = {
            provider = "ollama";
            model = "deepseek-r1:14b";
          };
          system_prompt = ''
            You are a meticulous debugging assistant. When analyzing bugs:
            1. First, understand what the code is supposed to do
            2. Trace through the execution flow step by step
            3. Identify where the actual behavior diverges from expected behavior
            4. Explain why the bug occurs
            5. Propose a fix with explanation

            Show your complete reasoning process. Consider multiple hypotheses.
            Use the diagnostic tools to gather information systematically.
          '';
        };

        learning = {
          name = "Learning & Teaching";
          tools = {
            copy_path = true;
            diagnostics = true;
            list_directory = true;
            find_path = true;
            read_file = true;
            grep = true;
            now = true;
            thinking = true;
            fetch = true;
            web_search = true;
            create_directory = false;
            delete_path = false;
            edit_file = false;
            move_path = false;
            terminal = false;
            project_notifications = false;
          };
          enable_all_context_servers = true;
          context_servers = {};
          default_model = {
            provider = "ollama";
            model = "deepseek-r1:14b";
          };
          system_prompt = ''
            You are a patient and thorough programming teacher. When explaining concepts:
            1. Start with the fundamentals and build up gradually
            2. Use concrete examples and analogies
            3. Show your reasoning process step by step
            4. Anticipate common points of confusion
            5. Encourage understanding over memorization

            Break down complex topics into digestible parts.
            Relate new concepts to things the student already knows.
            Ask guiding questions to promote active learning.
          '';
        };

        read = {
          name = "Read & Explore";
          tools = {
            copy_path = true;
            diagnostics = true;
            list_directory = true;
            find_path = true;
            read_file = true;
            grep = true;
            now = true;
            thinking = false;
            fetch = false;
            web_search = false;
            create_directory = false;
            delete_path = false;
            edit_file = false;
            move_path = false;
            terminal = false;
            project_notifications = false;
          };
          enable_all_context_servers = true;
          context_servers = {};
          default_model = {
            provider = "ollama";
            model = "codegemma:7b-instruct";
          };
          system_prompt = ''
            You are a helpful code reading assistant.
            Provide clear, concise explanations of code structure and behavior.
          '';
        };
      };
    };

    # UI
    ui_font_size = 16;
    buffer_font_size = 16;
    theme = "Dracula";
    icon_theme = "Material Icon Theme";

    # Discord Presence config
    lsp = {
      discord_presence = {
        initialization_options = {
          application_id = "1263505205522337886";
          base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";
          state = "Working on {filename}";
          details = "In {workspace}";
          large_image = "{base_icons_url}/{language}.png";
          large_text = "{language:u}";
          small_image = "{base_icons_url}/zed.png";
          small_text = "Zed";
          idle = {
            timeout = 600;
            action = "clear_activity";
            state = "Idling";
            details = "In Zed";
            large_image = "{base_icons_url}/zed.png";
            large_text = "Zed";
            small_image = "{base_icons_url}/idle.png";
            small_text = "Idle";
          };
          rules = {
            mode = "blacklist";
            paths = [];
          };
          git_integration = true;
        };
      };
    };

    auto_install_extensions = {
      # System Languages
      rust = true;
      nix = true;

      # Web Dev language
      html = true;
      css = true;
      javascript = true;
      typescript = true;

      # Backend languages
      go = true;
      python = true;

      # Data Format
      json = true;
      yaml = true;
      toml = true;

      # Documentation
      markdown = true;
    };

    # Autocomplete with Ollama
    features = {
      inline_completion_provider = "ollama";
      edit_prediction_provider = "none";
    };
  };

in
{
  options.programs.zed-custom = {
    enable = lib.mkEnableOption "Zed AI configuration with Chain of Thought";

    enableCoTModels = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Automatically download and configure Chain of Thought capable models.
        This will add DeepSeek-R1 models to your Ollama installation.
      '';
    };

    mcpServers = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "MCP servers config";
    };

    githubToken = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Github token for the MCP";
    };

    braveSearchApiKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Brave Search API key";
    };
  };

  config = lib.mkIf cfg.enable {

    sops = lib.mkIf (cfg.githubToken != null || cfg.braveSearchApiKey != null) {
      secrets = {
        "zed/github_token" = lib.mkIf (cfg.githubToken != null) {
          sopsFile = ../../secrets/secrets.yaml;
        };

        "zed/brave_api_key" = lib.mkIf (cfg.braveSearchApiKey != null) {
          sopsFile = ../../secrets/secrets.yaml;
        };
      };
    };

    # Configure default MCP servers
    programs.zed-custom.mcpServers = lib.mkDefault {
      filesystem = {
        command = "npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-filesystem"
          "${config.home.homeDirectory}/Developer"
        ];
      };

      github = lib.mkIf (cfg.githubToken != null) {
        command = "npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-github"
        ];
        env = {
          GITHUB_PERSONAL_ACCESS_TOKEN = "$(cat ${config.sops.secrets."zed/github_token".path})";
        };
      };

      git = {
        command = "npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-git"
        ];
      };

      brave-search = lib.mkIf (cfg.braveSearchApiKey != null) {
        command = "npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-brave-search"
        ];
        env = {
          BRAVE_API_KEY = "$(cat ${config.sops.secrets."zed/brave_api_key".path})";
        };
      };
    };

    # Generate Zed config
    home.file.".config/zed/settings.json" = {
      text = builtins.toJSON (zedSettings // {
        agent = zedSettings.agent // {
          profiles = lib.mapAttrs (name: profile:
            profile // {
              context_servers = cfg.mcpServers;
            }
          ) zedSettings.agent.profiles;
        };
      });
    };

    # Helper Scripts
    home.packages = [
      # Main test script
      (pkgs.writeShellScriptBin "zed-custom-test" ''
        echo "🔍 Testing Zed AI Configuration with Chain of Thought..."
        echo ""

        echo "Checking Ollama service..."
        if ${pkgs.curl}/bin/curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
          echo "✅ Ollama is running"
          echo ""
          echo "Available models:"
          ${pkgs.curl}/bin/curl -s http://localhost:11434/api/tags | ${pkgs.jq}/bin/jq -r '.models[].name' | sort
          echo ""

          echo "Chain of Thought models:"
          ${pkgs.curl}/bin/curl -s http://localhost:11434/api/tags | ${pkgs.jq}/bin/jq -r '.models[].name' | grep -E "deepseek-r1" || echo "  No CoT models found. Run 'ollama pull deepseek-r1:14b'"
        else
          echo "❌ Ollama is not running"
        fi

        echo ""
        echo "Checking Zed configuration..."
        if [ -f ~/.config/zed/settings.json ]; then
          echo "✅ Zed configuration exists"
          echo ""
          echo "Configured CoT-capable models:"
          ${pkgs.jq}/bin/jq -r '.language_models.ollama.available_models[] | select(.supports_thinking == true) | "  - \(.name) (\(.display_name))"' ~/.config/zed/settings.json
          echo ""
          echo "Agent profiles:"
          ${pkgs.jq}/bin/jq -r '.agent.profiles | keys[]' ~/.config/zed/settings.json | sed 's/^/  - /'
        else
          echo "❌ Zed configuration not found"
        fi

        echo ""
        echo "💡 Tips:"
        echo "   - Use 'reasoning' profile for complex problems with visible thinking"
        echo "   - Use 'debug' profile for detailed bug analysis"
        echo "   - Use 'learning' profile when learning new concepts"
        echo "   - Use 'fast' profile for quick coding without visible CoT"
        echo ""
        echo "   To switch profiles in Zed: Open settings (Cmd+,) and search for 'agent profile'"
      '')

      # Sript to directly test CoT
      (pkgs.writeShellScriptBin "test-cot" ''
        #!/usr/bin/env bash

        MODEL="''${1:-deepseek-r1:14b}"
        PROMPT="''${2:-Explain step by step how to implement a binary search tree in Rust}"

        echo "🧠 Testing Chain of Thought with model: $MODEL"
        echo "📝 Prompt: $PROMPT"
        echo ""
        echo "Generating response with thinking process..."
        echo "=================================================="

        ${pkgs.curl}/bin/curl -s http://localhost:11434/api/generate -d "{
          \"model\": \"$MODEL\",
          \"prompt\": \"$PROMPT\",
          \"stream\": false
        }" | ${pkgs.jq}/bin/jq -r '.response'

        echo ""
        echo "=================================================="
        echo ""
        echo "💡 Try other models:"
        echo "   test-cot deepseek-r1:8b 'your question'"
        echo "   test-cot codegemma:7b-instruct 'your question'"
      '')

      # Script to compare CoT responses
      (pkgs.writeShellScriptBin "compare-cot" ''
        #!/usr/bin/env bash
        PROMPT="''${1:-Write a function to find the longest palindromic substring}"

        echo "🔬 Comparing responses with and without Chain of Thought"
        echo "📝 Prompt: $PROMPT"
        echo ""

        echo "1️⃣  Response WITHOUT explicit CoT (codegemma:7b-instruct):"
        echo "=================================================="
        ${pkgs.curl}/bin/curl -s http://localhost:11434/api/generate -d "{
          \"model\": \"codegemma:7b-instruct\",
          \"prompt\": \"$PROMPT\",
          \"stream\": false
        }" | ${pkgs.jq}/bin/jq -r '.response'

        echo ""
        echo "2️⃣  Response WITH Chain of Thought (deepseek-r1:14b):"
        echo "=================================================="
        ${pkgs.curl}/bin/curl -s http://localhost:11434/api/generate -d "{
          \"model\": \"deepseek-r1:14b\",
          \"prompt\": \"Think through this step by step. $PROMPT\",
          \"stream\": false
        }" | ${pkgs.jq}/bin/jq -r '.response'

        echo ""
        echo "💡 Notice how the CoT model shows its reasoning process"
      '')
    ];
  };
}
