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
