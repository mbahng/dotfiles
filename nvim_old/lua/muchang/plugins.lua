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
  -- My plugins here
  use { -- Have packer manage itself 
    "wbthomason/packer.nvim" 
  }
  use { -- an implementation of the popup API from vim in neovim
    "nvim-lua/popup.nvim" 
  }

  use { -- useful lua functions used by lots of plugins 
    "nvim-lua/plenary.nvim" 
  } 
   
  use { 
    "nvim-telescope/telescope.nvim", 
    tag = "0.1.4", -- or branch = "0.1.x"
  }

  use {
    "rose-pine/neovim", 
    as = "rose-pine", 
    config = function()
      vim.cmd('colorscheme rose-pine')
    end 
  }
  
  use {
    "nvim-treesitter/nvim-treesitter", 
    {run = ':TSUpdate'}
  }

  use {
    "nvim-treesitter/playground"
  }

  use {
    "mbbill/undotree"
  }

  use {
    "theprimeagen/harpoon"
  } 

  use {
    "tpope/vim-fugitive"
  } 

  use {
    "lervag/vimtex"
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
