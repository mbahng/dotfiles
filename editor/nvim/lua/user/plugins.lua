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

  -- essentials 
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use {"nvim-telescope/telescope.nvim", tag = "0.1.4"}

  -- Read/Write with sudo privilge
  use "lambdalisue/suda.vim"

  -- indent line guides 
  use "lukas-reineke/indent-blankline.nvim"

  -- syntax highlighting
  use {"nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"}}

  -- configuration of status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use 'unblevable/quick-scope'
  -- automatic indent format
  -- use "sbdchd/neoformat"

  -- auto pairing "" and {} and ...
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"

  use "mbbill/undotree"
  use "lervag/vimtex" -- latex 

  -- better visual 
  use "navarasu/onedark.nvim"
  use "mhartington/oceanic-next"


  -- Jupyter Notebook and Interactive REPL 
  use 'Vigemus/iron.nvim'
  use "GCBallesteros/NotebookNavigator.nvim"
  use "anuvyklack/hydra.nvim"
  use "GCBallesteros/jupytext.nvim"
  use "edluffy/hologram.nvim" -- image viewer for neovim

  use "terrortylor/nvim-comment"
  use "mhinz/vim-startify"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye" -- delete buffers without closing nvim

  -- floating terminal window 
  use "akinsho/toggleterm.nvim"


  -- git 
  use "lewis6991/gitsigns.nvim"

-- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})

  use "nvim-tree/nvim-web-devicons"
  use "nvim-tree/nvim-tree.lua"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip"
  -- use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use 'jose-elias-alvarez/null-ls.nvim' -- LSP diagnostics and code actionsi


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
