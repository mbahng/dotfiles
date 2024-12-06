vim.cmd "hi WinSeparator guifg=#ffffff"
require "user.options"
require "user.colorscheme"
vim.cmd "colorscheme catppuccin-frappe"
require "user.keymaps"
require "user.snip"
require "user.plugins"
require "user.comment"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.quickscope"
require "user.vimtex"
require "user.startify"
require "user.iron"
require "user.indent-blankline"
require "user.lualine"
require "user.bufferline"
require "user.toggleterm"
require "user.neotree"
require "user.ts-autotag"
require "user.leetcode"
require "user.dap"

vim.g.loaded_perl_provider = 0
vim.cmd "colorscheme catppuccin-frappe"
vim.cmd "hi WinSeparator guifg=#ffffff"


vim.g.loaded_perl_provider = 0
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("Copilot disable")
	end,
})
