return {
  "lervag/vimtex",
  lazy = false,

  config = function()
    vim.g.vimtex_view_method = "zathura"

    -- Compile with LuaLaTeX through latexmk
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk_engines = {
      ["_"] = "-lualatex",
    }

    vim.g.vimtex_fold_enabled = 0
    vim.g.vimtex_fold_levelmarker = ">"
    vim.g.vimtex_indent_enabled = 1

    vim.g.vimtex_fold_types = {
      preamble = {
        enabled = 1,
      },

      items = {
        enabled = 0,
      },

      envs = {
        blacklist = {
          "figure",
          "table",
          "definition",
          "theorem",
          "lemma",
          "example",
          "corollary",
          "solution",
          "proof",
          "enumerate",
          "itemize",
          "equation",
          "align",
        },

        whitelist = {
          "item",
        },
      },

      sections = {
        parse_levels = 1,
      },
    }
  end,
}
