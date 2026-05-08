-- keymap("v", "<leader>c", ":s/^/%/<cr>:noh<cr>", opts)
keymap("n", "<leader>s", ":VimtexCompile<cr>", opts)
-- keymap("n", "<leader>r", ":VimtexTocToggle<cr>", opts)
-- keymap("n", "<C-f>", ":.!inkscape-figures create fig/", opts)
-- keymap("n", "<C-e>", ":.!inkscape-figures edit figures/", opts)
-- inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
-- nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>


