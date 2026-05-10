-- vim.api.nvim_set_keymap("v", "<leader>c", ":s/^/%/<cr>:noh<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>s", ":VimtexCompile<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>r", ":VimtexTocToggle<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-f>", ":.!inkscape-figures create fig/", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-e>", ":.!inkscape-figures edit figures/", { noremap = true, silent = true })
-- vim.cmd([[
--   inoremap <C-f> <Esc>:silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
--
--   nnoremap <C-f> :silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
-- ]])
