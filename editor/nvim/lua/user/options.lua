vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = true                         -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 4000                       -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program, it is not allowed to be edited
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 4 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8                       -- keep 8 columns left/right of cursor
vim.cmd "set linebreak"

vim.opt.tabstop = 8                     -- How many spaces the <tab> key takes. Should be 8 always according to neovim docs
vim.opt.shiftwidth = 4                  -- this is whatever you want it to be
vim.opt.expandtab = false               -- Replace tabs with spaces? 
vim.opt.smarttab = true                 -- Smarttab allows you to use shiftwidth to configure the tab key

vim.opt.shortmess:append "c"          -- Suppress completion menu messages like "match 1 of 3"
-- vim.o.colorcolumn = "80"              -- Set color on column 80
vim.cmd "set cinkeys-=0#"             -- Don't auto-indent when typing # at line start
vim.cmd "set indentkeys-=0#"          -- Don't trigger reindent when typing # at line start  
vim.cmd "set whichwrap+=<,>,[,],h,l"  -- Let cursor keys and h/l wrap to next/prev line
vim.cmd [[set iskeyword+=-]]          -- Treat - as part of words (affects word motions)
vim.cmd [[set formatoptions-=cro]]    -- Disable auto-commenting on new lines
vim.cmd "set breakindent"             -- Visually indent wrapped lines
vim.cmd "set foldmethod=indent"       -- Fold based on indentation
vim.cmd "set foldlevel=10000"         -- Start with all folds open
vim.cmd "set foldignore="             -- Don't ignore any lines when folding
vim.g.copilot_assume_mapped = true    -- Tell Copilot that mappings are handled

-- on X11, make sure to install xclip (sudo pacman -S xclip) for this to work
vim.cmd "set clipboard=unnamedplus"

vim.cmd [[
try
  colorscheme OceanicNext
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

-- Set separator after colorscheme loads
vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋'
}
vim.cmd "hi WinSeparator guifg=#ff8c69 guibg=NONE cterm=NONE"
vim.cmd "hi VertSplit guifg=#ff8c69 guibg=NONE cterm=NONE"

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- for mistyping 
vim.api.nvim_set_keymap("n", ":Q<cr>", ":q<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ":W<cr>", ":w<cr>", { noremap = true, silent = true })

-- Better left/right window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<bs>", "<C-w>h", { noremap = true, silent = true }) -- need this since for some shells, <C-h> gets mapped to ^?, which is backspace. 

vim.api.nvim_set_keymap("n", "<C-j>", "5j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "5k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-j>", "5j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-k>", "5k", { noremap = true, silent = true })

-- Resize with arrows
vim.api.nvim_set_keymap("n", "<C-Up>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- Press jk fast to enter
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })

-- moving within the same line
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true })

-- Keep cursor in the middle when page up/down and when searching
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true, silent = true })

-- folding
vim.api.nvim_set_keymap("n", "<leader>f", "za", { noremap = true, silent = true }) -- fold where I am currently at
vim.api.nvim_set_keymap("n", "<leader>zM", "zM", { noremap = true, silent = true }) -- close all folds 
vim.api.nvim_set_keymap("n", "<leader>zR", "zR", { noremap = true, silent = true }) -- open all folds 

-- wrapping 
vim.api.nvim_set_keymap("n", "<leader>w", ":set wrap!<cr>", { noremap = true, silent = true })

-- stuff for split keyboards 
vim.api.nvim_set_keymap("n", "m", "n", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "n", "b", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "n", "b", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "dn", "db", { noremap = true, silent = true })

-- vertical split
vim.api.nvim_set_keymap("n", "<leader>v", ":vsplit<cr>", { noremap = true, silent = true })

-- editing all instance of a word at the same time, short for :%substitute
vim.keymap.set("n", "<leader>o", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- word count 
vim.api.nvim_set_keymap("v", "<leader>w", "g<S-g>", { noremap = true, silent = true })

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


