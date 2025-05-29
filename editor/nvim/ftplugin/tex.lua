vim.cmd "set wrap"
vim.cmd "set linebreak"
vim.cmd "setlocal spell spelllang=en_us"


vim.g.tex_indent_items = 0
vim.g.tex_indent_and = 0
vim.g.tex_indent_brace = 0

-- keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap


-- keymap("v", "<leader>c", ":s/^/%/<cr>:noh<cr>", opts)
keymap("n", "<leader>s", ":VimtexCompile<cr>", opts)
-- keymap("n", "<leader>r", ":VimtexTocToggle<cr>", opts)
-- keymap("n", "<C-f>", ":.!inkscape-figures create fig/", opts)
-- keymap("n", "<C-e>", ":.!inkscape-figures edit figures/", opts)
-- inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
-- nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>


