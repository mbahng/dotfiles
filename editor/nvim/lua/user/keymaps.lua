local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Neotree toggle<cr>", opts)
keymap("n", "<leader>u", ":UndotreeToggle<cr>", opts)
keymap("n", "<leader>y", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>t", ":Telescope live_grep<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-w>", ":Bdelete<CR>", opts)
keymap("n", "<C-t>", ":Telescope find_files<cr>", opts)

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- moving within the same line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Keep cursor in the middle when page up/down and when searching
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- folding
keymap("n", "<leader>f", "za", opts) -- fold where I am currently at
keymap("n", "<leader>zM", "zM", opts) -- close all folds 
keymap("n", "<leader>zR", "zR", opts) -- open all folds 

-- go to definition and error
keymap("n", "gd", "gd", opts)
keymap("n", "gl", "gl", opts)

-- indenting multiples lines
keymap("v", "<tab>", ">", opts)
keymap("v", "<S-tab>", "<", opts)

-- yank to system clipboard
-- vim.keymap.set("v", "y", "+y")
-- keymap("v", "y", "+y", opts)
-- keymap("n", "yy", '"+yy', opts)

-- vertical split
keymap("n", "<leader>v", ":vsplit<cr>", opts)

-- LSP helpers 
keymap("n", "K", "K", opts) -- hover over  
keymap("n", "gd", "gd", opts) -- go to definition
keymap("n", "gD", "gD", opts) -- go to declaration

-- diffview open 
keymap("n", "<leader>g", ":DiffviewOpen<cr>", opts)
keymap("n", "<leader>h", ":DiffviewClose<cr>", opts)
keymap("n", "<leader>p", ":DiffviewFileHistory<cr>", opts)


-- Easy access to REPL for Python, Julia, and JavaScript 
keymap("n", ":repl<cr>", ":IronRepl<cr>", opts)

-- editing all instance of a word at the same time
vim.keymap.set("n", "<leader>o", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- word count 
keymap("v", "<leader>w", "g<S-g>", opts)

