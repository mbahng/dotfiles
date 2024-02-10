local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)

  use "wbthomason/packer.nvim"                -- the packer package manager
  use "nvim-lua/plenary.nvim"                 -- for async programming
  use "nvim-telescope/telescope.nvim"         -- quickly find files in pwd
  use "jesseduffield/lazygit"                 -- all things git 
  use "lambdalisue/suda.vim"                  -- Read/Write with sudo privilge
  use "lukas-reineke/indent-blankline.nvim"   -- indent line guides 
  use "nvim-treesitter/nvim-treesitter"       -- syntax highlighting
  use 'nvim-lualine/lualine.nvim'             -- configure status line
  use 'unblevable/quick-scope'                -- highlights letter when pressing f/F
  use "windwp/nvim-autopairs"                 -- autopairing (),[], {}, "", ''
  use "windwp/nvim-ts-autotag"                -- autopairing <html> tags
  use "mbbill/undotree"                       -- can see undo tree history
  use "lervag/vimtex"                         -- for compiling tex documents
  use "navarasu/onedark.nvim"                 -- color scheme
  use "mhartington/oceanic-next"              -- color scheme
  use "rcarriga/nvim-notify"                  -- notification manager
  use "kmontocam/nvim-conda"                  -- activate conda envs within neovim
  use "Vigemus/iron.nvim"                     -- interactive REPL 
  use "terrortylor/nvim-comment"              -- comment out visual blocks of line
  use "mhinz/vim-startify"                    -- start screen when starting neovim
  use "akinsho/bufferline.nvim"               -- shows the buffer (tab) line
  use "moll/vim-bbye"                         -- delete buffers without closing nvim
  use "akinsho/toggleterm.nvim"               -- floating terminal window
  use "lewis6991/gitsigns.nvim"               -- see inline git history modifications
  use "L3MON4D3/LuaSnip"                      -- custom snippets 
  use "nvim-tree/nvim-tree.lua"               -- the left sidebar showing filetree
  use "nvim-tree/nvim-web-devicons"           -- icons for filetypes
  use "edluffy/hologram.nvim"                 -- to show pictures within neovim buffers
  use({"iamcco/markdown-preview.nvim",        -- preview markdown in browser
  run = function() vim.fn["mkdp#util#install"]() end,})   -- install without yarn or npm

  -- LSP
  use "williamboman/mason.nvim"               -- LSP: simple to use language server installer
  use "williamboman/mason-lspconfig.nvim"     -- simple to use language server installer
  use "neovim/nvim-lspconfig"                 -- enable LSP
  use 'jose-elias-alvarez/null-ls.nvim'       -- LSP diagnostics and code actions

  -- cmp plugins
  use "hrsh7th/nvim-cmp"                      -- The completion plugin
  use "hrsh7th/cmp-buffer"                    -- buffer completions
  use "hrsh7th/cmp-path"                      -- path completions
  use "hrsh7th/cmp-cmdline"                   -- cmdline completions
  use "saadparwaiz1/cmp_luasnip"              -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
