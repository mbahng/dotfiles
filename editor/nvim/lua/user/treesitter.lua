local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end
configs.setup {
  ensure_installed = {
    "python", 
    "c", 
    "cpp", 
    "lua", 
    "bash", 
    "html", 
    "css", 
    "markdown_inline", 
    "markdown", 
    "jsdoc", 
    "json", 
    "yaml",
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  -- indent = { enable = true, disable = { "" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
