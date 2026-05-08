local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets(
  "toml",
  {
    s({trig="pyproject", regTrig=false, snippetType="snippet"},
      fmta(
        [[ 
        [project]
        name = ""
        dynamic = [""]
        description = ""

        requires-python = ">= 3.8"
        dependencies = [
          "numpy"
        ]

        authors = [
          {name = "Muchang Bahng", email = "bahngmc@gmail.com"},
        ]
        maintainers = [
          {name = "Muchang Bahng", email = "bahngmc@gmail.com"}
        ]

        [build-system]
        requires = ["setuptools>=70.0"]
        build-backend = "setuptools.build_meta"

        [project.scripts]
        # python cli commands that allow you to run stuff straight from command line
        # greet = "converters.convert:greet"

        [project.gui-scripts]

        [project.optional-dependencies]
        gui = []
        cli = []
        ]],
        {}, 
        { delimiters = "()" }
      )
    )
  }
)
