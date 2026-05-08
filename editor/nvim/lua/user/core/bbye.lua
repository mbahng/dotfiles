return { "moll/vim-bbye",                                  -- delete buffers without closing windows
  config = function() 
    vim.api.nvim_set_keymap("n", "<C-x>", ":Bdelete<CR>", { noremap = true, silent = true })
  end
}
