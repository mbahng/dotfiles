return { "tpope/vim-dadbod",                               -- for SQL
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",  -- UI for browsing DB
    "kristijanhusak/vim-dadbod-completion", -- Autocompletion
  },
  config = function() 
    vim.g.db_ui_win_position = 'right'
  end
}
