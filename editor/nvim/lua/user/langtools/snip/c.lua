local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets(
  "c",
  {
    s({trig="init", regTrig=false, snippetType="snippet"},
      fmta(
        [[
          #include<stdio.h>

          int main(void) {
            
            return 0; 
          }
        ]],
        {}, 
        { delimiters = "xz" }
      )
    ),
  }
)
