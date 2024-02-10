require "user.options"
require "user.colorscheme"
require "user.keymaps"
require "user.snip"
require "user.plugins"
require "user.comment"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.quickscope"
require "user.gitsigns"
require "user.vimtex"
require "user.startify"
require "user.iron"
require "user.indent-blankline"
require "user.lualine"
require "user.hologram"

vim.g.loaded_perl_provider = 0

require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    filters = {
      dotfiles = false,
      custom = {}
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
    view = {
        width = 30,
        side = "left",
        number = false,
        relativenumber = false,
    },

})

-- require "user.nvim-tree"
require "user.bufferline"
require "user.toggleterm"
