local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = {
    "python", 
    "c", 
    "cpp", 
    "lua", 
    "bash", 
    "html", 
    "css", 
    "javascript", 
    "typescript", 
    "json", 
    "yaml"
  },
  sync_install = false,
  auto_install = true,
  ignore_install = { "vimdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true, disable = { "" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
