vim.g['vimtex_view_method'] = 'general'
--  vim.keymap.set("n", "<leader>lv", "<leader>lv") -- forward search 
vim.g['vimtex_fold_enabled'] = 0
vim.g['vimtex_fold_levelmarker'] = '>'
vim.g['vimtex_indent_enabled'] = 1
vim.g.vimtex_fold_types = {
  preamble = { enabled = 1 }, -- enable folding of preamble
  items = {enabled = 0}, 
  envs = {
    blacklist = {
      'figure',
      'table',
      'definition', 'theorem', 'lemma', 'example', 'corollary', 'solution', 'proof',
      'enumerate', 'itemize', 'equation', 'align'
    }, 
    whitelist = {
      'item'
    }
  }, 
  sections = {
    parse_levels = 1, 
  }
}

