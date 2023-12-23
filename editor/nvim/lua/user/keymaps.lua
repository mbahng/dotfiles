local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
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

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
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

-- Vimtex compile 
keymap("n", "<leader>s", ":VimtexCompile<cr>", opts)
keymap("n", "<leader>c", ":VimtexTocToggle<cr>", opts)
keymap("n", "<leader>f", "za", opts)

keymap("n", "gd", "gd", opts)

