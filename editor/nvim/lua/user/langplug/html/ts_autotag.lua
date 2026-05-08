return { "windwp/nvim-ts-autotag",                         -- auto-close HTML/XML tags
  event = "VeryLazy",
  config = function() 
    require("nvim-ts-autotag").setup {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
    }
  end
}
