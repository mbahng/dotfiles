local builtin = require('telescope.builtin')

-- Keymaps for finding through all files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Just ones kept through by git
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Finding all words through grep
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") }); 
end)
