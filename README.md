# dotfiles

All of my configuration files, along with a guide on how to set them up, what problems I encountered, how to fix them... Refer to the Github Wiki for more details. 


Some useful symlinks. 
```
ln -s ~/dotfiles/conda/condarc ~/.condarc
```

## Debugging Neovim Startup

Added init-time OSV bootstrap so you can step-debug startup, plus OSV launch/stop keymaps for runtime debugging.
Changes
- editor/nvim/init.lua now checks _G.init_debug at the very top, prepends stdpath("data") .. "/lazy/one-small-step-for-vimkind" to runtimepath, then runs require("osv").launch({ port = 8086, blocking = true }).
- editor/nvim/lua/user/langtools/dap/dap.lua adds:
  - <leader>dl запуска OSV server in the debuggee (osv.launch({ port = 8086 }))
  - <leader>dL stop OSV server (osv.stop())
How to step through startup (C)
1. Debuggee instance:
   - nvim --cmd "lua init_debug=true"
   - it should freeze immediately
2. Debugger instance:
   - open editor/nvim/init.lua
   - set breakpoints (<leader>db)
   - attach (<leader>dc) using your existing “Attach to Neovim (OSV)” DAP config (port 8086)
Notes
- For plugin code, breakpoints must be set in the exact executed path (often under :echo stdpath("data") .. "/lazy/<plugin>/"
