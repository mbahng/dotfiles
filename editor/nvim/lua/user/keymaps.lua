local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- for mistyping 
keymap("n", ":Q<cr>", ":q<cr>", opts)
keymap("n", ":W<cr>", ":w<cr>", opts)

-- Better left/right window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<bs>", "<C-w>h", opts) -- need this since for some shells, <C-h> gets mapped to ^?, which is backspace. 

keymap("n", "<C-j>", "5j", opts) 
keymap("n", "<C-k>", "5k", opts)
keymap("v", "<C-j>", "5j", opts) 
keymap("v", "<C-k>", "5k", opts)

keymap("n", "<leader>e", ":Neotree toggle<cr>", opts)
keymap("n", "<leader>u", ":UndotreeToggle<cr>", opts)
keymap("n", "<leader>y", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>t", ":Telescope live_grep<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate and move buffers 
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<leader>h", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<leader>l", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<C-n>", ":tabnew<CR>", opts)
keymap("n", "<C-x>", ":Bdelete<CR>", opts)
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

-- wrapping 
keymap("n", "<leader>w", ":set wrap!<cr>", opts)

-- stuff for split keyboards 
keymap("n", "m", "n", opts)
keymap("n", "n", "b", opts)
keymap("v", "n", "b", opts)
keymap("n", "dn", "db", opts)

-- yanking both copies to neovim clipboard (normal) and local clipboard (osc52) 
-- local clipboard is good for when working in remote servers. Must be after plugins.lua
vim.keymap.set('v', 'y', function()
  -- Copy to Neovim registers
  vim.cmd('normal! y')
  -- Copy to system clipboard via OSC52
  require('osc52').copy_visual()
end)

vim.keymap.set('n', 'yy', function()
  vim.cmd('normal! yy')
  local line = vim.fn.getline('.')
  require('osc52').copy(line)
end)

-- vertical split
keymap("n", "<leader>v", ":vsplit<cr>", opts)

-- LSP helpers 
keymap("n", "K", "K", opts) -- hover over  
keymap("n", "<C-o>", "<C-o>", opts) -- jump back

-- leetcode
keymap("n", "<leader>ll", ":Leet list<cr>", opts)
keymap("n", "<leader>ld", ":Leet run<cr>", opts)
keymap("n", "<leader>ls", ":Leet submit<cr>", opts)
keymap("n", "<leader>lc", ":Leet console<cr>", opts)
keymap("n", "<leader>lt", ":Leet tabs<cr>", opts)
keymap("n", "<leader>la", ":Leet lang<cr>", opts)

-- Easy access to REPL for Python, Julia, and JavaScript 
keymap("n", ":repl<cr>", ":IronRepl<cr>", opts)
keymap('n', '<space>rf', '<cmd>IronFocus<cr>', opts)
keymap('n', '<space>rh', '<cmd>IronHide<cr>', opts)
keymap("n", "<leader>rr", ":IronRestart<cr>", opts)
keymap("t", "1jk", "<C-\\><C-n>", opts)

-- editing all instance of a word at the same time
vim.keymap.set("n", "<leader>o", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- word count 
keymap("v", "<leader>w", "g<S-g>", opts)

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- diffview
vim.cmd("cnoreabbrev df DiffviewOpen")
vim.cmd("cnoreabbrev dh DiffviewFileHistory %")
keymap("n", "<leader>dc", ":DiffviewClose<cr>", opts)

-- gitsigns 
keymap("n", "<leader>wd", ":Gitsigns toggle_word_diff<cr>", opts)

