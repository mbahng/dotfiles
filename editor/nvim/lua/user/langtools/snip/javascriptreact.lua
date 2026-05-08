local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets(
  "javascriptreact",
  {
    s({trig="doc", regTrig=false, snippetType="snippet"},
      fmta(
        [[
        /**
        * <> 
        */
        ]],
        { i(1) }
      )
    ),
  }
)
