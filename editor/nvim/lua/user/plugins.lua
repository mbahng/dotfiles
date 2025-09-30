-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Essentials for pretty much all coding  
  { "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
  }, 
  { "dhruvasagar/vim-table-mode" 
  },
  { "nvim-lua/plenary.nvim",                          -- async programming utilities
  },
  { "MunifTanjim/nui.nvim",                           -- UI component library for nvim 
  },
  { "nvim-telescope/telescope.nvim",                  -- fuzzy finder for files/text
  },
  { "jesseduffield/lazygit",                          -- git TUI integration
  },
  { "mbbill/undotree",                                -- visualize undo history
  },
  { "lukas-reineke/indent-blankline.nvim",            -- indent guide lines
  },
  { "ojroques/nvim-osc52",                            -- connecting local clipboard to remote connections 
  },
  { "mhartington/oceanic-next",                       -- Oceanic Next colorscheme
  },
  { "nvim-lualine/lualine.nvim",                      -- status line at the bottom
  },
  { "terrortylor/nvim-comment",                       -- commenting functionality
  },
  { "akinsho/bufferline.nvim",                        -- buffer tabs
  },
  { "moll/vim-bbye",                                  -- delete buffers without closing windows
  },
  { "akinsho/toggleterm.nvim",                        -- floating terminal
  },
  { "sindrets/diffview.nvim",                        -- git diff indicators
  },
  { "lewis6991/gitsigns.nvim",                        -- git diff indicators
  },
  { "unblevable/quick-scope",                        -- git diff indicators
		init = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
		end,
  },

  { "L3MON4D3/LuaSnip",                               -- snippet engine
    build = "make install_jsregexp"
  },
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  { "kyazdani42/nvim-web-devicons",                   -- file type icons
  },
  { "stevearc/aerial.nvim",
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },
  { "nvim-neo-tree/neo-tree.nvim",                    -- file explorer
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    }
  },
  { "windwp/nvim-autopairs",                          -- auto-close brackets/quotes
  },
  -- HTML/XML 
  { "windwp/nvim-ts-autotag",                         -- auto-close HTML/XML tags
    event = "VeryLazy",
  },
  -- LaTeX
  { "lervag/vimtex",                                  -- LaTeX support
    event = "VeryLazy",
  },
  -- Python 
  { "kmontocam/nvim-conda",                           -- conda environment integration
    event = "VeryLazy",
  },
  { "Vigemus/iron.nvim",                              -- interactive REPL
  },
  { "mfussenegger/nvim-dap", 
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
    }
  },
  { "tpope/vim-dadbod",                               -- for SQL
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",  -- UI for browsing DB
      "kristijanhusak/vim-dadbod-completion", -- Autocompletion
    },
  },
  -- Markdown 
  { "toppair/peek.nvim",
    event = "VeryLazy",
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  -- Syntax Highlighting, LSP, Completion
  { "tree-sitter-grammars/tree-sitter-markdown",     -- enhanced markdown parsing since treesitter doesn't have default markdown parsers
  },
  { "williamboman/mason.nvim",                        -- LSP server installer
  },
  { "neovim/nvim-lspconfig",                          -- LSP configuration
  },
  { "hrsh7th/nvim-cmp",                               -- completion engine
  },
  { "hrsh7th/cmp-buffer",                             -- buffer completions
  },
  { "hrsh7th/cmp-path",                               -- file path completions
  },
  { "saadparwaiz1/cmp_luasnip",                       -- snippet completions
  },
  { "hrsh7th/cmp-nvim-lsp",                           -- LSP completions
  },
  -- Special-purpose plugins 
  { "kawre/leetcode.nvim",                            -- LeetCode integration
    event = "VeryLazy",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {},
  },
})
