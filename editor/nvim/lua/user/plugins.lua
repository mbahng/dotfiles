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
  "nvim-lua/plenary.nvim",                     -- async programming utilities
  "nvim-telescope/telescope.nvim",             -- fuzzy finder for files/text
  "jesseduffield/lazygit",                     -- git TUI integration
  "mbbill/undotree",                           -- visualize undo history
  "lukas-reineke/indent-blankline.nvim",       -- indent guide lines
  'ojroques/nvim-osc52',                       -- connecting local clipboard to remote connections 
  "mhartington/oceanic-next",                  -- Oceanic Next colorscheme
  "nvim-lualine/lualine.nvim",                 -- status line at the bottom
  "terrortylor/nvim-comment",                  -- commenting functionality
  "akinsho/bufferline.nvim",                   -- buffer tabs
  "moll/vim-bbye",                             -- delete buffers without closing windows
  "akinsho/toggleterm.nvim",                   -- floating terminal
  "lewis6991/gitsigns.nvim",                   -- git diff indicators
  {
    "L3MON4D3/LuaSnip",                        -- snippet engine
    build = "make install_jsregexp" 
  },
  {
    'stevearc/aerial.nvim',
    event = "VeryLazy", 
    opts = {},
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  }, 
  "kyazdani42/nvim-web-devicons",              -- file type icons
  {
    "unblevable/quick-scope",                  --  highlights letters when finding with f or F
    keys = { "f", "F", "t", "T" },
    config = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
      vim.cmd "highlight QuickScopePrimary guifg='#00ffff' gui=underline ctermfg=155 cterm=underline"
      vim.cmd "highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline"
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",             -- file explorer
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },
  "windwp/nvim-autopairs",                     -- auto-close brackets/quotes

  -- HTML/XML 
  "windwp/nvim-ts-autotag",                    -- auto-close HTML/XML tags

  -- LaTeX
  "lervag/vimtex",                             -- LaTeX support

  -- Python Specific 
  "kmontocam/nvim-conda",                      -- conda environment integration
  "Vigemus/iron.nvim",                         -- interactive REPL

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
  {
    "nvim-treesitter/nvim-treesitter",         -- syntax highlighting
    build = ":TSUpdate"
  },
  "tree-sitter-grammars/tree-sitter-markdown", -- enhanced markdown parsing since treesitter doesn't have default markdown parsers
  "williamboman/mason.nvim",                   -- LSP server installer
  "williamboman/mason-lspconfig.nvim",         -- mason-lspconfig bridge
  "neovim/nvim-lspconfig",                     -- LSP configuration
  "hrsh7th/nvim-cmp",                          -- completion engine
  "hrsh7th/cmp-buffer",                        -- buffer completions
  "hrsh7th/cmp-path",                          -- file path completions
  "saadparwaiz1/cmp_luasnip",                  -- snippet completions
  "hrsh7th/cmp-nvim-lsp",                      -- LSP completions

  -- Special-purpose plugins 
  {
    "kawre/leetcode.nvim",                     -- LeetCode integration
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {},
  },

})
