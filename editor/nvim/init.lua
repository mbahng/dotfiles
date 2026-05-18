-- Init-time debugging (OSV) for stepping through startup.
-- Usage (debuggee): nvim --cmd "lua init_debug=true"
-- Then attach from another Neovim instance via nvim-dap (port 8086).
if rawget(_G, "init_debug") then
  local uv = vim.uv or vim.loop
  local osv_path = vim.fn.stdpath("data") .. "/lazy/one-small-step-for-vimkind"

  if uv and uv.fs_stat and uv.fs_stat(osv_path) then
    vim.opt.rtp:prepend(osv_path)
  end

  local ok, osv = pcall(require, "osv")
  if ok and osv and osv.launch then
    osv.launch({ port = 8086, blocking = true })
  end
end

require "user.options"
require "user.plugins"
