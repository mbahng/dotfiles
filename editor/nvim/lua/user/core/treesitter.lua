return { "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", 
  config = function() 
    require("nvim-treesitter").setup {
      ensure_installed = {
        "python", 
        "c", 
        "cpp", 
        "java", 
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
  end
}
