return { "nvim-telescope/telescope.nvim",                  -- fuzzy finder for files/text
  config = function() 
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_set_keymap

    vim.api.nvim_set_keymap("n", "<leader>y", ":Telescope find_files<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>t", ":Telescope live_grep<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-t>", ":Telescope find_files<cr>", { noremap = true, silent = true })
  end
}
