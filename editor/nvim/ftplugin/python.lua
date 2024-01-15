vim.cmd "colorscheme onedark"
vim.cmd "set foldmethod=indent"

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

