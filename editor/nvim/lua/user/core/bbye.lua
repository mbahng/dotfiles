return { "moll/vim-bbye",                                  -- delete buffers without closing windows
  config = function() 
    vim.api.nvim_set_keymap("n", "<C-x>", ":Bdelete<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-z>", ":Bdelete<cr>", { noremap = true, silent = true })
  end
}
