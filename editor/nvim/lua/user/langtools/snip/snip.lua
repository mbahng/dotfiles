return { "L3MON4D3/LuaSnip",                               -- snippet engine
  build = "make install_jsregexp",
  config = function() 
    -- require("luasnip.loaders.from_vscode").lazy_load({
    --   exclude = { "markdown-preview.nvim" }
    -- })

    local ls = require("luasnip")
    ls.setup({
      -- Enable history to prevent some deletion warnings
      history = true,
      
      -- Make the region checks less frequent to reduce warnings
      region_check_events = "InsertEnter",
      
      -- Only check for deletion on InsertLeave rather than any text change
      delete_check_events = "InsertLeave",
      
      -- Add this to ignore VSCode snippet warnings from packages without snippets
      ext_opts = {
        store_selection_keys = nil, -- Recommended for less noise
      },
      
      -- Add this to suppress some verbose logging
      loaders_store_source = false
    })

    -- Language-specific snippets
    require("user.langtools.snip.python")
    require("user.langtools.snip.javascript")
    require("user.langtools.snip.javascriptreact")
    require("user.langtools.snip.toml")
    require("user.langtools.snip.html")
    require("user.langtools.snip.c")
    require("user.langtools.snip.markdown")
    require("user.langtools.snip.tex")
  end
}
