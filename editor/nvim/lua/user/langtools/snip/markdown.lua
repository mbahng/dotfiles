local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets(
  "markdown",
  {
    s({trig="rm", regTrig=false, snippetType="snippet"},
      fmta(
        "\\mathrm{<>}",
        { i(1) }
      )
    ), 

    s({trig="lit", regTrig=false, snippetType="snippet"},
      fmta(
        [[
          Background. 

          Contribution

          Model Inference. 

          Training. 

          Results. 
        ]],
        {}, 
        { delimiters = "()" }
      )
    ),
  }
)
