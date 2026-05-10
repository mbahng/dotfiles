local jdtls = require("jdtls")
vim.env.JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local config = require("user.langtools.lsp.jdtls").get_config()
    if config then
      jdtls.start_or_attach(config)
      jdtls.setup_dap({ hotcodereplace = "auto" })
    end
  end,
})
