return { "lukas-reineke/indent-blankline.nvim",            -- indent guide lines
  config = function() 
    require("ibl").setup {
      indent = { char = '▏'}
    }
  end
}
