vim.cmd "colorscheme onedark"

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

vim.cmd "highlight QuickScopePrimary guifg='#00ffff' gui=underline ctermfg=155 cterm=underline"
vim.cmd "highlight QuickScopeSecondary guifg='#5ffff' gui=underline ctermfg=81 cterm=underline"
vim.g.python_recommended_style = 0
vim.cmd "set shiftwidth=2"

