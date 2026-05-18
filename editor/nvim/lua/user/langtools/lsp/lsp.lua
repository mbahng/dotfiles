return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup(
        {
          log_level = vim.log.levels.WARN,
          max_concurrent_installers = 4,
        }
      )
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, { noremap = true, silent = true })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })

      vim.lsp.config("ts_ls", require("user.langtools.lsp.ts_ls"))
      vim.lsp.enable("ts_ls")

      vim.lsp.config("lua_ls", require("user.langtools.lsp.lua_ls"))
      vim.lsp.enable("lua_ls")

      vim.lsp.config("pyright", require("user.langtools.lsp.pyright"))
      vim.lsp.enable("pyright")

      vim.lsp.config("clangd", require("user.langtools.lsp.clangd"))
      vim.lsp.enable("clangd")
    end
  },
  {
    "mfussenegger/nvim-jdtls",
  }
}
