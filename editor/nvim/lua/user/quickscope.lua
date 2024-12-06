
-- Trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.cmd "highlight QuickScopePrimary guifg='#00ffff' gui=underline ctermfg=155 cterm=underline"
vim.cmd "highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline"

