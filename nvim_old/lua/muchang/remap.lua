local opts = { noremap = true, silent = true } 

local term_opts = { silent = true } 

-- Shorten function name 
local keymap = vim.api.nvim_set_keymap 

-- Remap space as leader key 
keymap("", "<Space>", "<Nop>", opts) 
vim.g.mapleader = " " 
vim.g.maplocalleader = " " 

-- Press jk fast to escape insert mode
vim.keymap.set("i", "jk", "<ESC>")

-- navigating directories
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- resize windows with arrows 
keymap("n", "<C-Up>", ":resize +2<CR>", opts) 
keymap("n", "<C-Down>", ":resize -2<CR>", opts) 
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts) 
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts) 

-- Better window navigation 
vim.keymap.set("n", "<C-h>", "<C-w>h") 
vim.keymap.set("n", "<C-j>", "<C-w>j") 
vim.keymap.set("n", "<C-k>", "<C-w>k") 
vim.keymap.set("n", "<C-l>", "<C-w>l") 

-- navigating buffers 
keymap("n", "<S-l>", ":bnext<CR>", opts) 
keymap("n", "<S-h>", ":bprevious<CR>", opts) 

-- Fast navigation of lines up and down
-- vim.keymap.set("n", "<C-j>", "5j")
-- vim.keymap.set("n", "<C-k>", "5k")

-- moving and automatic indenting 
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")




