vim.opt.guicursor = "" 

-- Number lining and highlights 
vim.opt.nu = true                         -- set numbered lines  
vim.opt.relativenumber = true             -- set relative number lines 
vim.opt.cursorline = true                 -- get cursor 
vim.opt.wrap = false                      -- set wrap lines 

-- allows neovim to access system clipboard 
vim.opt.clipboard = "unnamedplus" 

-- encoding written to a file 
vim.opt.fileencoding = "utf-8"

-- ignore case in search patterns  
vim.opt.ignorecase = true

-- tabs stuff
vim.opt.tabstop = 2 
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2 
vim.opt.expandtab = true 
vim.opt.smartindent = true 

-- file manager 
vim.opt.swapfile = false 
vim.opt.backup = false 
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" 
vim.opt.undofile = true 

-- coloring
vim.opt.termguicolors = true 

vim.opt.mouse = "a"                       -- allows mouse to be used in neovim
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes" 
vim.opt.isfname:append("@-@")
vim.opt.conceallevel = 0 
vim.opt.updatetime = 400

vim.opt.colorcolumn = "200"

-- leader key is SPACE
vim.g.mapleader = " "
