vim.cmd "colorscheme onedark"
vim.cmd "set foldmethod=indent"


-- keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>s", ":terminal firefox index.html<cr>", opts)
