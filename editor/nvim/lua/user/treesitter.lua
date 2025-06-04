local status_ok, configs = pcall(require, "ts_context_commentstring")
if not status_ok then
  return
end
configs.setup {
  ensure_installed = {
    "c", 
    "cpp", 
    "lua", 
    "bash", 
    "verilog", 
    "html", 
    "css", 
    "markdown_inline", 
    "markdown", 
    "javascript", 
    "jsdoc", 
    "typescript", 
    "json", 
    "yaml",
    "latex",
    "asm", 
    "nasm"
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
