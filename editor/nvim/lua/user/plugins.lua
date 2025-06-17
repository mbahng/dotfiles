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
  "nvim-lua/plenary.nvim",                     -- async programming utilities
  "nvim-telescope/telescope.nvim",             -- fuzzy finder for files/text
  "jesseduffield/lazygit",                     -- git TUI integration
  "lukas-reineke/indent-blankline.nvim",       -- indent guide lines
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- syntax highlighting
  "nvim-lualine/lualine.nvim",                 -- status line
  {
    "unblevable/quick-scope",
    keys = { "f", "F", "t", "T" },
    config = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
      vim.cmd "highlight QuickScopePrimary guifg='#00ffff' gui=underline ctermfg=155 cterm=underline"
      vim.cmd "highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline"
    end,
  },
  "windwp/nvim-autopairs",                     -- auto-close brackets/quotes
  "windwp/nvim-ts-autotag",                    -- auto-close HTML/XML tags
  "mbbill/undotree",                           -- visualize undo history
  "lervag/vimtex",                             -- LaTeX support
  'ojroques/nvim-osc52',                       -- connecting local clipboard to remote connections 
  "navarasu/onedark.nvim",                     -- One Dark colorscheme
  "mhartington/oceanic-next",                  -- Oceanic Next colorscheme

  "kmontocam/nvim-conda",                      -- conda environment integration
  "Vigemus/iron.nvim",                         -- interactive REPL
  "terrortylor/nvim-comment",                  -- commenting functionality
  "akinsho/bufferline.nvim",                   -- buffer tabs
  "moll/vim-bbye",                             -- delete buffers without closing windows
  "akinsho/toggleterm.nvim",                   -- floating terminal
  "lewis6991/gitsigns.nvim",                   -- git diff indicators
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- snippet engine
  "kyazdani42/nvim-web-devicons",              -- file type icons
  {
    "iamcco/markdown-preview.nvim",            -- markdown preview in browser
    build = function() vim.fn["mkdp#util#install"]() end,
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
  "tree-sitter-grammars/tree-sitter-markdown", -- enhanced markdown parsing
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
  
  -- LSP
  "williamboman/mason.nvim",                   -- LSP server installer
  "williamboman/mason-lspconfig.nvim",         -- mason-lspconfig bridge
  "neovim/nvim-lspconfig",                     -- LSP configuration
  
  -- Completion
  "hrsh7th/nvim-cmp",                          -- completion engine
  "hrsh7th/cmp-buffer",                        -- buffer completions
  "hrsh7th/cmp-path",                          -- file path completions
  "saadparwaiz1/cmp_luasnip",                  -- snippet completions
  "hrsh7th/cmp-nvim-lsp",                      -- LSP completions
})
