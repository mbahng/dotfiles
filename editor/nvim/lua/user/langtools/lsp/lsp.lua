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
    end
  }, 

  { 
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function() 
      -- Define keymaps when an LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, noremap = true, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
      end

      local function make_config(name)
        local config = require("user.langtools.lsp." .. name)
        config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
        return config
      end

      -- Modern Neovim 0.11+ Native Setup
      vim.lsp.config("ts_ls", make_config("ts_ls"))
      vim.lsp.enable("ts_ls")

      vim.lsp.config("pyright", make_config("pyright"))
      vim.lsp.enable("pyright")

      vim.lsp.config("clangd", make_config("clangd"))
      vim.lsp.enable("clangd")

      vim.lsp.config("jdtls", make_config("jdtls"))
      vim.lsp.enable("jdtls")
    end 
  }
}
