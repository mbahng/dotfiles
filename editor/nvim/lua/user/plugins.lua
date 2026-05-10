local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
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
