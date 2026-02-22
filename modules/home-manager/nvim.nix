{inputs, pkgs, ...}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  programs = {
    nixvim = {
      enable = true;
      
      # Color scheme
      colorschemes = {
        catppuccin = {
          enable = true;
        };
      };
      
      # ========================================
      # BASIC VIM OPTIONS
      # ========================================
      opts = {
        # Line numbers
        number = true;           # Show absolute line numbers
        #relativenumber = true;   # Show relative line numbers (great for vim motions)
        
        # Indentation
        tabstop = 2;            # Number of spaces a tab counts for
        shiftwidth = 2;         # Number of spaces for each indentation level
        expandtab = true;       # Convert tabs to spaces
        autoindent = true;      # Copy indent from current line when starting new line
        smartindent = true;     # Smart autoindenting when starting a new line
        
        # Search
        ignorecase = true;      # Ignore case in search patterns
        smartcase = true;       # Override ignorecase if search contains uppercase
        hlsearch = true;        # Highlight search results
        incsearch = true;       # Show search matches as you type
        
        # UI
        termguicolors = true;   # Enable 24-bit RGB colors
        cursorline = true;      # Highlight the current line
        signcolumn = "yes";     # Always show sign column (prevents text shifting)
        scrolloff = 8;          # Keep 8 lines above/below cursor when scrolling
        sidescrolloff = 8;      # Keep 8 columns left/right of cursor
        
        # Performance
        updatetime = 300;       # Faster completion (default is 4000ms)
        
        # Splits
        splitright = true;      # Vertical splits open to the right
        splitbelow = true;      # Horizontal splits open below
        
        # Other
        mouse = "a";            # Enable mouse support
        clipboard = "unnamedplus"; # Use system clipboard
        undofile = true;        # Persistent undo
        backup = false;         # Don't create backup files
        #swapfile = false;       # Don't create swap files
      };
      
      # ========================================
      # PLUGINS
      # ========================================
      plugins = {
        # Status line
        lualine = {
          enable = true;
        };

	      web-devicons = {
	        enable = true;
	      };
        
        # File tree
        neo-tree = {
          enable = true;
          settings = {
	          close_if_last_window = true;
            window = {
              width = 30;
            };
	        };
        };
        
        # Fuzzy finder
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
          };
        };
        
        # Git integration
        gitsigns = {
          enable = true;
        };
        
        # Auto pairs
        nvim-autopairs = {
          enable = true;
        };
        
        # Comment toggling
        comment = {
          enable = true;
        };
        
        # Treesitter for better syntax highlighting
        treesitter = {
          enable = true;
          settings = {
            highlight = {
              enable = true;
            };
            indent = {
              enable = true;
            };
          };
        };
        
        # ========================================
        # LSP CONFIGURATION
        # ========================================
        lsp = {
          enable = true;
          
          # LSP servers
          servers = {
            # Nix language server
            nixd = {
              enable = true;
            };

            cmake-language-server = {
              enable = true;
            };
            
            # C++ language server
            clangd = {
              enable = true;
              # You can add custom settings here
              # cmd = ["clangd" "--background-index"];
            };
            
            # Optional: other language servers you might want
            # bashls.enable = true;     # Bash
            # pyright.enable = true;    # Python
            # gopls.enable = true;      # Go
            # rust-analyzer.enable = true; # Rust
          };
          
          # LSP keymaps - these work when an LSP is attached
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
            lspBuf = {
              "gd" = "definition";
              "gD" = "declaration";
              "gr" = "references";
              "gi" = "implementation";
              "K" = "hover";
              "<leader>rn" = "rename";
              "<leader>ca" = "code_action";
            };
          };
        };
        
        # ========================================
        # COMPLETION
        # ========================================
        cmp = {
          enable = true;
          
          settings = {
            # Snippet support (required for nvim-cmp)
            snippet = {
              expand = "function(args) require('luasnip').lsp_expand(args.body) end";
            };
            
            # Completion sources
            sources = [
              { name = "nvim_lsp"; }  # LSP completions
              { name = "path"; }      # Path completions
              { name = "buffer"; }    # Buffer completions
              { name = "luasnip"; }   # Snippet completions
            ];
            
            # Keybindings for completion menu
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.close()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
            };
          };
        };
        
        # Snippet engine (required by cmp)
        luasnip = {
          enable = true;
        };
        
        # ========================================
        # QUALITY OF LIFE PLUGINS
        # ========================================
        
        # Which-key: shows available keybindings
        which-key = {
          enable = true;
        };
        
        # Better buffer management
        bufferline = {
          enable = true;
        };
        
        # Indent guides
        indent-blankline = {
          enable = true;
        };
        
        # Color highlighter (shows colors inline)
        nvim-colorizer = {
          enable = true;
        };
      };
      
      # ========================================
      # CUSTOM KEYMAPS
      # ========================================
      keymaps = [
        # Leader key
        {
          mode = "n";
          key = "<Space>";
          action = "<Nop>";
          options = {
            silent = true;
          };
        }
        
        # File tree toggle
        {
          mode = "n";
          key = "<leader>e";
          action = ":Neotree toggle<CR>";
          options = {
            silent = true;
            desc = "Toggle file tree";
          };
        }
        
        # Better window navigation
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
          options = {
            desc = "Move to left window";
          };
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
          options = {
            desc = "Move to lower window";
          };
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
          options = {
            desc = "Move to upper window";
          };
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
          options = {
            desc = "Move to right window";
          };
        }
        
        # Resize windows
        {
          mode = "n";
          key = "<C-Up>";
          action = ":resize +2<CR>";
          options = {
            silent = true;
            desc = "Increase window height";
          };
        }
        {
          mode = "n";
          key = "<C-Down>";
          action = ":resize -2<CR>";
          options = {
            silent = true;
            desc = "Decrease window height";
          };
        }
        {
          mode = "n";
          key = "<C-Left>";
          action = ":vertical resize -2<CR>";
          options = {
            silent = true;
            desc = "Decrease window width";
          };
        }
        {
          mode = "n";
          key = "<C-Right>";
          action = ":vertical resize +2<CR>";
          options = {
            silent = true;
            desc = "Increase window width";
          };
        }
        
        # Buffer navigation
        {
          mode = "n";
          key = "<Tab>";
          action = ":bnext<CR>";
          options = {
            silent = true;
            desc = "Next buffer";
          };
        }
        {
          mode = "n";
          key = "<S-Tab>";
          action = ":bprevious<CR>";
          options = {
            silent = true;
            desc = "Previous buffer";
          };
        }
        
        # Save file
        {
          mode = "n";
          key = "<C-s>";
          action = ":w<CR>";
          options = {
            silent = true;
            desc = "Save file";
          };
        }
        
        # Clear search highlight
        {
          mode = "n";
          key = "<leader>h";
          action = ":nohlsearch<CR>";
          options = {
            silent = true;
            desc = "Clear search highlight";
          };
        }
        
        # Better indenting in visual mode
        {
          mode = "v";
          key = "<";
          action = "<gv";
          options = {
            desc = "Indent left";
          };
        }
        {
          mode = "v";
          key = ">";
          action = ">gv";
          options = {
            desc = "Indent right";
          };
        }
      ];
      
      # ========================================
      # GLOBAL SETTINGS
      # ========================================
      globals = {
        mapleader = " ";  # Set space as leader key
        maplocalleader = " ";
      };
      
    }; # End of NixVIM
  };
}
