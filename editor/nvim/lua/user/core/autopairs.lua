return { "windwp/nvim-autopairs",                          -- auto-close brackets/quotes 
  config = function() 
    require("nvim-autopairs").setup {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt" },
    }
  end 
}
