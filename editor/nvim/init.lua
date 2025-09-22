require "user.options"
require "user.plugins"
require "user.colorscheme"
require "user.keymaps"
require "user.snip"
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
require "user.aerial"
require "user.leetcode"
require "user.diffview"
require "user.dadbod"
require "user.dap"
-- require "user.oil"

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})
vim.g.loaded_perl_provider = 0

