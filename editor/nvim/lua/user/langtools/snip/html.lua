local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets(
  "html",
  {
    s({trig="init", regTrig=false, snippetType="snippet"},
      fmta(
        [[
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="ie=edge">
            <title>HTML 5 Boilerplate</title>
            <link rel="stylesheet" href="style.css">
          </head>
          <body>
          <script src="index.js"></script>
          </body>
        </html>
        ]],
        {}, 
        { delimiters = "()" }
      )
    ),
  }
)
