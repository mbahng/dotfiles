return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python",
        "c",
        "cpp",
        "java",
        "lua",
        "bash",
        "verilog",
        "html",
        "css",
        "markdown_inline",
        "markdown",
        "javascript",
        "jsdoc",
        "typescript",
        "json",
        "yaml",
        "latex",
        "asm",
        "nasm",
      },

      sync_install = false,
      auto_install = false,
      ignore_install = {},

      modules = {},

      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true,
      },

      -- indent = {
      --   enable = true,
      --   disable = {},
      -- },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    })

    vim.keymap.set("n", "<C-p>", "<cmd>TSBufToggle highlight<cr>", {
      desc = "Toggle Treesitter highlight",
    })
  end,
}
