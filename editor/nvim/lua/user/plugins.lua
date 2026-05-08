local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- "require(x)" imports file "x" or "x/init.lua" if x is a directory
  require("user.core"),
  require("user.git"),
  require("user.other"),
  require("user.langplug"),
  
  require("user.langtools.lsp.lsp"), 
  require("user.langtools.dap.dap"), 
  require("user.langtools.completion.completion"), 
  require("user.langtools.snip.snip"), 
})
